Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317635AbSGZJRj>; Fri, 26 Jul 2002 05:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSGZJRj>; Fri, 26 Jul 2002 05:17:39 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1408 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317635AbSGZJRi>;
	Fri, 26 Jul 2002 05:17:38 -0400
Date: Fri, 26 Jul 2002 02:06:42 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: EFAULT vs. SIGSEGV [was Re: close return value]
Message-ID: <20020726000642.GA512@elf.ucw.cz>
References: <8765zazv5r.fsf@CERT.Uni-Stuttgart.DE> <Pine.LNX.4.44.0207200936160.2342-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207200936160.2342-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Returning an error and still doing the operation is slightly awkward.
> > Are there any other syscalls which do similar things?
> 
> mmap(MAP_FIXED) may have already unmapped any underlying old area if an
> error occurs.
> 
> And EFAULT may have strange behaviour for left-over stuff. If I remember
> correctly, at some point, for example, EFAULT on a write to a TCP socket
> (if the fault happened in the middle) would still send out the full-sized
> packet zero-padded, because not doing so would have screwed up the state
> machine.
> 
> (But EFAULT is a special case in general, it's documented to be undefined
> behaviour).

SOme time ago you said you'd agree to doing SIGSEGV in addition to
segfault. What about following patch? It should make difference
between VSYSCALL and normal syscall smaller...

								Pavel

--- clean.2.5/arch/i386/mm/fault.c	Thu Jul 25 22:21:08 2002
+++ linux/arch/i386/mm/fault.c	Thu Jul 25 22:21:24 2002
@@ -305,6 +305,15 @@
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
 	if ((fixup = search_exception_table(regs->eip)) != 0) {
+		tsk->thread.cr2 = address;
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = 14;
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		/* info.si_code has been set above */
+		info.si_addr = (void *)address;
+		force_sig_info(SIGSEGV, &info, tsk);
+
 		regs->eip = fixup;
 		return;
 	}

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
