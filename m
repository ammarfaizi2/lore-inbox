Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267395AbSLRXSq>; Wed, 18 Dec 2002 18:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267402AbSLRXSq>; Wed, 18 Dec 2002 18:18:46 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:22023 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267395AbSLRXSm>; Wed, 18 Dec 2002 18:18:42 -0500
Date: Wed, 18 Dec 2002 23:26:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Message-ID: <20021218232640.A1746@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com>; from venkatesh.pallipadi@intel.com on Wed, Dec 18, 2002 at 02:36:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 02:36:20PM -0800, Pallipadi, Venkatesh wrote:
> These reasons together led to panics on other OEM systems with > 8 CPUS. The 
> patch tries to fix this issue in a generic way (in place of having multiple 
> hacks for different OEMs). Note, the patch only intends to change the 
> initialization of systems with more than 8 CPUs and it will not affect
> other systems (apart from possible bugs in my code itself).

Any pointers to these systems?

> - Separate out xAPIC stuff from APIC destination setup. And the availability of 
>   xAPIC support can actually  be determined from the LAPIC version.

Are you sure?  IIRC some of the early summit boxens didn't report the
right versions..

> - physical mode support _removed_, as we can use clustered logical setup to 
>   support can support upto a max of 60 CPUs. This is mainly because of the 
>   advantage of being able to setup IOAPICs in LowestPrio, when using clustered mode.

does this really not break anything in the fragile summit setups?



-   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
-   if [ "$CONFIG_X86_NUMA" = "y" ]; then
+   bool 'Clustered APIC (> 8 CPUs) support' CONFIG_X86_APIC_CLUSTER
+   if [ "$CONFIG_X86_APIC_CLUSTER" = "y" ]; then
+      define_bool CONFIG_X86_CLUSTERED_APIC y

Do we really need CONFIG_X86_APIC_CLUSTER _and_ CONFIG_X86_CLUSTERED_APIC?

 	unsigned long id;
-	if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
-		id = physical_to_logical_apicid(hard_smp_processor_id());
+	if(clustered_apic_mode)
+		id = cpu_2_logical_apicid[smp_processor_id()];
 	else

Okay, this was wrong before, but any chance you could use proper
style here (i.e. if ()
	
 		id = 1UL << smp_processor_id();
 
-		if (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id) {
+		if ( !xapic_support && 
+			(mp_ioapics[apic].mpc_apicid >= apic_broadcast_id)) {

		if (!xapic_support &&
		    (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id)) {

+		if ( !xapic_support ) {

Again.

-	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
+	if (clustered_apic_mode &&
+		(configured_platform_type == CONFIGURED_PLATFORM_NUMA) ) {

Doesn;t configured_platform_type == CONFIGURED_PLATFORM_NUMA imply
clustered_apic_mode?  and it should be at least CONFIGURED_PLATFORM_NUMAQ,
btw.  Probably better something short like SUBARCH_NUMAQ..

Except of that the patch looks fine, but IMHO something like that should
get testing in 2.5 first.
