Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbSIRQgb>; Wed, 18 Sep 2002 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbSIRQfl>; Wed, 18 Sep 2002 12:35:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267441AbSIRQed>;
	Wed, 18 Sep 2002 12:34:33 -0400
Message-ID: <3D88AC27.4050805@mandrakesoft.com>
Date: Wed, 18 Sep 2002 12:39:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/3] 2.5.36 i2c core drivers module_init/exit cleanup
References: <Pine.LNX.4.44.0209180158230.358-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
>  /**** debug level */
> -static int i2c_debug=1;
> +static int i2c_debug=0;

don't need "=0", that wastes space in initialized data section


> @@ -658,18 +624,19 @@
>  	struct i2c_client *client;
>  	int i,j,k,order_nr,len=0,len_total;
>  	int order[I2C_CLIENT_MAX];
> +#define OUTPUT_LENGTH_PER_LINE 70
>  
> -	if (count > 4096)
> -		return -EINVAL; 
>  	len_total = file->f_pos + count;
> -	/* Too bad if this gets longer (unlikely) */
> -	if (len_total > 4096)
> -		len_total = 4096;
> +	if (len_total > (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE) )
> +		/* adjust to maximum file size */
> +		len_total = (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE);
>  	for (i = 0; i < I2C_ADAP_MAX; i++)
>  		if (adapters[i]->inode == inode->i_ino) {
>  		/* We need a bit of slack in the kernel buffer; this makes the
>  		   sprintf safe. */
> -			if (! (kbuf = kmalloc(count + 80,GFP_KERNEL)))
> +			if (! (kbuf = kmalloc(len_total +
> +			                      OUTPUT_LENGTH_PER_LINE,
> +			                      GFP_KERNEL)))
>  				return -ENOMEM;
>  			/* Order will hold the indexes of the clients

this really wants to be converted to seq_printf API...

otherwise, looks ok

