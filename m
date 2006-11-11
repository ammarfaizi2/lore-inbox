Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424009AbWKKPUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424009AbWKKPUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 10:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424010AbWKKPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 10:20:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44734 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424009AbWKKPUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 10:20:32 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Date: Sat, 11 Nov 2006 16:20:24 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
References: <20061111151414.GA32507@elte.hu>
In-Reply-To: <20061111151414.GA32507@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111620.24551.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2006 16:14, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> this patch fixes a couple of inconsistencies/problems i found while 
> reviewing the x86_64 genapic code (when i was chasing mysterious eth0 
> timeouts that would only trigger if CPU_HOTPLUG is enabled):
> 
>  - AMD systems defaulted to the slower flat-physical mode instead
>    of the flat-logical mode. The only restriction on AMD systems
>    is that they should not use clustered APIC mode.

This will open a race on CPU hotunplug unfortunately
(common for multi core suspend) 

> 
>  - removed the CPU hotplug hacks, switching the default for small
>    systems back from phys-flat to logical-flat. The switching to logical 
>    flat mode on small systems fixed sporadic ethernet driver timeouts i 
>    was getting on a dual-core Athlon64 system:

That will break CPU hotplug on some Intel systems (Ashok can give details) 

That is caused ethernet timeouts is weird, probably needs to be root caused.

>     NETDEV WATCHDOG: eth0: transmit timed out
>     eth0: Transmit timeout, status 0c 0005 c07f media 80.
>     eth0: Tx queue start entry 32  dirty entry 28.
>     eth0:  Tx descriptor 0 is 0008a04a. (queue head)
>     eth0:  Tx descriptor 1 is 0008a04a.
>     eth0:  Tx descriptor 2 is 0008a04a.
>     eth0:  Tx descriptor 3 is 0008a04a.
>     eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
> 
>  - The use of '<= 8' was a bug by itself (the valid APIC ids
>    for logical flat mode go from 0 to 7, not 0 to 8). The new logic
>    is to use logical flat mode on both AMD and Intel systems, and
>    to only switch to physical mode when logical mode cannot be used.
>    If CPU hotplug is racy wrt. APIC shutdown then CPU hotplug needs
>    fixing, not the whole IRQ system be made inconsistent and slowed
>    down.

Yes that needs to be fixed.

-Andi
