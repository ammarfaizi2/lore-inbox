Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbSLSC1d>; Wed, 18 Dec 2002 21:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbSLSC1c>; Wed, 18 Dec 2002 21:27:32 -0500
Received: from fmr01.intel.com ([192.55.52.18]:3057 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267471AbSLSC1X> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 21:27:23 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs 
Date: Wed, 18 Dec 2002 18:35:22 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E192@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcKm9e+fUm/DfhLoEdeNCQBQi+Bs2AABNzmg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, <jamesclv@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 19 Dec 2002 02:35:22.0463 (UTC) FILETIME=[476B76F0:01C2A707]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The rules that I am trying to follow

					numaq		summit/			all other      
							other >8 CPU system	systems
------------------------------------------------------------------------------
clustered_apic_mode		CLUSTERED	CLUSTERED			NONE
configured_platform_type	NUMAQ		NONE				NONE
------------------------------------------------------------------------------
Note that in the patch, wherever I said NUMA, I actually meant NUMAQ. I think I lost
that Q, while I was trying to reduce the length of this variable 
(CONFIGURED_PLATFORM_NUMAQ) :). Sorry about all the resulting confusion. Doing a 
search and replace of NUMA by NUMAQ on my patch right now.

Noticeable changes here are
- summit using CLUSTERED in place of XAPIC(Physical destination).
- use "configured_platform_type" it basically separate out numaq specific stuff
  (like, waking up the CPUs through NMI), from the generic cluster apic support.

We are trying to use a common APIC destination mode for all systems with more
than 8 CPUs. This is by having the logical clusters of the CPUs. I am hoping that
this mode works fine on summit. Another option is to allow summit to continue using 
physical mode, if there is any binding reason to do so. But anyway NUMAQ specific stuff
has to be separated from cluster APIC stuff.

Rest of the comments inlined below..

> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> > -         define_bool CONFIG_X86_CLUSTERED_APIC y
> > +                 define_bool CONFIG_MULTIQUAD y
> 
> You seem to have lost turning on CONFIG_X86_NUMA.

I dont see CONFIG_X86_NUMA getting used anywhere in 2.4.21-pre1. Am I missing
something here??

> > +CONFIG_X86_APIC_CLUSTER=y
> >  # CONFIG_MULTIQUAD is not set
> >  CONFIG_HAVE_DEC_LOCK=y
> 
> Errrm ... on by default?

I was just trying to be little ambitious :). Will remove that now..

> > -	if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
> > -		id = 
> physical_to_logical_apicid(hard_smp_processor_id());
> > +	if(clustered_apic_mode)
> > +		id = cpu_2_logical_apicid[smp_processor_id()];
> 
> Don't use those arrays directly, use the macros.

OK. Will change it.

> And that was off before for NUMA-Q ... you seem to have turned it on.
> Unless you've inverted the meaning of clustered_apic_mode, which is
> going to confuse the hell out of everyone?

NO. This check is happening inside calculate_ldr() routine, and NUMAQ never comes
to calculate_ldr(), as (according to the comments), it is the BIOS that programs 
LDR in NUMAQ. So only thing we have to worry about in calculate_ldr() is 
non-NUMAQ systems.

> > -	if (clustered_apic_mode != CLUSTERED_APIC_NUMAQ) {
> > +	if (configured_platform_type != CONFIGURED_PLATFORM_NUMA) {
> 
> OK, what exactly are your switching rules here? Before:

I am trying to get the stuff which are _only_ specific to NUMAQ, under
"platform type" check. And the stuff specific to cluster APIC setup under 
"apic mode" check.
Can you please review the complete patch now. I am not sure whether my explaination 
was clear enough. Let me know if have any questions.

Thanks,
-Venkatesh 
