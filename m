Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUBWEoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 23:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUBWEoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 23:44:03 -0500
Received: from everest.2mbit.com ([24.123.221.2]:31973 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261807AbUBWEnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 23:43:55 -0500
Message-ID: <403984DD.4030108@greatcn.org>
Date: Mon, 23 Feb 2004 12:43:09 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <c16rdh$gtk$1@terminus.zytor.com> <40375261.6030705@greatcn.org> <20040221163213.GB15991@mail.shareable.org>
In-Reply-To: <20040221163213.GB15991@mail.shareable.org>
X-Scan-Signature: 62d1087d478a9a52db5682afa485e771
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Re: BOOT_CS
Content-Type: multipart/mixed;
 boundary="------------090105030904020007020704"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105030904020007020704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jamie Lokier wrote:

> Coywolf Qi Hunt wrote:
> 
>>>(the jump and indirect branch aren't guaranteed to have the
>>>proper effects, although technically neither should be required due to
>>>the %cr0 write):

???

>>
>>
>>IMHO, why bother to re-reload %cs again?
>>
>>In setup.S, %cs is reloaded already. The enable paging code maps the
>>address identically, so %cs already contains the proper selector.
> 
> 
> It's to flush the instruction prefetch queue: that's one of the side
> effects of ljmp.

Re-loading %cs and flushing prefetch queue are two different things.

> 
> I recall an Intel manual that said ljmp is required when switching
> between real and protected modes, to flush the prefetch queue.

Not necessarily ljmp, imho

> 
> Unfortunately I don't remember what that manual said about just setting PG.
> 
> I'd guess that current generation CPUs don't care about ljmp when
> changing modes, but older ones certainly do.
> 
> -- Jamie
> 

FYI, intel's example code located in STARTUP.ASM Listing arround line
180, chapter 9, IA-32 Intel Architecture Software Developer's Manual,
Volume 3: System Programming Guide



Please consider my patch for this issue.


	Coywolf



-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org





--------------090105030904020007020704
Content-Type: text/plain;
 name="patch-cy0402230"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0402230"

--- head.S.orig	2004-02-18 11:57:16.000000000 +0800
+++ head.S	2004-02-23 12:35:24.000000000 +0800
@@ -115,10 +115,8 @@
 	movl %cr0,%eax
 	orl $0x80000000,%eax
 	movl %eax,%cr0		/* ..and set paging (PG) bit */
-	jmp 1f			/* flush the prefetch-queue */
-1:
-	movl $1f,%eax
-	jmp *%eax		/* make sure eip is relocated */
+	pushl $1f		/* flush the prefetch-queue */
+	ret			/* and normalize $eip */
 1:
 	/* Set up the stack pointer */
 	lss stack_start,%esp


--------------090105030904020007020704--

