Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbTEVACO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTEVACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:02:13 -0400
Received: from holomorphy.com ([66.224.33.161]:6025 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262402AbTEVACL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:02:11 -0400
Date: Wed, 21 May 2003 17:14:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>, davem@redhat.com,
       habanero@us.ibm.com, haveblue@us.ibm.com, arjanv@redhat.com,
       pbadari@us.ibm.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
       Andrew Morton <akpm@digeo.com>
Subject: Re: userspace irq =?unknown-8bit?Q?balance?=
	=?unknown-8bit?B?csKg?=
Message-ID: <20030522001459.GN8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Mannthey <kmannth@us.ibm.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	"Martin J. Bligh" <mbligh@aracnet.com>, davem@redhat.com,
	habanero@us.ibm.com, haveblue@us.ibm.com, arjanv@redhat.com,
	pbadari@us.ibm.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
	Andrew Morton <akpm@digeo.com>
References: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com> <1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 04:39:29PM -0700, Keith Mannthey wrote:
>   Only kinda.  Boxes with Hyperthreaded cpus have an odd ordering
> scheme.  The BIOS is free to assign apicids at will to any cpu.  It is
> not forced to any certain scheme.  On some hyperthreaded boxes the 2nd
> cpu is on the same apicid cluster even thought the cpu numbers are far
> apart. 
>   This makes building meaningful apicid masks (more than one cpu) a bit
> tricky.  For example a user would have to know that cpus 1,2,9,10 were
> on the same cluster not (1,2,3,4) as you would expect. Since the bios
> can do what it will it makes it hard to build masks of capable clusters
> easily in all situations.

APIC issues can be dealt with very, very simply.
(1) for each cpu, report the physical APIC ID
(2) for each cpu, report the logical APIC ID
	(or if using only physical IPI's whatever the BIOS left in the LDR)
(3) report the DFR setting used globally across the system
(4) for each IO-APIC, report where it's attached (bus and node)
(5) report the contents of each IO-APIC RTE
	(5a) report the destination (interpretation depends on DESTMOD)
	(5b) report DESTMOD as either logical or physical
	(5c) report what it's connected to (irq, possibly driver name)
(6) report the APIC revision(s) (to distinguish APIC from xAPIC)
(7) report the IO-APIC revision(s) (for completeness)

The cpus a given IO-APIC RTE can address with physical DESTMOD can then
be determined from the APIC revision, and the cpus a given IO-APIC RTE
can address with logical DESTMOD can then be determined from the APIC
revision and (global and immutable, though the register is per- local
APIC; there's no good way to switch over, and no reason to) DFR setting.

The logical CPU number used to refer to CPUs by the kernel bears no
relation to APIC ID's apart from arithmetic schemes artificially
imposed by the implementation. Fully tabulating the APIC ID's for all
the CPUs as in (1) and (2) is sufficient information for userspace to
construct and invert the relation as required to determine APIC cluster
membership. It is also possible to directly export APIC clusters as
sysfs objects and enumerate the cpus, though (IMHO) it's best to merely
expose the information the kernel acts on as it stands now and let
userspace infer the rest.

In principle one could also export the ability to set IO-APIC RTE's
DESTMOD bits on the fly, given proper validity checks for
addressibility and the like (I'm assuming one would rather barf than
deadlock the box even if some additional code were required). The one
box where it matters doesn't care to use irqbalance anyway, though.

Basically, spill your guts as to what you've got and let userspace
think about how to do the right thing with it.


-- wli
