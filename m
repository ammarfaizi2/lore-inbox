Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSIXFCm>; Tue, 24 Sep 2002 01:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261563AbSIXFCm>; Tue, 24 Sep 2002 01:02:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41738 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261560AbSIXFCk>;
	Tue, 24 Sep 2002 01:02:40 -0400
Message-ID: <3D8FF30A.1060609@pobox.com>
Date: Tue, 24 Sep 2002 01:07:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] linux-2.5.38 new i2c parallel port adapter
References: <Pine.LNX.4.44.0209240044400.16117-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> +#define DEFAULT_BASE 0x378

surely there is a parport define for this?


> +static int base=0;
> +static unsigned char PortData = 0;

don't explicitly init to zero... you were told this before :)


> +static int bit_pport_init(void)
> +{
> +	if (!request_region((base+2),1, "i2c (PPORT adapter)")) {
> +		return -ENODEV;	
> +	} else {
> +
> +		/* test for PPORT adap. 	*/
> +	
> +
> +		PortData=inb(base+2);
> +		PortData= (PortData SET_SDA) SET_SCL;
> +		outb(PortData,base+2);				
> +
> +		if (!(inb(base+2) | 0x06)) {	/* SDA and SCL will be high	*/
> +			DEBINIT(printk("i2c-pport.o: SDA and SCL was low.\n"));
> +			return -ENODEV;

leak, no release_region


> +		} else {
> +		
> +			/*SCL high and SDA low*/
> +			PortData = PortData SET_SCL CLR_SDA;
> +			outb(PortData,base+2);	
> +			schedule_timeout(400);

ugly... use a constant based on HZ



> +			if ( !(inb(base+2) | 0x4) ) {
> +				//outb(0x04,base+2);
> +				DEBINIT(printk("i2c-port.o: SDA was high.\n"));
> +				return -ENODEV;

likewise


> +static void bit_pport_inc_use(struct i2c_adapter *adap)
> +{
> +#ifdef MODULE
> +	MOD_INC_USE_COUNT;
> +#endif
> +}
> +
> +static void bit_pport_dec_use(struct i2c_adapter *adap)
> +{
> +#ifdef MODULE
> +	MOD_DEC_USE_COUNT;
> +#endif
> +}

remove the ifdefs... you were told this too :)



> +int __init i2c_bitpport_init(void)
> +{
> +	printk("i2c-pport.o: i2c Primitive parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
> +
> +	if (base==0) {
> +		/* probe some values */
> +		base=DEFAULT_BASE;
> +		bit_pport_data.data=(void*)DEFAULT_BASE;
> +		if (bit_pport_init()==0) {
> +			if(i2c_bit_add_bus(&bit_pport_ops) < 0)
> +				return -ENODEV;

bug, no release_region


> +		} else {
> +			return -ENODEV;
> +		}
> +	} else {
> +		bit_pport_data.data=(void*)base;
> +		if (bit_pport_init()==0) {
> +			if(i2c_bit_add_bus(&bit_pport_ops) < 0)
> +				return -ENODEV;

likewise


