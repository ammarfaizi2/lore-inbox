Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUB0XJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbUB0XJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:09:22 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:45285 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S263197AbUB0XHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:07:46 -0500
Message-Id: <200402272309.i1RN98bk002304@nikto.sfbay.sun.com>
Date: Fri, 27 Feb 2004 15:09:08 -0800 (PST)
From: Ralph Campbell <ralphc@nikto.sfbay.sun.com>
Reply-To: Ralph Campbell <ralphc@nikto.sfbay.sun.com>
Subject: wait_queue_t is fundamentally broken; need pthread_cond_t
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: 3DKTKOVLN9LblyiHOiQd+g==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.6_41 SunOS 5.10 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
	wait_queue_t is fundamentally broken; need pthread_cond_t

[2.] Full description of the problem/report:
	I hate to be the bearer of bad news but the programming model
	for using wait queues is fundamentally broken and should be
	replaced with something like pthread_cond_t. Here is an example
	taken from chapter 5 of "Linux Device Drivers", 2nd edition,
	by Rubini & Corbet:

ssize_t scull_p_read (struct file *filp, char *buf, size_t count,
        loff_t *f_pos)
{
  Scull_Pipe *dev = filp->private_data;

  if (f_pos != &filp->f_pos) return -ESPIPE;

  if (down_interruptible(&dev->sem))
    return -ERESTARTSYS;
  while (dev->rp == dev->wp) { /* nothing to read */
    up(&dev->sem); /* release the lock */
    if (filp->f_flags & O_NONBLOCK)
      return -EAGAIN;
    PDEBUG("\"%s\" reading: going to sleep\n", current->comm);
    if (wait_event_interruptible(dev->inq, (dev->rp != dev->wp)))
      return -ERESTARTSYS; /* signal: tell the fs layer to handle it */
    /* otherwise loop, but first reacquire the lock */
    if (down_interruptible(&dev->sem))
      return -ERESTARTSYS;
  }
  /* ok, data is there, return something */
  if (dev->wp > dev->rp)
    count = min(count, dev->wp - dev->rp);
  else /* the write pointer has wrapped, return data up to dev->end */
    count = min(count, dev->end - dev->rp);
  if (copy_to_user(buf, dev->rp, count)) {
    up (&dev->sem);
    return -EFAULT;
  }
  dev->rp += count;
  if (dev->rp == dev->end)
    dev->rp = dev->buffer; /* wrapped */
  up (&dev->sem);

  /* finally, awaken any writers and return */
  wake_up_interruptible(&dev->outq);
  PDEBUG("\"%s\" did read %li bytes\n",current->comm, (long)count);
  return count;
}

	The problem is that the condition is only protected from changing
	when the dev->sem lock is held. The reader thread calling
	wait_event_interruptible() can check the condition but since it
	doesn't hold the lock, the writer thread can get the lock, put
	something in the buffer, unlock, and call wake_up_interruptible().
	The reader thread now sleeps waiting for a wake up
	that may never happen.

	Chapter 3 of "Programming with Threads" by Steve Kleiman, et. al.
	describes how to use pthread_cond_t.  Here is a very small example of
	of waiting for a condition:

	/* In one thread (e.g., the reader). */
	pthread_mutex_lock(&lock);
	while (!condition) {
		/* mutex is released during wait */
		pthread_cond_wait(&cv, &lock);
		/* mutex is reacquired after sleeping */
	}
	pthread_mutex_unlock(&lock);

	/* In another thread (e.g., the writer). */
	pthread_mutex_lock(&lock);
	condition = true;
	pthread_cond_signal(&cv);
	pthread_mutex_unlock(&lock);

	The difference between this example and using wait_queue_t is that
	the check for the condition and being put on the wait queue are
	atomic. There can be no missed wake_up()/pthread_cond_signal().

	The wait_event_interruptible() macro attempts to fix the problem
	by retesting the condition before calling schedule() but since
	no lock is held, this only reduces the race window.

	Other macros have similar problems such as add_wait_queue_cond().

	I know this is a big clean up job and reeducation effort to
	fix this problem.  However, the effort involved doesn't make
	the problem go away.


[3.] Keywords (i.e., modules, networking, kernel):
	kernel, locking, SMP

[4.] Kernel version (from /proc/version):
	2.4.x and 2.6.x



