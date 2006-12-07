Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032201AbWLGNW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032201AbWLGNW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032203AbWLGNW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:22:57 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:46384 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032201AbWLGNW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:22:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z5Vsrw0k8pv4eludj0nYdYdINrkyGDY1yBC1L8xv4X/Utttcgrpdg6pzfIg65Asl6lqG6LEaoSMqVOFNBBVQ3kllGFRDoc0KZjAKAr1+L1TGtjFuQZgg2/h9ibvYMLFvldA18tcvmyFX5+3zR/m4StXnE50816CGZvUWditmQKM=
Message-ID: <9a8748490612070522v2a4f8446l9833758526c3a1ba@mail.gmail.com>
Date: Thu, 7 Dec 2006 14:22:51 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: drivers/net/chelsio/my3126.c: inconsequent NULL checking
Cc: "Stephen Hemminger" <shemminger@osdl.org>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061207113452.GD8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207113452.GD8963@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/06, Adrian Bunk <bunk@stusta.de> wrote:
> The Coverity checker spotted the following inconsequent NULL checking
> introduced by commit f1d3d38af75789f1b82969b83b69cab540609789:
>
> <--  snip  -->
>
> ...
> static struct cphy *my3126_phy_create(adapter_t *adapter,
>                         int phy_addr, struct mdio_ops *mdio_ops)
> {
>         struct cphy *cphy = kzalloc(sizeof (*cphy), GFP_KERNEL);
>
>         if (cphy)
>                 cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);
>
>         INIT_WORK(&cphy->phy_update, my3216_poll, cphy);
>         cphy->bmsr = 0;
>
>         return (cphy);
> }
> ...
>
> <--  snip  -->
>
> It doesn't make sense to first check whether "cphy" is NULL and
> dereference it unconditionally later.
>

How about simply changing
         if (cphy)
                 cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);
into
         if (!cphy)
                 return NULL;

callers need to be able to handle that ofcourse, but I haven't checked that yet.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
