Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTGCPac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTGCPac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:30:32 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:37135 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264279AbTGCPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:30:30 -0400
Date: Thu, 3 Jul 2003 16:44:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030703164455.A4801@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <UTC200307021521.h62FLbw16702.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200307021521.h62FLbw16702.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Jul 02, 2003 at 05:21:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A general comment to the design of this code: imho we should rip
out the whole concept of transfer functions and go directly to
the cryptoapi algorithms - one level of unneeded abstractions
gone (the transfer funcs were never used for anything but X0R in
mainline and the interface is quite wrong as we could really
pass the page+offsets through).  If we finally decide to get rid
of this legacy junk I even volunteer to implemente a X0R cryptoapi
module :)

Some more nitpicking:

> +#include <linux/version.h>

not needed.

> +#include <linux/config.h>

dito.

> +static struct loop_func_table cryptoloop_funcs = {
> +	number:		LO_CRYPT_CRYPTOAPI,
> +	init:		cryptoloop_init,
> +	ioctl:		cryptoloop_ioctl,
> +	transfer:	cryptoloop_transfer,
> +	release:	cryptoloop_release,
> +	owner:		THIS_MODULE
> +};

please use C99-initializers.

> +	printk(KERN_INFO "cryptoloop: loaded\n");

isn't this a bit verbose?

> +	if (loop_unregister_transfer(LO_CRYPT_CRYPTOAPI))

how could this fail?

> +		printk(KERN_ERR
> +			"cryptoloop: unregistering transfer funcs failed\n");
> +
> +	printk(KERN_INFO "cryptoloop: unloaded\n");

dito.

> +	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
> +		memcpy(info64->lo_crypt_name, info->lo_name, LO_NAME_SIZE);
> +	else
> +		memcpy(info64->lo_file_name, info->lo_name, LO_NAME_SIZE);

this special-casing sounds like a bad idea.  I'd say anyone who wants
crypto support needs to use a losetup that uses the newstyle loop_info.
(Or did I get the context wrong?  diff -p helps a lot if you don't have
a recent kernel tree nearby..)

