Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbTCLBF3>; Tue, 11 Mar 2003 20:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262996AbTCLBF3>; Tue, 11 Mar 2003 20:05:29 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13800
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261747AbTCLBF0>; Tue, 11 Mar 2003 20:05:26 -0500
Date: Tue, 11 Mar 2003 20:13:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux-net@vger.kernel.org>
Subject: Re: [PATCH] (1/8) Eliminate brlock in psnap
In-Reply-To: <1047428075.15875.97.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.50.0303111954080.6957-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
 <1047428075.15875.97.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Stephen Hemminger wrote:

>  void unregister_snap_client(struct datalink_proto *proto)
>  {
> -	br_write_lock_bh(BR_NETPROTO_LOCK);
> +	static RCU_HEAD(snap_rcu);
>  
> -	list_del(&proto->node);
> -	kfree(proto);
> +	spin_lock_bh(&snap_lock);
> +	list_del_rcu(&proto->node);
> +	spin_unlock_bh(&snap_lock);
>  
> -	br_write_unlock_bh(BR_NETPROTO_LOCK);
> +	call_rcu(&snap_rcu, (void (*)(void *)) kfree, proto);
>  }

Do we need the spin_lock_bh around the list_del_rcu? But also How 
about. This way we don't change the previous characteristic of block till 
done unregistering

struct datalink_proto {
...
	struct completion registration;
};

void __unregister_snap_client(void *__proto)
{
	struct datalink_proto *proto = __proto;
	complete(&proto->registration);
}

unregister_snap_client(struct datalink_proto *proto)
{
	list_del_rcu(&proto->node);
	call_rcu(&snap_rcu, __unregister_snap_client, proto);
	wait_for_completion(&proto->registration);
	kfree(proto);
}
