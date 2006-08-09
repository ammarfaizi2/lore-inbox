Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWHINtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWHINtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWHINtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:49:15 -0400
Received: from helium.samage.net ([83.149.67.129]:59840 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1750822AbWHINtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:49:14 -0400
Message-ID: <39903.81.207.0.53.1155131329.squirrel@81.207.0.53>
In-Reply-To: <1155128046.12225.40.camel@twins>
References: <20060808193325.1396.58813.sendpatchset@lappy> 
    <20060808193345.1396.16773.sendpatchset@lappy> 
    <42414.81.207.0.53.1155080443.squirrel@81.207.0.53> 
    <44D92B78.20408@google.com> 
    <35608.81.207.0.53.1155124956.squirrel@81.207.0.53>
    <1155128046.12225.40.camel@twins>
Date: Wed, 9 Aug 2006 15:48:49 +0200 (CEST)
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: "Daniel Phillips" <phillips@google.com>, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, August 9, 2006 14:54, Peter Zijlstra said:
> On Wed, 2006-08-09 at 14:02 +0200, Indan Zupancic wrote:
>>  That avoids lots of checks and should guarantee that the
>> accounting is correct, except in the case when the IFF_MEMALLOC flag is
>> cleared and the counter is set to zero manually. Can't that be avoided and
>> just let it decrease to zero naturally?
>
> That would put the atomic op on the free path unconditionally, I think
> davem gets nightmares from that.

I confused SOCK_MEMALLOC with sk_buff::memalloc, sorry. What I meant was
to unconditionally decrement the reserved usage only when memalloc is true
on the free path. That way all skbs that increased the reserve also decrease
it, and the counter should never go below zero.

Also as far as I can see it should be possible to replace all atomic
"if (unlikely(dev_reserve_used(skb->dev)))" checks witha check if
memalloc is set. That should make davem happy, as there aren't any
atomic instructions left in hot paths.

If IFF_MEMALLOC is set new skbs set memalloc and increase the reserve.
When the skb is being destroyed it doesn't matter if IFF_MEMALLOC is set
or not, only if that skb used reserves and thus only the memalloc flag
needs to be checked. This means that changing the IFF_MEMALLOC doesn't
affect in-flight skbs but only newly created ones, and there's no need to
update in-flight skbs whenever the flag is changed as all should go well.

+int sk_set_memalloc(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct net_device *dev = ip_dev_find(inet->rcv_saddr);
+	int err = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (!(dev->features & NETIF_F_MEMALLOC)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	if (atomic_read(&dev->memalloc_socks) == 0) {
+		spin_lock(&dev->memalloc_lock);
+		if (atomic_read(&dev->memalloc_socks) == 0) {
+			dev->memalloc_reserve =
+				dev->rx_reserve * skb_pages(dev->mtu);
+			err = adjust_memalloc_reserve(dev->memalloc_reserve);
+			if (err) {
+				spin_unlock(&dev->memalloc_lock);
+				printk(KERN_WARNING
+			"%s: Unable to allocate RX reserve, error: %d\n",
+					dev->name, err);
+				goto out;
+			}
+			sock_set_flag(sk, SOCK_MEMALLOC);
+			dev->flags |= IFF_MEMALLOC;
+		}
+		atomic_inc(&dev->memalloc_socks);
+		spin_unlock(&dev->memalloc_lock);
+	} else
+		atomic_inc(&dev->memalloc_socks);
+
+out:
+	dev_put(dev);
+	return err;
+}

It seems that here SOCK_MEMALLOC is only set on the first socket.
Shouldn't it be set on all sockets instead?

Greetings,

Indan


