Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVJUUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVJUUQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVJUUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:16:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:14480 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965142AbVJUUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:16:05 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43594BD3.9070103@s5r6.in-berlin.de>
Date: Fri, 21 Oct 2005 22:13:07 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, bcollins@debian.org,
       Greg KH <greg@kroah.com>, scjody@steamballoon.com, gregkh@suse.de
Subject: Re: new PCI quirk for Toshiba Satellite?
References: <20051015185502.GA9940@plato.virtuousgeek.org> <20051020000614.GI18295@kroah.com> <4357E2D3.9090206@s5r6.in-berlin.de> <200510211138.57847.jbarnes@virtuousgeek.org>
In-Reply-To: <200510211138.57847.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.344) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> Stefan, is a PCI quirk addition possible or do we have to use 
> dmi_check_system in the ohci driver itself (since we have to reprogram 
> the cache line size in addition to the other registers)?

I am not familiar with the PCI subsystem, thus cannot advise how to 
handle it best nor wanted to post a patch myself (yet).

[...]
>>		.callback = ohci1394_toshiba_reprogram_config,
>>		.ident = "Toshiba PSM4 based laptop",
>>		.matches = {
>>			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>>			DMI_MATCH(DMI_PRODUCT_VERSION, "PSM4"),
>>		},
>>		.driver_data = &tosh_data;

It seems to me, using the .callback and .driver_data doesn't make it 
cleaner and leaner.

> But then what about the dev->current_state = 4?  Is that necessary?

It is necessary; at least if the workaround resides in ohci1394. 
Otherwise the controller won't come back after a suspend/ resume cycle. 
(See Rob's post from February, 
http://marc.theaimsgroup.com/?m=110786495210243 ) Maybe there is another 
way to do that if the workaround was moved to pci/quirks.c.

[...]
> +	if (toshiba) {
> +		dev->current_state = 4;
> +		pci_read_config_word(dev, PCI_CACHE_LINE_SIZE, &toshiba_data);
> +	}
> +
>          if (pci_enable_device(dev))
>  		FAIL(-ENXIO, "Failed to enable OHCI hardware");
>          pci_set_master(dev);
>  
> +	if (toshiba) {
> +		mdelay(10);
> +		pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_data);
[...]

pci_set_master(dev) can be moved below the second part of the Toshiba 
workaround. That means AFAIU, the 2nd part of the Toshiba workaround can 
be moved out of ohci1394 into pci_fixup_device() which is called from 
pci_enable_device(), to be called as a DECLARE_PCI_FIXUP_ENABLE hook.

The first part of the workaround, i.e. caching the cache line size, for 
example by means of a static variable, would have to go into an 
_FIXUP_EARLY, _FIXUP_HEADER, or _FIXUP_FINAL hook. I am not sure yet 
about which type of hook to use.

Furthermore, everything which belongs to the workaround should IMO be 
enclosed by #ifdef SOME_SENSIBLE_MACRO. This avoids kernel bloat for any 
target which is surely not a Toshiba laptop. Rob used an #if 
defined(__i386__).
-- 
Stefan Richter
-=====-=-=-= =-=- =-=-=
http://arcgraph.de/sr/
