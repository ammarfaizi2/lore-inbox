Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSIOWxI>; Sun, 15 Sep 2002 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSIOWxI>; Sun, 15 Sep 2002 18:53:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23051 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318283AbSIOWxG>;
	Sun, 15 Sep 2002 18:53:06 -0400
Message-ID: <3D85105B.8010705@mandrakesoft.com>
Date: Sun, 15 Sep 2002 18:57:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151831540.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> +static void
> +cpm_iic_interrupt(void *dev_id, void *regs)
> +{
> +	volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;

no need for volatile


> +}
> +
> +static void
> +cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)
> +{
> +	volatile iic_t		*iip = cpm_adap->iip;
> +	volatile i2c8xx_t	*i2c = cpm_adap->i2c;

no need for volatile.  repeat this comment several times...


> +	if (cpm_adap->reloc == 0) {
> +		volatile cpm8xx_t *cp = cpm_adap->cp;
> +
> +		cp->cp_cpcr =
> +			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
> +		while (cp->cp_cpcr & CPM_CR_FLG)
> +			cpu_relax(); /* prevent Athlons self-destruct */
> +	}

don't busy-wait in a context where you can sleep



> +static void force_close(struct i2c_algo_8xx_data *cpm)
> +{
> +	if (cpm->reloc == 0) {
> +		volatile cpm8xx_t *cp = cpm->cp;
> +
> +		if (cpm_debug) printk("force_close()\n");
> +		cp->cp_cpcr =
> +			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
> +			CPM_CR_FLG;
> +
> +		while (cp->cp_cpcr & CPM_CR_FLG)
> +			cpu_relax(); /* prevent Athlons self-destruct */
> +	}

likewise for volatile and busy-wait



> +	tbdf->cbd_bufaddr = __pa(tb);
> +	tbdf->cbd_datlen = count + 1;
> +	tbdf->cbd_sc =
> +		BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
> +		BD_SC_WRAP | BD_IIC_START;
> +
> +	rbdf->cbd_datlen = 0;
> +	rbdf->cbd_bufaddr = __pa(buf);
> +	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
> +
> +	dma_cache_inv((unsigned long) buf, (unsigned long) (buf+count));
> +
> +	/* Chip bug, set enable here */
> +	local_irq_save(flags);
> +	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +	i2c->i2c_i2cer = 0xff;
> +	i2c->i2c_i2mod = 1;	/* Enable */
> +	i2c->i2c_i2com = 0x81;	/* Start master */

__pa should very rarely be used in drivers


> +	/* Wait for IIC transfer */
> +	interruptible_sleep_on(&iic_wait);
> +	local_irq_restore(flags);
> +	if (signal_pending(current))
> +		return -EIO;

local_irq_xxx should not be used...

And it is very likely you should be using a semaphore here...



> +	/* Chip bug, set enable here */
> +	local_irq_save(flags);
> +	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +	i2c->i2c_i2cer = 0xff;
> +	i2c->i2c_i2mod = 1;	/* Enable */
> +	i2c->i2c_i2com = 0x81;	/* Start master */
> +
> +	/* Wait for IIC transfer */
> +	interruptible_sleep_on(&iic_wait);
> +	local_irq_restore(flags);
> +	if (signal_pending(current))
> +		return -EIO;

likewise




> +	printk("i2c-algo-8xx.o: adapter unregistered: %s\n",adap->name);
> +
> +#ifdef MODULE
> +	MOD_DEC_USE_COUNT;
> +#endif
> +	return 0;


Is this MOD_DEC_USE_COUNT is for a file op, use ->owner instead.


> +#ifdef MODULE
> +MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");
> +MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");
> +#ifdef MODULE_LICENSE
> +MODULE_LICENSE("GPL");
> +#endif
> +
> +int init_module(void) 
> +{
> +	return i2c_algo_8xx_init();
> +}
> +
> +void cleanup_module(void) 
> +{
> +}

kill ifdef MODULE.
use module_init, module_exit




