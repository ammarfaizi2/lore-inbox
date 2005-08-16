Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVHPTSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVHPTSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVHPTSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:18:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932367AbVHPTSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:18:43 -0400
Date: Tue, 16 Aug 2005 12:05:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: Zachary Amsden <zach@vmware.com>, Chuck Ebbert <76306.1226@compuserve.com>,
       Chris Wright <chrisw@osdl.org>, virtualization@lists.osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 / desc_empty macro is incorrect
Message-ID: <20050816190509.GE7762@shell0.pdx.osdl.net>
References: <200508161306_MC3-1-A75D-6646@compuserve.com> <430233FF.7090106@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430233FF.7090106@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zachary Amsden <zach@vmware.com>

Chuck Ebbert wrote:
>     I think that should be "|" instead of "+".

I think so too.  I merely moved the code here and didn't notice it in 
all this excitement.

0x00cf9a000xff306600  =>

Present CPL-0 32-bit code segment, base 0x0000ff30, limit 0xf6601 pages, 
for which desc_empty(desc) is true.

Thankfully, this is not used as a security check, but it can falsely 
overwrite TLS segments with carefully chosen base / limits.  I do not 
believe this is an issue in practice, but it is a kernel bug.

Nice catch.  Looks like it affects all 2.6.X kernels.

Chuck Ebbert noticed that the desc_empty macro is incorrect.  Fix it.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -29,7 +29,7 @@ struct desc_struct {
 };
 
 #define desc_empty(desc) \
-		(!((desc)->a + (desc)->b))
+		(!((desc)->a | (desc)->b))
 
 #define desc_equal(desc1, desc2) \
 		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))
