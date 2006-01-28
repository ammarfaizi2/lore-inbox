Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWA1CU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWA1CU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWA1CTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:19:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:61624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422795AbWA1CTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:19:09 -0500
Date: Fri, 27 Jan 2006 18:18:22 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, richm@oldelvet.org.uk
Subject: [patch 3/6] [SPARC64]: Fix ptrace/strace
Message-ID: <20060128021822.GD10362@kroah.com>
References: <20060128015840.722214000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-fix-ptrace.patch"
In-Reply-To: <20060128021749.GA10362@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Richard Mortimer <richm@oldelvet.org.uk>

Don't clobber register %l0 while checking TI_SYS_NOERROR value in
syscall return path.  This bug was introduced by:

db7d9a4eb700be766cc9f29241483dbb1e748832

Problem narrowed down by Luis F. Ortiz and Richard Mortimer.

I tried using %l2 as suggested by Luis and that works for me.

Looking at the code I wonder if it makes sense to simplify the code
a little bit. The following works for me but I'm not sure how to
exercise the "NOERROR" codepath.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc64/kernel/entry.S |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- linux-2.6.14.6.orig/arch/sparc64/kernel/entry.S
+++ linux-2.6.14.6/arch/sparc64/kernel/entry.S
@@ -1657,13 +1657,10 @@ ret_sys_call:
 	/* Check if force_successful_syscall_return()
 	 * was invoked.
 	 */
-	ldub		[%curptr + TI_SYS_NOERROR], %l0
-	brz,pt		%l0, 1f
-	 nop
-	ba,pt		%xcc, 80f
+	ldub            [%curptr + TI_SYS_NOERROR], %l2
+	brnz,a,pn       %l2, 80f
 	 stb		%g0, [%curptr + TI_SYS_NOERROR]
 
-1:
 	cmp		%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn		%xcc, 1f
 	 andcc		%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6

--
