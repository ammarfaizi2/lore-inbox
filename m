Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUKCTvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUKCTvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUKCTkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:40:08 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:44669 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261835AbUKCTiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:38:08 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2)
Date: Wed, 3 Nov 2004 20:28:44 +0100
User-Agent: KMail/1.7.1
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <1099482457.16445.1.camel@imp.csi.cam.ac.uk> <20041103120829.GA23182@taniwha.stupidest.org>
In-Reply-To: <20041103120829.GA23182@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032028.44376.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 13:08, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 11:47:38AM +0000, Anton Altaparmakov wrote:
> > You have two %d but only one argument.  You seem to have forgotten
> > an "old_pid, " in there.

> kill(..., SIGKILL) doesn't work to kill host-OS processes created in
> the exec path in TT mode --- for this we need PTRACE_KILL (it did work
> in previous kernels, but not by design).  Without this process will
> accumulate on the host-OS (although the won't be visible inside UML).

> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> ---
>
> Index: cw-current/arch/um/kernel/tt/exec_user.c
> ===================================================================
> --- cw-current.orig/arch/um/kernel/tt/exec_user.c 2004-11-03
> 02:10:18.064830204 -0800 +++
> cw-current/arch/um/kernel/tt/exec_user.c 2004-11-03 04:05:00.435843464
> -0800 @@ -35,7 +35,8 @@
>    tracer_panic("do_exec failed to get registers - errno = %d",
>          errno);
>
> - kill(old_pid, SIGKILL);
> + if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
> +  printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", old_pid,
> errno);
>
>   if(ptrace_setregs(new_pid, regs) < 0)
>    tracer_panic("do_exec failed to start new proc - errno = %d",

I'm going to test this. I thought that Gerd Knorr patch (which I sent cc'ing 
LKML and most of you) already solved this (I actually modified that one, 
replacing his SIGCONT kill()ing with a PTRACE_KILL, but I did this in the 
places he identified). I guess that old_pid should either already be dead 
there or going to die after a little, but I'm going to check (after I get UML 
to run in the current snapshot...)

For now, please hold on this.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

