Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSKJXCX>; Sun, 10 Nov 2002 18:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSKJXCX>; Sun, 10 Nov 2002 18:02:23 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:15890 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S265242AbSKJXCW>;
	Sun, 10 Nov 2002 18:02:22 -0500
Date: Mon, 11 Nov 2002 00:08:56 +0100
From: romieu@fr.zoreil.com
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org
Subject: Re: oops when adding bridge interface, using v2.5.45
Message-ID: <20021111000856.A8050@electric-eye.fr.zoreil.com>
References: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu> <200211110052.29495.bdschuym@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211110052.29495.bdschuym@pandora.be>; from bdschuym@pandora.be on Mon, Nov 11, 2002 at 12:52:29AM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart De Schuymer <bdschuym@pandora.be> :
[...]
> net/bridge/br_if.c::new_nbp() does
> 	p = kmalloc(sizeof(*p), GFP_KERNEL);
> which triggers the oops through mm/slab.c::kmem_flagcheck()
> I don't know what is wrong (I have no such problems with 2.4).
> 
> The trace is below:
[sleeping function called with lock held]

[net/bridge/br_if.c:236]
        write_lock_bh(&br->lock);
        if ((p = new_nbp(br, dev)) == NULL) {
                write_unlock_bh(&br->lock);

Following patch should fix it. It looks the same in 2.5.46.

--- net/bridge/br_if.c	Sun Nov 10 23:57:28 2002
+++ net/bridge/br_if.c	Sun Nov 10 23:57:57 2002
@@ -143,7 +143,7 @@ static struct net_bridge_port *new_nbp(s
 	int i;
 	struct net_bridge_port *p;
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = kmalloc(sizeof(*p), GFP_ATOMIC);
 	if (p == NULL)
 		return p;
 

--
Ueimor
