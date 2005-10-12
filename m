Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVJLPWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVJLPWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVJLPWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:22:14 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:45072 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964811AbVJLPWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:22:12 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1129061494.11164.38.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Tue, 11 Oct 2005 16:11:34 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128698035.8583.36.camel@lade.trondhjem.org>
	 <E1ENu8h-0005Kd-00@dorka.pomaz.szeredi.hu>
	 <1128702227.8583.69.camel@lade.trondhjem.org>
	 <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu> <1129061494.11164.38.camel@lade.trondhjem.org>
Message-Id: <E1EPiOw-0000pZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Oct 2005 17:20:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * release_open_intent - free up open intent resources
> + * @nd: pointer to nameidata
> + */
> +void release_open_intent(struct nameidata *nd)
> +{
> +	if (nd->intent.open.file->f_dentry == NULL)
> +		put_filp(nd->intent.open.file);
> +	else
> +		fput(nd->intent.open.file);
> +}
> +

This (or at least it's call site in open_namei()) should check for
IS_ERR(nd->intent.open.file).

If lookup_instantiate_filp() retuns an error and is called from
->create(), release_open_intent() will be called twice, and the second
one will Oops.

Miklos
