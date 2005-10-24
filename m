Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVJXRpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVJXRpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVJXRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:45:30 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:26058 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751192AbVJXRp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:45:29 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: new PCI quirk for Toshiba Satellite?
Date: Mon, 24 Oct 2005 10:45:07 -0700
User-Agent: KMail/1.8.91
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, bcollins@debian.org,
       Greg KH <greg@kroah.com>, scjody@steamballoon.com, gregkh@suse.de
References: <20051015185502.GA9940@plato.virtuousgeek.org> <200510211138.57847.jbarnes@virtuousgeek.org> <43594BD3.9070103@s5r6.in-berlin.de>
In-Reply-To: <43594BD3.9070103@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510241045.08494.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 21, 2005 1:13 pm, Stefan Richter wrote:
> Jesse Barnes wrote:
> > Stefan, is a PCI quirk addition possible or do we have to use
> > dmi_check_system in the ohci driver itself (since we have to
> > reprogram the cache line size in addition to the other registers)?
>
> I am not familiar with the PCI subsystem, thus cannot advise how to
> handle it best nor wanted to post a patch myself (yet).

Ok, I'll update Rob's patch to the latest tree and send it on (I hadn't 
seen it yet when I wrote my version).

> It seems to me, using the .callback and .driver_data doesn't make it
> cleaner and leaner.

I agree, I thought it was necessary since I hadn't looked at 
dmi_check_system and didn't know if it had a return value I could check.  
Rob's patch looks much simpler and nicer.

> > But then what about the dev->current_state = 4?  Is that necessary?
>
> It is necessary; at least if the workaround resides in ohci1394.
> Otherwise the controller won't come back after a suspend/ resume
> cycle. (See Rob's post from February,
> http://marc.theaimsgroup.com/?m=110786495210243 ) Maybe there is
> another way to do that if the workaround was moved to pci/quirks.c.

Having it all in the driver probably makes the most sense if we have to 
have code there anyway.  Otherwise future users may have to check both 
places if things break again in another configuration.

> Furthermore, everything which belongs to the workaround should IMO be
> enclosed by #ifdef SOME_SENSIBLE_MACRO. This avoids kernel bloat for
> any target which is surely not a Toshiba laptop. Rob used an #if
> defined(__i386__).

Checks against the compiler defined arch are usually wrong since users 
could be cross compiling, and I'd like to avoid an ifdef altogether.  I 
think we can make the code collapse entirely by fixing linux/dmi.h.  If 
we remove the !defined(CONFIG_X86_64) check around the extern of 
dmi_check_system, all other arches will have it defined to simply return 
0, causing gcc to remove the dead conditional in ohci1394.c.

Anyway, I'll refresh that patch, test it, and send it on to Andrew, 
hopefully tonight.

Thanks,
Jesse
