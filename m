Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSIOXGV>; Sun, 15 Sep 2002 19:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSIOXGV>; Sun, 15 Sep 2002 19:06:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318297AbSIOXGU>;
	Sun, 15 Sep 2002 19:06:20 -0400
Message-ID: <3D851374.8060402@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:10:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151837510.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:

> +static void pcf_epp_waitforpin(void) {
> +  int timeout = 10;
> +
> +  if (gpe.pe_irq > 0) {
> +    local_irq_disable();
> +    if (pcf_pending == 0) {
> +      interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ);
> +      //udelay(100);
> +    } else {
> +      pcf_pending = 0;
> +    }
> +    local_irq_enable();
> +  } else {
> +    udelay(100);
> +  }
> +}

use a semaphore...  don't ever use local_irq_xxx() when you clearly 
don't need to


> +static void pcf_epp_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
> +  pcf_pending = 1;
> +  wake_up_interruptible(&pcf_wait);
> +  DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: in interrupt handler.\n"));
> +}
> +
> +
> +static int pcf_epp_init(void *data)
> +{
> +  if (check_region(gpe.pe_base, 5) < 0 ) {
> +    
> +    printk(KERN_WARNING "Could not request port region with base 0x%x\n", gpe.pe_base);
> +    return -ENODEV;
> +  } else {
> +    request_region(gpe.pe_base, 5, "i2c (EPP parallel port adapter)");
> +  }

race. never use check_region



> +  DEB3(printk(KERN_DEBUG "i2c-pcf-epp.o: init status port = 0x%x\n", inb(0x379)));
> +  
> +  if (gpe.pe_irq > 0) {
> +    if (request_irq(gpe.pe_irq, pcf_epp_handler, 0, "PCF8584", 0) < 0) {
> +      printk(KERN_NOTICE "i2c-pcf-epp.o: Request irq%d failed\n", gpe.pe_irq);
> +      gpe.pe_irq = 0;
> +    } else
> +      disable_irq(gpe.pe_irq);
> +    enable_irq(gpe.pe_irq);
> +  }

why do you disable then enable the irq here?



> +static void pcf_epp_inc_use(struct i2c_adapter *adap)
> +{
> +#ifdef MODULE
> +  MOD_INC_USE_COUNT;
> +#endif
> +}
> +
> +static void pcf_epp_dec_use(struct i2c_adapter *adap)
> +{
> +#ifdef MODULE
> +  MOD_DEC_USE_COUNT;
> +#endif
> +}

kill ifdefs, use ->owner if possible


> +#ifdef MODULE
> +MODULE_AUTHOR("Hans Berglund <hb@spacetec.no> \n modified by Ryosuke Tajima <rosk@jsk.t.u-tokyo.ac.jp>");
> +MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 EPP parallel port adapter");
> +
> +MODULE_PARM(base, "i");
> +MODULE_PARM(irq, "i");
> +MODULE_PARM(clock, "i");
> +MODULE_PARM(own, "i");
> +MODULE_PARM(i2c_debug, "i");
> +
> +int init_module(void) 
> +{
> +  return i2c_pcfepp_init();
> +}
> +
> +void cleanup_module(void) 
> +{
> +  i2c_pcf_del_bus(&pcf_epp_ops);
> +  pcf_epp_exit();
> +}
> +
> +#endif

kill ifdef, use module_init, module_exit


