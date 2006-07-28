Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161326AbWG1V76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbWG1V76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbWG1V75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:59:57 -0400
Received: from mail.gmx.de ([213.165.64.21]:60598 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161326AbWG1V75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:59:57 -0400
X-Authenticated: #271361
Date: Fri, 28 Jul 2006 23:59:51 +0200
From: Edgar Toernig <froese@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] /dev/itimer
Message-Id: <20060728235951.7de534eb.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a simple driver which provides interval timers via
file descriptors.

Everytime I have to write code to do something at regular
intervals I face the problem that the time routines on Unix 
are pretty archaic.  Only a single process wide timer which
notifies via signals.  The single timer asks for a dedicated
roll-your-own timer infrastructur, usually implemented via
a lot of gettimeofday calls and appropriate select timeouts.
But even if the single timer is enough, the delivery via
signals is error prone and breaks a lot of (i.e. library)
code, especially when the timer rate is high.  One common
work around is forking a separate task which gets the signals
and a pipe to notify the main process which may select/poll
the other and of the pipe.  But this is pretty heavy-weight
and not easy to get right either.  Recently, people started
to use the real time clock driver (/dev/rtc) to get an fd
to sleep on.  But this is even worse as there's (usually)
only a single one in the whole system and you have to decide
whether i.e. mplayer, artsd, timidity, or vdr gets it.

Most things in Linux/Unix are based on file descriptors.
It's one of the nice things that you can throw all kind
of fds into select/poll/epoll and get notified when some-
thing happens on any of them.  But there's no fd-type to
deliver time events.  Well, up to now...

So here is a (tiny) driver which delivers time events at
regular intervals.  You can get as much independant timers
per process as there are available fds.  The interchanged
data (time intervals and time stamps) is in ASCII so that
they may be used from script languages.  To avoid rounding
issues (which may easily accumulate in interval timers),
times are given as fractions.

Usage is straightforward:

    - Opening /dev/itimer creates a new timer with the
      default interval of 1 second.

    - A write to the fd resets the timer and sets a new
      interval.

      The format is "numerator/denominator\n".  The den-
      ominator may be omitted and is then taken as 1.
      Examples: "5\n" = 5 seconds, "25/1000\n" = 25 micro-
      seconds, "1001/60000\n" = NTSC field rate.

    - A read blocks until the next interval starts and then
      returns the seconds (again, as a fraction) that passed
      since the last reset (write or open) of the timer.  If
      O_NONBLOCK is set, read returns with EAGAIN instead of
      blocking.  If the app missed some 'ticks', the read
      returns immediately.
      Example return string: "251/100\n" = 2.51 seconds.

    - select/poll/epoll work as expected - they block as long
      as a read would do.

Simple shell example:

    $ { echo "1/3" >&0; head -6; } <>/dev/itimer
    34/100
    67/100
    100/100
    134/100
    167/100
    200/100

Due to the recent discussion about mmap-ing a timer into
userspace, this was added to the driver as a compile time
option.  The driver stores the current interval number of
the fd's timer in the first long word of the mmap area.

So, what do you think?  Does this driver has a chance to
go into the kernel (either with or without mmap support)?

Comments are welcome!

Ciao, ET.

---8<---
/*
 * /dev/itimer -- A simple interval timer.
 *
 * It uses fractions for time values to avoid rounding errors.
 *
 * - open creates a new timer with default interval of 1 second.
 * - write("50/1000\n") resets the timer and sets a new interval
 *   (here 50 milliseconds)
 * - read blocks until next interval is reached.  Gives back the
 *   seconds elapsed since the last reset (or open) as e.g. "50/250\n".
 * - select/poll/epoll is supported
#ifdef ITIMER_MMAP
 * - mmap-ing a page from the timer gives you the current interval
 *   number in the first (kernel-)long.
#endif
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/wait.h>
#include <linux/timer.h>
#include <linux/poll.h>
#include <linux/mm.h>
#include <asm/atomic.h>

#include <linux/miscdevice.h>

#ifndef ITIMER_MINOR
#define ITIMER_MINOR	240	// "Reserved for local use"
#endif

#define ITIMER_MMAP

/* per-open data structure */
struct itimer {
	struct mutex lock;

	unsigned long time0;		// base jiffies of this itimer
	unsigned long expire;		// when to wake up
	unsigned long num, denom;	// the interval in num/denom jiffies

	struct timer_list timer;
	wait_queue_head_t waitq;

	char rbuf[64];		// output buffer to support single char reads
	size_t rpos, rsize;
	char wbuf[64];		// input buffer to collect partial writes
	size_t wpos;

#ifdef ITIMER_MMAP
	atomic_t map_cnt;		// when !=0 timer restarts itself
	struct page *mm_page;		// handed out via mmap
#endif
};

#ifdef ITIMER_MMAP
#define auto_restarting(it)	(atomic_read(&(it)->map_cnt) != 0)
static void set_mm_time(struct itimer *it, unsigned long time);
#define _MM			" (mmap)"
#else
#define auto_restarting(it)	0
static inline void set_mm_time(struct itimer *it, unsigned long time) { }
#define _MM			""
#endif

/**********/

static unsigned long
gcd(unsigned long a, unsigned long b) //lib?
{
	while (b != 0) {
		unsigned long t = b;
		b = a % b;
		a = t;
	}
	return a;
}

/*
 * Compute lowest x*num/denom greater than now.
 *
 * expire = (now * denom / num * num + num + denom - 1) / denom
 */
static unsigned long
next_expire(struct itimer *it, unsigned long now)
{
	unsigned long long x;

	x = now - it->time0;

	x *= it->denom;
	do_div(x, it->num);
	x *= it->num;
	x += it->num;
	x += it->denom - 1;
	do_div(x, it->denom);

	return it->time0 + (unsigned long)x;
}

static void
reset_itimer(struct itimer *it, unsigned long num, unsigned long denom)
{
	del_timer_sync(&it->timer);
	it->num = num;
	it->denom = denom;
	it->time0 = jiffies;
	it->expire = next_expire(it, it->time0);
	set_mm_time(it, 0);
	__mod_timer(&it->timer, it->expire);
}

/*
 * Parse "numerator[/denominator]" seconds and use that to reset_itimer.
 */
static int
new_itimer_params(struct itimer *it, char *str)
{
	unsigned long num, denom, d;

	num = simple_strtoul(str, &str, 10);
	denom = 1;
	if (*str == '/')
		denom = simple_strtoul(str + 1, &str, 10);

	if (*str != '\0' || num == 0 || denom == 0)
		return -EINVAL;

	d = gcd(num, denom);
	num /= d;
	denom /= d;

	/* need to multiply num by HZ without overflow */
	d = gcd(HZ, denom);
	if (num > ULONG_MAX / (HZ/d))
		d = HZ / (ULONG_MAX / num); // precision loss :-/
	num *= HZ / d;
	denom /= d;

	if (denom == 0 || num / denom >= MAX_JIFFY_OFFSET)
		num = MAX_JIFFY_OFFSET, denom = 1;  // hmm...

	reset_itimer(it, num, denom);
	return 0;
}

static void
wait_till(wait_queue_head_t *waitq, unsigned long expire)
{
	wait_queue_t wait;

	init_wait(&wait);
	for (;;) {
		prepare_to_wait(waitq, &wait, TASK_INTERRUPTIBLE);
		if (time_after_eq(jiffies, expire))
			break;
		if (signal_pending(current))
			break;
		schedule();
	}
	finish_wait(waitq, &wait);
}

static ssize_t
itimer_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
{
	struct itimer *it = file->private_data;

	mutex_lock(&it->lock);

	if (it->rsize == 0) {
		unsigned long now = jiffies;
		unsigned long time0 = it->time0;
		unsigned long expire = it->expire;

		if (time_before(now, expire)) {
			mutex_unlock(&it->lock);

			if (file->f_flags & O_NONBLOCK)
				return -EAGAIN;

			wait_till(&it->waitq, expire);
			if (signal_pending(current))
				return -ERESTARTSYS;

			mutex_lock(&it->lock);
			now = jiffies;
		}
		it->expire = next_expire(it, now);
		if (!auto_restarting(it))
			mod_timer(&it->timer, it->expire);

		it->rsize = sprintf(it->rbuf, "%lu/%d\n", now - time0, HZ);
		it->rpos = 0;
	}
	if (count > it->rsize)
		count = it->rsize;
	if (count) {
		if (copy_to_user(buf, it->rbuf + it->rpos, count) != 0) {
			mutex_unlock(&it->lock);
			return -EFAULT;
		}
		it->rpos += count;
		it->rsize -= count;
	}
	mutex_unlock(&it->lock);
	return count;
}

static ssize_t
itimer_write(struct file *file, const char __user *buf, size_t count,
								    loff_t *pos)
{
	struct itimer *it = file->private_data;
	char *p;

	if (count == 0)
		return 0;

	mutex_lock(&it->lock);

	if (count > sizeof(it->wbuf) - it->wpos)
		count = sizeof(it->wbuf) - it->wpos;

	if (copy_from_user(it->wbuf + it->wpos, buf, count) != 0) {
		mutex_unlock(&it->lock);
		return -EFAULT;
	}

	p = memchr(it->wbuf + it->wpos, '\n', count);
	if (!p) {
		it->wpos += count;
		if (it->wpos == sizeof(it->wbuf)) {
			it->wpos = 0;
			count = -EINVAL;
		}
	} else {
		*p++ = '\0';
		count = p - it->wbuf - it->wpos;
		it->wpos = 0;

		if (new_itimer_params(it, it->wbuf))
			count = -EINVAL;
	}

	mutex_unlock(&it->lock);
	return count;
}

static unsigned int
itimer_poll(struct file *file, poll_table *ptable)
{
	struct itimer *it = file->private_data;
	unsigned int mask = POLLOUT | POLLWRNORM;

	mutex_lock(&it->lock);

	poll_wait(file, &it->waitq, ptable);

	if (it->rsize || time_after_eq(jiffies, it->expire))
		mask |= POLLIN | POLLRDNORM;

	mutex_unlock(&it->lock);
	return mask;
}

static void
wake_me_up(unsigned long data)
{
	struct itimer *it = (struct itimer *)data;

	wake_up(&it->waitq);
	if (auto_restarting(it)) {
		unsigned long now = jiffies - it->time0;
		set_mm_time(it, now);
		__mod_timer(&it->timer, next_expire(it, now));
	}
}

static int
itimer_open(struct inode *inode, struct file *file)
{
	struct itimer *it;

	it = kzalloc(sizeof(*it), GFP_KERNEL);
	if (!it)
		return -ENOMEM;
	file->private_data = it;

	nonseekable_open(inode, file);

	mutex_init(&it->lock);
	init_waitqueue_head(&it->waitq);
#ifdef ITIMER_MMAP
	atomic_set(&it->map_cnt, 0);
#endif
	setup_timer(&it->timer, wake_me_up, (unsigned long)it);

	reset_itimer(it, HZ, 1); // default interval is 1 second
	return 0;
}

static int
itimer_release(struct inode *inode, struct file *file)
{
	struct itimer *it = file->private_data;

	del_timer_sync(&it->timer);
#ifdef ITIMER_MMAP
	if (it->mm_page)
		__free_page(it->mm_page);
#endif
	kfree(it);
	return 0;
}

#ifdef ITIMER_MMAP /***************************/

static void
set_mm_time(struct itimer *it, unsigned long time)
{
	if (it->mm_page) {
		unsigned long *p = page_address(it->mm_page);
		unsigned long long x = time;

		x *= it->denom;
		do_div(x, it->num);
		*p = x;
	}
}

static void
itimer_vm_open(struct vm_area_struct *vma)
{
	struct itimer *it = vma->vm_file->private_data;

	mutex_lock(&it->lock);
	if (atomic_inc_return(&it->map_cnt) == 1)
		mod_timer(&it->timer, next_expire(it, jiffies));
	mutex_unlock(&it->lock);
}

static void
itimer_vm_close(struct vm_area_struct *vma)
{
	struct itimer *it = vma->vm_file->private_data;

	mutex_lock(&it->lock);
	atomic_dec(&it->map_cnt);
	/* don't cancel timer - may be in use by read/poll */
	mutex_unlock(&it->lock);
}

static struct vm_operations_struct itimer_vm_ops = {
	.open = itimer_vm_open,
	.close = itimer_vm_close,
};

static int
itimer_mmap(struct file *file, struct vm_area_struct *vma)
{
	struct itimer *it = file->private_data;
	unsigned long limit;
	struct page *page;

	if (vma->vm_pgoff != 0 || vma->vm_end - vma->vm_start != PAGE_SIZE)
		return -EINVAL;

	limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur >> PAGE_SHIFT;
	if (current->mm->locked_vm >= limit || !capable(CAP_IPC_LOCK))
		return -EAGAIN;
	vma->vm_flags |= VM_LOCKED;
	vma->vm_flags |= VM_RESERVED; // necessary?  af_packet doesn't do it.
	vma->vm_ops = &itimer_vm_ops;

	mutex_lock(&it->lock);
	page = it->mm_page;
	if (!page) {
		page = alloc_page(GFP_USER | __GFP_ZERO);
		if (!page) {
			mutex_unlock(&it->lock);
			return -ENOMEM;
		}
		it->mm_page = page;
	}
	mutex_unlock(&it->lock);
	vma->vm_ops->open(vma);
	return vm_insert_page(vma, vma->vm_start, page);
}

#endif /* ITIMER_MMAP *************************/

static struct file_operations itimer_fops = {
	.owner		= THIS_MODULE,
	.open		= itimer_open,
	.release	= itimer_release,
	.llseek		= no_llseek,
	.read		= itimer_read,
	.write		= itimer_write,
	.poll		= itimer_poll,
#ifdef ITIMER_MMAP
	.mmap		= itimer_mmap,
#endif
};

static struct miscdevice itimer_miscdev = {
	.minor		= ITIMER_MINOR,
	.name		= "itimer",
	.fops		= &itimer_fops,
};

static int __init
itimer_init(void)
{
	printk("Interval Timer"_MM" - %u/%u/%u\n", HZ, CLOCK_TICK_RATE, LATCH);
	return misc_register(&itimer_miscdev);
}

static void __exit
itimer_exit(void)
{
	misc_deregister(&itimer_miscdev);
}

module_init(itimer_init);
module_exit(itimer_exit);

MODULE_DESCRIPTION("Interval Timer"_MM);
MODULE_AUTHOR("Edgar Toernig's Bonobo");
MODULE_LICENSE("Public Domain");	// as Bonobos don't benefit from
MODULE_ALIAS_MISCDEV(ITIMER_MINOR);	//			copyright law.
MODULE_SUPPORTED_DEVICE("itimer");
--->8---
*EOF*
