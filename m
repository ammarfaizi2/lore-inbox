Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbTEGPFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTEGPFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:05:32 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:10386 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263721AbTEGPF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:05:29 -0400
Date: Wed, 7 May 2003 17:16:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030507151613.GB412@elf.ucw.cz>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <200305071518.25595.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071518.25595.arnd@arndb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +typedef struct sg_io_hdr32 {
> > +	s32 interface_id;	/* [i] 'S' for SCSI generic (required) */
> > +	s32 dxfer_direction;	/* [i] data transfer direction  */
> > +	u8  cmd_len;		/* [i] SCSI command length ( <= 16 bytes) */
> > +	u8  mx_sb_len;		/* [i] max length to write to sbp */
> > +	u16 iovec_count;	/* [i] 0 implies no scatter gather */
> > +	u32 dxfer_len;		/* [i] byte count of data transfer */
> > +	u32 dxferp;		/* [i], [*io] points to data transfer memory
> > +					      or scatter gather list */
> > +	u32 cmdp;		/* [i], [*i] points to command to perform */
> > +	u32 sbp;		/* [i], [*o] points to sense_buffer memory */
> > +	u32 timeout;		/* [i] MAX_UINT->no timeout (unit: millisec) */
> > +	u32 flags;		/* [i] 0 -> default, see SG_FLAG... */
> > +	s32 pack_id;		/* [i->o] unused internally (normally) */
> > +	u32 usr_ptr;		/* [i->o] unused internally */
> > +	u8  status;		/* [o] scsi status */
> > +	u8  masked_status;	/* [o] shifted, masked scsi status */
> > +	u8  msg_status;		/* [o] messaging level data (optional) */
> > +	u8  sb_len_wr;		/* [o] byte count actually written to sbp */
> > +	u16 host_status;	/* [o] errors from host adapter */
> > +	u16 driver_status;	/* [o] errors from software driver */
> > +	s32 resid;		/* [o] dxfer_len - actual_transferred */
> > +	u32 duration;		/* [o] time taken by cmd (unit: millisec) */
> > +	u32 info;		/* [o] auxiliary information */
> > +} sg_io_hdr32_t;  /* 64 bytes long (on sparc32) */
> > +
> > +typedef struct sg_iovec32 {
> > +	u32 iov_base;
> > +	u32 iov_len;
> > +} sg_iovec32_t;
> 
> These should better be expressed with compat_uptr_t, compat_ulong_t etc.
> 
> 
> > +	sg_iovec32_t *uiov = (sg_iovec32_t *) compat_ptr(uptr32);
> 
> > +		if (verify_area(VERIFY_WRITE, (void *)compat_ptr(iov_base32),
> > kiov->iov_len)) +			return -EFAULT;
> > +		kiov->iov_base = (void *)compat_ptr(iov_base32);
> 
> You don't need to cast to a pointer when using compat_ptr.

I thought so. I originally wanted as clean move as possible. I'll fix it.

> > +static int __init init_compat(void)
> > +{
> > +	register_ioctl32_conversion(SG_IO, sg_ioctl_trans);
> > +	return 0;
> > +}
> > +
> > +__initcall(init_compat);
> > +#endif
> > +
> >  #define FORMAT_UNIT_TIMEOUT		(2 * 60 * 60 * HZ)
> >  #define START_STOP_TIMEOUT		(60 * HZ)
> >  #define MOVE_MEDIUM_TIMEOUT		(5 * 60 * HZ)
> 
> Has anyone solved the register_ioctl32_conversion() from module problem
> yet? The patch will break if you build scsi as a module because you
> never unregister the conversion helper on unload.
> Even if you do the unregister from a module_exit() function, there
> will still be a small race against running ioctl handlers. I suppose
> we have to add an 'owner' field to struct ioctl_trans in order to
> get it right.

Its in drivers/block/scsi_ioctl.c. AFAICS, its always compiled in, so
I'm not hitting that problem *yet*.

> > +#ifdef CONFIG_COMPAT
> > +struct serial_struct32 {
> > +	int	type;
> > +	int	line;
> > +	unsigned int	port;
> > +	int	irq;
> > +	int	flags;
> > +	int	xmit_fifo_size;
> > +	int	custom_divisor;
> > +	int	baud_base;
> > +	unsigned short	close_delay;
> > +	char	io_type;
> > +	char	reserved_char[1];
> > +	int	hub6;
> > +	unsigned short	closing_wait; /* time to wait before closing */
> > +	unsigned short	closing_wait2; /* no longer used... */
> > +	__u32 iomem_base;
> > +	unsigned short	iomem_reg_shift;
> > +	unsigned int	port_high;
> > +	int	reserved[1];
> > +};
> see above.
> 
> > +		ss.iomem_base = (void *)((unsigned long)ss.iomem_base & 0xffffffff);
> you need compat_ptr() for iomem_base as well

Its not pointer, AFAICS (at least it can not be dereferenced by
userspace).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
