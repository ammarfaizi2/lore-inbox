Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVAMWxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVAMWxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMWvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:51:10 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44769 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261803AbVAMWqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:46:02 -0500
Date: Thu, 13 Jan 2005 23:41:07 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Adam Anthony <AAnthony@sbs.com>
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: Linux HDLC Stack - N2 module
Message-ID: <20050113224107.GA32656@electric-eye.fr.zoreil.com>
References: <4F23E557A0317D45864097982DE907941A38A8@pilotmail.sbscorp.sbs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F23E557A0317D45864097982DE907941A38A8@pilotmail.sbscorp.sbs.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Anthony <AAnthony@sbs.com> :
[...]
> It seems like the transmit buffers aren't getting emptied after transmit,
> because I can only transmit a few frames before traffic halts.  Transmit
> statistics don't increment either, but I am seeing frames on the remote end.
> 	Has the N2 module been tested with recent kernels?  Is it useable?

No idea.

> If not, which module will show me the genius of the Linux HDLC "stack"?

struct foo_dev_priv {
	/*
	   Device private stuff here
	 */
	...
	struct net_device *dev;
}

...

static int foo_init_one(...)
{
	struct foo_dev_priv *priv;
	struct net_device *dev;
	hdlc_device *hdlc;

	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
	if (!priv)
		goto damn_it;
	memset(priv, 0, ...);

	dev = alloc_hdlcdev(priv);
	if (!dev)
		goto crap;
	memset(dev, 0, ...);

	priv->dev = dev;

	hdlc = dev_to_hdlc(dev);
	
	hdlc->xmit = foo_start_xmit();
	hdlc->attach = foo_hdlc_attach();

	ret = register_hdlc_device(hdlc);
	if (ret < 0)
		goto not_my_day;
	...
}

static int foo_start_xmit(struct sk_buff *skb, struct net_device *dev)
{
	/* The usual linux hard_start_xmit() handler of a net_device */
	...
}

unregister_hdlc_device() balances register_hdlc_device().
hdlc_to_dev(hdlc) is the counterpart of dev_to_hdlc(dev).

Impressing, is not it ?

--
Ueimor
