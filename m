Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUBWK2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUBWK2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:28:39 -0500
Received: from everest.2mbit.com ([24.123.221.2]:21958 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261910AbUBWK2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:28:36 -0500
Message-ID: <4039D599.7060001@greatcn.org>
Date: Mon, 23 Feb 2004 18:27:37 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
References: <c16rdh$gtk$1@terminus.zytor.com>
In-Reply-To: <c16rdh$gtk$1@terminus.zytor.com>
X-Scan-Signature: ec6cedc14a2c94d5e7cc71388ad972a6
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Does Flushing the Queue after PG REALLY a Necessity?
Content-Type: multipart/mixed;
 boundary="------------070302020309010701090206"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070302020309010701090206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

> Anyone happen to know of any legitimate reason not to reload %cs in
> head.S?  I think the following would be a lot cleaner, as well as a
> lot safer (the jump and indirect branch aren't guaranteed to have the
> proper effects, although technically neither should be required due to
> the %cr0 write):

Anyone happen to know of any legitimate reason to flush the prefetch
queue after enabling paging?

I've read the intel manual volume 3 thoroughly. It only says that after
entering protected mode, flushing is required, but never says
specifically about whether to do flushing after enabling paging.

Furthermore the intel example code enables protected mode and paging at
the same time. So does FreeBSD. There's really no more references to check.

  From the cpu's internal view, flushing for PE is to flush the prefetch
queue as well as re-load the %cs, since the protected mode is just about
to begin. But no reason to flushing for PG, since linux maps the
addresses *identically*.

If no any reason, please remove the after paging flushing queue code,
two near jump.


	Coywolf

(patch enclosed)
-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org


--------------070302020309010701090206
Content-Type: text/plain;
 name="patch-cy0402232"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cy0402232"

--- head.S	2004-02-18 11:57:16.000000000 +0800
+++ head-cy.S	2004-02-23 17:19:02.000000000 +0800
@@ -115,11 +115,7 @@
 	movl %cr0,%eax
 	orl $0x80000000,%eax
 	movl %eax,%cr0		/* ..and set paging (PG) bit */
-	jmp 1f			/* flush the prefetch-queue */
-1:
-	movl $1f,%eax
-	jmp *%eax		/* make sure eip is relocated */
-1:
+
 	/* Set up the stack pointer */
 	lss stack_start,%esp
 


--------------070302020309010701090206--
