Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbTASC7q>; Sat, 18 Jan 2003 21:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTASC7q>; Sat, 18 Jan 2003 21:59:46 -0500
Received: from holomorphy.com ([66.224.33.161]:48261 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265368AbTASC7p>;
	Sat, 18 Jan 2003 21:59:45 -0500
Date: Sat, 18 Jan 2003 19:08:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca, zab@zabbo.net, manfred@colorfullife.com,
       macro@ds2.pg.gda.pl, Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com,
       andrew.grover@intel.com
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030119030840.GE780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca, zab@zabbo.net,
	manfred@colorfullife.com, macro@ds2.pg.gda.pl,
	Martin.Bligh@us.ibm.com, jamesclv@us.ibm.com,
	andrew.grover@intel.com
References: <20030119015013.GB780@holomorphy.com> <Pine.LNX.4.44.0301182114400.24250-100000@montezuma.mastecende.com> <20030119025514.GD780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119025514.GD780@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 09:32:22PM -0500, Zwane Mwaikambo wrote:
>> You'll drop irqs when you have collisions with devices 
>> attached to other busses/ioapics

On Sat, Jan 18, 2003 at 06:55:14PM -0800, William Lee Irwin III wrote:
> Those aren't reachable anyway. Any given IO-APIC can only reach
> devices within its own node. The only possible issue is the priority
> class bounded-depth queueing issue (max of 2 or 3 pending) which I've
> decided to ignore until something closer to working materializes.

Clarification: each node has its own APIC bus, and only logical DESTMOD
RTE's can interrupt cpus on remote nodes. The invariant of "any given
IO-APIC can only interrupt cpus on the same node" comes from the fact
that the RTE destinations s are programmed for physical broadcast, which
by definition cannot reach any further than the local node / APIC bus.

Essentially, because only interrupts with logical destinations are
routed by the cluster controllers, the guarantee of local-only
interruption is provided by using physical destinations in RTE's.

The net result is that so long as there are no vector clashes within a
given node, the software interrupt number is uniquely determined by the
vector and the node the interrupt was received on. And it is always
possible to assign unique vectors within a node as there are 190 vectors
and only 48 IO-APIC RTE's/pins.

All good? No more IDT overwriting and/or cross-node interrupt number
sharing concerns?

-- wli
