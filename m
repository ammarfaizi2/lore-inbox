Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272433AbRIKNkY>; Tue, 11 Sep 2001 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRIKNkO>; Tue, 11 Sep 2001 09:40:14 -0400
Received: from ohta003008.catv.ppp.infoweb.ne.jp ([61.121.90.8]:32775 "HELO
	clef.score") by vger.kernel.org with SMTP id <S268017AbRIKNkG>;
	Tue, 11 Sep 2001 09:40:06 -0400
To: linux-kernel@vger.kernel.org
Cc: takehiro@users.sourceforge.net
Subject: boot time inflation code hack
From: Takehiro Tominaga <tominaga@isoternet.org>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Tue_Sep_11_22:40:22_2001_809)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010911224024B.tominaga@isoternet.org>
Date: Tue, 11 Sep 2001 22:40:24 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Tue_Sep_11_22:40:22_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi all,

On some architectures, linux kernel image can be stored in compressed
format(with gzip) and boot loader will inflate the compression.

I found linux/lib/inflate.c is the boot-time inflating routine and
is not used from another part of kernel. In the inflate.c, there
are some malloc() and free().

inflate.c is included from linux/arch/*/boot/compressed/misc.c, which
provides these functions.

but, for each architecture, free() does nothing at all. So we can remove
some part of inflate.c. the patch is attached.

I just tested it on IA32 platform only. please review on your architecture.
--- 
Takehiro TOMINAGA // may the source be with you!

----Next_Part(Tue_Sep_11_22:40:22_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=inflation-diff

--- lib/inflate.c.bak	Wed Mar  7 12:44:37 2001
+++ lib/inflate.c	Tue Sep 11 21:35:37 2001
@@ -140,7 +140,11 @@
 /* Function prototypes */
 STATIC int huft_build OF((unsigned *, unsigned, unsigned, 
 		const ush *, const ush *, struct huft **, int *));
-STATIC int huft_free OF((struct huft *));
+#ifdef SOMETHINGINFREE
+ STATIC int huft_free OF((struct huft *));
+#else
+ #define huft_free(dummy) 0
+#endif
 STATIC int inflate_codes OF((struct huft *, struct huft *, int, int));
 STATIC int inflate_stored OF((void));
 STATIC int inflate_fixed OF((void));
@@ -489,6 +493,7 @@
 
 
 
+#ifdef SOMETHINGINFREE
 STATIC int huft_free(t)
 struct huft *t;         /* table to free */
 /* Free the malloc'ed tables built by huft_build(), which makes a linked
@@ -508,7 +513,7 @@
   } 
   return 0;
 }
-
+#endif
 
 STATIC int inflate_codes(tl, td, bl, bd)
 struct huft *tl, *td;   /* literal/length and distance decoder tables */
@@ -1026,6 +1031,7 @@
   int i;                /* counter for all possible eight bit values */
   int k;                /* byte being shifted into crc apparatus */
 
+#if 0
   /* terms of polynomial defining this crc (except x^32): */
   static const int p[] = {0,1,2,4,5,7,8,10,11,12,16,22,23,26};
 
@@ -1033,6 +1039,9 @@
   e = 0;
   for (i = 0; i < sizeof(p)/sizeof(int); i++)
     e |= 1L << (31 - p[i]);
+#else
+  e = 0xedb88320;
+#endif
 
   crc_32_tab[0] = 0;
 

----Next_Part(Tue_Sep_11_22:40:22_2001_809)----
