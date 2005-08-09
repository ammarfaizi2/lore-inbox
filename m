Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVHIVHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVHIVHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVHIVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:07:39 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49076 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964966AbVHIVHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:07:38 -0400
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect
	sa_mask
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Wright <chrisw@osdl.org>
Cc: gdt@linuxppc.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
In-Reply-To: <1123621223.9553.4.camel@localhost.localdomain>
References: <42F8EB66.8020002@fujitsu-siemens.com>
	 <1123612016.3167.3.camel@localhost.localdomain>
	 <42F8F6CC.7090709@fujitsu-siemens.com>
	 <1123612789.3167.9.camel@localhost.localdomain>
	 <42F8F98B.3080908@fujitsu-siemens.com>
	 <1123614253.3167.18.camel@localhost.localdomain>
	 <1123615983.18332.194.camel@localhost.localdomain>
	 <42F906EB.6060106@fujitsu-siemens.com>
	 <1123617812.18332.199.camel@localhost.localdomain>
	 <1123618745.18332.204.camel@localhost.localdomain>
	 <20050809204928.GH7991@shell0.pdx.osdl.net>
	 <1123621223.9553.4.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 09 Aug 2005 17:07:17 -0400
Message-Id: <1123621637.9553.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is indeed the way things should work. I'll go ahead and fix all
the other architectures.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc6-git1/arch/ppc/kernel/signal.c.orig	2005-08-09 17:00:43.000000000 -0400
+++ linux-2.6.13-rc6-git1/arch/ppc/kernel/signal.c	2005-08-09 17:01:37.000000000 -0400
@@ -759,13 +759,12 @@ int do_signal(sigset_t *oldset, struct p
 	else
 		handle_signal(signr, &ka, &info, oldset, regs, newsp);
 
-	if (!(ka.sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka.sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka.sa.sa_mask);
+	if (!(ka.sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, signr);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 
 	return 1;
 }


