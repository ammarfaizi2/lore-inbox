Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSIOW4W>; Sun, 15 Sep 2002 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSIOW4W>; Sun, 15 Sep 2002 18:56:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32779 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318286AbSIOW4U>;
	Sun, 15 Sep 2002 18:56:20 -0400
Message-ID: <3D85111E.5030509@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:00:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151834280.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:

> +#ifdef MODULE_LICENSE
> +MODULE_LICENSE("GPL");
> +#endif

kill the ifdef


> +static int bit_pport_init(void)
> +{
> +	//release_region( (base+2) ,1);
> +
> +	if (check_region((base+2),1) < 0 ) {

wrong.  race.  use request_region, and check its return value. 
check_region should never be used.


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
> +		} else {
> +		
> +			/*SCL high and SDA low*/
> +			PortData = PortData SET_SCL CLR_SDA;
> +			outb(PortData,base+2);	
> +			udelay(400);

long udelay in process context, where you should sleep instead



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

kill the ifdef.  use ->owner instead if possible.



> +#ifdef MODULE
> +MODULE_AUTHOR("Daniel Smolik <marvin@sitour.cz>");
> +MODULE_DESCRIPTION("I2C-Bus adapter routines for Primitive parallel port adapter")
> +;
> +
> +MODULE_PARM(base, "i");
> +
> +int init_module(void)
> +{
> +	return i2c_bitpport_init();
> +}
> +
> +void cleanup_module(void)
> +{
> +	i2c_bit_del_bus(&bit_pport_ops);
> +	bit_pport_exit();
> +}
> +
> +#endif

kill the ifdef, use module_init, module_exit

