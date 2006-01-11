Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWAKVb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWAKVb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWAKVb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:31:27 -0500
Received: from spirit.analogic.com ([204.178.40.4]:48392 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750802AbWAKVb0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:31:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060111221412.57ef8fc1.khali@linux-fr.org>
X-OriginalArrivalTime: 11 Jan 2006 21:30:55.0133 (UTC) FILETIME=[4DE61CD0:01C616F6]
Content-class: urn:content-classes:message
Subject: Re: [RFC] copy loop versus memcpy
Date: Wed, 11 Jan 2006 16:30:47 -0500
Message-ID: <Pine.LNX.4.61.0601111626120.28204@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] copy loop versus memcpy
Thread-Index: AcYW9k3t/pN5dGiiQYe6tcuqfqUvpg==
References: <20060111221412.57ef8fc1.khali@linux-fr.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2006, Jean Delvare wrote:

> Hi all,
>
> I am considering applying the following patch, in the hope to slightly
> speed up some I2C/SMBus transfers. Am I right assuming that using memcpy
> is faster than an explicit copy loop? The typical data size will be 32
> bytes.
>
> Thanks.
>
> ---
> drivers/i2c/i2c-core.c |   15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
>
> --- linux-2.6.15-git.orig/drivers/i2c/i2c-core.c	2006-01-11 18:53:43.000000000 +0100
> +++ linux-2.6.15-git/drivers/i2c/i2c-core.c	2006-01-11 21:35:53.000000000 +0100
> @@ -921,12 +921,11 @@
> 			       u8 length, u8 *values)
> {
> 	union i2c_smbus_data data;
> -	int i;
> +
> 	if (length > I2C_SMBUS_BLOCK_MAX)
> 		length = I2C_SMBUS_BLOCK_MAX;
> -	for (i = 1; i <= length; i++)
> -		data.block[i] = values[i-1];
> 	data.block[0] = length;
> +	memcpy(data.block + 1, values, length);
> 	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> 			      I2C_SMBUS_WRITE,command,
> 			      I2C_SMBUS_BLOCK_DATA,&data);
> @@ -936,16 +935,14 @@
> s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
> {
> 	union i2c_smbus_data data;
> -	int i;
> +
> 	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> 	                      I2C_SMBUS_READ,command,
> 	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
> 		return -1;
> -	else {
> -		for (i = 1; i <= data.block[0]; i++)
> -			values[i-1] = data.block[i];
> -		return data.block[0];
> -	}
> +
> +	memcpy(values, data.block + 1, data.block[0]);
> +	return data.block[0];
> }
>
> s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
>
>
> --
> Jean Delvare
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I would prefer:

  	data.block[0] = length;
 	memcpy(&data.block[1], values, length);

... because it goes with the data.block[0] above it. Same for the copy
back later.

And yes, memcpy() should be about as optimized as you can get, certainly
at least as fast as the copy-loop, maybe more, and it uses less code.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.71 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
