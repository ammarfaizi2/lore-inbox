Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbSJ0KCf>; Sun, 27 Oct 2002 05:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbSJ0KCf>; Sun, 27 Oct 2002 05:02:35 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:40887 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262328AbSJ0KCe>;
	Sun, 27 Oct 2002 05:02:34 -0500
Message-ID: <3DBBBB30.20409@colorfullife.com>
Date: Sun, 27 Oct 2002 11:08:48 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] faster kmalloc lookup
References: <3DBAEB64.1090109@colorfullife.com> <1035671412.13032.125.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------040808040707070602020605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040808040707070602020605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>On Sat, 2002-10-26 at 20:22, Manfred Spraul wrote:
>  
>
>>kmalloc spends a large part of the total execution time trying to find 
>>the cache for the passed in size.
>>
>>What about the attached patch (against 2.5.44-mm5)?
>>It uses fls jump over the caches that are definitively too small.
>>    
>>
>
>Out of curiousity how does fls compare with finding the right cache by
>using a binary tree walk ? A lot of platforms seem to use generic_fls
>which has a lot of conditions in it and also a lot of references to just
>computed values that look likely to stall 
>  
>
Binary tree walk means 4 unpredictable branches and at least i386 can 
use bsrl for a fast fls().
Patch is attached.

--
    Manfred


--------------040808040707070602020605
Content-Type: text/plain;
 name="patch-fls"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fls"

--- 2.5/include/asm-i386/bitops.h	Sun Sep 22 06:25:12 2002
+++ build-2.5/include/asm-i386/bitops.h	Sun Oct 27 11:04:57 2002
@@ -414,11 +414,22 @@
 	return word;
 }
 
-/*
+/**
  * fls: find last bit set.
+ * @x: The word to search
+ *
  */
 
-#define fls(x) generic_fls(x)
+static inline int fls(int x)
+{
+	int r;
+
+	__asm__("bsrl %1,%0\n\t"
+		"jnz 1f\n\t"
+		"movl $-1,%0\n"
+		"1:" : "=r" (r) : "g" (x));
+	return r+1;
+}
 
 #ifdef __KERNEL__
 

--------------040808040707070602020605--

