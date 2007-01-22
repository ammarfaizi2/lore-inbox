Return-Path: <linux-kernel-owner+w=401wt.eu-S1751857AbXAVOxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXAVOxa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbXAVOxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:53:30 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:3873 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbXAVOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:53:30 -0500
Date: Mon, 22 Jan 2007 09:52:59 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] select: fix sys_select to not leak ERESTARTNOHAND to userspace
Message-ID: <20070122145259.GB21059@hmsreliant.homelinux.net>
References: <20070116201332.GA28523@hmsreliant.homelinux.net> <20070122145956.4a68762d@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070122145956.4a68762d@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2007 at 02:59:56PM +0100, Paolo Ornati wrote:
> On Tue, 16 Jan 2007 15:13:32 -0500
> Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> > As it is currently written, sys_select checks its return code to convert
> > ERESTARTNOHAND to EINTR.  However, the check is within an if (tvp) clause, and
> > so if select is called from userspace with a NULL timeval, then it is possible
> > for the ERESTARTNOHAND errno to leak into userspace, which is incorrect.  This
> > patch moves that check outside of the conditional, and prevents the errno leak.
> 
> the ERESTARTNOHAND thing is handled in arch specific signal code,

In the signal handling path yes.
Not always in the case of select, though.  Check core_sys_select:

if (!ret) {
                ret = -ERESTARTNOHAND;
                if (signal_pending(current))
                        goto out;
                ret = 0;
        }
...

out:
        if (bits != stack_fds)
                kfree(bits);
out_nofds:
        return ret;

Its possible for core_sys_select to return ERESTARTNOHAND to sys_select, which
will in turn (as its currently written), return that value back to user space.

> syscalls can return -ERESTARTNOHAND as much as they want (and your
> change breaks the current behaviour of select()).
> 

It doesn't break it, it fixes it.  select isn't meant to ever return
ERESTARTNOHAND to user space:
http://www.opengroup.org/onlinepubs/009695399/functions/select.html

And ENORESTARTHAND isn't defined in the userspace errno.h, so this causes all
sorts of confusion for apps that don't expect it.

Neil

> For example:
> 
> arch/x86_64/kernel/signal.c
> 
>         /* Are we from a system call? */
>         if ((long)regs->orig_rax >= 0) {
>                 /* If so, check system call restarting.. */
>                 switch (regs->rax) {
>                         case -ERESTART_RESTARTBLOCK:
>                         case -ERESTARTNOHAND:
>                                 regs->rax = -EINTR;
>                                 break;
> 
> -- 
> 	Paolo Ornati
> 	Linux 2.6.20-rc5 on x86_64
