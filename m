Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVCKCQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVCKCQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVCKCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:16:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263089AbVCKCMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:12:54 -0500
Date: Thu, 10 Mar 2005 21:12:48 -0500
From: Dave Jones <davej@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050311021248.GA20697@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 12:24:54PM +1100, Paul Mackerras wrote:

 > In fact there are other bogosities in drivers/char/agp/generic.c.  I
 > can't believe Dave ever tested that code with an AGP 3.0 device.

Hrmm, I'm fairly sure I did. It's also been sat in -mm without complaint
for a few weeks, which is odd.

 > you pass in a mode that has the AGP 3.0 bit set, agp_v3_parse_one()
 > will first clear that bit (and print a message), and then complain
 > because you haven't got that bit set in the mode, with a message that
 > the caller is broken.  Furthermore, if the mode passed in has both the
 > 4x and 8x bits set, the new code will give you 4x where the old code
 > would give you 8x (which is what the caller wanted).
 > 
 > The patch below fixes these problems.  It will work in the 99.99% of
 > cases where we have one AGP bridge and one AGP video card.  We should
 > eventually cope with multiple AGP bridges, but doing the matching of
 > bridges to video cards is a hard problem because the video card is not
 > necessarily a child or sibling of the PCI device that we use for
 > controlling the AGP bridge.  I think we need to see an actual example
 > of a system with multiple AGP bridges first.
 > 
 > Oh, and by the way, I have 3D working relatively well on my G5 with a
 > 64-bit kernel (and 32-bit X server and clients), which is why I care
 > about AGP 3.0 support. :)
 > 
 > Paul.
 > 
 > diff -urN linux-2.5/drivers/char/agp/agp.h g5-bad/drivers/char/agp/agp.h
 > --- linux-2.5/drivers/char/agp/agp.h	2005-03-07 14:01:44.000000000 +1100
 > +++ g5/drivers/char/agp/agp.h	2005-03-11 11:54:54.000000000 +1100
 > @@ -322,7 +322,7 @@
 >  #define AGPCTRL_GTLBEN		(1<<7)
 >  
 >  #define AGP2_RESERVED_MASK 0x00fffcc8
 > -#define AGP3_RESERVED_MASK 0x00ff00cc
 > +#define AGP3_RESERVED_MASK 0x00ff00c4
 >  
 >  #define AGP_ERRATA_FASTWRITES 1<<0
 >  #define AGP_ERRATA_SBA	 1<<1
 > diff -urN linux-2.5/drivers/char/agp/generic.c g5-bad/drivers/char/agp/generic.c
 > --- linux-2.5/drivers/char/agp/generic.c	2005-03-11 11:47:37.000000000 +1100
 > +++ g5/drivers/char/agp/generic.c	2005-03-11 12:08:29.000000000 +1100
 > @@ -515,13 +515,9 @@
 >  		printk (KERN_INFO PFX "%s tried to set rate=x0. Setting to AGP3 x4 mode.\n", current->comm);
 >  		*requested_mode |= AGPSTAT3_4X;
 >  	}
 > -	if (tmp == 3) {
 > -		printk (KERN_INFO PFX "%s tried to set rate=x3. Setting to AGP3 x4 mode.\n", current->comm);
 > -		*requested_mode |= AGPSTAT3_4X;
 > -	}
 > -	if (tmp >3) {
 > -		printk (KERN_INFO PFX "%s tried to set rate=x%d. Setting to AGP3 x8 mode.\n", current->comm, tmp);
 > -		*requested_mode |= AGPSTAT3_8X;
 > +	if (tmp >= 3) {
 > +		printk (KERN_INFO PFX "%s tried to set rate=x%d. Setting to AGP3 x8 mode.\n", current->comm, tmp * 4);
 > +		*requested_mode = (*requested_mode & ~7) | AGPSTAT3_8X;
 >  	}

This seems to make sense.

 >  	/* ARQSZ - Set the value to the maximum one.
 > @@ -642,11 +638,6 @@
 >  			return 0;
 >  		}
 >  		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
 > -		if (!cap_ptr) {
 > -			pci_dev_put(device);
 > -			continue;
 > -		}
 > -			cap_ptr = 0;
 >  	}

This part I'm not so sure about.
The pci_get_class() call a few lines above will get a refcount that
we will now never release.

Thanks for taking a look at this. The absense of hardware to test
on means I pretty much rely on feedback from inclusion in -mm
to hear about problems like this before it hits mainline.
Unfortunatly, no-one with ppc64 tested it there it seems :-(

		Dave

