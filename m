Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSEaHys>; Fri, 31 May 2002 03:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSEaHyr>; Fri, 31 May 2002 03:54:47 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:39886 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S315182AbSEaHyo>; Fri, 31 May 2002 03:54:44 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: <dipankar@in.ibm.com>, "'Mala Anand'" <manand@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <lse-tech-admin@lists.sourceforge.net>,
        "'Paul McKenney'" <Paul.McKenney@us.ibm.com>,
        "'Rusty Russell'" <rusty@rustcorp.com.au>
Subject: RE: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Date: Fri, 31 May 2002 13:27:44 +0530
Message-ID: <00eb01c20878$d952b890$290806c0@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-1f8fa994-0366-4293-a61d-0e7a3ad13b7d"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020530232513.C3575@in.ibm.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-1f8fa994-0366-4293-a61d-0e7a3ad13b7d
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

|Actually I don't know for sure what plans are afoot to fix the 
|slab allocator
|for per-cpu. One plan I heard about was allocating from per-cpu pools
|rather than per-cpu copies. My requirements are similar to
|the hot list skbs. I want to do this -
|
|	int *ctrp1, *ctrp2;
|	
|	ctrp1 = kmalloc_percpu(sizeof(*ctrp1), GFP_ATOMIC);
|	if (ctrp1 == NULL) {
|		/* recover */
|	}
|	ctrp2 = kmalloc_percpu(sizeof(*ctrp2), GFP_ATOMIC);
|	if (ctrp2 == NULL) {
|		/* recover */
|	}
|
|	*per_cpu_ptr(ctrp1, smp_processor_id())++;
|	this_cpu_ptr(ctrp2)++;
|
|Now I can allocate by making ctrp1/ctrp2 point to an array
|of NR_CPUS and kmalloc() memory for each CPU's copy of the
|int. This is simple and will work. 
|
|	void **ptrs = kmalloc(sizeof(*ptrs) * NR_CPUS, flags);
|
|	if (!ptrs) return NULL;
|	for (i = 0; i < NR_CPUS; i++) {
|	      ptrs[i] = kmalloc(size, flags);
|	      if (!ptrs[i])
|		      goto unwind_oom;
|	}
|
|
|However I would like to use kmalloc_percpu() for allocating very 
|small objects - typlically integer counters or small structures
|to be used as per-cpu counters for things like dst entries and 
|dentries.
|kmalloc will waste the rest of the cache line for such small objects.
|The alternative is to use a layer of code to interleave small objects
|and save on space.
|
|
|   CPU #0          CPU#1
|
| ---------       ---------         Start of cache line
|   *ctrp1         *ctrp1
|   *ctrp2         *ctrp2
|
|   .               .
|   .               .
|   .               .
|   .               .
|   .               .
|
| ---------       ----------        End of cache line


Won't this result in a lot of false sharing, if any of the CPUs
tried to access any of the counters, the entire cache line would be
moved from the current CPU to that CPU. Isn't this a very bad thing or
am I missing something? Do all your counters fit into one cache line.

For sometime now, I have been thinking of implementing/supporting
PME's (Peformance Monitoring Events and Counters), so that we can
get real values (atleast on x86) as compared to our guesses about
cacheline bouncing, etc. Do you know if somebody is already doing
this?

Regards,
Balbir

|
|I have an allocator that interleaves objects like this if they 
|can be fitted
|into size that is a factor of SMP_CACHE_BYTES. 
|
|I hope someone can tell me that I don't even have to do this. Otherwise
|I will go ahead and do my thing.
|
|Thanks
|-- 
|Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
|Linux Technology Center, IBM Software Lab, Bangalore, India.
|
|_______________________________________________________________
|
|Don't miss the 2002 Sprint PCS Application Developer's Conference
|August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
|
|_______________________________________________
|Lse-tech mailing list
|Lse-tech@lists.sourceforge.net
|https://lists.sourceforge.net/lists/listinfo/lse-tech
|


------=_NextPartTM-000-1f8fa994-0366-4293-a61d-0e7a3ad13b7d
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-1f8fa994-0366-4293-a61d-0e7a3ad13b7d--
