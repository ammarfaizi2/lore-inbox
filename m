Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWJEVdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWJEVdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWJEVdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:33:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:46117 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932219AbWJEVdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:33:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=pXx2nRFR97yLcFBNHl3/LW0y+Oes+D17ZBMQT6WDrBOmBXdGlq3yFNzHD/tY1PVdd2/zKCUGoo+r2RZb0QBGpWMtKPBltlLVOPsQStfB5nJ9WvsNd4APZOFQPNkeshmYCnEH0+LD1mPx3yLijs9BtKQBQOcrc47u3hibvqEGk7c=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Thu, 5 Oct 2006 17:31:56 -0400
User-Agent: KMail/1.9.1
Cc: andrew.j.wade@gmail.com, tim.c.chen@linux.intel.com,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
References: <1159916644.8035.35.camel@localhost.localdomain> <200610050417.39518.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061005013635.e016bf2b.akpm@osdl.org>
In-Reply-To: <20061005013635.e016bf2b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051732.44669.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 04:36, Andrew Morton wrote:
> On Thu, 5 Oct 2006 04:13:07 -0400
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > (...)
> 
> 
> That all looks OK (by sheer luck).
> 
> Well.  What's the cache line size on that machine?  Every exit() will cause
> a down_read() on task_exit_notifier's lock which might affect things.  And
> I think you snipped the above list a bit short (depending on that line
> size).
> 
> 
> But still, we know that moving those things into __read_mostly didn't fix
> it, yes?

No. To my knowledge Tim Chen hasn't tried __read_mostly, and I have not
attempted to replicate the test case. (I only have a uniprocessor
machine.) Core 2 machines have a cache line size of 64 bytes, but Tim
Chen is likely using a different kernel/.config than I am so my objdump
isn't definitive.

Tim, perhaps you can try the __read_mostly marking as Andrew suggests?

signed-off-by: Andrew Wade <andrew.j.wade@gmail.com>
upN a/include/asm-generic/bug.h b/include/asm-generic/bug.h
--- a/include/asm-generic/bug.h	2006-10-05 16:16:37.000000000 -0400
+++ b/include/asm-generic/bug.h	2006-10-05 16:33:08.000000000 -0400
@@ -42,7 +42,7 @@
 #endif
 
 #define WARN_ON_ONCE(condition)	({			\
-	static int __warn_once = 1;			\
+	static int __warn_once __read_mostly = 1;	\
 	typeof(condition) __ret_warn_once = (condition);\
 							\
 	if (likely(__warn_once))			\
