Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUJDVdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUJDVdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268633AbUJDVbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:31:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:60595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268541AbUJDV3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:29:01 -0400
Date: Mon, 4 Oct 2004 14:32:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grant Wilson <gww@btinternet.com>
Cc: s.rivoir@gts.it, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004143253.50a82050.akpm@osdl.org>
In-Reply-To: <4161BCCB.4080302@btinternet.com>
References: <20041004020207.4f168876.akpm@osdl.org>
	<4161462A.5040806@gts.it>
	<20041004121805.2bffcd99.akpm@osdl.org>
	<4161BCCB.4080302@btinternet.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Wilson <gww@btinternet.com> wrote:
>
> Andrew Morton wrote:
> [snip]
> 
> >>IP: routing cache hash table of 4096 buckets, 32KBytes
> >>kmem_cache_create: Early error in slab ip_fib_hash
> >>-----[ cut here ] -----
> >>kernel BUG at mm/slab.c:1185!
> >>invalid operand: 0000 [#1]
> >>PREEMPT
> 
> [snip]
> 
> I am hitting the same stop on my amd64 box.  With your patch the
> following is reported:
> 
> in_interrupt(): 268435200  (ie 0x0fffff00)
> preempt_count(): ffffffff

heh, OK, someone goofed there.

Could you try this patch?  It'll locate the bug for us.

--- 25/include/linux/preempt.h~a	Mon Oct  4 14:31:24 2004
+++ 25-akpm/include/linux/preempt.h	Mon Oct  4 14:31:49 2004
@@ -19,6 +19,8 @@ do { \
 #define dec_preempt_count() \
 do { \
 	preempt_count()--; \
+	if (preempt_count() == -1) \
+		*(char *)0 = 0; \
 } while (0)
 
 #ifdef CONFIG_PREEMPT
_


(I'd have used BUG, but that might cause inclusion problems)
