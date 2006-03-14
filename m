Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWCNXAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWCNXAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNXAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:00:05 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:39122 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S1751855AbWCNXAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:00:04 -0500
Date: Wed, 15 Mar 2006 08:54:48 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
To: Valdis.Kletnieks@vt.edu
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Adrian Bunk <bunk@stusta.de>,
       davem@davemloft.net, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/aes.c: array overrun
Message-ID: <20060314225448.GA27285@beast>
References: <20060311010339.GF21864@stusta.de> <20060311024116.GA21856@gondor.apana.org.au> <200603142025.k2EKP8Z4010175@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <200603142025.k2EKP8Z4010175@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Jivin Valdis.Kletnieks@vt.edu lays it down ...
> On Sat, 11 Mar 2006 13:41:16 +1100, Herbert Xu said:
> 
> > OK this is not pretty but it is actually correct.  Notice how we only
> > overstep the mark for E_KEY but never for D_KEY.  Since D_KEY is only
> > initialised after this, it is OK for us to trash the start of D_KEY.
> 
> I think a big comment block describing this behavior is called for,
> as it carries an implicit requirement that D_KEY and E_KEY remain
> adjacent in memory.  Anybody allocating space between them is in for
> a rude awakening....

Sounds like a bug waiting to happen to me.
Why not do something like the attached patch.

Cheers,
Davidm

-- 
David McCullough, david_mccullough@au.securecomputing.com, Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aes.diff"

Index: linux-2.6.x/crypto/aes.c
===================================================================
RCS file: linux-2.6.x/crypto/aes.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 aes.c
--- linux-2.6.x/crypto/aes.c	31 Aug 2005 00:33:03 -0000	1.1.1.6
+++ linux-2.6.x/crypto/aes.c	14 Mar 2006 22:53:06 -0000
@@ -78,12 +78,11 @@
 
 struct aes_ctx {
 	int key_length;
-	u32 E[60];
-	u32 D[60];
+	u32 _KEYS[120];
 };
 
-#define E_KEY ctx->E
-#define D_KEY ctx->D
+#define E_KEY (&ctx->_KEYS[0])
+#define D_KEY (&ctx->_KEYS[60])
 
 static u8 pow_tab[256] __initdata;
 static u8 log_tab[256] __initdata;

--ZGiS0Q5IWpPtfppv--
