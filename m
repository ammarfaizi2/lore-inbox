Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUI2B6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUI2B6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUI2B6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:58:51 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:42763 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268145AbUI2B6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:58:48 -0400
Date: Wed, 29 Sep 2004 11:58:27 +1000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mdz@canonical.com, janitor@sternwelten.at
Subject: Re: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel thread
Message-ID: <20040929015827.GA26337@gondor.apana.org.au>
References: <20040927102552.GA19183@gondor.apana.org.au> <1096289501.9930.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1096289501.9930.19.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2004 at 01:51:42PM +0100, Alan Cox wrote:
> On Llu, 2004-09-27 at 11:25, Herbert Xu wrote:
> > The continue is just paranoia in case something relies on the sleep
> > to take 2 seconds or more.
> 
> If the signal occurs then you'll spin for 2 seconds because the signal
> is still waiting to be serviced. This therefore looks broken

Yes you're right.  However I'd say that msleep_interruptible should
mirror the behaviour of schedule_timeout and at least sleep once.

BTW, msleep_interruptible() is white-space damaged.  Can someone please
fix it up?

> A more interesting question is why this isn't being driven off a
> timer ?

It probably could if the stuff afterwards doesn't sleep.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== kernel/timer.c 1.93 vs edited =====
--- 1.93/kernel/timer.c	2004-09-17 17:07:06 +10:00
+++ edited/kernel/timer.c	2004-09-29 11:48:06 +10:00
@@ -1626,10 +1626,10 @@
 {
        unsigned long timeout = msecs_to_jiffies(msecs);
 
-       while (timeout && !signal_pending(current)) {
+	do {
                set_current_state(TASK_INTERRUPTIBLE);
                timeout = schedule_timeout(timeout);
-       }
+	} while (timeout && !signal_pending(current));
        return jiffies_to_msecs(timeout);
 }
 

--vtzGhvizbBRQ85DL--
