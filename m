Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVH3P3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVH3P3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVH3P3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:29:05 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:59540 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932168AbVH3P3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:29:04 -0400
Message-ID: <43147B3D.1030309@vc.cvut.cz>
Date: Tue, 30 Aug 2005 17:29:01 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jon Smirl <jonsmirl@gmail.com>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
References: <1125371996.11963.37.camel@gaston>  <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>  <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>  <20050829.212021.43291105.davem@davemloft.net>  <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org> <9e473391050829215148807c49@mail.gmail.com> <Pine.LNX.4.58.0508292207330.3243@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508292207330.3243@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 30 Aug 2005, Jon Smirl wrote:
> 
>>I was reading the status out of the PCI config space to account for
>>our friend X which enables ROMs without informing the OS. With X
>>around PCI config space can get out of sync with the kernel
>>structures.
> 
> 
> Well, yes, except that we use the in-kernel resource address for the
> actual ioremap() _anyway_ in the routine that calls this, so if X has
> remapped the ROM somewhere else, that wouldn't work in the first place.
> 
> I'm sure X plays games with this register (I suspect that's why the Matrox 
> thing broke in the first place), but I don't think it should do so while 
> the kernel uses it. 

Matrox broke because some of their chips have ROM base bits 31-1 reserved
(read as 0) when bit 0 is cleared.  So if you read valid ROM resource,
clear enable bit, write it to the device, and later it read from device,
enable it, and write back, you'll end up with ROM enabled at bus address
zero.  Probably not what you want.

And FYI, on my Tyan S2885 box 2.6.13 relocates all (as far as I can tell)
ROMs because BIOS assigns them into 'MEM window' (non-prefetchable) while
kernel reassigns then to the 'PREFETCH window'.  In the past code was
even allocating ROM resources above 4GB (which is nonsense for ROM region,
unfortunately pci_bus_alloc_resource does not seem to know about difference
between 64bit and 32bit BARs, and it always uses -1 as max address, which
is wrong on 64bit kernel), but it does not happen since I went from 4GB
of memory back to 2GB...
						Petr Vandrovec

