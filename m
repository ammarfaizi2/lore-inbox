Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWI0NNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWI0NNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWI0NNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:13:20 -0400
Received: from dpc691978010.direcpc.com ([69.19.78.10]:43967 "EHLO
	third-harmonic.com") by vger.kernel.org with ESMTP id S1751147AbWI0NNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:13:20 -0400
Message-ID: <451A7842.4090201@third-harmonic.com>
Date: Wed, 27 Sep 2006 09:10:26 -0400
From: john cooper <john.cooper@third-harmonic.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lennert Buytenhek <buytenh@wantstofly.org>, linux-kernel@vger.kernel.org,
       john cooper <john.cooper@third-harmonic.com>
Subject: 2.6.18-rt4
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <45134829.9040708@third-harmonic.com> <20060922063621.GA1283@xi.wantstofly.org> <20060922115636.GA12212@elte.hu>
In-Reply-To: <20060922115636.GA12212@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010701000303070907030206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010701000303070907030206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * Lennert Buytenhek <buytenh@wantstofly.org> wrote:
> 
>> On Thu, Sep 21, 2006 at 10:19:21PM -0400, john cooper wrote:
>>
>>>> ok, i've uploaded -rt3:
>>> Attached is a patch which fixes a build problem
>>> for ARM pxa270, and general ARM boot issue when
>>> LATENCY_TRACE is configured.
>> This patch (queued for Linus) lifts that 4MB limitation:
>>
>> 	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3809/2
>>
>> (I ran into the limit when enabling lockdep on ARM.)
> 
> ok, i've added this no-4M-limit patch to -rt. John, does that solve your 
> problem?

A few of us hit a snag in Lennert's original patch.  He has a
fix which addresses this, attached.

-john

-- 
john.cooper@third-harmonic.com

--------------010701000303070907030206
Content-Type: text/x-patch;
 name="fix-allow-large-kernels.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-allow-large-kernels.diff"


The 'sub r3, r3, r5' check to determine the compressed kernel size in
arch/arm/boot/compressed/head.S doesn't work properly, since at that
point, r3 will have been overwritten by cache_on().

What we can do is to use sp instead, which does not get clobbered in
the meanwhile.  Using sp will give us a slightly higher compressed
kernel image size guess than when using r3, but that's safe.

Bug reported by John Cooper and David Anders.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Index: linux-2.6.18/arch/arm/boot/compressed/head.S
===================================================================
--- linux-2.6.18.orig/arch/arm/boot/compressed/head.S
+++ linux-2.6.18/arch/arm/boot/compressed/head.S
@@ -240,7 +240,7 @@ not_relocated:	mov	r0, #0
  */
 		cmp	r4, r2
 		bhs	wont_overwrite
-		sub	r3, r3, r5		@ compressed kernel size
+		sub	r3, sp, r5		@ > compressed kernel image
 		add	r0, r4, r3, lsl #2	@ allow for 4x expansion
 		cmp	r0, r5
 		bls	wont_overwrite

--------------010701000303070907030206--
