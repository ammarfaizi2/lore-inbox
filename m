Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTAUTdm>; Tue, 21 Jan 2003 14:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbTAUTdm>; Tue, 21 Jan 2003 14:33:42 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:38022 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267180AbTAUTdl>; Tue, 21 Jan 2003 14:33:41 -0500
Message-Id: <5.1.0.14.2.20030121102804.073b3198@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 Jan 2003 11:42:41 -0800
To: "David S. Miller" <davem@redhat.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030121.030314.41949353.davem@redhat.com>
References: <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0301020341140.2038-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:03 AM 1/21/2003 -0800, David S. Miller wrote:
>   From: Max Krasnyansky <maxk@qualcomm.com>
>   Date: Sun, 19 Jan 2003 19:22:44 -0800 (PST)
>   
>   The only reason to do module refcounting in sk is if protocol
>   changes default callbacks  (i.e. sk->data_ready, etc).
>
>What about the reference to skb->sk?  Are you sure there are
>no cases where:
>
>1) skb->sk will be non-NULL
>2) default callbacks are used

In that case we don't care whether the module is still loaded or not.
Here is the list of sk callbacks
        void                    (*state_change)(struct sock *sk);
        void                    (*data_ready)(struct sock *sk, int bytes);
        void                    (*write_space)(struct sock *sk);
        void                    (*error_report)(struct sock *sk);
        int                     (*backlog_rcv) (struct sock *sk, struct sk_buff *skb);  
        void                    (*destruct)(struct sock *sk);
Net core doesn't make any other calls into the protocol module.

In any case if protocol module wants, for some reason, to be around until sk is destroyed
it can call sk_set_owner() right after sk_alloc(), even if it uses default callbacks.

While looking at the net families that we support I realized that there is one more reason
why protocol may have to call sk_set_owner(). Is if protocol uses private slab cache for its 
sks. Otherwise cache will be destroyed during module unloading but sk may still be alive.

Here is a little summary about families that I looked at:
        Netlink - Global sk cache, replaces sk->destruct() callback.
                  Must call sk_set_owner()

        Unix -  Private sk cache, replaces sk->destruct() and sk->write_space() callbacks
                Must call sk_set_owner()

        IPv4/6 - Private cache, non-default callbacks.
                Must call sk_set_owner() (cannot be a module, so we don't really care)

        IPX - Global cache, default callbacks.

        ATM - Global cache, default callbacks.
                
        IRDA - Global cache, default callbacks.

        Bluetooth - Private cache (don't really need it, will change to global), non-default callbacks
                Must call sk_set_owner()

        AX25 - Global cache, non-default sk->destroy()
                Must call sk_set_owner()

        Rose - Global cache, default callbacks. 
        
        DecNet - Private cache, non-default callbacks.
                Must call sk_set_owner()
        
        LLC - Global cache, default callbacks.

Max

