Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRKOWcK>; Thu, 15 Nov 2001 17:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKOWcB>; Thu, 15 Nov 2001 17:32:01 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:37548 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281128AbRKOWbq> convert rfc822-to-8bit; Thu, 15 Nov 2001 17:31:46 -0500
Date: Thu, 15 Nov 2001 20:46:34 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small sym-2 fix
In-Reply-To: <20011115172204.B1589-100000@gerard>
Message-ID: <20011115203852.M2136-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, Gérard Roudier wrote:

> On Thu, 15 Nov 2001, Anton Blanchard wrote:
>
> >
> > Hi,
> >
> > I tested the sym-2 driver on ppc64 and found that hcb_p can be > 1 page
> > but __sym_malloc fails for allocations over 1 page. This means we
> > die in sym_attach.
>
> The driver should not need more than 4096 bytes for a single allocation.
> If the ppc64 page size is smaller, your patch is ok, otherwise something
> may have to be fixed, likely in the driver. I cannot access to kernel
> source immediately but I will check what kind of page size ppc64 is using
> asap.

Could you revert your change and give my patch below a try. Btw, you will
be in sync with my current sources. Booting with sym53c8xx=debug:1 will
let the driver print all memory allocations to the syslog. You may send me
the drivers messages related to these allocations for information.

  Gérard.

PS: I do have tried the patch on a IA32 machine under linux-2.4.13.

> > With this patch the sym-2 works on ppc64. BTW so far it looks solid :)
>
> Great!
>
> Thanks for your report.
>
> Regards,
>   Gérard.
> >
> > Anton
> >
> > diff -urN 2.4.15-pre4/drivers/scsi/sym53c8xx_2/sym_glue.h linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h
> > --- 2.4.15-pre4/drivers/scsi/sym53c8xx_2/sym_glue.h	Thu Nov 15 13:38:02 2001
> > +++ linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h	Tue Nov 13 18:03:07 2001
> > @@ -526,7 +526,7 @@
> >   *  couple of things related to the memory allocator.
> >   */
> >  typedef u_long m_addr_t;	/* Enough bits to represent any address */
> > -#define SYM_MEM_PAGE_ORDER 0	/* 1 PAGE  maximum */
> > +#define SYM_MEM_PAGE_ORDER 1	/* 2 PAGE  maximum */
> >  #define SYM_MEM_CLUSTER_SHIFT	(PAGE_SHIFT+SYM_MEM_PAGE_ORDER)
> >  #ifdef	MODULE
> >  #define SYM_MEM_FREE_UNUSED	/* Free unused pages immediately */

diff -u ../sym-2-orig/sym_glue.h ./sym_glue.h
--- ../sym-2-orig/sym_glue.h	Thu Nov 15 22:53:34 2001
+++ ./sym_glue.h	Thu Nov 15 23:18:58 2001
@@ -77,7 +77,6 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/string.h>
-#include <linux/malloc.h>
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/time.h>
Only in .: sym_glue.o
diff -u ../sym-2-orig/sym_hipd.c ./sym_hipd.c
--- ../sym-2-orig/sym_hipd.c	Thu Nov 15 22:53:28 2001
+++ ./sym_hipd.c	Thu Nov 15 23:16:03 2001
@@ -4691,6 +4691,7 @@
 	OUTL_DSP (SCRIPTA_BA (np, clrack));
 	return;
 out_stuck:
+	return;
 }

 /*
@@ -5226,6 +5227,7 @@

 	return;
 fail:
+	return;
 }

 /*
@@ -5788,6 +5790,13 @@
 		goto attach_failed;

 	/*
+	 *  Allocate the array of lists of CCBs hashed by DSA.
+	 */
+	np->ccbh = sym_calloc(sizeof(ccb_p *)*CCB_HASH_SIZE, "CCBH");
+	if (!np->ccbh)
+		goto attach_failed;
+
+	/*
 	 *  Initialyze the CCB free and busy queues.
 	 */
 	sym_que_init(&np->free_ccbq);
@@ -5978,6 +5987,8 @@
 			sym_mfree_dma(cp, sizeof(*cp), "CCB");
 		}
 	}
+	if (np->ccbh)
+		sym_mfree(np->ccbh, sizeof(ccb_p *)*CCB_HASH_SIZE, "CCBH");

 	if (np->badluntbl)
 		sym_mfree_dma(np->badluntbl, 256,"BADLUNTBL");
diff -u ../sym-2-orig/sym_hipd.h ./sym_hipd.h
--- ../sym-2-orig/sym_hipd.h	Thu Nov 15 22:53:34 2001
+++ ./sym_hipd.h	Thu Nov 15 22:54:31 2001
@@ -1068,7 +1068,8 @@
 	/*
 	 *  CCB lists and queue.
 	 */
-	ccb_p ccbh[CCB_HASH_SIZE];	/* CCB hashed by DSA value	*/
+	ccb_p *ccbh;			/* CCBs hashed by DSA value	*/
+					/* CCB_HASH_SIZE lists of CCBs	*/
 	SYM_QUEHEAD	free_ccbq;	/* Queue of available CCBs	*/
 	SYM_QUEHEAD	busy_ccbq;	/* Queue of busy CCBs		*/

diff -u ../sym-2-orig/sym_nvram.c ./sym_nvram.c
--- ../sym-2-orig/sym_nvram.c	Thu Nov 15 22:53:28 2001
+++ ./sym_nvram.c	Thu Nov 15 22:54:25 2001
@@ -505,10 +505,10 @@
 	return retv;
 }

-#undef SET_BIT 0
-#undef CLR_BIT 1
-#undef SET_CLK 2
-#undef CLR_CLK 3
+#undef SET_BIT
+#undef CLR_BIT
+#undef SET_CLK
+#undef CLR_CLK

 /*
  *  Try reading Symbios NVRAM.

