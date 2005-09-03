Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVICRiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVICRiG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVICRiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:38:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:39906 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751243AbVICRiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:38:04 -0400
Message-ID: <431A33D0.1040807@us.ibm.com>
Date: Sat, 03 Sep 2005 18:37:52 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
References: <41FFBDC9.2010206@us.ibm.com> <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk> <4200F2B2.3080306@us.ibm.com> <20050208200816.GA25292@kroah.com> <42B83B8D.9030901@us.ibm.com> <430B3CB4.1050105@us.ibm.com> <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org>
In-Reply-To: <20050903000854.GC8463@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Sat, Sep 03, 2005 at 09:11:30AM +1000, Paul Mackerras wrote:
> 
>>Think about it.  Taking the lock ensures that we don't do the
>>assignment (dev->block_ucfg_access = 1) while any other cpu has the
>>pci_lock.  In other words, the reason for taking the lock is so that
>>we wait until nobody else is doing an access, not to make others wait.
> 
> 
> The block_ucfg_access field is only used when making the choice to
> use saved state or call the PCI bus cfg accessor.
> I don't what problem waiting solves here since any CPU already
> accessing real cfg space will finish what they are doing anyway.
> ie they already made the choice to access real cfg space.
> We just need to make sure successive accesses to cfg space
> for this device only access the saved state. For that, a memory barrier
> around all uses of block_ucfg_access should be sufficient.
> Or do you think I'm still drinking the wrong color cool-aid?

Without the locking, we introduce a race condition.

CPU 0                                           CPU 1

					pci_block_user_cfg_access
						pci_save_state
pci_read_user_config_space
	check block_ucfg_access
						set block_ucfg_access
					other code that puts the device
					in a state such that it cannot
					handle read config i/o, such as
					running BIST.

	pci read config

In this scenario, If the real read on the left happens after the flag is 
set to block user config accesses, then the thread that set the flag 
could go off and start BIST or do something else to put the pci device 
in a state where it cannot accept real config I/O and we end up with a 
target abort, which is exactly what this patch is attempting to fix.

Granted, for the specific usage scenario in ipr, where I am using this 
to block config space over BIST, I use a pci config write to start BIST, 
which would end up being a point of synchronization, but that seems a 
bit non-obvious and limits how the patch can be used by others...

>>>If you had:
>>>	spin_lock_irqsave(&pci_lock, flags);
>>>	pci_save_state(dev);
>>>	dev->block_ucfg_access = 1;
>>>	spin_unlock_irqrestore(&pci_lock, flags);
>>>
>>>Then I could buy your arguement since the flag now implies
>>>we need to atomically save state and set the flag.
>>
>>That's probably a good thing to do to.
> 
> 
> One needs to verify pci_lock isn't acquired in pci_save_state()
> (or some other obvious dead lock).

Unfortunately, it is... Every pci config access grabs the lock, so we 
would need to use some special code that did not acquire the lock in 
pci_save_state if we wanted to do such a thing.

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
