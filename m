Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSHGNAz>; Wed, 7 Aug 2002 09:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSHGNAz>; Wed, 7 Aug 2002 09:00:55 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:43672 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317793AbSHGNAv>; Wed, 7 Aug 2002 09:00:51 -0400
Message-ID: <3D511AD9.F041F7BE@attbi.com>
Date: Wed, 07 Aug 2002 09:04:25 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       LM Sensors <sensors@Stimpy.netroedge.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]2.5.30 i2c updates 3/4
X-Priority: 2 (High)
References: <3D50B01F.53D7FFF5@attbi.com> <20020807102346.A5934@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please hold off incorporating all 4 patches until we
can get corrections.  Thanks.

Rusty,
Couple of quick comments while I forward to I2C authors.
First thanks for your effort to review our code.  It is
very much appreciated.  Next time I'll post to kernel list
before submitting to Linus.

I meant to remove the compatibility stuff from 2.5. 
Something I forgot to check in the new drivers.

The cli&sti replacement with driver_lock should be at the
module level and not proc level for SMP safety.  I'll
change this in all three drivers.

The requirement to support I2C and Sensors for releases
2.2 through current is very challenging.  I took your
advice from the last time, but haven't completed the work
yet.

The important clues you provided will be reviewed and incorporated in the next patch attempt.
Thanks again,
Albert


Russell King wrote:
> 
> The following are _some_ comments from a quick read through; they're not
> a thorough review, so there's probably lots of stuff I've missed.  But I
> felt I couldn't carry on reading anything else on lkml... 8)
> 
> On Wed, Aug 07, 2002 at 01:29:03AM -0400, Albert Cranford wrote:
> > +static void iic_ibmocp_waitforpin(void *data) {
> > +
> > +   int timeout = 2;
> > +   struct iic_ibm *priv_data = data;
> > +   spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
> 
> What's the point of a spinlock on the stack?  It doesn't gain you any
> protection against other threads on a SMP system.
> 
> > +   if (priv_data->iic_irq > 0) {
> > +      spin_lock_irq(&driver_lock);
> > +      if (iic_pending == 0) {
> > +        interruptible_sleep_on_timeout(&(iic_wait[priv_data->index]), timeout*HZ );
> 
> You shouldn't be scheduling with interrupts disabled, spinlock locked.
> Using a derivative of sleep_on().  Please look at wait_event() and
> interruptible_wait_event().  Also, interruptible_sleep_on() returns a
> value to tell you if it was interrupted...
> 
> > +   for(i=0; i<IIC_NUMS; i++) {
> > +      struct iic_ibm *priv_data = (struct iic_ibm *)iic_ibmocp_data[i]->data;
> > +      if (priv_data->iic_irq > 0) {
> > +         disable_irq(priv_data->iic_irq);
> > +         free_irq(priv_data->iic_irq, 0);
> 
> You shouldn't be calling disable_irq() just before free_irq().  Firstly, if
> the interrupt is being shared, then you just killed the other devices using
> that IRQ.  Secondly, free_irq will disable the interrupt source for you, so
> its redundant anyway.
> 
> > +       if (cpm->reloc == 0) {
> > +               volatile cpm8xx_t *cp = cpm->cp;
> > +
> > +               if (cpm_debug) printk("force_close()\n");
> > +               cp->cp_cpcr =
> > +                       mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
> > +                       CPM_CR_FLG;
> > +
> > +               while (cp->cp_cpcr & CPM_CR_FLG);
> 
> Ouch.  There should be a call to cpu_relax() in this (and any other such)
> while loops.  (IIRC Athlons tend to self-destruct without this.)
> 
> > +       invalidate_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
> 
> This is only defined on ARM and PPC; on ARM its not intended to be called
> by any driver directly (it should be using the pci_* DMA consistency stuff).
> On PPC, it looks like it should be a call to dma_cache_inv() which is the
> more accepted interface.  You can find them in include/asm-ppc/io.h
> 
> > +
> > +       /* Chip bug, set enable here */
> > +       local_irq_save(flags);
> > +       i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
> > +       i2c->i2c_i2cer = 0xff;
> > +       i2c->i2c_i2mod = 1;     /* Enable */
> > +       i2c->i2c_i2com = 0x81;  /* Start master */
> > +
> > +       /* Wait for IIC transfer */
> > +       interruptible_sleep_on(&iic_wait);
> 
> Again, sleeping with interrupts disabled...
> 
> > +       flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
> > +       flush_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
> 
> Same comments as invalidate_dcache_range(); dma_cache_wback_inv().
> 
> > +static void pcf_epp_waitforpin(void) {
> > +  int timeout = 10;
> > +  spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
> > +
> > +  if (gpe.pe_irq > 0) {
> > +    spin_lock_irq(&driver_lock);
> > +    if (pcf_pending == 0) {
> > +      interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ);
> > +      //udelay(100);
> > +    } else {
> > +      pcf_pending = 0;
> > +    }
> > +    spin_unlock_irq(&driver_lock);
> 
> See above.
> 
> > +  if (gpe.pe_irq > 0) {
> 
> An IRQ number of zero is completely valid on some systems.
> 
> > +    if (request_irq(gpe.pe_irq, pcf_epp_handler, 0, "PCF8584", 0) < 0) {
> > +      printk(KERN_NOTICE "i2c-pcf-epp.o: Request irq%d failed\n", gpe.pe_irq);
> > +      gpe.pe_irq = 0;
> > +    } else
> > +      disable_irq(gpe.pe_irq);
> > +      enable_irq(gpe.pe_irq);
> 
> The indentation here makes the code look broken.  However, I suspect the
> bug is balanced out because of the following bit of code:
> 
> > +static void pcf_epp_exit(void)
> > +{
> > +  if (gpe.pe_irq > 0) {
> > +    disable_irq(gpe.pe_irq);
> > +    free_irq(gpe.pe_irq, 0);
> 
> See comments about disable_irq/free_irq above.
> 
> > +static int bit_pport_init(void)
> > +{
> > +       //release_region( (base+2) ,1);
> 
> Eww.  Please don't give people ideas about releasing someone elses
> resources.
> 
> > +       if (check_region((base+2),1) < 0 ) {
> 
> You should request the region first, then probe.  If the probe fails,
> release the region.  Using check_region is not safe on any 2.2 or later
> kernel (hint: you can sleep in request_region).
> 
> And finally, I think keeping all the ifdef crap for "I want i2c to build
> across any kernel what so ever" is really bad.  For an example how to
> handle this, please see the jffs2/mtd code which has more or less the
> same requirement, but without the pain of having to put lots of ifdefs
> in the code.  The code is written to support the latest kernel, and the
> compatibility stuff is tucked away inside a header file.
> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
