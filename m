Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUKCLsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUKCLsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 06:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKCLsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 06:48:38 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:56298 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261551AbUKCLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 06:48:23 -0500
Subject: Re: [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill
	host-OS processes
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041103113736.GA23041@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1099482457.16445.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 03 Nov 2004 11:47:38 +0000
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 11:37, Chris Wedgwood wrote:
> kill(..., SIGKILL) doesn't work to kill host-OS processes created in
> the exec path in TT mode --- for this we need PTRACE_KILL (it did work
> in previous kernels, but not by design).  Without this process will
> accumulate on the host-OS (although the won't be visible inside UML).
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> ---
> 
> Yes, there are other fixes along these lines which are needed but one
> at a time as we test these...
> 
> Index: cw-current/arch/um/kernel/tt/exec_user.c
> ===================================================================
> --- cw-current.orig/arch/um/kernel/tt/exec_user.c	2004-11-03 02:10:18.064830204 -0800
> +++ cw-current/arch/um/kernel/tt/exec_user.c	2004-11-03 02:12:10.447716745 -0800
> @@ -35,7 +35,8 @@
>  		tracer_panic("do_exec failed to get registers - errno = %d",
>  			     errno);
>  
> -	kill(old_pid, SIGKILL);
> +	if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
> +		printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", errno);

You have two %d but only one argument.  You seem to have forgotten an
"old_pid, " in there.

>  
>  	if(ptrace_setregs(new_pid, regs) < 0)
>  		tracer_panic("do_exec failed to start new proc - errno = %d",

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

