Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263465AbVBEV3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbVBEV3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271316AbVBEV3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:29:32 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:25017 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S263465AbVBEV2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:28:53 -0500
Message-ID: <313680C9A886D511A06000204840E1CF0A6475F6@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: question re usage of  interruptible_sleep_on( ) function call  in
	 cpm_iic_tryaddress( ) function (in i2c-algo-8xx.c)
Date: Sat, 5 Feb 2005 16:28:49 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>  
> I have MPC880 microprocessor based board with single 24C02 I2C EEPROM,
> connected to the I2C bus.
> 
Yes, it is embedded, yes it is not INTEL arch ... but PLEASE - READ ON ! ;-)
>  
> Currently booting of the board hangs in the I2C driver after invocation of
> interruptible_sleep_on( )
>  function call  in cpm_iic_tryaddress( ) function (in i2c-algo-8xx.c
> file).
> 
> Is it appropriate to use the interruptible_sleep_on( ) function at the
> kernel booting stage ?
>  (I personally do not think so - since such usage prevents further kernel
> booting - as observed).
> What should be done in this code to avoid sleeping  forever - how to put
> time out on this sleep ?
> 
> I presume that the usage of the interruptible_sleep_on( ) function would
> be appropriate if the 
> I2C would be configured as a module (after the kernel booting is
> completed) ?
> Follow up question:  is it really expected to do I2C initialization ONLY
> as a module after the kernel booting ?
> (is it documented anyplace ?) 
> 
> The (end of) log buffer shows following:
> ....
> <6>i2c /dev entries driver.
> <7>device class 'i2c-dev': registering.
> <7>bus i2c:add driver dev_driver.
> <7>i2c-core: driver dev_driver registered
> <6>i2c-rpx: i2c MPC8xx driver.
> <7>DEV: registering device: ID ='i2c-0'.
> <7>CLASS: registering class device: ID= 'i2c-0'.
> <7>i2c_adapter i2c-0:Registered as minor 0.
> <7>CLASS:registering class device: ID = 'i2c-0'
> <7>i2c_adapter i2c-0: registered as adapter #0.
> <4>cpm_iic_init() - iip=fa203c80.
> <4>cpm_iic_init[132] Install ISR for IRQ 16.
> <6>CPM interrupt c0105d90 replacing c01f7a8c.
> <3>request_irq() returned -22  for CPM vector 32.
> <6> i2c-algo-8xx.o: scanning bus m8xx........
> <4>cpm_iic_tryaddress(cpm=c019b9f8,addr=0).
> <4>iip fa203c80, dp_addr 0x800.
> <4>iic_tbase 2048, r_tbase 2048
> <4>about to sleep
> .ABOVE LINE IS THE LAST ENTRY IN THE LOG BUFFER - THE BOOT HANGS
> THEREAFTER ... 
> 
> Here is the fragment of the cpm_iic_tryaddress( ) function in
> i2c-algo-8xx.c,
> where the problem takes place:
> .... 
> //      save_flags(flags); cli();
>         i2c->i2c_i2cer = 0xff;
>         i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
>         i2c->i2c_i2mod = 1;     /* Enable */
>         i2c->i2c_i2com = 0x81;  /* Start master */
> //      restore_flags(flags);
> 
>         if (cpm_debug > 1) printk("about to sleep\n");
> 
>         /* wait for IIC transfer */
> interruptible_sleep_on(&iic_wait);
> if (signal_pending(current))
>         return -EIO;
> 
> if (cpm_debug > 1) printk("back from sleep\n");
> 
> if (tbdf->cbd_sc & BD_SC_NAK) {
>         if (cpm_debug > 1) printk("IIC try; no ack\n");
>         return 0;
> }
> 
> if (tbdf->cbd_sc & BD_SC_READY) {
>         printk("IIC try; complete but tbuf ready\n");
> }
> 
> return 1;
> 
> ........
> Thanks,
> Best Regards,
> Alex 
> 
> 
