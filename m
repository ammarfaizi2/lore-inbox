Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286406AbRLTVkJ>; Thu, 20 Dec 2001 16:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286395AbRLTVhe>; Thu, 20 Dec 2001 16:37:34 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:2529 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S286396AbRLTVgr>; Thu, 20 Dec 2001 16:36:47 -0500
Message-ID: <3C2259E2.4070504@superbt.com>
Date: Thu, 20 Dec 2001 16:36:34 -0500
From: Ilguiz Latypov <ilatypov@superbt.com>
Organization: SuperBT Canada, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: sjh@wibble.net
Subject: Re: pc speaker cant be accessed with no video card in computer
Content-Type: multipart/mixed;
 boundary="------------000509060406030303050102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509060406030303050102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



I guess it is not easy to produce a series of sounds without
waiting each note to finish.  There is an 8 year old PC speaker
driver for BSD kernel that performs the BASIC PLAY lines in kernel.

Rather than porting it to Linux I chose a simple option of copying
the ioctl PC speaker code into a skeleton misc character device
driver.  As a result I can issue ioctl "beep" calls against my
/dev/pcspeaker (character device with major number 10, minor number
240).  E.g., replacing "/dev/console" with "/dev/pcspeaker" in
PCMCIA cardmgr.c will revive its sound effects.

Please pardon my ignorance in kernel linking.  I don't know how to
refer to the existing _kd_mksound() code from the loadable module.
So I just cut and pasted the code from vt.c.

Ilguiz

From: Steven Hanley (sjh@wibble.net)
Date: Thu Jun 01 2000 - 23:36:57 EST
[...]
 > Basically the pc speaker access from userspace is tied to having a
 > valid tty in the machine. When there is no tty in the computer the pc
 > speaker wont work. This of course means you need a video card in said
 > machine.
[...]

--------------000509060406030303050102
Content-Type: text/plain;
 name="pcspeaker.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcspeaker.c"

#define PCSPEAKER_VERSION "1.0"
#define PCSPEAKER_MINOR 240

#include <linux/module.h>
#include <linux/config.h>
#include <linux/sched.h>
#include <linux/smp_lock.h>

#if !defined(__i386__) && !defined(__x86_64__)
#error Cannot build speaker driver for this machine configuration.
#endif

#include <linux/types.h>
#include <linux/errno.h>
#include <linux/miscdevice.h>
#include <linux/ioport.h>
#include <linux/fcntl.h>
#include <linux/init.h>
#include <linux/proc_fs.h>
#include <linux/spinlock.h>
#include <linux/vt_kern.h>
#include <linux/timex.h>

#include <asm/io.h>
#include <asm/uaccess.h>
#include <asm/system.h>

static int pcspeaker_open_cnt;	/* #times opened */
static int pcspeaker_open_mode;	/* special open modes */
#define	PCSPEAKER_WRITE	1	/* opened for writing (exclusive) */
#define	PCSPEAKER_EXCL	2	/* opened with O_EXCL */

/* I don't know how to link this module agains _kd_mktone() in
   drivers/char/vt.c -- Ilguiz Latypov
 */

/*
 * Generates sound of some frequency for some number of clock ticks
 *
 * If freq is 0, will turn off sound, else will turn it on for that time.
 * If msec is 0, will return immediately, else will sleep for msec time, then
 * turn sound off.
 *
 * We also return immediately, which is what was implied within the X
 * comments - KDMKTONE doesn't put the process to sleep.
 */

#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
    || (defined(__mips__) && defined(CONFIG_ISA)) \
    || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE)) \
    || defined(__x86_64__)

static void
kd_nosound(unsigned long ignored)
{
	/* disable counter 2 */
	outb(inb_p(0x61)&0xFC, 0x61);
	return;
}

void
_kd_mksound2(unsigned int hz, unsigned int ticks)
{
	static struct timer_list sound_timer = { function: kd_nosound };
	unsigned int count = 0;
	unsigned long flags;

	if (hz > 20 && hz < 32767)
		count = 1193180 / hz;
	
	save_flags(flags);
	cli();
	del_timer(&sound_timer);
	if (count) {
		/* enable counter 2 */
		outb_p(inb_p(0x61)|3, 0x61);
		/* set command for counter 2, 2 byte write */
		outb_p(0xB6, 0x43);
		/* select desired HZ */
		outb_p(count & 0xff, 0x42);
		outb((count >> 8) & 0xff, 0x42);

		if (ticks) {
			sound_timer.expires = jiffies+ticks;
			add_timer(&sound_timer);
		}
	} else
		kd_nosound(0);
	restore_flags(flags);
	return;
}

#else

void
_kd_mksound2(unsigned int hz, unsigned int ticks)
{
}

#endif

static long long pcspeaker_llseek(struct file *file,loff_t offset, int origin )
{
	return 0;
}

static ssize_t pcspeaker_read(struct file * file,
	char * buf, size_t count, loff_t *ppos )
{
	return 0;
}

static ssize_t pcspeaker_write(struct file * file,
		const char * buf, size_t count, loff_t *ppos )
{
	return 0;
}

static int pcspeaker_ioctl( struct inode *inode, struct file *file,
				unsigned int cmd, unsigned long arg )
{
	int perm;
	
	perm = 0;
	if (suser())
		perm = 1;
 
	switch( cmd ) {
	case KIOCSOUND:
		if (!perm)
			return -EPERM;
		if (arg)
			arg = CLOCK_TICK_RATE / arg;
		_kd_mksound2(arg, 0);
		return 0;

	case KDMKTONE:
		if (!perm)
			return -EPERM;
	{
		unsigned int ticks, count;
		
		/*
		 * Generate the tone for the appropriate number of ticks.
		 * If the time is zero, turn off sound ourselves.
		 */
		ticks = HZ * ((arg >> 16) & 0xffff) / 1000;
		count = ticks ? (arg & 0xffff) : 0;
		if (count)
			count = CLOCK_TICK_RATE / count;
		_kd_mksound2(count, ticks);
		return 0;
	}
	  default:
		return( -EINVAL );
	}
}

static int pcspeaker_open( struct inode *inode, struct file *file )
{
	if ((pcspeaker_open_cnt && (file->f_flags & O_EXCL)) ||
		(pcspeaker_open_mode & PCSPEAKER_EXCL) ||
		((file->f_mode & 2) && (pcspeaker_open_mode & PCSPEAKER_WRITE)))
		return( -EBUSY );

	if (file->f_flags & O_EXCL)
		pcspeaker_open_mode |= PCSPEAKER_EXCL;
	if (file->f_mode & 2)
		pcspeaker_open_mode |= PCSPEAKER_WRITE;
	pcspeaker_open_cnt++;
	return( 0 );
}

static int pcspeaker_release( struct inode *inode, struct file *file )
{
	lock_kernel();
	pcspeaker_open_cnt--;
	if (file->f_flags & O_EXCL)
		pcspeaker_open_mode &= ~PCSPEAKER_EXCL;
	if (file->f_mode & 2)
		pcspeaker_open_mode &= ~PCSPEAKER_WRITE;
	unlock_kernel();

	return( 0 );
}

static struct file_operations pcspeaker_fops = {
	owner:		THIS_MODULE,
	llseek:		pcspeaker_llseek,
	read:		pcspeaker_read,
	write:		pcspeaker_write,
	ioctl:		pcspeaker_ioctl,
	open:		pcspeaker_open,
	release:	pcspeaker_release,
};

static struct miscdevice pcspeaker_dev = {
	PCSPEAKER_MINOR,
	"pcspeaker",
	&pcspeaker_fops
};


static int __init pcspeaker_init(void)
{
	int ret;

	ret = misc_register( &pcspeaker_dev );
	if (ret) {
		printk(KERN_ERR "pcspeaker: can't misc_register on minor=%d\n", PCSPEAKER_MINOR);
		goto out;
	}
	ret = 0;
	printk(KERN_INFO "PC speaker driver v" PCSPEAKER_VERSION "\n");
out:
	return( ret );
#if 0
outmisc:
	misc_deregister( &pcspeaker_dev );
	goto out;
#endif
}

static void __exit pcspeaker_cleanup_module (void)
{
	misc_deregister( &pcspeaker_dev );
}

module_init(pcspeaker_init);
module_exit(pcspeaker_cleanup_module);

MODULE_LICENSE("GPL");

EXPORT_NO_SYMBOLS;

/*
 * Local variables:
 *  c-indent-level: 4
 *  tab-width: 4
 *  compile-command: "gcc -pipe -mpreferred-stack-boundary=2 -march=i386  -O2 -D__KERNEL__ -I../include -I/home/ilatypov/linux/include -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strict-aliasing  -DMODULE -DMODVERSIONS -include /home/ilatypov/linux/include/linux/modversions.h -c pcspeaker.c -o pcspeaker.o"
 * End:
 */


--------------000509060406030303050102
Content-Type: text/plain;
 name="beep.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="beep.c"

#include <sys/ioctl.h>
#include <sys/kd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <signal.h>
#include <stdio.h>

#define CLOCK_TICK_RATE   1193180

#define NUMNOTES 12
unsigned long notes[NUMNOTES] = { 26163, 27718, 29366, 31113, 32963, 34923, 
                                  37000, 39200, 41530, 44000, 46616, 49388 };

int default_note = 10;  // 1-based

#define DEFAULT_PARAMS_LEN 3
static const char *default_params[DEFAULT_PARAMS_LEN] = { 
                  "beep", "-10", "10" };

static int fd = -1;

void exiting(int signum) {
    int tone = 0;
    if (fd >= 0)
        ioctl(fd, KIOCSOUND, tone);
}

int check_sound_capabilities(const char *filename, int *fd) {
    int tone;
    int lfd;

    if (strcmp(filename, "-")) {
        lfd = open(filename, O_RDONLY);
        if (lfd < 0) {
            perror(filename);
            return 0;
        }
    } else {
        lfd = 0;
    }

    tone = 0;
    if (ioctl(lfd, KIOCSOUND, tone)) {
        close(lfd);
        perror(filename);
        return 0;
    }

    if (fd != NULL) {
        *fd = lfd;
    }

    return 1;
}

int main(int argc, char *argv[]) {
    int i;
    unsigned int tone;
    int hertz, length;
    int param_len;
    const char **params;

    if (!check_sound_capabilities("/dev/pcspeaker", &fd) &&
        !check_sound_capabilities("-", &fd) &&
	!check_sound_capabilities("/dev/tty0", &fd)) {
        exit(EXIT_FAILURE);
    }

    if (argc <= 1) {
        params = default_params;
        param_len = DEFAULT_PARAMS_LEN;
    } else {
        params = (const char **)argv;
        param_len = argc;
    }

    signal(SIGHUP, exiting);
    signal(SIGINT, exiting);
    signal(SIGQUIT, exiting);
    signal(SIGPIPE, exiting);
    signal(SIGTERM, exiting);
    signal(SIGTSTP, exiting);

    for (i = 1; i < param_len; i += 2) {
        hertz = strtol(params[i], NULL, 0);
        if (hertz < 0) {
            if (hertz < -NUMNOTES)
                hertz = -default_note;
            hertz = notes[-hertz - 1];
        }
        if (i + 1 < param_len)
            length = strtol(params[i + 1], NULL, 0);
        else
            length = 10;

        // printf("hertz %d\n", hertz); fflush(stdout);

        tone = (CLOCK_TICK_RATE * 100) / hertz;
        ioctl(fd, KIOCSOUND, tone);
        usleep(((unsigned long)length) * 10000);
        tone = 0;
        ioctl(fd, KIOCSOUND, tone);
    }

    close(fd);
    fd = -1;
    exit(EXIT_SUCCESS);
    return 0;
}

--------------000509060406030303050102
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

all: beep

pcspeaker.o: pcspeaker.c
	gcc -pipe -mpreferred-stack-boundary=2 -march=i386  -O2 -D__KERNEL__ -I../include -I/home/ilatypov/linux/include -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strict-aliasing  -DMODULE -DMODVERSIONS -include /home/ilatypov/linux/include/linux/modversions.h -c pcspeaker.c -o pcspeaker.o

clean:	 
	rm -rf beep *.o *~ *.gdb

--------------000509060406030303050102--

