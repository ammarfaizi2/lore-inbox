Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVHIUtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVHIUtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVHIUtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:49:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964953AbVHIUtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:49:41 -0400
Date: Tue, 9 Aug 2005 13:49:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Subject: Re: Signal handling possibly wrong
Message-ID: <20050809204928.GH7991@shell0.pdx.osdl.net>
References: <42F8EB66.8020002@fujitsu-siemens.com> <1123612016.3167.3.camel@localhost.localdomain> <42F8F6CC.7090709@fujitsu-siemens.com> <1123612789.3167.9.camel@localhost.localdomain> <42F8F98B.3080908@fujitsu-siemens.com> <1123614253.3167.18.camel@localhost.localdomain> <1123615983.18332.194.camel@localhost.localdomain> <42F906EB.6060106@fujitsu-siemens.com> <1123617812.18332.199.camel@localhost.localdomain> <1123618745.18332.204.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123618745.18332.204.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> Where, sa_mask is _ignored_ if NODEFER is set. (I now have woken up!).
> The attached program shows that the sa_mask is indeed ignored when
> SA_NODEFER is set.
> 
> Now the real question is... Is this a bug?

That's not correct w.r.t. SUSv3.  sa_mask should be always used and
SA_NODEFER is just whether or not to add that signal in.

SA_NODEFER
    [XSI] If set and sig is caught, sig shall not be added to the thread's
    signal mask on entry to the signal handler unless it is included in
    sa_mask. Otherwise, sig shall always be added to the thread's signal
    mask on entry to the signal handler.

Brodo, is this what you mean?

thanks,
-chris
--

Subject: [PATCH] fix SA_NODEFER signals to honor sa_mask

When receiving SA_NODEFER signal, kernel was inapproriately not applying
the sa_mask.  As pointed out by Brodo Stroesser.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -577,13 +577,12 @@ handle_signal(unsigned long sig, siginfo
 	else
 		ret = setup_frame(sig, ka, oldset, regs);
 
-	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+	if (ret && !(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked,sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 
 	return ret;
 }
