Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWHSImn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWHSImn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 04:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWHSImn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 04:42:43 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:40978 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751475AbWHSImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 04:42:42 -0400
Date: Sat, 19 Aug 2006 09:42:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Return real errno from execve in ____call_usermodehelper
Message-ID: <20060819084233.GA25767@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <20060819011428.05ec2ae4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819011428.05ec2ae4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 01:14:28AM -0700, Andrew Morton wrote:
> On Sat, 19 Aug 2006 09:30:31 +0200
> Bj?rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> 
> > If execve fails in ____call_usermodehelper we treat its return value as
> > error code, but as execve is a syscall, we actually want -errno there.
> > 
> > Signed-off-by: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
> > 
> > --
> > 
> > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > index 1d32def..865abc0 100644
> > --- a/kernel/kmod.c
> > +++ b/kernel/kmod.c
> > @@ -149,8 +149,10 @@ static int ____call_usermodehelper(void 
> >  	set_cpus_allowed(current, CPU_MASK_ALL);
> >  
> >  	retval = -EPERM;
> > -	if (current->fs->root)
> > -		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
> > +	if (current->fs->root) {
> > +		execve(sub_info->path, sub_info->argv, sub_info->envp);
> > +		retval = -errno;
> > +	}
> >  
> >  	/* Exec failed? */
> >  	sub_info->retval = retval;
> 
> ug.  I wish we could find some way of using do_execve() here.  Or hoist
> sys_execve() out of the architectures.

Some architectures do implement their own special execve() function,
some of which are written for how this code above currently is (iow,
not using errno) and are probably buggy in that respect.

Maybe what we should be thinking of doing is changing execve() calls
to kernel_execve() which returns the error code.

This way, architectures are free to implement execve() whatever way
they wish - and if they're concerned about using errno, that's their
own implementation specific detail.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
