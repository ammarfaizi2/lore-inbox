Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbTLOUVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTLOUVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:21:23 -0500
Received: from fmr01.intel.com ([192.55.52.18]:54990 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264132AbTLOUVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:21:17 -0500
Message-ID: <3FDE17B3.40009@intel.com>
Date: Mon, 15 Dec 2003 22:21:07 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDC9DC5.2070302@intel.com> <Pine.LNX.4.58.0312151023570.1488@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312151023570.1488@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, besides discussion on how to save 4 bytes in executable size, 
I see 2 real problems with my PCI-E patch.

First problem is those addressed by Linus (thanks a lot!). I looked for 
proper way to do mapping, but it was either wasting lots of virtual 
space, or overhead for ioremap/unmap per transaction. I though 1-st 
variant is preferable and used it.

Linus, FIXMAP helps, it is lighter then ioremap, but it still requires 
page table walk. In addition, since several operations should be done 
atomically, lock/unlock required as well. Can it be faster method, 
without page table walk for each transaction? To what extent should one 
concern about performance here?

As alternative between 1 page and 256M, I see also lazy allocation on 
per-bus basis: when bus is first accessed, ioremap 1Mb for it. On real 
system, it is no more then 3-4 buses. This way, we will end with several 
1MB mappings. Finer granularity do not looks feasible, since bus 
scanning procedure tries to access all devices.

I am going to re-do PCI-E stuff with FIXMAP. To save extra page table 
walks, I'll keep last accessed page to not set_fixmap if we access the 
same device several times sequentially.

Second problem is generic way (lack of it) to recognize PCI-E presence 
and RRBAR physical address. Default is 0xe0000000, but theoretically it 
may be set to any 256M aligned. I used this default address and 
sanity_check for presence recognition. It is really not nice place in 
this patch. And worse, problem seems to be in PCI-E definition. I am 
working to address this problem before it is too late. What I want is 
some standard PCI capability that will be required in 00:00.0 device, 
its presence will indicate it is PCI-E, and its content will include 
RRBAR (and optionally any other appropriate stuff). Any alternative ideas?

Vladimir.

Linus Torvalds wrote:

>This really isn't appropriate. The
>
>	With PCI-E, config space accessed through memory. Each device gets
>	its own 4k memory mapped config, total 256M for all devices.
>
>thing _really_ does not work on x86, since 256M of IO mapping is _way_ way
>too much.
>
>You _really_ need to allocate a FIXMAP entry (just one), and then use
>
>	set_fixmap_nocache(FIX_PCIEXPRESS, phys);
>
>to set it up for each device.
>
>That's actually going to be a lot simpler than what you do now.
>
>		Linus
>
>  
>

