Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932741AbWKEQgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWKEQgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWKEQgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:36:25 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:24169 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932741AbWKEQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:36:25 -0500
Subject: Re: [PATCH 1/2] sunrpc: add missing spin_unlock
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Olaf Kirch <okir@monad.swb.de>
In-Reply-To: <20061029133700.GA10295@localhost>
References: <20061028185554.GM9973@localhost>
	 <20061029133551.GA10072@localhost>  <20061029133700.GA10295@localhost>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 17:35:16 +0100
Message-Id: <1162744516.26989.43.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 22:37 +0900, Akinobu Mita wrote:
> auth_domain_put() forgot to unlock acquired spinlock.
> 
> Cc: Olaf Kirch <okir@monad.swb.de>
> Cc: Andy Adamson <andros@citi.umich.edu>
> Cc: J. Bruce Fields <bfields@citi.umich.edu>
> Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

I just found this too while trying to get .19-rc4-git up and running on
a machine here - took me a few hours.

It made my kernel decidedly unhappy :-(

Andrew, could you push this and:
  http://lkml.org/lkml/2006/11/3/109
into .19 still? - those patches are needed to make todays git happy on
my machine.

> Index: work-fault-inject/net/sunrpc/svcauth.c
> ===================================================================
> --- work-fault-inject.orig/net/sunrpc/svcauth.c
> +++ work-fault-inject/net/sunrpc/svcauth.c
> @@ -126,6 +126,7 @@ void auth_domain_put(struct auth_domain 
>  	if (atomic_dec_and_lock(&dom->ref.refcount, &auth_domain_lock)) {
>  		hlist_del(&dom->hash);
>  		dom->flavour->domain_release(dom);
> +		spin_unlock(&auth_domain_lock);
>  	}
>  }


