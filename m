Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTEUTGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTEUTGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:06:48 -0400
Received: from holomorphy.com ([66.224.33.161]:57223 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262283AbTEUTGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:06:46 -0400
Date: Wed, 21 May 2003 12:19:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, davem@redhat.com,
       habanero@us.ibm.com, haveblue@us.ibm.com, arjanv@redhat.com,
       pbadari@us.ibm.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
       Andrew Morton <akpm@digeo.com>
Subject: Re: userspace irq =?unknown-8bit?Q?balance?=
	=?unknown-8bit?B?csKg?=
Message-ID: <20030521191929.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Mannthey <kmannth@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, davem@redhat.com,
	habanero@us.ibm.com, haveblue@us.ibm.com, arjanv@redhat.com,
	pbadari@us.ibm.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
	Andrew Morton <akpm@digeo.com>
References: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 11:28:41AM -0700, Keith Mannthey wrote:
>   Here is the patch to turn kirqd into a config option if it is really
> needed.  I don't see why the noirqbalance functionality isn't enough for
> now.  Is there anything currently keeping a userspace irq balancer from
> working as 2.5 stands today?  It dosen't look like it to me.
> Keith      

This will do, though my preference is to make the code actually
understand what DESTMOD means in IO-APIC RTE's and what DFR means
for local APIC's instead of the rather ridiculous workarounds for
not doing so currently present.

There are a couple of obstacles to doing this:

(1) There is no true mechanism for correlating IO-APIC's with the
	APIC buses corresponding to a given cluster for APIC. The
	assumption is largely global addressibility a la xAPIC.
(2) DESTMOD is not a static property. Dynamically switching between
	logical and physical DESTMOD is fully possible and allows a
	somewhat greater variety of cpu sets to be handled on APIC.

I'd also like for there to be validity checking and explicit error
returns from the affinity setting API.

I'm not entirely happy with the genapic bits. Basically the APIC
is relatively well-standardized, and I'd rather the point-by-point
"this codepath must differ" abstraction be built atop such an APIC
manipulation "library" as it were. For instance:

(1) cpu wakeup via NMI is possible on ordinary machines; INIT merely
	cannot address cpus above the limit of APIC's physical
	addressing scheme (which is 4 bits) and so is required for
	pre-xAPIC machines with > 16 cpus or machines where only
	logical interrupts are routed across bus boundaries (be they
	APIC buses or memory buses).
(2) clustered hierarchical DFR is usable on single APIC bus boxen and
	xAPIC boxen with provisos for cluster ID's being misrouted.
(3) IO-APIC RTE formats are not magical properties of the machine;
	there is just logical and physical DESTMOD and representability
	of target cpu sets in the logical format and physical format
	and the dependence of the logical format on the cpus' DFR's.

These somewhat obvious observations imply to me that common code should
be used to manipulate the local APIC and IO-APIC and the machine-
specific code should choose its preferred modes when calling it, not
provide a private implementation or magic values to stuff into various
registers that specialize the APIC handling to a particular mode.

OTOH I don't see much (if any) chance of any of this happening since
"just barely works" suffices for most people's purposes and the
moderately large amount of work required to do all this ends up with
approximately zero functional difference in the end.

Thanks.


-- wli
