Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSJYHQL>; Fri, 25 Oct 2002 03:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJYHQL>; Fri, 25 Oct 2002 03:16:11 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:54853 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261295AbSJYHQG>; Fri, 25 Oct 2002 03:16:06 -0400
Date: Fri, 25 Oct 2002 00:30:32 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, <lkcd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] LKCD for 2.5.44 (8/8): dump driver and build files
In-Reply-To: <20021023184020.D16547@infradead.org>
Message-ID: <Pine.LNX.4.44.0210231055090.28800-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Christoph Hellwig wrote:
|>On Wed, Oct 23, 2002 at 02:45:07AM -0700, Matt D. Robinson wrote:
|>The makefile is a bit illogical.  The dump-y stuff doesn't make much sense
|>unless you actually uses it :) E.g.:
|>
|>export-objs				:= dump_base.o
|>
|>dump-y					+= dump_base.o
|>dump-$(CONFIG_ALPHA)			+= dump_alpha.o
|>dump-$(CONFIG_IA64)			+= dump_ia64.o
|>dump-$(CONFIG_X86)			+= dump_i386.o
|>dump-objs				+= $(dump-y)
|>
|>obj-$(CONFIG_CRASH_DUMP)		+= dump.o
|>obj-$(CONFIG_CRASH_DUMP_BLOCKDEV)	+= dump_blockdev.o
|>obj-$(CONFIG_CRASH_DUMP_COMPRESS_RLE)	+= dump_rle.o
|>obj-$(CONFIG_CRASH_DUMP_COMPRESS_GZIP)	+= dump_gzip.o
|>
|>BTW, I can't see the alpha/ia64 stuff actually beeing included.

These are in the works by other development users.

|>> +static kdev_t dump_device;         /* the actual kdev_t device number      */
|>
|>should be dev_t, not kdev_t.

Fixed.

|>> +/*
|>> + * Name: dump_read_proc()
|>> + * Func: Read the proc data for dump tunables.
|>> + */
|>> +static int
|>> +dump_read_proc(char *page, char **start, off_t off,
|>> +	int count, int *eof, void *data)
|>> +{
|>> +	int len;
|>> +	char *out = page;
|>> +	struct proc_dir_entry *p = (struct proc_dir_entry *)data;
|>> +
|>> +
|>> +	if (0 == strcmp(p->name, DUMP_LEVEL_NAME)) {
|>> +		out += sprintf(out, "%d\n", dump_level);
|>> +		len = out - page;
|>> +	} else if (0 == strcmp(p->name, DUMP_FLAGS_NAME)) {
|>> +		out += sprintf(out, "%d\n", dump_flags);
|>> +		len = out - page;
|>> +	} else if (0 == strcmp(p->name, DUMP_COMPRESS_NAME)) {
|>> +		out += sprintf(out, "%d\n", dump_compress);
|>> +		len = out - page;
|>> +	} else if (0 == strcmp(p->name, DUMP_DEVICE_NAME)) {
|>> +		out += sprintf(out, "0x%x\n", kdev_val(dump_device));
|>> +		len = out - page;
|>> +	} else {
|>> +		return 0;
|>> +	}
|>> +	len -= off;
|>> +	if (len < count) {
|>> +		*eof = 1;
|>> +		if (len <= 0) return 0;
|>> +	} else {
|>> +		len = count;
|>> +	}
|>> +	*start = page + off;
|>> +	return len;
|>
|>Again:  if you have one value per file use (ro) sysctl!

Fixed.

|>> +#ifndef UTSNAME_ENTRY_SZ
|>> +#define UTSNAME_ENTRY_SZ 65
|>> +#endif
|>
|>Shouldn't this be in a generic header?

Corrected to use the right utsname definitions.

|>> +        dump_header_asm.dha_version = DUMP_ASM_VERSION_NUMBER;
|>> +        dump_header_asm.dha_header_size = sizeof(struct __dump_header_asm);
|>
|>Indentation looks broken.  Please run all sourcefiles through unexpand(1)

Indent is run against the patch.

|>
|>> +	/* if this is the second call to this function, clean up ... */
|>> +	if (dump_okay && !dump_page_buf_0)
|>> +		kfree((const void *)dump_page_buf_0);
|>
|>kfree(NULL) is fine.. i.e.:
|>
|>	if (dump_okay)
|>		kfree(dump_page_buf_0);
|>
|>Dito for all other places.

All cleaned up.

|>> +/*
|>> + * Name: dump_release()
|>> + * Func: Release the dump device -- it's never necessary to call
|>> + *       this function, but it's here regardless.
|>> + */
|>> +static int
|>> +dump_release(struct inode *i, struct file *f)
|>> +{
|>> +	return 0;
|>> +}
|>
|>Just remove it.  You don't have to implement ->release.

Done.

|>> +
|>> +/*
|>> + * Name: dump_ioctl()
|>> + * Func: Allow all dump tunables through a standard ioctl() mechanism.
|>> + *       This is far better than before, where we'd go through /proc,
|>> + *       because now this will work for multiple OS and architectures.
|>> + */
|>> +static int
|>> +dump_ioctl(struct inode *i, struct file *f, unsigned int cmd, unsigned long arg)
|>> +{
|>> +	/* check capabilities */
|>> +	if (!capable(CAP_SYS_ADMIN))
|>> +		return -EPERM;
|>> +
|>> +	/*
|>> +	 * This is the main mechanism for controlling get/set data
|>> +	 * for various dump device parameters.  The real trick here
|>> +	 * is setting the dump device (DIOSDUMPDEV).  That's what
|>> +	 * triggers everything else.
|>> +	 */
|>> +	switch (cmd) {
|>> +		/* set dump_device */
|>> +		case DIOSDUMPDEV:
|>> +			/* check flags */
|>> +			if (!(f->f_flags & O_RDWR))
|>> +				return -EPERM;
|>> +
|>> +			__dump_open();
|>> +			return (dump_open_kdev(to_kdev_t((dev_t)arg)));
|>> +
|>> +		/* get dump_device */
|>> +		case DIOGDUMPDEV:
|>> +			return (put_user((long)kdev_val(dump_device), (long *)arg));
|>> +
|>> +		/* set dump_level */
|>> +		case DIOSDUMPLEVEL:
|>> +			/* check flags */
|>> +			if (!(f->f_flags & O_RDWR))
|>> +				return -EPERM;
|>> +
|>> +			/* make sure we have a positive value */
|>> +			if (arg < 0)
|>> +				return -EINVAL;
|>> +			dump_level = (int)arg;
|>> +
|>> +			if (dump_level > DUMP_LEVEL_KERN)
|>> +				dump_unreserved_mem = 1;
|>> +			else
|>> +				dump_unreserved_mem = 0;
|>> +
|>> +			if (dump_level > DUMP_LEVEL_USED)
|>> +				dump_unreferenced_mem = 1;
|>> +			else
|>> +				dump_unreferenced_mem = 0;
|>> +
|>> +			if (dump_level > DUMP_LEVEL_ALL_RAM)
|>> +				dump_nonconventional_mem = 1;
|>> +			else
|>> +				dump_nonconventional_mem = 0;
|>> +			break;
|>> +
|>> +		/* get dump_level */
|>> +		case DIOGDUMPLEVEL:
|>> +			return (put_user((long)dump_level, (long *)arg));
|>> +
|>> +		/* set dump_flags */
|>> +		case DIOSDUMPFLAGS:
|>> +			/* check flags */
|>> +			if (!(f->f_flags & O_RDWR))
|>> +				return -EPERM;
|>> +
|>> +			/* make sure we have a positive value */
|>> +			if (arg < 0)
|>> +				return -EINVAL;
|>> +
|>> +			dump_flags = (int)arg;
|>> +			break;
|>> +
|>> +		/* get dump_flags */
|>> +		case DIOGDUMPFLAGS:
|>> +			return (put_user((long)dump_flags, (long *)arg));
|>> +
|>> +		/* set the dump_compress status */
|>> +		case DIOSDUMPCOMPRESS:
|>> +			/* check flags */
|>> +			if (!(f->f_flags & O_RDWR))
|>> +				return -EPERM;
|>> +
|>> +			return (dump_compress_init((int)arg));
|>> +
|>> +		/* get the dump_compress status */
|>> +		case DIOGDUMPCOMPRESS:
|>> +			return (put_user((long)dump_compress, (long *)arg));
|>
|>This is still the wrong interface :)  At least the read/write one value
|>stuff should be sysctl.  For the rest ioctl is horribly ugly, but I'll
|>leave the decision to Linus whether he wants to merge more ugly ioctl
|>APIs.

We'll look at this, but in the near term, we'd like to go in
with this in place.  Changing this means changing a lot of
lkcdutils RPMs which configure based on this mechanism.  While
I realize it's new code, testers today are using it.

Regardless, I'll look at this, but again, I'd prefer not to
change it.  If you end up telling me this is the only thing
keeping us from going in, it'll get changed, but hopefully
it doesn't come to that. :)

|>> +
|>> +	/* try to create our dump device */
|>> +	if (register_chrdev(CRASH_DUMP_MAJOR, "dump", &dump_fops)) {
|>> +		printk("cannot register dump character device!\n");
|>> +		return -EBUSY;
|>> +	}
|>> +
|>> +	/* initialize the dump headers to zero */
|>> +	memset(&dump_header, 0, sizeof(dump_header));
|>> +	memset(&dump_header_asm, 0, sizeof(dump_header_asm));
|>
|>You don't have to zero structures lying in .bss

Removed.

|>> +
|>> +	/* reset the dump function pointer */
|>> +	dump_function_ptr = NULL;
|>
|>pointless.  the module memory will be vfree()ed anyway.

This is just good practice.  If we find that for some reason
the code sets/unsets/sets again, it is cleaned properly.  In
addition, I don't have to worry about modutils doing something
wierd.

|>> +#ifdef MODULE
|>> +MODULE_AUTHOR("Matt D. Robinson <yakker@sourceforge.net>");
|>> +MODULE_DESCRIPTION("Linux Kernel Crash Dump (LKCD) driver");
|>> +MODULE_LICENSE("GPL");
|>> +#endif /* MODULE */
|>
|>No need for the ifdef - it'll be stubbed out anyway.

Removed.

|>> +kdev_t dump_dev;		/* the actual kdev_t device number      */
|>
|>
|>> +int dump_blk_size;		/* sector size for dump_device          */
|>> +int dump_blk_shift;		/* shift need to convert to sector size */
|>> +struct bio *dump_bio;		/* bio structure for io request         */
|>> +loff_t dump_offset;		/* the offset in the output device      */
|>> +unsigned long dumpdev_limit;	/* the size limit of the block device   */
|>> +int dump_io_abort = 0;		/* set by end_io func during io error   */
|>> +
|>> +/* dump block device */
|>> +struct block_device *dump_bdev = NULL;
|>> +
|>> +/* indicates completion of each bio request */
|>> +volatile int bio_complete = 1;
|>
|>Most of this should be static, right?

Almost all converted to static.

|>> +	dump_bdev = bdget(kdev_t_to_nr(tmp_dump_device));
|>> +	if (!dump_bdev) {
|>> +		retval = -ENODEV;
|>> +		goto err;
|>> +	}
|>> +
|>> +	if (blkdev_get(dump_bdev, O_RDWR | O_LARGEFILE, 0, BDEV_RAW)) {
|>> +		retval = -ENODEV;
|>> +		goto err1;
|>> +	}
|>> +	
|>> +	if (!dump_page_buf) {
|>> +		retval = -EINVAL;
|>> +		goto err2;
|>> +	}
|>
|>You need to call bd_claim to get exclusion on the bdev.

Actually, we shouldn't.  If it is a swap partition, there could be a
a race between the block device for dumping and swap.

|>> +err3:	dump_free_bio();
|>> +err2:	if (dump_bdev) {
|>> +		blkdev_put(dump_bdev, BDEV_RAW);
|>> +		dump_bdev = NULL;
|>> +	}
|>> +err1:	if (dump_bdev) {
|>> +		bdput(dump_bdev);
|>> +		dump_bdev = NULL;
|>> +	}
|>> +err:	return retval;
|>> +}
|>
|>err3:
|>	dump_free_bio();
|>err2:
|>	if (dump_bdev)
|>		blkdev_put(dump_bdev, BDEV_RAW);
|>	goto err;
|>err1:
|>	if (dump_bdev)
|>		bdput(dump_bdev);
|>err:
|>	return retval;
|>
|>> +
|>> +static int __init
|>> +dump_blockdev_init(void)
|>> +{        
|>> +	dump_offset = 0;
|>
|>once again, .bss is already per-zeroed :)

Fixed.

|>> +void
|>> +__dump_cleanup(void)
|>> +{
|>> +	free_dha_stack();
|>> +	return;
|>> +}
|>
|>I've noticed these superflous returns in void function a lot
|>over the code.  Linux kernel code usually avoids that.
|>
|>> +static int __init
|>> +dump_compress_rle_init(void)
|>> +{
|>> +	dump_register_compression(&dump_rle_compression);
|>> +	return 0;
|>
|>Shouldn't there be some kind of error reporting? i.e.
|>
|>	return dump_register_compression(&dump_rle_compression); ?

Not really, it's just a function pointer assignment.  If it
fails, something is seriously broken.

|>> +/* header definitions for s390 dump */
|>> +#define DUMP_MAGIC_S390		0xa8190173618f23fdULL  /* s390 magic number */
|>> +#define S390_DUMP_HEADER_SIZE	4096
|>
|>should go to asm-s390/dump.h?

Fixed.

The most recent patch with almost all fixes is on the web patch site:

	http://lkcd.sourceforge.net/download/latest

Thanks, Christoph.

--Matt



