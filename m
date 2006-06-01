Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWFAIJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWFAIJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFAIJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:09:36 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:12813 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750749AbWFAIJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:09:36 -0400
Date: Thu, 1 Jun 2006 18:09:13 +1000
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, pauldrynoff@gmail.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-ID: <20060601080913.GA26955@gondor.apana.org.au>
References: <20060530195417.e870b305.pauldrynoff@gmail.com> <20060530132540.a2c98244.akpm@osdl.org> <20060531181926.51c4f4c5.pauldrynoff@gmail.com> <1149085739.3114.34.camel@laptopd505.fenrus.org> <20060531102128.eb0020ad.akpm@osdl.org> <447DFE29.6040508@linux.intel.com> <20060531142525.5a22f9f1.akpm@osdl.org> <447E097C.2020707@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <447E097C.2020707@linux.intel.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2006 at 09:24:12PM +0000, Arjan van de Ven wrote:
> 
> misrouted_irq() in kernel/irq/spurious.c
> afaics that calls all handlers registered to the system regardless of what
> irq number they are registered for.....
> 
> which breaks the disable_irq() locking trick... because your irq handler now
> gets called anyway!

This is a serious bug in misrouted_irq().  disable_irq() is a software
state and must be repsected.

[IRQ]: Check IRQ_DISABLED in misrouted_irq

The misrouted interrupt function didn't check the IRQ_DISABLED flag
before calling the handlers.  This is highly undesirable as handlers
are usually disabled for a good reason.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="spurious-disabled-irq.patch"

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 7df9abd..0540b72 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -31,6 +31,10 @@ static int misrouted_irq(int irq, struct
 			continue;
 		desc = &irq_desc[i];
 		spin_lock(&desc->lock);
+		if (desc->status & IRQ_DISABLED) {
+			spin_unlock(&desc->lock);
+			continue;
+		}
 		action = desc->action;
 		/* Already running on another processor */
 		if (desc->status & IRQ_INPROGRESS) {

--nFreZHaLTZJo0R7j--
