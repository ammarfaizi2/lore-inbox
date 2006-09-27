Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWI0FNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWI0FNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965332AbWI0FNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:13:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1735 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965211AbWI0FN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:13:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, adurbin@google.com
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
	<20060926201104.1bb1a193.akpm@osdl.org>
Date: Tue, 26 Sep 2006 23:12:14 -0600
In-Reply-To: <20060926201104.1bb1a193.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 26 Sep 2006 20:11:04 -0700")
Message-ID: <m1ac4lriz5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 26 Sep 2006 20:04:05 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> When I apply:
>> x86_64-mm-insert-ioapics-and-local-apic-into-resource-map
>> 
>> My e1000 fails to initializes and complains about a bad eeprom checksum.
>> I haven't tracked this down to root cause yet and I am in the process of
> building
>> 2.6.18-mm1 with just that patch reverted to confirm that is the only cause.
>> 
>> I could not see anything obvious in the patch.  I don't have a clue the patch
>> could be triggering the problem I'm seeing.
>> 
>> At a quick visual diff I'm not seeing any other differences in the kernel boot
>> logs, or in /proc/iomem.
>
> This bit looks fishy:
>
>  GSI 17 sharing vector 0x4A and IRQ 17
>  PCI->APIC IRQ transform: 0000:05:0c.0[A] -> IRQ 17
> +PCI: Cannot allocate resource region 8 of bridge 0000:00:02.0
> +PCI: Cannot allocate resource region 8 of bridge 0000:01:00.0
> +PCI: Cannot allocate resource region 8 of bridge 0000:01:00.2
> +PCI: Cannot allocate resource region 0 of device 0000:01:00.1
> +PCI: Cannot allocate resource region 0 of device 0000:01:00.3
> +PCI: Cannot allocate resource region 0 of device 0000:03:04.0
> +PCI: Cannot allocate resource region 0 of device 0000:03:04.1
>  PCI-GART: No AMD northbridge found.
>  PCI: Bridge: 0000:01:00.0
>    IO window: disabled.
> -  MEM window: fe000000-fe0fffff
> +  MEM window: e2000000-e20fffff
>    PREFETCH window: fd000000-fdffffff
>  PCI: Bridge: 0000:01:00.2
>    IO window: 1000-1fff
> -  MEM window: fe100000-fe1fffff
> +  MEM window: e2100000-e21fffff
>    PREFETCH window: disabled.
>  PCI: Bridge: 0000:00:02.0
>    IO window: 1000-1fff
> -  MEM window: fe000000-fe2fffff
> +  MEM window: e2000000-e22fffff
>    PREFETCH window: fd000000-fdffffff
>  PCI: Bridge: 0000:00:06.0
>    IO window: disabled.
> @@ -123,17 +131,17 @@
>  PCI: Bridge: 0000:00:1e.0
>    IO window: 2000-2fff
>    MEM window: fb000000-fc0fffff
> -  PREFETCH window: e2000000-e20fffff
>
>
> Wanna hack into arch/i386/pci/i386.c:pcibios_allocate_bus_resources() and
> see what is conflicting with what?

Good catch.  Add that to the earlier /proc/iomem output.
> fe200000-fe200fff : IOAPIC 1
> fe201000-fe201fff : IOAPIC 2

On that board I have ioapics on pci devices and it appears the way
the patch is reserving them it doesn't account for ioapics that
have that property.  I.e.  Those ioapics regions show up in lspci
on an ioapic pci device and the regions are specified with normal
base address registers.

I'm trying to finish up my msi work, so I'm going to avoid further
digging.  Hopefully this is enough now that we have a reasonable
explanation someone can actually dig in and fix this problem.

Eric


