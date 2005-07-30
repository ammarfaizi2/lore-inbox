Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVG3RHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVG3RHO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVG3RHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:07:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263071AbVG3RHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:07:11 -0400
Date: Sat, 30 Jul 2005 10:05:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050730100556.4d554a4f.akpm@osdl.org>
In-Reply-To: <1122719266.7650.7.camel@localhost.localdomain>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<1122719266.7650.7.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> On Thu, 2005-07-28 at 02:58 -0700, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/
>  > 
>  > - There's a pretty large x86_64 update here which naughty maintainer wants
>  >   in 2.6.13.  Extra testing, please.
>  >
>  > +x86_64-switch-to-the-interrupt-stack-when-running-a.patch
> 
>  The above patch causes the BUG below on the Zaurus (arm pxa255 with
>  preempt enabled). This can only be due to the suspicious looking changes
>  to kernel/softirq.c in that patch...

err, yes.  I assume this was some debugging stuff which leaked through.  I
hope x86_64 still works after we fix it...

--- devel/kernel/softirq.c~revert-bogus-softirq-changes	2005-07-30 10:03:12.000000000 -0700
+++ devel-akpm/kernel/softirq.c	2005-07-30 10:03:21.000000000 -0700
@@ -86,7 +86,7 @@ restart:
 	/* Reset the pending bitmask before enabling irqs */
 	local_softirq_pending() = 0;
 
-	//local_irq_enable();
+	local_irq_enable();
 
 	h = softirq_vec;
 
@@ -99,7 +99,7 @@ restart:
 		pending >>= 1;
 	} while (pending);
 
-	//local_irq_disable();
+	local_irq_disable();
 
 	pending = local_softirq_pending();
 	if (pending && --max_restart)
_

