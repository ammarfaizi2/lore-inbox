Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVIFXCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVIFXCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIFXCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:02:07 -0400
Received: from mail.collax.com ([213.164.67.137]:1482 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751112AbVIFXCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:02:05 -0400
Message-ID: <431E1FE9.7030405@trash.net>
Date: Wed, 07 Sep 2005 01:02:01 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Orlandi <daniele@orlandi.com>
CC: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: proto_unregister sleeps while atomic
References: <200509070026.34999.daniele@orlandi.com>
In-Reply-To: <200509070026.34999.daniele@orlandi.com>
Content-Type: multipart/mixed;
 boundary="------------000704030201010204060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000704030201010204060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniele Orlandi wrote:
> I'm looking at proto_unregister() in linux-2.6.13:
> 
> Il calls kmem_cache_destroy() while holding proto_list_lock:
> 
> void proto_unregister(struct proto *prot)
> {
>         write_lock(&proto_list_lock);
> 
>         if (prot->slab != NULL) {
>                 kmem_cache_destroy(prot->slab);
> 
> 
> However, kmem_cache_destroy() may sleep:
> 
>         /* Find the cache in the chain of caches. */
>         down(&cache_chain_sem);
>         ^^^^^^^^^^^^^^^^^^^^^^^
> 
> Am I seeing it right?

You're right, good catch. This patch fixes it by moving the lock
down to the list-operation which it is supposed to protect.

--------------000704030201010204060600
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NET]: proto_unregister: fix sleeping while atomic

proto_unregister holds a lock while calling kmem_cache_destroy, which can
sleep.

Noticed by Daniele Orlandi <daniele@orlandi.com>.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 90fdf8bc78b52d40190766c5496a3d8c24903be8
tree 54048218d981ab263b37e0de09ad52f4bd49a000
parent 591bd554f58b7d363167760a606d2a84696772da
author Patrick McHardy <kaber@trash.net> Wed, 07 Sep 2005 01:00:00 +0200
committer Patrick McHardy <kaber@trash.net> Wed, 07 Sep 2005 01:00:00 +0200

 net/core/sock.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1528,8 +1528,6 @@ EXPORT_SYMBOL(proto_register);
 
 void proto_unregister(struct proto *prot)
 {
-	write_lock(&proto_list_lock);
-
 	if (prot->slab != NULL) {
 		kmem_cache_destroy(prot->slab);
 		prot->slab = NULL;
@@ -1551,6 +1549,7 @@ void proto_unregister(struct proto *prot
 		prot->twsk_slab = NULL;
 	}
 
+	write_lock(&proto_list_lock);
 	list_del(&prot->node);
 	write_unlock(&proto_list_lock);
 }

--------------000704030201010204060600--
