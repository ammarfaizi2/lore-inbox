Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWF3H6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWF3H6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWF3H6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:58:41 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:27038 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751450AbWF3H6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:58:40 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FEE@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Vitaly Bordug'" <vbordug@ru.mvista.com>,
       Fleming Andy-afleming <afleming@freescale.com>
Cc: Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "linux-kernel@vger.kernel.org Mailing List" 
	<linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Fri, 30 Jun 2006 15:58:30 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of you are reasonable.  But the simplest fix goes like this:

-       /* Reset the Ethernet PHY */
-       bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
-       bcsr_regs[9] &= ~0x20;
-       udelay(1000);
-       bcsr_regs[9] |= 0x20;
-       iounmap(bcsr_regs);
+       if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
+                       != NULL){
+               /* Reset the Ethernet PHY */
+               bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
+               bcsr_regs[9] &= ~0x20;
+               udelay(1000);
+               bcsr_regs[9] |= 0x20;
+               iounmap(bcsr_regs);
+       }


> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Friday, June 30, 2006 6:10 AM
> To: Fleming Andy-afleming
> Cc: Li Yang-r58472; Yin Olivia-r63875; linux-kernel@vger.kernel.org Mailing
> List; linuxppc-dev list; Chu hanjin-r52514
> Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> 
> On Thu, 29 Jun 2006 16:04:21 -0500
> Andy Fleming wrote:
> 
> >
> > On Jun 29, 2006, at 14:56, Vitaly Bordug wrote:
> >
> > > On Thu, 29 Jun 2006 14:18:51 -0500
> > > Andy Fleming wrote:
> > >
> > >>
> > >> On Jun 29, 2006, at 13:51, Vitaly Bordug wrote:
> > >>
> > >>> On Thu, 29 Jun 2006 13:03:23 -0500
> > >>> Andy Fleming wrote:
> > >>>
> > >>> [snip]
> > >>>>>>> +	iounmap(bcsr_regs);
> > >>>>>>> +
> > >>>>>> And if we have a design, which do not contain real ethernet UCC
> > >>>>>> usage? Or UCC
> > >>>>>> geth is disabled somehow explicitly? Stuff like that normally
> > >>>>>> goes to the
> > >>>>>> callback that is going to be triggered upon Etherbet init.
> > >>>>> I will move it.
> > >>>>
> > >>>>
> > >>>> Wait...no.  I don't understand Vitaly's objection.  If someone
> > >>>> creates a board with an 8360 that doesn't use the UCC ethernet,
> > >>>> they can create a separate board file.  This is the
> > >>>> board-specific code, and it is perfectly acceptable for it to
> > >>>> reset the PHY like this. What ethernet callback could be used?
> > >>>>
> > >>>
> > >>> I am sort of against the unconditional trigger of the ethernet-
> > >>> specific stuff,
> > >>> dependless if UCC eth is really wanted in specific configuration.
> > >>>
> > >>> For stuff like that I'd make a function (to setup low-level
> > >>> stuff), and pass it
> > >>> via platform_info to the eth driver, so that really
> > >>> driver-specific things happen in driver context only.
> > >>>
> > >>> Yes this is board specific file, and virtually everything needed
> > >>> for the board can take place here.
> > >>> But usually BCSR acts as a toggle for a several things, and IOW, I
> > >>> see it more correct to trigger those stuff from the respective
> > >>> drivers (using a callback passed through platform_info)
> > >>
> > >>
> > >> Callbacks are fairly evil.  And the driver most certainly cannot
> > >> know about the BCSR, since there may or may not even *be* a BCSR on
> > >> any given board with a QE.  The PHY only needs to be reset once,
> > >> during initialization.  On some boards, there is no need to trigger
> > >> some sort of reset, or enable any PHYs.  I'm still not sure why
> > >> this should be the domain of the device driver, since it's a board
> > >> option.
> > >>
> > >
> > > Well. The driver does not need to know anything about bcsr. All it
> > > needs to do is to execute the function pointer filled in bsp code,
> > > if one exists (If nothing needs to be tweaked in bsp level for a
> > > driver, just no need to fill that function pointer). For instance,
> > > in PQ2 uart, usb and fcc need to be enabled by bcsr before could
> > > be actually utilized, so say fs_enet does all needed upon startup,
> > > without messing with board setup code.
> > > The same does cpm uart...
> > >
> > > In case of this particular board, it is not that bad. But I
> > > dislike the concept to execute the code in common (for this board)
> > > path, not depending if UCC eth disabled in config explicitly.
> >
> > Well, let me try to see if I understand the two approaches being
> > pondered:
> >
> Yes, just right.
> 
> > 1) Use a callback.
> >
> > Inside the platform info device-specific structure, we create a
> > callback.  Something like enet_info->board_init().  The board boots,
> > and in the initialization function for that board, the callback is
> > assigned to be a function which does the appropriate board-specific
> > initialization.  Actually, it makes sure to do this for every device
> > which requires such initialization.  Then, later, the devices are
> > registered, and matched up with appropriate drivers.  Those drivers
> > make sure to invoke enet_info->board_init() before they do anything
> > hw related.
> >
> > 2) Let board init code do it
> >
> > The board boots, and in the initialization function for that board,
> > it checks to see if the device exists (by searching the device
> > tree), and if so, does any board-specific initialization (in this
> > case, configuring the board register to enable the PHY for that
> > device). The devices are registered, and matched with appropriate
> > drivers. Those drivers operate, blissfully unaware that there was
> > ever any danger the board wasn't set up.
> >
> 
> Sounds fine, but there are some corner cases.
> In case, really familiar to 8xx people, the board actually has devices, but
> they simply do not operate simultaneously (because of hw, or there are
> conflicting pin options)
> 
> So the only way to work in such a case is to craft proper kconfig for say,
> secondary Eth off, 2-nd uart on and vice versa.  BSP code could be aware of
> that, and make/do not make hw tweaks up to #ifdefs. The way for BSP code to
> put needed stuff into the function, hereby telling the driver to execute it
> upon setup before accessing hw seems more consistent way for me.
> 
> Again, I agree it may be extra for this particular board. But we are speaking
> about the concept... That sort of things is used within fs_enet and cpm_uart
> drivers already in the stock tree.
> 
> -Vitaly
