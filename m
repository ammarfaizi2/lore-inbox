Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTE2JEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTE2JEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:04:22 -0400
Received: from ns.suse.de ([213.95.15.193]:48393 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262019AbTE2JEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:04:20 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@digeo.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
References: <20030521152255.4aa32fba.akpm@digeo.com.suse.lists.linux.kernel>
	<20030521152334.4b04c5c9.akpm@digeo.com.suse.lists.linux.kernel>
	<20030526093717.GC642@zaurus.ucw.cz.suse.lists.linux.kernel>
	<20030528144839.47efdc4f.akpm@digeo.com.suse.lists.linux.kernel>
	<20030528215551.GB255@elf.ucw.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 May 2003 11:17:36 +0200
In-Reply-To: <20030528215551.GB255@elf.ucw.cz.suse.lists.linux.kernel>
Message-ID: <p73wuga6rin.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> +	kiov = (sg_iovec_t *) sgp->dxferp;
> +	for (i = 0; i < sgp->iovec_count; i++) {
> +		u32 iov_base32;
> +		if (__get_user(iov_base32, &uiov->iov_base) ||
> +		    __get_user(kiov->iov_len, &uiov->iov_len))
> +			return -EFAULT;
> +		if (verify_area(VERIFY_WRITE, compat_ptr(iov_base32), kiov->iov_len))
> +			return -EFAULT;
> +		kiov->iov_base = compat_ptr(iov_base32);


This part won't work on sparc64 because it has separate address spaces
for user/kernel. I did it this way for x86-64 because I didn't realize
the sparc64 problem yet and it works fine there. For sparc64 it needs to be 
converted to compat_alloc_user_space() (see net/compat.c for an example) 
or to alloc/copy the payload again.  The first is prefered.

Pavel you would need to fix this first, otherwise Ben Collins and DaveM
will be unhappy as soon as they want to burn a CD.

> +	} else {
> +		err = verify_area(VERIFY_WRITE, compat_ptr(dxferp32), sg_io64.dxfer_len);
> +		if (err) 
> +			goto out;
> +
> +		sg_io64.dxferp = compat_ptr(dxferp32); 
> +	}

Same here.

t_user(cdread.cdread_lba, &((struct cdrom_read32 *)arg)->cdread_lba);
> +		err |= __get_user(addr, &((struct cdrom_read32 *)arg)->cdread_bufaddr);
> +		err |= __get_user(cdread.cdread_buflen, &((struct cdrom_read32 *)arg)->cdread_buflen);
> +		if (err)
> +			return -EFAULT;
> +		if (verify_area(VERIFY_WRITE, compat_ptr(addr), cdread.cdread_buflen))
> +			return -EFAULT;
> +		cdread.cdread_bufaddr = compat_ptr(addr);

Same here.

> +		err |= __get_user(addr, &((struct cdrom_read_audio32 *)arg)->buf);
> +		if (err)
> +			return -EFAULT;
> +		
> +
> +		if (verify_area(VERIFY_WRITE, compat_ptr(addr), cdreadaudio.nframes*2352))
> +			return -EFAULT;

And here.

	err |= __get_user(addr, &((struct cdrom_generic_command32 *)arg)->buffer);
> +		err |= __get_user(cgc.buflen, &((struct cdrom_generic_command32 *)arg)->buflen);
> +		if (err)
> +			return -EFAULT;
> +		if (verify_area(VERIFY_WRITE, compat_ptr(addr), cgc.buflen))
> +			return -EFAULT;
> +		cgc.buffer = compat_ptr(addr);

And here

> +	if (iobuf32.buffer == (compat_caddr_t) NULL || iobuf32.length == 0) {
> +		iobuf.buffer = (void*)(unsigned long)iobuf32.buffer;
> +	} else {
> +		iobuf.buffer = compat_ptr(iobuf32.buffer);
> +		if (verify_area(VERIFY_WRITE, iobuf.buffer, iobuf.length))
> +			return -EINVAL;
> +	}

And here.

> +	if (sioc32.arg == (compat_caddr_t) NULL || sioc32.length == 0) {
> +		sioc.arg = (void*)(unsigned long)sioc32.arg;
> +        } else {
> +		sioc.arg = compat_ptr(sioc32.arg);
> +		if (verify_area(VERIFY_WRITE, sioc.arg, sioc32.length))
> +			return -EFAULT;
> +        }
> +        
> +        old_fs = get_fs(); set_fs (KERNEL_DS);
> +        err = sys_ioctl (fd, cmd, (unsigned long)&sioc);	

And here

> +
> +	if (get_user(karg.start, &uarg->start) 		||
> +	    get_user(karg.length, &uarg->length)	||
> +	    get_user(tmp, &uarg->ptr))
> +		return -EFAULT;
> +
> +	karg.ptr = compat_ptr(tmp); 
> +	if (verify_area(VERIFY_WRITE, karg.ptr, karg.length))
> +		return -EFAULT;

And here.
> +
> +	set_fs(KERNEL_DS);
> +	if (MEMREADOOB32 == cmd) 
> +		ret = sys_ioctl(fd, MEMREADOOB, (unsigned long)&karg);
> +	else if (MEMWRITEOOB32 == cmd)
> +		ret = sys_ioctl(fd, MEMWRITEOOB, (unsigned long)&karg);
> +	else
> +		ret = -EINVAL;
> +	set_fs(old_fs);

-Andi
