Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWEON2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWEON2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEON2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:28:25 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:46713 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S964882AbWEON2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:28:24 -0400
X-ME-UUID: 20060515132822901.DC1BB1C002B6@mwinf0208.wanadoo.fr
Message-ID: <446881EB.2070405@cosmosbay.com>
Date: Mon, 15 May 2006 15:28:11 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1
References: <20060515005637.00b54560.akpm@osdl.org>	<4468534A.3060604@cosmosbay.com> <20060515040358.5e24549d.akpm@osdl.org>
In-Reply-To: <20060515040358.5e24549d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020602080704060702060302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020602080704060702060302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Andrew Morton a =E9crit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>  =20
>> Hi Andrew
>>
>> It seems latest kernels have a problem in kmem_cache_destroy()
>>    =20
>
> Mainline, or just -mm?
>
>  =20
Mainline and mm it seems, only if NUMA is ON, on 2.6.17 only (2.6.16.XX=20
is OK)

I added some printks and it seems slab_partials is not empty in=20
__node_shrink() for node 0

I am not a mm/slab.c expert but the following patch cures the problem=20
for me :

[PATCH] slab : NUMA may need __cache_shrink() doing two loops.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>





--------------020602080704060702060302
Content-Type: text/plain;
 name="__cache_shrink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__cache_shrink.patch"

--- linux-2.6.17-rc4/mm/slab.c	2006-05-15 14:58:09.000000000 +0200
+++ linux-2.6.17-rc4-ed/mm/slab.c	2006-05-15 15:23:07.000000000 +0200
@@ -2225,25 +2225,32 @@
 		spin_lock_irq(&l3->list_lock);
 	}
 	ret = !list_empty(&l3->slabs_full) || !list_empty(&l3->slabs_partial);
+	if (ret)
+		printk(KERN_ERR "__node_shrink(name=%s,node=%d) ret=%d\n",
+			cachep->name, node, ret);
 	return ret;
 }
 
 static int __cache_shrink(struct kmem_cache *cachep)
 {
-	int ret = 0, i = 0;
+	int ret, i;
 	struct kmem_list3 *l3;
+	int loopcount = 0;
 
-	drain_cpu_caches(cachep);
+	do {
+		ret = 0;
+		drain_cpu_caches(cachep);
 
-	check_irq_on();
-	for_each_online_node(i) {
-		l3 = cachep->nodelists[i];
-		if (l3) {
-			spin_lock_irq(&l3->list_lock);
-			ret += __node_shrink(cachep, i);
-			spin_unlock_irq(&l3->list_lock);
+		check_irq_on();
+		for_each_online_node(i) {
+			l3 = cachep->nodelists[i];
+			if (l3) {
+				spin_lock_irq(&l3->list_lock);
+				ret += __node_shrink(cachep, i);
+				spin_unlock_irq(&l3->list_lock);
+			}
 		}
-	}
+	} while (ret && ++loopcount < 2);
 	return (ret ? 1 : 0);
 }
 

--------------020602080704060702060302--


