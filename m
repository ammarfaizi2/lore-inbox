Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbTCLAwn>; Tue, 11 Mar 2003 19:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbTCLAwm>; Tue, 11 Mar 2003 19:52:42 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:33041 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263083AbTCLAwj>; Tue, 11 Mar 2003 19:52:39 -0500
Date: Wed, 12 Mar 2003 02:03:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>
Subject: Re: [PATCH] (1/8) Eliminate brlock in psnap
In-Reply-To: <1047428075.15875.97.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0303120200391.32518-100000@serv>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
 <1047428075.15875.97.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11 Mar 2003, Stephen Hemminger wrote:

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

Is this really correct? What happens with snap_rcu, if 
unregister_snap_client is called again, before the call_rcu callback 
finished?

bye, Roman

