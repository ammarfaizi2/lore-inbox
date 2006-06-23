Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752037AbWFWVbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWFWVbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWFWVby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:31:54 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:33441 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1752084AbWFWVbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:31:53 -0400
Date: Fri, 23 Jun 2006 14:23:54 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: William Cohen <wcohen@redhat.com>
Cc: linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net,
       perfmon@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: [Perfctr-devel] [perfmon] 2.6.17.1 new perfmon code base, libpfm, pfmon available
Message-ID: <20060623212354.GA1102@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060621142447.GA29389@frankl.hpl.hp.com> <449C598B.7070803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449C598B.7070803@redhat.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

On Fri, Jun 23, 2006 at 05:13:47PM -0400, William Cohen wrote:
> Hi Stephane,
> 
> Some quick questions about the current perfmon code.
> 
> 
> The athlon has very similar hw to the amd64 and there is now 32-bit
> x86-64 support. Wouldn't it make sense to move perfmon_amd.c to i386
> and have it work in the same way as perfmon_p4.c does currently for p4
> and em64t?
> 
Does Athlon have 4 counters as well. I don't have the HW so I cannot really
test. I suspect they are similar. If you have HW and you can test, I don't
have a problem.

> Could the 32-bit and 64-bit code be combined in a manner similar to
> oprofile and avoid duplication between perfmon_em64t_pebs.c and
> perfmon_p4_pebs.c?  pfm_{p4|em64}_ds_area and
> pfm_{p4|em64t}_pebs_sample_entry have differences due to the upgrade
> from 32 to 64 bit values.
> 
You have several issues here:
	- the 64-bit version has 8 more reigsters int the PEBS entry
	- the PEBS entry uses 32 or 64 bitfields depending on data model
	- the ds_area uses 32 or 64 bits depending on the data model except for the threshold value

Now remember that on on EM64T we also support 32-bit (i386) binaries. 
With an EM64T kernel you would have the 64-bit PEBS format. With the same UUID if would satisfy
a i386 binary and this is wrong because they would not match the definition of the PEBS entry.
We need to keep the PEBS 32 and 64-bit format UUIDs different. At the source code level, you would
need to ifdef __x86_64__ and __i386__ to switch struct definition and UUID. That's doable but is
this clean?
	
> Why isn't Intel family 0xf model 3 not supported?
> 	Model 1,2, 4, and 5 are supported.
> 	Model 3 Pentium4 isn't that different is it?

I have not looked at this. I don't have a lot of P4 HW. I think that
all family 15 uses the same PMU. Could someone confirm this?


> 
> Why the following patch in the code and array using this constant in
> sys_pfm_write_pmcs and sys_pfm_write_pmds? The the p4/em64t certainly
> has more registers than that.
> 

The constant are not directly related to the number of registers. There is
an issue with stack space consumption. You need to use the right balance
between most common number of elements passed to read/write calls with
stack size. On i386 (and x86_64, I think) the page size is 4kB and
the default stack is 2 pages, so you have to be careful especially
when you have to call very deep.

> --- linux-2.6.17.1.old/include/asm-i386/perfmon.h	2006-06-21 
> 05:19:04.000000000 -0700
> +++ linux-2.6.17.1/include/asm-i386/perfmon.h	2006-06-21 
> 04:22:51.000000000 -0700
> @@ -18,6 +18,14 @@
> 
>   #ifdef __KERNEL__
> 
> +#ifdef CONFIG_4KSTACKS
> +#define PFM_ARCH_PMD_ARG	2
> +#define PFM_ARCH_PMC_ARG	2
> +#else
> +#define PFM_ARCH_PMD_ARG	4
> +#define PFM_ARCH_PMC_ARG	4
> +#endif
> +
>   #include <asm/desc.h>
>   #include <asm/apic.h>
> 
> 
> What is the purpose of PFM_MAX_XTRA_PMCS and PFM_MAX_XTRA_PMDS? Are
> they used for anything other than increasing the size of PFM_MAX_PMCS
> and PFM_MAX_PMDS?
> 
> 
> -Will
> 
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Perfctr-devel mailing list
> Perfctr-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfctr-devel

-- 

-Stephane
