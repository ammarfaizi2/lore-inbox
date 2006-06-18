Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWFRFOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWFRFOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 01:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWFRFOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 01:14:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14519
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932095AbWFRFOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 01:14:37 -0400
Date: Sat, 17 Jun 2006 22:14:35 -0700 (PDT)
Message-Id: <20060617.221435.48805608.davem@davemloft.net>
To: luke.adi@gmail.com
Cc: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol
 stack
From: David Miller <davem@davemloft.net>
In-Reply-To: <489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
References: <489ecd0c0606080015v4815d0f3wa3d28c564eaf6885@mail.gmail.com>
	<489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luke Yang" <luke.adi@gmail.com>
Date: Wed, 14 Jun 2006 10:29:19 +0800

> --- net/irda/irlmp.c.old        2006-06-08 14:49:20.000000000 +0800
> +++ net/irda/irlmp.c    2006-06-14 10:00:22.000000000 +0800
> @@ -849,7 +849,10 @@
>         }
> 
>         /* Construct new discovery info to be used by IrLAP, */
> -       u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
> +       irlmp->discovery_cmd.data.hints[0] = \
> +               le16_to_cpu(irlmp->hints.word) & 0xff;
> +       irlmp->discovery_cmd.data.hints[1] = \
> +               (le16_to_cpu(irlmp->hints.word) & 0xff00) >> 8;
> 
>         /*
>          *  Set character set for device name (we use ASCII), and

I decided in the end to fix this differently.

We have a portable unaligned access interface, via get_unaligned() and
put_unaligned() in asm/unaligned.h, which makes sure there is no
penalty for platforms whose cpu does unaligned memory accesses
transparently.

diff --git a/net/irda/irlmp.c b/net/irda/irlmp.c
index c19e9ce..57ea160 100644
--- a/net/irda/irlmp.c
+++ b/net/irda/irlmp.c
@@ -44,6 +44,8 @@
 #include <net/irda/irlmp.h>
 #include <net/irda/irlmp_frame.h>
 
+#include <asm/unaligned.h>
+
 static __u8 irlmp_find_free_slsap(void);
 static int irlmp_slsap_inuse(__u8 slsap_sel);
 
@@ -840,6 +842,7 @@ void irlmp_do_expiry(void)
 void irlmp_do_discovery(int nslots)
 {
 	struct lap_cb *lap;
+	__u16 *data_hintsp;
 
 	/* Make sure the value is sane */
 	if ((nslots != 1) && (nslots != 6) && (nslots != 8) && (nslots != 16)){
@@ -849,7 +852,8 @@ void irlmp_do_discovery(int nslots)
 	}
 
 	/* Construct new discovery info to be used by IrLAP, */
-	u16ho(irlmp->discovery_cmd.data.hints) = irlmp->hints.word;
+	data_hintsp = (__u16 *) irlmp->discovery_cmd.data.hints;
+	put_unaligned(irlmp->hints.word, data_hintsp);
 
 	/*
 	 *  Set character set for device name (we use ASCII), and
