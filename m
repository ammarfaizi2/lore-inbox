Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbTGDQEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266064AbTGDQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 12:04:24 -0400
Received: from franka.aracnet.com ([216.99.193.44]:20890 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S266063AbTGDQEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 12:04:22 -0400
Date: Fri, 04 Jul 2003 09:18:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <13170000.1057335490@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com>
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no><20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com><7910000.1057333295@[10.10.2.4]> <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 4 Jul 2003, Martin J. Bligh wrote:
> 
>> Is it really necessary to turn half the apic code upside down in order
>> to fix this? What's the actual bugfix that's buried in this cleanup?
> 
> The way i see it is that you can't use NR_CPUS to determine the upper 
> bound on APIC IDs. e.g. my 3way is normally configured with NR_CPUS = 3 
> but has APIC IDs of 0, 3 and 4. We need to make a distinction.

Fair enough. But that would seem to be a simpler operation than this patch.

>> > -			if (i >= 0xf)
>> > +			if (i >= APIC_BROADCAST_ID)
>> 
>> Is that always correct? it's not equivalent.
> 
> Well we really want APIC_MAX_ID (or whatever it's called)

Indeed. maybe MAX_PHYS_APIC_ID or something (it's different for logical).
We break it out in subarch, but it's the same everywhere, which seems
utterly useless - is probably historical cruft that needs to die.
But that sounds like a separate issue, and a separate patch to me.

>> > -	for (bit = 0; kicked < NR_CPUS && bit < 8*sizeof(cpumask_t); bit++) {
>> > +	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
>> 
>> Is that the actual one-line bugfix this is all about?
> 
> No, the problem is no space for physical ids in cpumask bitmaps, this 
> could manifest itself later on unless we fix it now.

Ugh, are you saying the cpumask stuff shrinks masks to < 32 bits if
NR_CPUS is low enough? If so, I can see more point to the patch, but
it still seems like violent overkill. Stopping it doing that would
probably fix it ... I can't imagine it buys you much.

phys_cpu_present_map started off as an unsigned long, and I reused it
in a fairly twisted way for NUMA-Q. As it's an array that's bounded
by apic space, using the bios_cpu_apicid method that summit uses
would be a much cleaner fix, and just leave the old one as a long
bitmask like it used to be - which is fine for non- clustered apic
systems, and saves inventing a whole new data type. See the
cpu_present_to_apicid abstraction.

>> Hmmmm. What are you using physical apicids here for? They seem
>> irrelevant to this function. 
> 
> Urgh, it's really hard to determine what these functions really want half 
> the time. But that change does look wrong.

Yeah, things taking logical apicids, and turning them into cpu numbers
presumably shouldn't have to touch that.

M.

