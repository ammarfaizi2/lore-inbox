Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSKMXiS>; Wed, 13 Nov 2002 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSKMXiS>; Wed, 13 Nov 2002 18:38:18 -0500
Received: from fmr02.intel.com ([192.55.52.25]:27874 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263837AbSKMXiQ>; Wed, 13 Nov 2002 18:38:16 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC93A@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Falk Hueffner'" <falk.hueffner@student.uni-tuebingen.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] include/asm-ARCH/page.h:get_order() Reorganize and op
	timize
Date: Wed, 13 Nov 2002 15:44:58 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C28B6E.ACC2B4A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C28B6E.ACC2B4A0
Content-Type: text/plain;
	charset="iso-8859-1"



> >     s = --s >> PAGE_SHIFT;
> 
> This code has undefined behaviour.
 
Do you mean that this:

s = (s-1) >> PAGE_SHIFT

is more deterministic? If so, I agree -- if you mean
something else, I am kind of lost.

> >     if (likely (s) < s)
> 
> What is that supposed to do?

This is doing the "you are looking at the obvious 
and not noticing" [I mean me, not you]. I started with 
another algorithm, crappier, that required this in order
to work properly, and I never took it out; not to mention 
it is wrong - it should read 'if (likely ((1 << exp) < s))' 
... McFly, anybody home?

I also realized I was not calling get_order() -the old version-
statically in the test case, so that slowed it down ... in any
case, it does not seem to affect much [probably because of the
tight loop].
 
> BTW, I just noticed
> 
> #define likely(x)       __builtin_expect((x),1)
> 
> I think this should rather be
> 
> #define likely(x)       __builtin_expect((x)!=0,1)
 
Yep, for NGPT what I did was to cast it to unsigned long,
although your way might be more elegant. Care to submit that?

Okay, so now I got it fixed, I will be submitting a new patch 
right now with the whole thing against 2.5.47. The changes versus
the previous one are:

--- page.h	13 Nov 2002 00:49:22 -0000	1.1.2.1
+++ page.h	13 Nov 2002 22:58:51 -0000	1.1.2.2
@@ -10,17 +10,10 @@
 static __inline__
 int generic_get_order (unsigned long s)
 {
-        int exp;
-
-        s = --s >> PAGE_SHIFT;
+        s = (s - 1) >> PAGE_SHIFT;
         if (s == 0)
                 return 0;
-    
-        exp = fls (s);
-        s = 1 << exp;
-        if (likely (s) < s)
-                exp++;
-        return exp;
+        return fls (s);
 }
 
 #endif _GENERIC_PAGE_H

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]



------_=_NextPart_000_01C28B6E.ACC2B4A0
Content-Type: text/plain;
	name="tt.txt"
Content-Disposition: attachment;
	filename="tt.txt"

Index: page.h
===================================================================
RCS file: /home/CVS/src/linux/kernel/linux/include/asm-generic/Attic/page.h,v
retrieving revision 1.1.2.1
retrieving revision 1.1.2.2
diff -u -r1.1.2.1 -r1.1.2.2
--- page.h	13 Nov 2002 00:49:22 -0000	1.1.2.1
+++ page.h	13 Nov 2002 22:58:51 -0000	1.1.2.2
@@ -10,17 +10,10 @@
 static __inline__
 int generic_get_order (unsigned long s)
 {
-        int exp;
-
-        s = --s >> PAGE_SHIFT;
+        s = (s - 1) >> PAGE_SHIFT;
         if (s == 0)
                 return 0;
-    
-        exp = fls (s);
-        s = 1 << exp;
-        if (likely (s) < s)
-                exp++;
-        return exp;
+        return fls (s);
 }
 
 #endif _GENERIC_PAGE_H

------_=_NextPart_000_01C28B6E.ACC2B4A0--
