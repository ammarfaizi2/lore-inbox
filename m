Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVKCELr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVKCELr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbVKCELr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:11:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbVKCELq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:11:46 -0500
Date: Thu, 3 Nov 2005 14:11:25 +1100
From: Andrew Morton <akpm@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: [PATCH 30/37] dvb: add nxt200x frontend module
Message-Id: <20051103141125.1463c1bd.akpm@osdl.org>
In-Reply-To: <43672436.6000006@m1k.net>
References: <43672436.6000006@m1k.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> 
> From: Kirk Lapray <kirk.lapray@gmail.com>
> 
> * nxt200x.c, nxt200x.h
> - New frontend module that supports both NXT2002 and NXT2004.
>   So far, only tested on NXT2004.  After testing on NXT2002, we should
>   deprecate the nxt2002 module, and implement this one instead on the
>   applicable cards.
> 
> * get_dvb_firmware:
> - Added support for the NXT2004 firmware. This firmware works with both
>   the ATI HDTV Wonder and the AVerTVHD MCE a180.
>   This was originally written by Jean-Francois Thibert
> 
> * dvb-pll.c
> - Fixed minimum frequency for tuv1236d. It seems that the data sheets
>   are wrong.
> 
> ...
> +static int nxt200x_writebytes (struct nxt200x_state* state, u8 reg, u8 *buf, u8 len)
> +{
> +	u8 buf2 [len+1];

hm, a variable-sized array, with the size defined by the caller.   I guess as the size is
in a u8 it's unlikely to cause too much trouble.

(Wonders what the compiler will do if len==255.  256, I think.)

> +static int nxt200x_readreg_multibyte (struct nxt200x_state* state, u8 reg, u8* data, u8 len)
> +{
> +	int i;
> +	u8 buf, len2, attr;
> +	dprintk("%s\n", __FUNCTION__);
> +
> +	/* set mutli register register */
> +	nxt200x_writebytes(state, 0x35, &reg, 1);
> +
> +	switch (state->demod_chip) {
> +		case NXT2002:
> +			/* set multi register length */
> +			len2 = len & 0x80;
> +			nxt200x_writebytes(state, 0x34, &len2, 1);
> +
> +			/* read the actual data */
> +			nxt200x_readbytes(state, reg, data, len);
> +			return 0;
> +			break;
> +		case NXT2004:
> +			/* probably not right, but gives correct values */
> +			attr = 0x02;
> +			if (reg & 0x80) {
> +				attr = attr << 1;
> +				if (reg & 0x04)
> +					attr = attr >> 1;
> +			}
> +
> +			/* set multi register length */
> +			len2 = (attr << 4) | len;
> +			nxt200x_writebytes(state, 0x34, &len2, 1);
> +
> +			/* toggle the multireg bit*/
> +			buf = 0x80;
> +			nxt200x_writebytes(state, 0x21, &buf, 1);
> +
> +			/* read status */
> +			nxt200x_readbytes(state, 0x21, &buf, 1);
> +
> +			if (buf == 0)
> +			{
> +				/* read the actual data */
> +				for(i = 0; i < len; i++) {
> +                    nxt200x_readbytes(state, 0x36 + i, &data[i], 1);
> +				}
> +				return 0;

whitespace broke.

> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +			break;
> +	}

We usually indent the body of a switch statement one tab further to the left.

> +
> +static int nxt200x_writetuner (struct nxt200x_state* state, u8* data)
> +{
> +	u8 buf, count = 0;
> +
> +	dprintk("%s\n", __FUNCTION__);
> +
> +	dprintk("Tuner Bytes: %02X %02X %02X %02X\n", data[0], data[1], data[2], data[3]);
> +
> +	/* if pll is a Philips TUV1236D then write directly to tuner */
> +	if (strcmp(state->config->pll_desc->name, "Philips TUV1236D") == 0) {

Does DVB have a better way of identifying a device type than strcmp?


