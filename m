Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWGYIZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWGYIZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWGYIZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:25:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932143AbWGYIZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:25:06 -0400
Date: Tue, 25 Jul 2006 01:24:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] Missing failure handling
Message-Id: <20060725012453.5765d1f6.akpm@osdl.org>
In-Reply-To: <20060720191629.GD7643@lumumba.uhasselt.be>
References: <20060720191629.GD7643@lumumba.uhasselt.be>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2006 21:16:29 +0200
takis@lumumba.uhasselt.be (Panagiotis Issaris) wrote:

> From: Panagiotis Issaris <takis@issaris.org>
> 
> The PPP code contains two kmalloc()s followed by memset()s without
> handling a possible memory allocation failure. (Suggested by 
> Joe Perches).
> 
> And furthermore, conversions from kmalloc+memset to kzalloc.

OK...

> -			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
> -			memset(np, 0, sizeof(*np));
> +			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
> +			if (!np) {
> +				printk(KERN_ERR "PPP: no memory (cardmap)\n");
> +				return -ENOMEM;
> +			}
>  			np->ptr[0] = p;
>  			if (p != NULL) {
>  				np->shift = p->shift + CARDMAP_ORDER;
> @@ -2719,8 +2727,11 @@ static void cardmap_set(struct cardmap *
>  	while (p->shift > 0) {
>  		i = (nr >> p->shift) & CARDMAP_MASK;
>  		if (p->ptr[i] == NULL) {
> -			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
> -			memset(np, 0, sizeof(*np));
> +			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
> +			if (!np) {
> +				printk(KERN_ERR "PPP: no memory (cardmap)\n");
> +				return -ENOMEM;
> +			}
>  			np->shift = p->shift - CARDMAP_ORDER;

But this leaks memory on errors.

It looks like cardmap_destroy() will handle a partially-constructed map,
so..

--- a/drivers/net/ppp_generic.c~ppp-handle-kmalloc-failures-leak-fix
+++ a/drivers/net/ppp_generic.c
@@ -2710,10 +2710,8 @@ static int cardmap_set(struct cardmap **
 		do {
 			/* need a new top level */
 			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
-			if (!np) {
-				printk(KERN_ERR "PPP: no memory (cardmap)\n");
-				return -ENOMEM;
-			}
+			if (!np)
+				goto enomem;
 			np->ptr[0] = p;
 			if (p != NULL) {
 				np->shift = p->shift + CARDMAP_ORDER;
@@ -2728,10 +2726,8 @@ static int cardmap_set(struct cardmap **
 		i = (nr >> p->shift) & CARDMAP_MASK;
 		if (p->ptr[i] == NULL) {
 			struct cardmap *np = kzalloc(sizeof(*np), GFP_KERNEL);
-			if (!np) {
-				printk(KERN_ERR "PPP: no memory (cardmap)\n");
-				return -ENOMEM;
-			}
+			if (!np)
+				goto enomem;
 			np->shift = p->shift - CARDMAP_ORDER;
 			np->parent = p;
 			p->ptr[i] = np;
@@ -2747,6 +2743,10 @@ static int cardmap_set(struct cardmap **
 	else
 		clear_bit(i, &p->inuse);
 	return 0;
+enomem:
+	printk(KERN_ERR "PPP: no memory (cardmap)\n");
+	cardmap_destroy(pmap);
+	return -ENOMEM;
 }
 
 static unsigned int cardmap_find_first_free(struct cardmap *map)
_

