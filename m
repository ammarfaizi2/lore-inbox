Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289388AbSA1Ue0>; Mon, 28 Jan 2002 15:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289467AbSA1UdW>; Mon, 28 Jan 2002 15:33:22 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:52609 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S289398AbSA1UcH>;
	Mon, 28 Jan 2002 15:32:07 -0500
Date: Mon, 28 Jan 2002 15:32:10 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH?] Crash in 2.4.17/ptrace
Message-ID: <20020128153210.A3032@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been debugging frame buffer graphics lately, and encountering a
very annoying problem.  If the debugee has /dev/fb/0 mapped, and I try
to print out the contents of a pointer into that buffer, GDB crashes in
kernel/ptrace.c:access_process_vm.  The problem seems to be that
get_user_pages returns a NULL page.  Something as simple as this
prevents the crash:

--- 2.4.18-pre7/2.4.18-pre7/kernel/ptrace.c	Fri Dec 21 12:42:04 2001
+++ 2.4.17/kernel-source-2.4.17/kernel/ptrace.c	Mon Jan 28 15:30:39 2002
@@ -160,6 +160,18 @@ int access_process_vm(struct task_struct
 
 		flush_cache_page(vma, addr);
 
+#if 1
+		if (!page)
+		{
+			/* FIXME: Writes? */
+			if (!write) memset (buf, 0, bytes);
+			len -= bytes;
+			buf += bytes;
+			continue;
+		}
+#endif
+
+
 		maddr = kmap(page);
 		if (write) {
 			memcpy(maddr + offset, buf, bytes);


Of course, I would much rather be able to see the contents of the
framebuffer.  Any suggestions?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
