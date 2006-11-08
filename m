Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbWKHVdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWKHVdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWKHVdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:33:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423792AbWKHVdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:33:17 -0500
Date: Wed, 8 Nov 2006 13:33:13 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: General network driver suspend/resume (was e1000 carrier
 related)
Message-ID: <20061108133313.20ea5f7c@freekitty>
In-Reply-To: <455247DA.3090406@intel.com>
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net>
	<20061107071449.GB21655@elf.ucw.cz>
	<4550AB7A.10508@intel.com>
	<20061108120407.GA9506@elf.ucw.cz>
	<20061108115414.7e089a58@freekitty>
	<455247DA.3090406@intel.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 13:10:50 -0800
Auke Kok <auke-jan.h.kok@intel.com> wrote:

> Stephen Hemminger wrote:
> > On Wed, 8 Nov 2006 13:04:07 +0100
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
> >> Hi!
> >>
> >>>>> This behavior differs from every other network card, and is also present 
> >>>>> in the
> >>>>> 7.3* version of the driver from sourceforge.
> >>>>>
> >>>>> I think the e1000 should try to raise the link during the probe, so that 
> >>>>> it
> >>>>> works properly, without having to set ifconfig ethX up first.
> >>>> I think you should cc e1000 maintainers, and perhaps provide a patch....
> >>> I've read it and not come up with an answer due to some other issues at 
> >>> hand. E1000 hardware works differently and this has been asked before, but 
> >>> the cards itself are in low power state when down. Changing this to bring 
> >>> up the link would make the card start to consume lots more power, which 
> >>> would automatically suck enormously for anyone using a laptop.
> >> Well, maybe E1000 should behave as the other cards behave, and
> >> different solution needs to be found for power saving? ifconfig eth0
> >> suspend?
> >>
> >> 									Pavel
> >>  
> >>
> > 
> > The standard which all network drivers should use is:
> > 
> > module insertion:
> > 	start in initial powerdown state
> > 
> > open:
> > 	power up, bring up link
> > 
> > stop:
> > 	bring down link
> > 	return to powerdown state unless WOL is set.
> > 	if doing WOL go to lowest power sensing state
> > 
> > suspend:
> > 	same as stop
> > 
> > resume:
> > 	same as open
> > 
> > module removal:
> > 	stop already called so device should be in power down state.
> > 
> > 
> > Since suspend is basically same as stop, and resume is open
> > I am going to investigate doing suspend/resume in the network device layer
> > (unless subclassed by driver), so we can rip out the suspend/resume hook
> > from many network drivers. There will still be boards like sky2
> > that need own suspend/resume to deal with dual port etc.
> 
> 
> beware that e1000 needs to save pci msi config space on top of the normal pci config 
> space. Perhaps this needs to be fixed upstream in pci_save_state for msi devices, but 
> the api for msi is not capable of detecting this atm.
> 

pci_config save needs to save more (including all the pci express stuff).
But until the mmconfig issues are fixed on x86_64 that will be impossible.
Maybe the last fix will solve the problem.


-- 
Stephen Hemminger <shemminger@osdl.org>
