Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423787AbWKHVKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423787AbWKHVKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423786AbWKHVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:10:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:47650 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1423787AbWKHVKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:10:53 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="158402879:sNHT45587073"
Message-ID: <455247DA.3090406@intel.com>
Date: Wed, 08 Nov 2006 13:10:50 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: General network driver suspend/resume (was e1000 carrier related)
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net>	<20061107071449.GB21655@elf.ucw.cz>	<4550AB7A.10508@intel.com>	<20061108120407.GA9506@elf.ucw.cz> <20061108115414.7e089a58@freekitty>
In-Reply-To: <20061108115414.7e089a58@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 21:10:50.0203 (UTC) FILETIME=[5E0B22B0:01C7037A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Wed, 8 Nov 2006 13:04:07 +0100
> Pavel Machek <pavel@ucw.cz> wrote:
> 
>> Hi!
>>
>>>>> This behavior differs from every other network card, and is also present 
>>>>> in the
>>>>> 7.3* version of the driver from sourceforge.
>>>>>
>>>>> I think the e1000 should try to raise the link during the probe, so that 
>>>>> it
>>>>> works properly, without having to set ifconfig ethX up first.
>>>> I think you should cc e1000 maintainers, and perhaps provide a patch....
>>> I've read it and not come up with an answer due to some other issues at 
>>> hand. E1000 hardware works differently and this has been asked before, but 
>>> the cards itself are in low power state when down. Changing this to bring 
>>> up the link would make the card start to consume lots more power, which 
>>> would automatically suck enormously for anyone using a laptop.
>> Well, maybe E1000 should behave as the other cards behave, and
>> different solution needs to be found for power saving? ifconfig eth0
>> suspend?
>>
>> 									Pavel
>>  
>>
> 
> The standard which all network drivers should use is:
> 
> module insertion:
> 	start in initial powerdown state
> 
> open:
> 	power up, bring up link
> 
> stop:
> 	bring down link
> 	return to powerdown state unless WOL is set.
> 	if doing WOL go to lowest power sensing state
> 
> suspend:
> 	same as stop
> 
> resume:
> 	same as open
> 
> module removal:
> 	stop already called so device should be in power down state.
> 
> 
> Since suspend is basically same as stop, and resume is open
> I am going to investigate doing suspend/resume in the network device layer
> (unless subclassed by driver), so we can rip out the suspend/resume hook
> from many network drivers. There will still be boards like sky2
> that need own suspend/resume to deal with dual port etc.


beware that e1000 needs to save pci msi config space on top of the normal pci config 
space. Perhaps this needs to be fixed upstream in pci_save_state for msi devices, but 
the api for msi is not capable of detecting this atm.

Auke
