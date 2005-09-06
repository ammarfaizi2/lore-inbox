Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVIFXmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVIFXmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVIFXmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:42:52 -0400
Received: from mail.collax.com ([213.164.67.137]:15027 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751138AbVIFXmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:42:51 -0400
Message-ID: <431E2978.2030701@trash.net>
Date: Wed, 07 Sep 2005 01:42:48 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: daniele@orlandi.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: proto_unregister sleeps while atomic
References: <200509070026.34999.daniele@orlandi.com>	<431E1FE9.7030405@trash.net> <20050906.160728.25203864.davem@davemloft.net>
In-Reply-To: <20050906.160728.25203864.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------030301070001070006070403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030301070001070006070403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Wed, 07 Sep 2005 01:02:01 +0200
> 
> 
>>You're right, good catch. This patch fixes it by moving the lock
>>down to the list-operation which it is supposed to protect.
> 
> 
> I think we need to unlink from the list first if you're
> going to do it this way.  Otherwise someone can find the
> protocol via lookup, and then bogusly try to use the SLAB
> cache we're freeing up.
> 
> Or does something else prevent this?

The only other user of proto_list besides proto_register, which
doesn't care, are the seqfs functions. They use the slab pointer,
but in a harmless way:

                    proto->slab == NULL ? "no" : "yes",

Anyway, I've moved it up to the top.

--------------030301070001070006070403
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
commit d68b08edb26dfb58d18ab6c555d011572f9115a6
tree 1d14cf91ca5db6878b6af3953f85a34a6fe12a91
parent 591bd554f58b7d363167760a606d2a84696772da
author Patrick McHardy <kaber@trash.net> Wed, 07 Sep 2005 01:35:19 +0200
committer Patrick McHardy <kaber@trash.net> Wed, 07 Sep 2005 01:35:19 +0200

 net/core/sock.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1529,6 +1529,8 @@ EXPORT_SYMBOL(proto_register);
 void proto_unregister(struct proto *prot)
 {
 	write_lock(&proto_list_lock);
+	list_del(&prot->node);
+	write_unlock(&proto_list_lock);
 
 	if (prot->slab != NULL) {
 		kmem_cache_destroy(prot->slab);
@@ -1550,9 +1552,6 @@ void proto_unregister(struct proto *prot
 		kfree(name);
 		prot->twsk_slab = NULL;
 	}
-
-	list_del(&prot->node);
-	write_unlock(&proto_list_lock);
 }
 
 EXPORT_SYMBOL(proto_unregister);

--------------030301070001070006070403--
