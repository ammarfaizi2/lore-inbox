Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbTAOLqf>; Wed, 15 Jan 2003 06:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTAOLqf>; Wed, 15 Jan 2003 06:46:35 -0500
Received: from holomorphy.com ([66.224.33.161]:49034 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266256AbTAOLqd>;
	Wed, 15 Jan 2003 06:46:33 -0500
Date: Wed, 15 Jan 2003 03:55:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030115115525.GI919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030115105802.GQ940@holomorphy.com> <20030115112412.GA5062@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115112412.GA5062@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> 	-- I've already tried and failed on PCI segments.
>> 	-- I would be much obliged for advice on this one, especially
>> 	-- since the workaround cripples the machine.

On Wed, Jan 15, 2003 at 10:24:12PM +1100, Anton Blanchard wrote:
> I was wondering if we could use pci_scan_bus_parented as a start.
> Assuming we fixed pci_bus_exists, this should allow us to create
> overlapping busses.
> What else needs fixing? To start with:
> * pci config read/writes
> 	Should be arch specific, can hide things in struct pci_bus
> 	which is passed in. (eg on ppc64 we have to pass an identifier
> 	into the low level config read or write)

PCI config cycles must be qualified by segment here just to get the
right address, so there's definitely a requirement for stuff. One
"advantage" of NUMA-Q (if it can be called that) is that firmware/BIOS
and hardware pushes a bus number mangling scheme that is more or less
mandatory, so things can at largely implicitly taken care of with the
bus number and the firmware's mapping of the mangled bus numbers to the
cross-quad portio area. But this scheme does not have cooperation from
PCI-PCI bridges, where NUMA-Q mangling scheme -noncompliant physical
bus ID's are kept in the bus number registers.

I've made some attempts to de-mangle the bus numbers (i.e. the failed
PCI segment support patches), but the issue is a hundred times worse
that way, as it breaks almost all of the I/O setup's reliance on the MP
config tables in x86 arch code.


On Wed, Jan 15, 2003 at 10:24:12PM +1100, Anton Blanchard wrote:
> * pci IO/memory reads/writes
> 	No problems on ppc64, it should just work. Are there problems
> 	on x86? 

This is basically a solved one on NUMA-Q, which is sort of "x86 cpu,
but little resembling traditional/standard x86 otherwise".


On Wed, Jan 15, 2003 at 10:24:12PM +1100, Anton Blanchard wrote:
> * /proc/bus/pci/
> 	As davem pointed out we have a backwards compatibility bit
> 	where all devices on domain 0 appear as they always have.
> 	Additionally we create another level of directories to represent
> 	the domain.
> * /proc/pci
> 	Need to print the domain
> * device printing
> 	We need a macro that drivers can use to print their PCI location
> 	Then we make that print the domain.
> * sysfs
> 	I havent looked into this yet

I have no idea what to do about these; I just sort of hope and pray the
backward-compatibility constraints won't hurt me. At the level of things
exported to userspace my main concern is largely that things like disk
arrays will actually be accessible as raw devices or mountable as fs's,
cooperation with userspace drivers and accurate reporting is kind of
secondary to me aside from satisfying backward-compatibility concerns
from Pee Cee -centric sides of things.


On Wed, Jan 15, 2003 at 10:24:12PM +1100, Anton Blanchard wrote:
> Does anything else spring to mind?

It's a bit x86-specific, but a lot of the low-level scanning for
bigboxen is shared with Pee Cees and Pee Cees win the contest, so
it's broken at a level below the generic code there. The subarch
bits have potential but it's largely been focused at firmware table
scanning and cpu bringup as opposed to I/O devices.

That, and PCI interrupt routing (again, lower-level than generic code)
falls apart with the number of interrupt sources I've got and some of
the IO-APIC (x86-specific again) identity confusions that go on with
multi-APIC-bus systems.


Bill
