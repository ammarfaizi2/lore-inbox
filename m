Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUKHX4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUKHX4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUKHX4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:56:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1783 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261307AbUKHXz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:55:59 -0500
Message-ID: <4190078D.106@mvista.com>
Date: Mon, 08 Nov 2004 16:55:57 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][PPC32] Add setup_indirect_pci_nomap() routine
References: <418FF992.8040604@mvista.com> <32E32A44-31DA-11D9-9BE7-000393DBC2E8@freescale.com>
In-Reply-To: <32E32A44-31DA-11D9-9BE7-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

> Mark,
>
> Out of interest, why would we not want to ioremap the cfg addr/data 
> registers?
>
> - kumar
>
> On Nov 8, 2004, at 4:56 PM, Mark A. Greer wrote:
>
>> This patch adds a routine that sets up indirect pci config space access
>> but doesn't ioremap the config space addr/data registers.
>

You do need them mapped, of course, but:

a) It so happens that on the marvell host bridges those regs are in the 
middle of a larger block that is already ioremapp'd.

b) [Warning: Long story...]  To determine the type of bridge, the code 
has to access a pci cfg register on the bridge so access to those regs 
are necessary no matter what.  However, some platforms that use the 
marvell bridges don't use one or both of the hoses.  We've seen cases 
where if you try to access the pci bus that isn't wired properly, the 
bridge hangs so I can't always use pcibios_alloc_controller() to alloc 
the hose struct (or the pci infrastructure will try to scan the bus & 
hang the bridge).  Instead, in the one routine that gets the bridge 
type, I temporarily use a hose struct alloc'd on the stack and call 
setup_indirect_pci[_nomap]() with it.  Once I've read the bridge type, I 
no longer need that mapping but there is no "remove_indirect_pci()" 
routine to undo the previous setup.  So, worst case, when a platform 
uses both hoses, those regs are mapped once when all the bridge's regs 
are mapped, a second time when the temporary mapping is used, and a 
third time when using a hose struct alloc'd by 
pcibios_alloc_controller().  I end up with two unused mappings.

With some work & ugly code, I could get rid of one extra mapping but not 
both, and making a "nomap" routine just seemed cleaner.  There are 
probably other ppc platforms that could use this as well.

Mark

