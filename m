Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWI0AhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWI0AhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWI0AhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:37:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbWI0AhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:37:16 -0400
Date: Tue, 26 Sep 2006 17:37:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       David Barksdale <amatus@ocgnet.org>
Subject: Re: [PATCH] IPMI: per-channel command registration
Message-Id: <20060926173711.ea3c877e.akpm@osdl.org>
In-Reply-To: <20060925140941.GA6364@localdomain>
References: <20060925140941.GA6364@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 09:09:41 -0500
Corey Minyard <minyard@acm.org> wrote:

> 
> This patch adds the ability to register for a command per-channel in
> the IPMI driver.
> 
> If your BMC supports multiple channels, incoming messages can be
> differentiated by the channel on which they arrived. In this case it's
> useful to have the ability to register to receive commands on a
> specific channel instead the current behaviour of all channels.
> 
> +	case IPMICTL_REGISTER_FOR_CMD_CHANS:
> +	{
> +		struct ipmi_cmdspec_chans val;
> +
> +		if (copy_from_user(&val, arg, sizeof(val))) {

It becomes part of the ABI.

> +/*
> + * Register to get commands from other entities on specific channels.
> + * This way, you can only listen on specific channels, or have messages
> + * from some channels go to one place and other channels to someplace
> + * else.  The chans field is a bitmask, (1 << channel) for each channel.
> + * It may be IPMI_CHAN_ALL for all channels.
> + */
> +struct ipmi_cmdspec_chans
> +{
> +	unsigned char netfn;
> +	unsigned char cmd;
> +	unsigned int  chans;
> +};

Has it been tested with 32-bit userspace and a 64-bit kernel?

Even if it has, I'd be a bit worried that it depends upon the user's
compiler laying this structure out in the same manner as did his
kernel-provider's compiler.

Turning this into three u32's sounds safer?
