Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCHSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCHSED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVCHSEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:04:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:1254 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261459AbVCHSC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:02:57 -0500
Date: Tue, 8 Mar 2005 10:02:50 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>
Subject: [UPDATE PATCH 9/many] acrypto: crypto_lb.c
Message-ID: <20050308180250.GC2834@us.ibm.com>
References: <1110227854480@2ka.mipt.ru> <1110227854957@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110227854957@2ka.mipt.ru>
X-Operating-System: Linux 2.6.11 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 11:37:34PM +0300, Evgeniy Polyakov wrote:
> --- /tmp/empty/crypto_lb.c	1970-01-01 03:00:00.000000000 +0300
> +++ ./acrypto/crypto_lb.c	2005-03-07 20:35:36.000000000 +0300
> @@ -0,0 +1,634 @@
> +/*
> + * 	crypto_lb.c
> + *
> + * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>

<snip>

> +void crypto_lb_unregister(struct crypto_lb *lb)
> +{
> +	struct crypto_lb *__lb, *n;
> +
> +	if (lb_num == 1) {
> +		dprintk(KERN_INFO "You are removing crypto load balancer %s which is current and default.\n"
> +			"There is no other crypto load balancers. "
> +			"Removing %s delayed untill new load balancer is registered.\n",
> +			lb->name, (force_lb_remove) ? "is not" : "is");
> +		while (lb_num == 1 && !force_lb_remove) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(HZ);
> +
> +			if (signal_pending(current))
> +				flush_signals(current);
> +		}
> +	}

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected. Using msleep*() also leads to a
more human-understandable interface and allows for virtualized systems
(jiffy-less) to function correctly (with appropriate extensions).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-v/acrypto/crypto_lb.c	2005-03-08 09:58:56.000000000 -0800
+++ 2.6.11/acrypto/crypto_lb.c	2005-03-08 09:59:38.000000000 -0800
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 
 #include "acrypto.h"
 #include "crypto_lb.h"
@@ -397,8 +398,7 @@ void crypto_lb_unregister(struct crypto_
 			"Removing %s delayed untill new load balancer is registered.\n",
 			lb->name, (force_lb_remove) ? "is not" : "is");
 		while (lb_num == 1 && !force_lb_remove) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ);
+			msleep_interruptible(1000);
 
 			if (signal_pending(current))
 				flush_signals(current);
