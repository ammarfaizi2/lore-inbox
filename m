Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVCGWmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVCGWmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVCGWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:42:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:34449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261809AbVCGVqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:46:36 -0500
Message-ID: <422CCBF4.1060902@osdl.org>
Date: Mon, 07 Mar 2005 13:47:32 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrei@arhont.com
CC: linux-kernel@vger.kernel.org
Subject: Re: amd64 2.6.11 oops on modprobe
References: <1110024688.5494.2.camel@whale.core.arhont.com>	 <422A5473.7030306@osdl.org> <1110115990.5611.2.camel@whale.core.arhont.com>
In-Reply-To: <1110115990.5611.2.camel@whale.core.arhont.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Mikhailovsky wrote:
> Hi Randy,
> 
> Done the kstack=32, here is the output:
> 
> cat /proc/cmdline 
> root=/dev/hda2 ro kstack=32 console=tty0
> 
> P.S. Yeah, this oops is repeatable; hapens everytime

Hi Andrei,

I've been working on this with Daniel Staaf and Jean Delvare.
Jean enabled some more/different I2C bit banging code in
2.6.11, and that causes callers to use it differently.

Specifically, in saa7110_write_block() now does this first
"if" block instead of the "else" block:

	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
		struct saa7110 *decoder = i2c_get_clientdata(client);
		struct i2c_msg msg;
		u8 block_data[54];

		msg.len = 0;
		msg.buf = (char *) block_data;
		msg.addr = client->addr;
		msg.flags = client->flags;
***		while (len >= 1) {
			msg.len = 0;
			block_data[msg.len++] = reg;
			while (len-- >= 1 && msg.len < 54)
				block_data[msg.len++] =
				    decoder->reg[reg++] = *data++;
			ret = i2c_transfer(client->adapter, &msg, 1);
		}
	} else {
		while (len-- >= 1) {
			if ((ret = saa7110_write(client, reg++,
						 *data++)) < 0)
				break;
		}
	}

The *** marked loop never terminates and keep incrementing <data>
until the oops occurs.  Making a copy of <len> as signed instead of
unsigned is a temporary fix for this.  Jean will be proposing a
real patch for that obfuscated loop.

-- 
~Randy
