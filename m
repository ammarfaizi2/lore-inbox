Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVAYUnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVAYUnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVAYUmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:42:47 -0500
Received: from waste.org ([216.27.176.166]:35200 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262124AbVAYUlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:41:09 -0500
Date: Tue, 25 Jan 2005 12:40:56 -0800
From: Matt Mackall <mpm@selenic.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1 Random related problems
Message-ID: <20050125204056.GL12076@waste.org>
References: <Pine.LNX.4.61.0501242134390.3010@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501242134390.3010@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 09:36:37PM -0700, Zwane Mwaikambo wrote:
> I'm having trouble booting here, were those random-* patches tested?
> 
> EIP is at __add_entropy_words+0xc5/0x1c0
> eax: 0000002d   ebx: 0000000f   ecx: 0000007b   edx: f5e50000
> esi: c0810980   edi: 0000000f   ebp: f5e4fea4   esp: f5e4fe5c
> ds: 007b   es: 007b   ss: 0068
> Process dd (pid: 2255, threadinfo=f5e4e000 task=ebdd7ac0)
> Stack: 00000010 78000000 c07043e0 00000286 0000007b 0000001f 00000001 00000007
>        0000000e 00000014 0000001a 00000000 0000002d f5e50000 c07043c0 00000080
>        c0704340 c07043c0 f5e4ff40 c037a4e0 00000000 00000010 2cda69d0 f7b9f75e
> Call Trace:
>  [<c010403a>] show_stack+0x7a/0x90
>  [<c01041c6>] show_registers+0x156/0x1c0
>  [<c01043e0>] die+0x100/0x190
>  [<c0116d59>] do_page_fault+0x349/0x63f
>  [<c0103cc7>] error_code+0x2b/0x30
>  [<c037a4e0>] xfer_secondary_pool+0xb0/0xe0

This oops is add_entropy_words running off the top of the stack
reading its input. The overrun is harmless until it causes a page
fault. After much staring:

This should fix Zwane's oops. Looks like I introduced this bug in Aug
2003, but it was hard to trigger until the recent changes. But it
ought to make it to mainline soonish.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rc2mm1/drivers/char/random.c
===================================================================
--- rc2mm1.orig/drivers/char/random.c	2005-01-25 12:27:00.000000000 -0800
+++ rc2mm1/drivers/char/random.c	2005-01-25 12:27:36.000000000 -0800
@@ -701,7 +701,7 @@
 
 		bytes=extract_entropy(r->pull, tmp, bytes,
 				      random_read_wakeup_thresh / 8, rsvd);
-		add_entropy_words(r, tmp, bytes);
+		add_entropy_words(r, tmp, (bytes + 3) / 4);
 		credit_entropy_store(r, bytes*8);
 	}
 }


-- 
Mathematics is the supreme nostalgia of our time.
