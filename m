Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSJUWB3>; Mon, 21 Oct 2002 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJUWB3>; Mon, 21 Oct 2002 18:01:29 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:28811
	"EHLO www.piet.net") by vger.kernel.org with ESMTP
	id <S261663AbSJUWBT>; Mon, 21 Oct 2002 18:01:19 -0400
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
From: Piet Delaney <piet@www.piet.net>
To: Christoph Hellwig <hch@sgi.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>, linux-kernel@vger.kernel.org,
       piet <piet@www.piet.net>, Keith Owens <kaos@ocs.com.au>,
       steiner@sgi.com, jeremy@classic.engr.sgi.com
In-Reply-To: <20021021172112.C14993@sgi.com>
References: <200210211016.g9LAG5J21214@nakedeye.aparity.com> 
	<20021021172112.C14993@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:06:59 -0700
Message-Id: <1035238019.4123.85.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 14:21, Christoph Hellwig wrote:
> On Mon, Oct 21, 2002 at 03:16:05AM -0700, Matt D. Robinson wrote:
> > diff -Naur linux-2.5.44.orig/drivers/dump/Makefile linux-2.5.44.lkcd/drivers/dump/Makefile
> > --- linux-2.5.44.orig/drivers/dump/Makefile	Wed Dec 31 16:00:00 1969
> > +++ linux-2.5.44.lkcd/drivers/dump/Makefile	Sat Oct 19 12:39:15 2002
> > @@ -0,0 +1,30 @@
> > +#
> > +# Makefile for the dump device drivers.
> > +#
> > +# 12 June 2000, Christoph Hellwig <schch@pe.tu-clausthal.de>
> > +# Rewritten by Matt D. Robinson (yakker@sourceforge.net) for
> > +# the dump directory.
> 
> *cough* is that an old mail address and I can't even remember having
> touched that file.. :)  What about remoing that note..
> 
> > +#include <linux/devfs_fs_kernel.h>
> 
> Can't see any devfs code used in this file..
> 
> > +#include <linux/delay.h>
> > +#include <linux/reboot.h>
> > +#include <linux/fs.h>
> > +#include <linux/mm.h>
> > +#include <linux/swap.h>
> > +#include <linux/dump.h>
> > +#include <linux/smp_lock.h>
> 
> Can't see lock_kernel/unlock_kernel used in this file,
> please check whether you have more unneeded includes.
> 
> > +/* 
> > + * Handle printing of 64-bit values  
> > + *
> > + * NOTE: on ia64 %llx is recommended for ia32. 
> > + *       on RedHat 7.2 	%llx work in user space but not in the kernel.
> > + *	 Perhaps this is dependent on the kernel version.
> > + */
> > +#if BITS_PER_LONG == 64
> > +#define PU64X "%lx"
> > +#else
> > +#define PU64X "%Lx"
> > +#endif
> 
> Argg.  Just always cast to long long and use %llx.

At Sun they consider that to be of poor taste. I used this
approach after having been "educated" by the Solaris kernel
folks about this. It's likely a religious issue. I like
the simplicity of casting to long long and useing %llx.


> 
> > +/* Dump tunables */
> > +kdev_t dump_device;                /* the actual kdev_t device number      */
> 
> Should be dev_T.
> 
> > +int dump_level;                    /* the current dump level               */
> > +int dump_compress;                 /* whether to try to compress each page */
> > +int dump_flags;                    /* whether to try to compress each page */
> > +
> > +/* Dump Notifier Tunables */
> > +long dump_scheduler_enabled = 0;     /* Default: scheduler is disabled     */
> > +long dump_interrupts_enabled = 1;    /* Default: interrupts stay enabled   */
> > +long dump_nondisruptive_enabled = 1; /* Default: non-disruptive enabled    */
> > +
> > +/* Other global fields */
> > +void *dump_page_buf;               /* dump page buffer for memcpy()!       */
> > +void *dump_page_buf_0;             /* dump page buffer returned by kmalloc */
> > +dump_header_t dump_header;         /* the primary dump header              */
> > +dump_header_asm_t dump_header_asm; /* the arch-specific dump header        */
> > +loff_t dump_fpos;                  /* the offset in the output device      */
> > +int dump_mbanks;		   /* number of  physical memory banks     */
> > +dump_mbank_t dump_mbank[MAXCHUNKS];/* describes layout of physical memory  */
> > +long dump_unreserved_mem = 0;      /* Save Pages even if it isn't reserved */
> > +long dump_unreferenced_mem = 0;    /* Save Pages even if page_count == 0   */
> > +long dump_nonconventional_mem = 0; /* Save non-conventional mem (firmware) */
> > +volatile int dump_started = 0;	   /* Indicated we are about to dump       */
> 
> Using volatile is almost always a bug.  USe atomic variables
> or bitops instead.

Yea, volatile is just being used to implement a simple atomic variable. 


> > +static struct dump_operations *dump_device_ops = 0;
> > +
> > +static int dump_compress_none(char *old, int oldsize, char *new, int newsize);
> 
> How many of those could be static?
> 
> > +
> > +static dump_compress_t dump_none_compression = {
> > +	compress_type:	DUMP_COMPRESS_NONE,
> > +	compress_func:	dump_compress_none,
> > +};
> 
> C99 initializers.

What's C99?


> 
> > +#if DUMP_DEBUG
> > +void dump_bp(void) {}
> > +#endif
> 
> Doesn't seem to be implemented at all.

.
dump_bp() is just a debugging hook that's
enabled while debugging the lkcd dump driver.
DUMP_DEBUG can be defined in dump.h and allows
the kernel and user space code to be instrumented
for easier debugging. I found it useful while debugging.

 

 
> 
> > + * Name: dump_read_proc()
> > + * Func: Read the proc data for dump tunables.
> > + */
> > +static int
> > +dump_read_proc(char *page, char **start, off_t off,
> > +	int count, int *eof, void *data)
> > +{
> > +	int len;
> > +	char *out = page;
> > +	struct proc_dir_entry *p = (struct proc_dir_entry *)data;
> > +
> > +
> > +	if (0 == strcmp(p->name, DUMP_LEVEL_NAME)) {
> > +		out += sprintf(out, "%d\n", dump_level);
> > +		len = out - page;
> > +	} else if (0 == strcmp(p->name, DUMP_FLAGS_NAME)) {
> > +		out += sprintf(out, "%d\n", dump_flags);
> > +		len = out - page;
> > +	} else if (0 == strcmp(p->name, DUMP_COMPRESS_NAME)) {
> > +		out += sprintf(out, "%d\n", dump_compress);
> > +		len = out - page;
> > +	} else if (0 == strcmp(p->name, DUMP_DEVICE_NAME)) {
> > +		out += sprintf(out, "0x%x\n", kdev_val(dump_device));
> > +		len = out - page;
> > +	} else {
> > +		return (0);
> > +	}
> > +	len -= off;
> > +	if (len < count) {
> > +		*eof = 1;
> > +		if (len <= 0) return 0;
> > +	} else {
> > +		len = count;
> > +	}
> > +	*start = page + off;
> > +	return (len);
> > +}
> 
> This wants to be changed to either seq_file or sysctl.  Sysctl
> might be better for the one value per file approach.

Perhaps the usefulness of the various aproaches during early startup
should be considered. In RedHat 8.0 there does seem to be existant
hooks for user space core dumps in /etc/sysctl.conf:
----------------------------------------------------------------------
 Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
kernel.core_uses_pid =
----------------------------------------------------------------------
When is /etc/sysctl.conf read by the kernel?

Supporting core file generation as soon as possible during startup
should be given high priority.
 

> 
> > +static int
> > +dump_compress_none(char *old, int oldsize, char *new, int newsize)
> > +{
> > +	/* just return the old size */
> > +	return (oldsize);
> 
> return style again.
> 
> > +void dump_scheduler_enable(void)
> > +{
> > +	DUMP_DPRINTF("setting dump_scheduler_enabled = 1\n");
> > +	dump_scheduler_enabled = 1;
> > +}
> 
> Can't see this called anywhere

It's a callback used by the dump driver. These callbacks are
used by disk drivers, like the SGI SCSI driver, to tune the
dump driver for it's needs. The callback facility was added
to the dump driver and this tuning for the device driver seemed
like a natural user of the facility. 

> 
> > +
> > +void dump_interrupts_disable(void)
> > +{
> > +	DUMP_DPRINTF("setting dump_interrupts_enabled = 0\n");
> > +	dump_interrupts_enabled = 0;
> > +}
> 
> Dito.

For example, the SGI SCSI driver may need to have interrupts 
disabled once the SCSI driver switches to dump mode. When
I added this the SGI SCSI driver had to run with interrupts
disabled once the disk driver was setup for dumping. Actually
dumping with interrupts enabled will likely eventually not
be supported.


> 
> > +
> > +void dump_nondisruptive_disable(void)
> > +{
> > +	DUMP_DPRINTF("setting dump_nondisruptive_enabled = 0\n");
> > +	dump_nondisruptive_enabled = 0;
> > +}
> 
> Dito.

This is here to allow the dump driver to avoid trying to do
a nondistruptive dump when in fact the disk driver can support it.
If not here the nondisruptive dump will hang. This just makes
the dump driver bullet proof.


> 
> > +static int
> > +dump_add_page(unsigned long page_index, unsigned long *toffset, int pass)
> > +{
> > +#if defined(CONFIG_X86) || defined(CONFIG_ALPHA)
> > +	extern int page_is_ram(unsigned long);
> > +#endif
> 
> Yuck.  Please just declare page_is_ram for every port.
> 
> > +#if !defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_IA64)
> > +	p = (struct page *) &(mem_map[page_index]);
> 
> Yuck.  Please don't use mem_map in common code.

Yea the NUMA Ia64 code can't use it; I dind't see
and easy way of replacing it. What do you suggest?



> 
> > +#ifdef CONFIG_HIGHMEM
> > +	if (PageHighMem(p)) {
> > +		/*
> > +		 * Since this can be executed from IRQ context,
> > +		 * reentrance on the same CPU must be avoided:
> > +		 */
> > +		vaddr = kmap_atomic(p, KM_USER0);
> > +	}
> > +	else
> 
> kmap_atomic is a noop for !CONFIG_HIGHMEM - make this code unconditional.
> 
> > +#if !defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_IA64)
> > +	if (!kern_addr_valid(dp.dp_address)) {
> > +		/* dump of I/O memory not supported yet */
> > +		printk(KERN_ALERT "dump_add_page: !kern_addr_valid"
> > +				"(dp.dp_address: " PU64X "\n", dp.dp_address);
> > +		return(1);
> > +	}
> > +#endif
> 
> Why don't you do this 

Perhaps it could. Perhaps kern_addr_valid() doesn't work for ia64.
I'd have to check to be sure.


> 
> > +static int
> > +dump_ioctl(struct inode *i, struct file *f, unsigned int cmd, unsigned long arg)
> > +{
> > +	/* check capabilities */
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return (-EPERM);
> > +
> > +	/*
> > +	 * This is the main mechanism for controlling get/set data
> > +	 * for various dump device parameters.  The real trick here
> > +	 * is setting the dump device (DIOSDUMPDEV).  That's what
> > +	 * triggers everything else.
> > +	 */
> > +	switch (cmd) {
> > +		/* set dump_device */
> > +		case DIOSDUMPDEV:
> > +			/* check flags */
> > +			if (!(f->f_flags & O_RDWR))
> > +				return (-EPERM);
> > +
> > +			__dump_open();
> > +			return (dump_open_kdev(to_kdev_t((dev_t)arg)));
> > +
> > +		/* get dump_device */
> > +		case DIOGDUMPDEV:
> > +			return (put_user((long)kdev_val(dump_device), (long *)arg));
> > +
> > +		/* set dump_level */
> > +		case DIOSDUMPLEVEL:
> > +			/* check flags */
> > +			if (!(f->f_flags & O_RDWR))
> > +				return (-EPERM);
> > +
> > +			/* make sure we have a positive value */
> > +			if (arg < 0)
> > +				return (-EINVAL);
> > +			dump_level = (int)arg;
> > +
> > +			/*
> > +			 * REMIND: Still in development:
> > +			 * We will consider reserved pages a initial proxy 
> > +			 * for kernel pages.
> > +			 */
> > +			if (dump_level > DUMP_LEVEL_KERN)
> > +				dump_unreserved_mem = 1;
> > +			else
> > +				dump_unreserved_mem = 0;
> > +
> > +			/*
> > +			 * REMIND: Still in development:
> > +			 * Using refcount > 1 as a proxy for kernel & user 
> > +			 * pages.
> > +			 */
> > +			if (dump_level > DUMP_LEVEL_USED)
> > +				dump_unreferenced_mem = 1;
> > +			else
> > +				dump_unreferenced_mem = 0;
> > +
> > +			/*
> > +			 *  REMIND: Still in development:
> > +			 *	This may not be 100% stable on all ia64
> > +			 *	memory banks. Accessing uncached memory
> > +			 *	with cached accesses can cause subsequent
> > +			 *	bus errors when the cache is flushed.
> > +			 */
> > +			if (dump_level > DUMP_LEVEL_ALL_RAM)
> > +				dump_nonconventional_mem = 1;
> > +			else
> > +				dump_nonconventional_mem = 0;
> > +			break;
> > +
> > +		/* get dump_level */
> > +		case DIOGDUMPLEVEL:
> > +			return (put_user((long)dump_level, (long *)arg));
> > +
> > +		/* set dump_flags */
> > +		case DIOSDUMPFLAGS:
> > +			/* check flags */
> > +			if (!(f->f_flags & O_RDWR))
> > +				return (-EPERM);
> > +
> > +			/* make sure we have a positive value */
> > +			if (arg < 0)
> > +				return (-EINVAL);
> > +
> > +			dump_flags = (int)arg;
> > +			break;
> > +
> > +		/* get dump_flags */
> > +		case DIOGDUMPFLAGS:
> > +			return (put_user((long)dump_flags, (long *)arg));
> > +
> > +		/* set the dump_compress status */
> > +		case DIOSDUMPCOMPRESS:
> > +			/* check flags */
> > +			if (!(f->f_flags & O_RDWR))
> > +				return (-EPERM);
> > +
> > +			return (dump_compress_init((int)arg));
> > +
> > +		/* get the dump_compress status */
> > +		case DIOGDUMPCOMPRESS:
> > +			return (put_user((long)dump_compress, (long *)arg));
> > +
> > +	}
> > +	return (0);
> 
> I don't think ioctl is the right interface.  Most of those want to be sysctls.

When can sysctls be set up? Earlier that ioctls() can be used? Perhaps
something very early in startup should be used; like kernel boot
options. 




> 
> > +/*
> > + * Name: dump_open()
> > + * Func: Open the dump device for use when the system crashes.
> > + */
> > +static int
> > +dump_open(struct inode *i, struct file *f)
> > +{
> > +	/* opening a device is straightforward -- nothing to do here */
> > +	return (0);
> > +}
> 
> Remove it.
> 
> > +/*
> > + * Name: dump_init()
> > + * Func: Initialize the dump process.  This will set up any architecture
> > + *       dependent code.  The big key is we need the memory offsets before
> > + *       the page table is initialized, because the base memory offset
> > + *       is changed after paging_init() is called.
> > + */
> > +int __init
> > +dump_init(void)
> 
> static
> 
> > +{
> > +	struct sysinfo info;
> > +	int i; 
> > +
> > +	/* try to initialize /proc interfaces */
> > +	if (dump_proc_init() < 0) {
> > +		DUMP_PRINTF("dump_proc_init failed!; dump not initialized\n");
> > +		return (-EBUSY);
> > +	}
> > +
> > +	/* try to create our dump device */
> > +	if (register_chrdev(DUMP_MAJOR, "dump", &dump_fops)) {
> > +		DUMP_PRINTF("cannot register dump character device!\n");
> > +		return (-EBUSY);
> > +	}
> > +
> > +	/* initialize the dump headers to zero */
> > +	memset(&dump_header, 0, sizeof(dump_header));
> > +	memset(&dump_header_asm, 0, sizeof(dump_header_asm));
> > +
> > +#if    !defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_IA64)
> > +	/* 
> > +	 * CONFIG_DISCONTIGMEM and CONFIG_IA64 systems are responsible 
> > +	 * for initializing dump_mbank[] in __dump_init().
> > +	 */
> > +	dump_mbanks = 1;
> > +	dump_mbank[0].start = 0;
> > +	dump_mbank[0].end  = (((u64) max_mapnr) << PAGE_SHIFT) - 1;
> > +	dump_mbank[0].type = DUMP_MBANK_TYPE_CONVENTIONAL_MEMORY;
> > +#endif
> 
> Just move it to arch code for everyone.

What's wrong with having code which is common for most
arch's in the dump driver. Seems to me it keeps things
easier to understand. With ia64 being the only arch
with special needs, it seems cleaner to just have common
code handle the common situation.




> 
> > +void __exit
> > +dump_cleanup(void)
> 
> static
> 
> > +	/* try to create our dump device */
> > +	if (unregister_chrdev(DUMP_MAJOR, "dump"))
> > +		DUMP_PRINT("cannot unregister dump character device!\n");
> 
> the printk is rather pointless..

Why is that?


> 
> > +#ifdef MODULE
> > +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,16))
> > +#if !defined(MODULE_LICENSE)
> > +#define MODULE_LICENSE(str)
> > +#endif
> > +#endif
> 
> kill this ifdef junk.
> 
> > +
> > +#define DUMP_MODULE_NAME "dump_blockdev"
> 
> doesn't seem to be used.
> 
> > +
> > +/*
> > + * -----------------------------------------------------------------------
> > + *                         V A R I A B L E S
> > + * -----------------------------------------------------------------------
> > + */
> > +kdev_t dump_dev;   	           /* the actual kdev_t device number      */
> 
> didn't we already have this one in dump_base.c?
I thought this is dump_base.c


> 
> > +void *dump_page_buffer;            /* dump page buffer for memcpy()!       */
> > +int dump_blk_size;                 /* sector size for dump_device          */
> > +int dump_blk_shift;                /* shift need to convert to sector size */
> > +struct bio *dump_bio;              /* bio structure for io request         */
> > +loff_t dump_offset;                /* the offset in the output device      */
> > +struct block_device *dump_bdev = NULL;
> > +unsigned long dumpdev_limit;	   /* the size limit of the block device   */
> > +volatile int bio_complete = 1;/* Indicates the completion of each bio request */
> > +int dump_io_abort = 0;		   /* set by end_io routine during io error */
> 
> Shouldn't much of this be static? again volatile is seldomly a good idea.

I suppose  with 'bio_complete' being an int changing it's value is
atomic as long as it's treated a a volatile.Using a spinlock might
be cleaner.


 
> 
> > +static void
> > +dump_free_bio(void)
> > +{
> > +	if (dump_bio && dump_bio->bi_io_vec)
> > +		kfree(dump_bio->bi_io_vec);
> > +	if (dump_bio)
> > +		kfree(dump_bio);
> > +}
> 
> kfree(NULL) is fine.
> 
> > +/*
> > + * Name: dump_open_kdev()
> > + * Func: Try to open the kdev_t argument as the real dump device.
> > + *       This is where all the work is done for setting up the dump
> > + *       device.  It's assumed at this point that by passing in the
> > + *       dump device's major/minor number, we can open it up, check
> > + *       it out, and use it for whatever purposes.
> > + */
> > +static int
> > +dump_open_kdev(kdev_t tmp_dump_device)
> 
> Should take a dev_t.
> 
> > +	/* release earlier dump_bdev if present */
> > +	if (dump_bdev) {
> > +		blkdev_put(dump_bdev, BDEV_RAW);
> > +		dump_bdev = NULL;
> > +	}
> 
> Shouldn't this have gone away in ->close?
> 
> > +
> > +	dump_bdev = bdget(kdev_t_to_nr(tmp_dump_device));
> > +	if (!dump_bdev) {
> > +		retval = -ENODEV;
> > +		goto err;
> > +	}
> > +
> > +	if (blkdev_get(dump_bdev, O_RDWR | O_LARGEFILE, 0, BDEV_RAW)) {
> > +		retval = -ENODEV;
> > +		goto err1;
> > +	}
> 
> bd_claim is missing
> 
> > +	
> > +	if ((dump_page_buffer== (void *)NULL)) {
> 
> (void *)NULL) is silly
> 
> > +		retval = -EINVAL;
> > +		goto err2;
> > +	}
> > +
> > +	if (dump_bio)
> > +		dump_free_bio();
> > +
> > +	if ((dump_bio = kmalloc(sizeof(struct bio), GFP_KERNEL)) == NULL) {
> > +		DUMP_PRINTF("Cannot allocate bio\n");
> > +		retval = -ENOMEM;
> > +		goto err2;
> > +	}
> 
> Shouldn't you use the generic bio allocator?
> 
> > +static int
> > +dev_dump_ioctl(unsigned int cmd, unsigned long arg)
> > +{
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * This is the main mechanism for controlling get/set data
> > +	 * for various dump device parameters.  The real trick here
> > +	 * is setting the dump device (DIOSDUMPDEV).  That's what
> > +	 * triggers everything else.
> > +	 */
> > +	switch (cmd) {
> > +		case DIOSDUMPDEV:
> > +			ret = dump_open_kdev(to_kdev_t((dev_t)arg));
> > +			break;	
> > +		case DIOSDUMPMEM:
> > +			dump_page_buffer = (void *)arg;
> > +			break;
> > +		default:
> > +			break;
> > +
> > +	}
> > +	return (ret);
> > +}
> 
> ioctl is not a replacement for sane interfaces again!
> 
> > +static struct dump_operations dump_blockdev_ops = {
> > +	dump_open:		dev_dump_open,
> > +	dump_release:	        dev_dump_release,
> > +	dump_ioctl:		dev_dump_ioctl,
> > +        dump_write:             dev_dump_write,
> > +	dump_seek:              dev_dump_seek,
> > +	dump_start:             dev_dump_start,
> > +        dump_end:               dev_dump_end,
> > +	dump_ready:             dev_dump_ready,
> > +};
> 
> Indentation seems strange, wants C99 initializers.
> 
> > +int __init
> > +dump_blockdev_init(void)
> 
> static
> 
> > +{        
> > +	dump_page_buffer = NULL;
> > +	dump_offset = 0;
> 
> .bbs is per-zeroed.
> 
> > +void __exit
> > +dump_blockdev_cleanup(void)
> 
> static.
> 
> > +#ifdef MODULE
> > +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,16))
> > +#if !defined(MODULE_LICENSE)
> > +#define MODULE_LICENSE(str)
> > +#endif
> > +#endif
> > +
> > +MODULE_AUTHOR("Mohamed. Abbas");
> > +MODULE_DESCRIPTION("Block Device Driver for Linux Kernel Crash Dump (LKCD)");
> > +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,16))
> > +MODULE_LICENSE("GPL");
> > +#endif
> > +#endif /* MODULE */
> 
> more ifdef-crap to kill.
> 
> > +	int i;
> > +	void *ptr;
> > +	
> > +	if (dump_header_asm.dha_stack[0])
> > +		return 0;
> > +
> > +       	ptr = vmalloc(THREAD_SIZE * num_online_cpus());
> > +	if (!ptr) {
> 
> very strange indention..
> 
> > +typedef struct _dump_header_asm_s {
> 
> Please DON'T do typedefs.  just struct _dump_header_asm!
> 
> > +        /* the dump magic number -- unique to verify dump is valid */
> > +        uint64_t             dha_magic_number;
> 
> u64 & co
> 
> > +#ifdef __KERNEL__
> 
> kernel/user headers usually aren't shared..
> 
> > +/* define TRUE and FALSE for use in our dump modules */
> > +#ifndef FALSE
> > +#define FALSE 0
> > +#endif
> > +
> > +#ifndef TRUE
> > +#define TRUE 1
> > +#endif
> 
> Please just use 0/1 like evreryone else.
> 
> > +#if DUMP_DEBUG
> > +void dump_bp(void);			/* Called when something exceptional occurs */
> > +#define DUMP_BP() dump_bp()			/* Breakpoint */
> > +#else
> > +#define DUMP_BP()
> > +#endif
> 
> It doesn't look like this actually works.

It works; I used it while debugging the ia64 port.




> 
> > +/* necessary header definitions in all cases */
> > +#define DUMP_KIOBUF_NUMBER  0xdeadbeef  /* special number for kiobuf maps   */
> 
> kiobufs are gone in 2.5.44.
> 
> > +typedef struct dump_mbank {
> > +        u64 		start;
> > +        u64 		end;
> > +	int		type;
> > +	int		pad1;
> > +	long		pad2;
> > +} dump_mbank_t;
> 
> identation is once again rather strange.
> 
> > +#ifndef KERNEL_VERSION
> > +#define KERNEL_VERSION(a,b,c) (((a) << 16) | ((b) << 8) | (c))
> > +#endif
> 
> kill this.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
piet@www.piet.net

