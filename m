Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCCD2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCCD2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVCCDZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:25:31 -0500
Received: from [203.2.177.22] ([203.2.177.22]:15123 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261439AbVCCDYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:24:16 -0500
Subject: Re: x25_create initializing socket data twice ...
From: Andrew Hendry <ahendry@tusc.com.au>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: eis@baty.hanse.de, linux-x25@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303011413.GB11516@mail.13thfloor.at>
References: <20050303011413.GB11516@mail.13thfloor.at>
Content-Type: text/plain
Message-Id: <1109820054.3014.146.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Mar 2005 14:20:54 +1100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2005 03:20:45.0875 (UTC) FILETIME=[FD3BE830:01C51F9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On the same path sk_set_owner also gets called twice, I think this
causes double module use count when creating sockets. Module use count
need some attention all over x25.

Im not sure if the fix is as straightforward, the calls are:
sock_init_data(sock,sk) vs
sock_init_data(NULL,sk)

Andrew.

On Thu, 2005-03-03 at 12:14, Herbert Poetzl wrote:
> Hi Folks!
> 
> x25_create() [net/x25/af_x25.c] is calling sock_init_data()
> twice ... once indirectly via x25_alloc_socket() and a
> second time directly via sock_init_data(sock, sk);
> 
> while this might not look as critical as it seems, it can
> easily break stuff which assumes that sock_init_data()
> isn't called twice on the same socket ...
> 
> maybe something like this might be appropriate?
> 
> --- ./net/x25/af_x25.c.orig	2005-03-02 12:39:11 +0100
> +++ ./net/x25/af_x25.c	2005-03-03 02:12:11 +0100
> @@ -490,7 +490,6 @@ static int x25_create(struct socket *soc
>  
>  	x25 = x25_sk(sk);
>  
> -	sock_init_data(sock, sk);
>  	sk_set_owner(sk, THIS_MODULE);
>  
>  	x25_init_timers(sk);
> 
> 
> best,
> Herbert
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

