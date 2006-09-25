Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWIYGD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWIYGD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWIYGD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:03:56 -0400
Received: from ozlabs.org ([203.10.76.45]:1711 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751210AbWIYGDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:03:55 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <45176865.7020300@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <4514663E.5050707@goop.org>
	 <1158985882.26261.60.camel@localhost.localdomain>
	 <45172AC8.2070701@goop.org>
	 <1159146974.26986.30.camel@localhost.localdomain>
	 <45173287.8070204@goop.org>
	 <1159152678.26986.38.camel@localhost.localdomain>
	 <45176865.7020300@goop.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 16:03:52 +1000
Message-Id: <1159164232.26986.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 22:25 -0700, Jeremy Fitzhardinge wrote:
> The %gs:per_cpu__foo addressing mode still calculates 
> 0xbcef00+0xc0433800, which is still a subtraction.  My essential point 
> is that *all* kernel addresses (=kernel symbols) are negative, so using 
> them as an offset from a segment base (any segment base) is a 
> subtraction, which requires a 4G limit.

I don't think so.  There's *never* address subtraction, there's
sometimes 32 bit wrap (glibc uses this to effect subtraction, sure).
But there's no wrap here.

To test, I changed the following:

--- smpboot.c.~8~	2006-09-25 15:51:50.000000000 +1000
+++ smpboot.c	2006-09-25 16:00:36.000000000 +1000
@@ -926,8 +926,9 @@
 					      unsigned long per_cpu_off)
 {
 	unsigned limit, flags;
+	extern char __per_cpu_end[];
 
-	limit = (1 << 20);
+	limit = PAGE_ALIGN((long)__per_cpu_end) >> PAGE_SHIFT;
 	flags = 0x8;		/* 4k granularity */
 
 	/* present read-write data segment */


Works fine...

Hope that clarifies!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

