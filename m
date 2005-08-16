Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVHPSG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVHPSG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVHPSG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:06:58 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:27917 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030273AbVHPSG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:06:58 -0400
Message-ID: <43022B0A.4030807@vmware.com>
Date: Tue, 16 Aug 2005 11:06:02 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@osdl.org>, Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 7/14] i386 / Add some descriptor convenience  functions
References: <200508161306_MC3-1-A75D-6645@compuserve.com>
In-Reply-To: <200508161306_MC3-1-A75D-6645@compuserve.com>
Content-Type: multipart/mixed;
 boundary="------------020809010708010407020409"
X-OriginalArrivalTime: 16 Aug 2005 18:05:41.0258 (UTC) FILETIME=[1D1EE6A0:01C5A28D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809010708010407020409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chuck Ebbert wrote:

>On Wed, 10 Aug 2005 at 21:56:20 -0700, zach@vmware.com wrote:
>
>  
>
>>Patch-base: 2.6.13-rc5-mm1
>>Patch-keys: i386 desc cleanup
>>Signed-off-by: Zachary Amsden <zach@vmware.com>
>>Index: linux-2.6.13/include/asm-i386/desc.h
>>===================================================================
>>--- linux-2.6.13.orig/include/asm-i386/desc.h 2005-08-09 19:43:38.000000000 -0700
>>+++ linux-2.6.13/include/asm-i386/desc.h      2005-08-10 20:42:03.000000000 -0700
>>@@ -14,6 +14,28 @@
>> 
>> #include <asm/mmu.h>
>> 
>>+#define desc_empty(desc) \
>>+             (!((desc)->a + (desc)->b))
>>+
>>    
>>
>
>     I think that should be "|" instead of "+".
>  
>

I think so too.  I merely moved the code here and didn't notice it in 
all this excitement.

0x00cf9a000xff306600  =>

Present CPL-0 32-bit code segment, base 0x0000ff30, limit 0xf6601 pages, 
for which desc_empty(desc) is true.

Thankfully, this is not used as a security check, but it can falsely 
overwrite TLS segments with carefully chosen base / limits.  I do not 
believe this is an issue in practice, but it is a kernel bug.

Nice catch.  Looks like it affects all 2.6.X kernels.

Zach

--------------020809010708010407020409
Content-Type: text/plain;
 name="fix-desc-empty"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-desc-empty"

Chuck Ebbert noticed that the desc_empty macro is incorrect.  Fix it.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-15 11:23:32.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-16 10:49:03.000000000 -0700
@@ -18,7 +18,7 @@
 #include <asm/mmu.h>
 
 #define desc_empty(desc) \
-		(!((desc)->a + (desc)->b))
+		(!((desc)->a | (desc)->b))
 
 #define desc_equal(desc1, desc2) \
 		(((desc1)->a == (desc2)->a) && ((desc1)->b == (desc2)->b))

--------------020809010708010407020409--
