Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSIOXCT>; Sun, 15 Sep 2002 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSIOXCS>; Sun, 15 Sep 2002 19:02:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318286AbSIOXCQ>;
	Sun, 15 Sep 2002 19:02:16 -0400
Message-ID: <3D851280.4030504@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:06:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151836230.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:

> +#ifdef MODULE_LICENSE
> +MODULE_LICENSE("GPL");
> +#endif

kill the ifdef



> +#if 0
> +static void iic_ibmocp_sleep(unsigned long timeout)
> +{
> +   schedule_timeout( timeout * HZ);
> +}
> +#endif

dead code



> +
> +
> +//
> +// Description:  Put this process to sleep.  We will wake up when the
> +// IIC controller interrupts.
> +//
> +static void iic_ibmocp_waitforpin(void *data) {
> +
> +   int timeout = 2;
> +   struct iic_ibm *priv_data = data;
> +
> +   //
> +   // If interrupts are enabled (which they are), then put the process to
> +   // sleep.  This process will be awakened by two events -- either the
> +   // the IIC peripheral interrupts or the timeout expires. 
> +   //
> +   if (priv_data->iic_irq > 0) {
> +      local_irq_disable();
> +      if (iic_pending == 0) {
> +  	 interruptible_sleep_on_timeout(&(iic_wait[priv_data->index]), timeout*HZ );
> +      } else
> + 	 iic_pending = 0;
> +      local_irq_enable();

ug ug ug.


> +   } else {
> +      //
> +      // If interrupts are not enabled then delay for a reasonable amount
> +      // of time and return.  We expect that by time we return to the calling
> +      // function that the IIC has finished our requested transaction and
> +      // the status bit reflects this.
> +      //
> +      // udelay is probably not the best choice for this since it is
> +      // the equivalent of a busy wait
> +      //
> +      udelay(100);

what context is this?

> +
> +//
> +// Description: This function is very hardware dependent.  First, we lock
> +// the region of memory where out registers exist.  Next, we request our
> +// interrupt line and register its associated handler.  Our IIC peripheral
> +// uses interrupt number 2, as specified by the 405 reference manual.
> +//
> +static int iic_hw_resrc_init(int instance)
> +{
> +
> +   DEB(printk("iic_hw_resrc_init: Physical Base address: 0x%x\n", (u32) IIC_ADDR[instance] ));
> +   iic_ibmocp_adaps[instance]->iic_base = (u32)ioremap((unsigned long)IIC_ADDR[instance],PAGE_SIZE);

check for failure

> +
> +   DEB(printk("iic_hw_resrc_init: ioremapped base address: 0x%x\n", iic_ibmocp_adaps[instance]->iic_base));
> +
> +   if (iic_ibmocp_adaps[instance]->iic_irq > 0) {
> +	
> +      if (request_irq(iic_ibmocp_adaps[instance]->iic_irq, iic_ibmocp_handler,
> +       0, "IBM OCP IIC", iic_ibmocp_adaps[instance]) < 0) {
> +         printk(KERN_ERR "iic_hw_resrc_init: Request irq%d failed\n",
> +          iic_ibmocp_adaps[instance]->iic_irq);
> +	 iic_ibmocp_adaps[instance]->iic_irq = 0;
> +      } else {
> +         DEB3(printk("iic_hw_resrc_init: Enabled interrupt\n"));
> +      }
> +   }
> +   return 0;

you blindly return zero even if request_irq fails... is this correct?



> +}
> +
> +
> +//
> +// Description: Release irq and memory
> +//
> +static void iic_ibmocp_release(void)
> +{
> +   int i;
> +
> +   for(i=0; i<IIC_NUMS; i++) {
> +      struct iic_ibm *priv_data = (struct iic_ibm *)iic_ibmocp_data[i]->data;
> +      if (priv_data->iic_irq > 0) {
> +         disable_irq(priv_data->iic_irq);
> +         free_irq(priv_data->iic_irq, 0);
> +      }
> +      kfree(iic_ibmocp_data[i]);
> +      kfree(iic_ibmocp_ops[i]);
> +   }
> +}

where is the matching iounmap() call for the above?  leak.



> +static void iic_ibmocp_inc_use(struct i2c_adapter *adap)
> +{
> +#ifdef MODULE
> +	MOD_INC_USE_COUNT;
> +#endif
> +}
> +
> +
> +//
> +// Description: If this is a module, then decrement the count
> +//
> +static void iic_ibmocp_dec_use(struct i2c_adapter *adap)
> +{
> +#ifdef MODULE
> +	MOD_DEC_USE_COUNT;
> +#endif
> +}


kill the ifdefs.  use ->owner instead if possible.



> +
> +//
> +// Description: Called when the module is loaded.  This function starts the
> +// cascade of calls up through the heirarchy of i2c modules (i.e. up to the
> +//  algorithm layer and into to the core layer)
> +//
> +int __init iic_ibmocp_init(void) 
> +{
> +   int i;
> +
> +   printk(KERN_INFO "iic_ibmocp_init: IBM on-chip iic adapter module\n");
> + 
> +   for(i=0; i<IIC_NUMS; i++) {
> +      iic_ibmocp_data[i] = kmalloc(sizeof(struct i2c_algo_iic_data),GFP_KERNEL);
> +      if(iic_ibmocp_data[i] == NULL) {
> +         return -ENOMEM;
> +      }
> +      memset(iic_ibmocp_data[i], 0, sizeof(struct i2c_algo_iic_data));
> +      
> +      switch (i) {
> +	      case 0:
> +	       iic_ibmocp_adaps[i]->iic_irq = IIC_IRQ(0);
> +	      break;
> +	      case 1:
> +	       iic_ibmocp_adaps[i]->iic_irq = IIC_IRQ(1);
> +	      break;
> +      }
> +      iic_ibmocp_adaps[i]->iic_clock = IIC_CLOCK;
> +      iic_ibmocp_adaps[i]->iic_own = IIC_OWN; 
> +      iic_ibmocp_adaps[i]->index = i;
> + 
> +      DEB(printk("irq %x\n", iic_ibmocp_adaps[i]->iic_irq));
> +      DEB(printk("clock %x\n", iic_ibmocp_adaps[i]->iic_clock));
> +      DEB(printk("own %x\n", iic_ibmocp_adaps[i]->iic_own));
> +      DEB(printk("index %x\n", iic_ibmocp_adaps[i]->index));
> +
> +
> +      iic_ibmocp_data[i]->data = (struct iic_regs *)iic_ibmocp_adaps[i]; 
> +      iic_ibmocp_data[i]->setiic = iic_ibmocp_setbyte;
> +      iic_ibmocp_data[i]->getiic = iic_ibmocp_getbyte;
> +      iic_ibmocp_data[i]->getown = iic_ibmocp_getown;
> +      iic_ibmocp_data[i]->getclock = iic_ibmocp_getclock;
> +      iic_ibmocp_data[i]->waitforpin = iic_ibmocp_waitforpin;
> +      iic_ibmocp_data[i]->udelay = 80;
> +      iic_ibmocp_data[i]->mdelay = 80;
> +      iic_ibmocp_data[i]->timeout = 100;
> +      
> +            iic_ibmocp_ops[i] = kmalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> +      if(iic_ibmocp_ops[i] == NULL) {
> +         return -ENOMEM;

memory leak -- free above kmalloc on error




> +// If modules is NOT defined when this file is compiled, then the MODULE_*
> +// macros will resolve to nothing
> +//
> +MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
> +MODULE_DESCRIPTION("I2C-Bus adapter routines for PPC 405 IIC bus adapter");
> +MODULE_PARM(base, "i");
> +MODULE_PARM(irq, "i");
> +MODULE_PARM(clock, "i");
> +MODULE_PARM(own, "i");
> +MODULE_PARM(i2c_debug,"i");
> +
> +
> +module_init(iic_ibmocp_init);
> +module_exit(iic_ibmocp_exit); 

nice!  why don't the other drivers look like this?  ;-)

