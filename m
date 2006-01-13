Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWAMEA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWAMEA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWAMEA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:00:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964799AbWAMEAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:00:25 -0500
Date: Thu, 12 Jan 2006 19:59:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Message-Id: <20060112195950.60188acf.akpm@osdl.org>
In-Reply-To: <1136924357.3435.107.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924357.3435.107.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> The attached patch handles TIF_RESTORE_SIGMASK as added by David Woodhouse's
> patch entitled:
> 
>         [PATCH] 2/3 Add TIF_RESTORE_SIGMASK support for arch/powerpc
>         [PATCH] 3/3 Generic sys_rt_sigsuspend
> 
> It does the following:
> 
>  (1) Declares TIF_RESTORE_SIGMASK for i386.
> 
>  (2) Invokes it over to do_signal() when TIF_RESTORE_SIGMASK is set.
> 
>  (3) Makes do_signal() support TIF_RESTORE_SIGMASK, using the signal mask saved
>      in current->saved_sigmask.
> 
>  (4) Discards sys_rt_sigsuspend() from the arch, using the generic one instead.
> 
>  (5) Makes sys_sigsuspend() save the signal mask and set TIF_RESTORE_SIGMASK
>      rather than attempting to fudge the return registers.
> 
>  (6) Makes sys_sigsuspend() return -ERESTARTNOHAND rather than looping
>      intrinsically.
> 
>  (7) Makes setup_frame(), setup_rt_frame() and handle_signal() return 0 or
>      -EFAULT rather than true/false to be consistent with the rest of the
>      kernel.
> 
> Due to the fact do_signal() is then only called from one place:
> 
>  (8) Makes do_signal() no longer have a return value is it was just being
>      ignored; force_sig() takes care of this.
> 
>  (9) Discards the old sigmask argument to do_signal() as it's no longer
>      necessary.
> 
> (10) Makes do_signal() static.
> 
> (11) Marks the second argument to do_notify_resume() as unused. The unused
>      argument should remain in the middle as the arguments are passed in as
>      registers, and the ordering is specific in entry.S
> 
> Given the way do_signal() is now no longer called from sys_{,rt_}sigsuspend(),
> they no longer need access to the exception frame, and so can just take
> arguments normally.
> 
> This patch depends on sys_rt_sigsuspend patch.

I have problems with this patch.

With

	generic-sys_rt_sigsuspend.patch
	handle-tif_restore_sigmask-for-frv.patch
	handle-tif_restore_sigmask-for-i386.patch

applied, or with all of David's patches applied, an FC5-test1 machine hangs
during the login process (local vt or sshd).  An FC1 machine doesn't
exhibit the problem.

dmesg+sysrq-t:
	http://www.zip.com.au/~akpm/linux/patches/stuff/dmesg

.config:
	http://www.zip.com.au/~akpm/linux/patches/stuff/config-sony

culprit patches:
	http://www.zip.com.au/~akpm/linux/patches/stuff/generic-sys_rt_sigsuspend.patch
	http://www.zip.com.au/~akpm/linux/patches/stuff/handle-tif_restore_sigmask-for-i386.patch

(I retested with just current -linus and the above two patches.  Same
deal).

