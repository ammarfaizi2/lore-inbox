Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUBKLOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 06:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUBKLOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 06:14:48 -0500
Received: from aun.it.uu.se ([130.238.12.36]:62144 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264113AbUBKLOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 06:14:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16426.3711.606419.745835@alkaid.it.uu.se>
Date: Wed, 11 Feb 2004 12:14:07 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: RE: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/messag
	 e/fusion/mptctl.c
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703D1A97A@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E5703D1A97A@exa-atlanta.se.lsil.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moore, Eric Dean writes:
 > On Tuesday, February 10, 2004 9:25 AM, Mikael Pettersson  wrote:
 > > Moore, Eric Dean writes:
 > >  > If we pass NULL as the 2nd parameter for 
 > > register_ioctl32_conversion(),
 > >  > the mpt_ioctl() entry point is *not* called when running a 32 bit
 > >  > application in x86_64 mode.
 > > 
 > > Ok, but you still don't need sys_ioctl() since the one-liner
 > > 
 > >  > > filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg)
 > > 
 > > (or a hardcoded call to your ioctl() method) suffices.
 > > 
 > > sys_ioctl() mostly just checks for special case ioctls before
 > > doing the line above, but those special cases can't occur
 > > since the kernel has already matched your particular ioctl.
 > > 
 > > /Mikael
 > > 
 > 
 > 
 > Ok - I have modified the mpt fusion driver per your suggestions.
 > Please advise if this would work.
...
 >  static int
 > +compat_mptctl_ioctl(unsigned int fd, unsigned int cmd,
 > +			unsigned long arg, struct file *filp)
 > +{
 > +	dctlprintk((KERN_INFO MYNAM "::compat_mptctl_ioctl() called\n"));
 > +
 > +	return mptctl_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 > +}
 > +
 > +static int
 >  compat_mptfwxfer_ioctl(unsigned int fd, unsigned int cmd,
 >  			unsigned long arg, struct file *filp)
 >  {
 > @@ -2864,30 +2872,31 @@
 >  	}
 >  
 >  #ifdef MPT_CONFIG_COMPAT
 > -	err = register_ioctl32_conversion(MPTIOCINFO, sys_ioctl);
 > +	err = register_ioctl32_conversion(MPTIOCINFO, compat_mptctl_ioctl);

Looks fine to me.

I forgot to mention that sys_ioctl() also does lock_kernel(), but
AMD64's sys32_ioctl() does not. So if you rely on having the BKL
you'll need to add lock_kernel() to your wrapper above.

/Mikael
