Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbSLTB5T>; Thu, 19 Dec 2002 20:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbSLTB5S>; Thu, 19 Dec 2002 20:57:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17120 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267684AbSLTB5P> convert rfc822-to-8bit; Thu, 19 Dec 2002 20:57:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Date: Thu, 19 Dec 2002 18:04:55 -0800
User-Agent: KMail/1.4.3
Cc: "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212191804.55194.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 December 2002 02:36 pm, Pallipadi, Venkatesh wrote:
> 2.4.21-pre1 (i386) based patch to fix the issues with systems having more
> than 8 CPUs, in a generic way.
>
>
> Motivation:
> The current APIC destination mode ("Flat Logical") used in linux kernel has
> an upper limit of 8 CPUs. For more than 8 CPUs, either "Clustered Logical"
> or "Physical" mode has to be used.
> There is already some code in current kernel (2.4.21-pre1), to support such
> conditions. Specifically, IBM Summit, uses Physical mode, and IBM NUMAQ
> uses clustered mode. But, there are some issues too:
> - it is not generic enough to support any other more than 8 CPU system
>   out of the box. Supporting different systems may need more hacks in the
> code. - clustered mode setup is tightly coupled with NUMA system. Whereas,
> in reality, we can as well have logical clusters in a non-NUMA system as
> well. - physical mode setup is somewhat tightly coupled with xAPIC. But,
> xAPIC doesn't necessarily imply physical mode. You can as well have
> clustered mode with xAPIC - APIC destination mode is selected based on
> particular OEM string.
>
> These reasons together led to panics on other OEM systems with > 8 CPUS.
> The patch tries to fix this issue in a generic way (in place of having
> multiple hacks for different OEMs). Note, the patch only intends to change
> the initialization of systems with more than 8 CPUs and it will not affect
> other systems (apart from possible bugs in my code itself).

Your goals are laudable and, in many ways, I share them.  However, this is 
2.4.  Our goals for 2.4 have always been minimal changes and as little impact 
as possible to the UP and flat SMP cases.

> Description:
> The basic idea is to use the number of processors detected on the system,
> to decide on which APIC destination mode is to be used. Once all the CPU
> info, is collected either from ACPI or MP table, we can check the total
> number of processors in the system.
> If the number of processors in less than equal to 8,
>    then no change is required, and we can use the default, "Flat Logical"
> set up. If the number of processors is more than 8
>    we can switch to clustered logical setup.
>    The logical clusters set up as follows.
>    Cluster 0 (CPU 0-3), Cluster 1 (CPU 4-7), Cluster 2 (CPU 8-11) and so
> on..
>
> The other things that are done in the patch include:
> - Separate out the NUMA specific stuff from APIC setup in cluster mode.
> Also, NUMA has its own way of setting up the clusters, and doesn't follow
> the logical cluster mapping defined above.
> - Separate out xAPIC stuff from APIC destination setup. And the
> availability of xAPIC support can actually  be determined from the LAPIC
> version. - physical mode support _removed_, as we can use clustered logical
> setup to support can support upto a max of 60 CPUs. This is mainly because
> of the advantage of being able to setup IOAPICs in LowestPrio, when using
> clustered mode.

See my 2.5 patches for an example of using solely logical mode interrupts.  
The patches submitted to 2.4 are those that have been in Alan's tree since 
August and running in SuSE 8.0+ since 8.0's release.

> The whole stuff is protected by 'Clustered APIC (> 8 CPUs) support
> (CONFIG_X86_APIC_CLUSTER)' config option under Processor Type and Features.
> But going forward, we can actually make this as default, as this doesn't
> affect the systems with less than equal to 8 CPUs (Apart from minor
> increase in code size and couple of additional checks during boot up), but
> gives the default support to more than 8 CPU systems.

An x440 needs to use clustered APIC mode whenever more than two physical CPUs 
are present.  Consider scanning the list of physical APIC IDs to determine 
whether clustered mode is necessary.  (I had such code in my 2.5 patch, but 
ripped it out when it falsely triggered on a couple oddball systems.  You may 
be able to write a more comprehensive analyzer.)

> Please let me know your comments/criticisms about this.
> I was able to test this successfully on an 8-way with HT(16 logical)
> CPU systems that I have access to. But, I haven't tested it on x440, or
> NUMAQ systems. Would love to hear about the effect of this patch on these
> systems.
>
> Thanks,
> -Venkatesh

A generic patch should also support Unisys' new box, the ES7000 or some such.

> > -----Original Message-----
> > From: Nakajima, Jun
> > Sent: Thursday, December 12, 2002 7:06 PM
> > To: jamesclv@us.ibm.com; Zwane Mwaikambo
> > Cc: Martin Bligh; John Stultz; Linux Kernel
> > Subject: RE: [PATCH][2.5][RFC] Using xAPIC apic address space
> > on !Summit
> >
> >
> > BTW, we are working on a xAPIC patch that supports more than
> > 8 CPUs in a
> > generic fashion (don't use hardcode OEM checking). We already
> > tested it on
> > two OEM systems with 16 CPUs.
> > - It uses clustered mode. We don't want to use physical mode
> > because it does
> > not support lowest priority delivery mode.
> > - We also check the version of the local APIC if it's xAPIC
> > or not. It's
> > possible that some other x86 architecture (other than P4P) uses xAPIC.
> >
> > Stay tuned.
> >
> > Jun

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

