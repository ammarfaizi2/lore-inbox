Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933043AbWF2WKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbWF2WKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933041AbWF2WKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:10:30 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:20279 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S933040AbWF2WK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:10:28 -0400
Date: Fri, 30 Jun 2006 02:10:17 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Andy Fleming <afleming@freescale.com>
Cc: Li Yang-r58472 <LeoLi@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "linux-kernel@vger.kernel.org Mailing List" 
	<linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Message-ID: <20060630021017.18d0ddc3@localhost.localdomain>
In-Reply-To: <E5D17B54-D345-4859-A9B0-62F038A694EF@freescale.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FE2@zch01exm40.ap.freescale.net>
	<8A7E4B7C-8744-47FF-90FA-9B68C5187CEE@freescale.com>
	<20060629225131.43b9ed59@localhost.localdomain>
	<C45A575E-1283-4299-A403-BE46B13AEF9C@freescale.com>
	<20060629235625.5a8880a0@localhost.localdomain>
	<E5D17B54-D345-4859-A9B0-62F038A694EF@freescale.com>
X-Mailer: Sylpheed-Claws 2.3.0cvs16 (GTK+ 2.8.19; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 16:04:21 -0500
Andy Fleming wrote:

> 
> On Jun 29, 2006, at 14:56, Vitaly Bordug wrote:
> 
> > On Thu, 29 Jun 2006 14:18:51 -0500
> > Andy Fleming wrote:
> >
> >>
> >> On Jun 29, 2006, at 13:51, Vitaly Bordug wrote:
> >>
> >>> On Thu, 29 Jun 2006 13:03:23 -0500
> >>> Andy Fleming wrote:
> >>>
> >>> [snip]
> >>>>>>> +	iounmap(bcsr_regs);
> >>>>>>> +
> >>>>>> And if we have a design, which do not contain real ethernet UCC
> >>>>>> usage? Or UCC
> >>>>>> geth is disabled somehow explicitly? Stuff like that normally
> >>>>>> goes to the
> >>>>>> callback that is going to be triggered upon Etherbet init.
> >>>>> I will move it.
> >>>>
> >>>>
> >>>> Wait...no.  I don't understand Vitaly's objection.  If someone
> >>>> creates a board with an 8360 that doesn't use the UCC ethernet,
> >>>> they can create a separate board file.  This is the
> >>>> board-specific code, and it is perfectly acceptable for it to
> >>>> reset the PHY like this. What ethernet callback could be used?
> >>>>
> >>>
> >>> I am sort of against the unconditional trigger of the ethernet-
> >>> specific stuff,
> >>> dependless if UCC eth is really wanted in specific configuration.
> >>>
> >>> For stuff like that I'd make a function (to setup low-level
> >>> stuff), and pass it
> >>> via platform_info to the eth driver, so that really
> >>> driver-specific things happen in driver context only.
> >>>
> >>> Yes this is board specific file, and virtually everything needed
> >>> for the board can take place here.
> >>> But usually BCSR acts as a toggle for a several things, and IOW, I
> >>> see it more correct to trigger those stuff from the respective
> >>> drivers (using a callback passed through platform_info)
> >>
> >>
> >> Callbacks are fairly evil.  And the driver most certainly cannot
> >> know about the BCSR, since there may or may not even *be* a BCSR on
> >> any given board with a QE.  The PHY only needs to be reset once,
> >> during initialization.  On some boards, there is no need to trigger
> >> some sort of reset, or enable any PHYs.  I'm still not sure why
> >> this should be the domain of the device driver, since it's a board
> >> option.
> >>
> >
> > Well. The driver does not need to know anything about bcsr. All it  
> > needs to do is to execute the function pointer filled in bsp code,  
> > if one exists (If nothing needs to be tweaked in bsp level for a  
> > driver, just no need to fill that function pointer). For instance,  
> > in PQ2 uart, usb and fcc need to be enabled by bcsr before could
> > be actually utilized, so say fs_enet does all needed upon startup,  
> > without messing with board setup code.
> > The same does cpm uart...
> >
> > In case of this particular board, it is not that bad. But I
> > dislike the concept to execute the code in common (for this board)
> > path, not depending if UCC eth disabled in config explicitly.
> 
> Well, let me try to see if I understand the two approaches being  
> pondered:
> 
Yes, just right.

> 1) Use a callback.
> 
> Inside the platform info device-specific structure, we create a  
> callback.  Something like enet_info->board_init().  The board boots,  
> and in the initialization function for that board, the callback is  
> assigned to be a function which does the appropriate board-specific  
> initialization.  Actually, it makes sure to do this for every device  
> which requires such initialization.  Then, later, the devices are  
> registered, and matched up with appropriate drivers.  Those drivers  
> make sure to invoke enet_info->board_init() before they do anything  
> hw related.
> 
> 2) Let board init code do it
> 
> The board boots, and in the initialization function for that board,  
> it checks to see if the device exists (by searching the device
> tree), and if so, does any board-specific initialization (in this
> case, configuring the board register to enable the PHY for that
> device). The devices are registered, and matched with appropriate
> drivers. Those drivers operate, blissfully unaware that there was
> ever any danger the board wasn't set up.
> 

Sounds fine, but there are some corner cases. 
In case, really familiar to 8xx people, the board actually has devices, but 
they simply do not operate simultaneously (because of hw, or there are conflicting pin options)

So the only way to work in such a case is to craft proper kconfig for say, secondary Eth off, 2-nd uart on and vice versa.  BSP code could be aware of that, and make/do not make hw tweaks up to #ifdefs. The way for BSP code to put needed stuff into the function, hereby telling the driver to execute it upon setup before accessing hw seems more consistent way for me. 

Again, I agree it may be extra for this particular board. But we are speaking about the concept... That sort of things is used within fs_enet and cpm_uart drivers already in the stock tree.

-Vitaly
