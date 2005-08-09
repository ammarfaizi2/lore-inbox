Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVHIVFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVHIVFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVHIVFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:05:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964938AbVHIVFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:05:01 -0400
Date: Tue, 9 Aug 2005 14:04:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Subject: Re: Signal handling possibly wrong
Message-ID: <20050809210431.GI7991@shell0.pdx.osdl.net>
References: <1123612016.3167.3.camel@localhost.localdomain> <42F8F6CC.7090709@fujitsu-siemens.com> <1123612789.3167.9.camel@localhost.localdomain> <42F8F98B.3080908@fujitsu-siemens.com> <1123614253.3167.18.camel@localhost.localdomain> <1123615983.18332.194.camel@localhost.localdomain> <42F906EB.6060106@fujitsu-siemens.com> <1123617812.18332.199.camel@localhost.localdomain> <1123618745.18332.204.camel@localhost.localdomain> <20050809204928.GH7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809204928.GH7991@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:

Actually that one broke a fix that I think Brodo discovered in the first
place with bogus stack frames.

Should be this one.

thanks,
-chris
---


Subject: [PATCH] fix SA_NODEFER signals to honor sa_mask

When receiving SA_NODEFER signal, kernel was inapproriately not applying
the sa_mask.  As pointed out by Brodo Stroesser.

Signed-off-by: Chris Wright <chrisw@osdl.org>

diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -577,10 +577,11 @@ handle_signal(unsigned long sig, siginfo
 	else
 		ret = setup_frame(sig, ka, oldset, regs);
 
-	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
-		sigaddset(&current->blocked,sig);
+		if (!(ka->sa.sa_flags & SA_NODEFER))
+			sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
