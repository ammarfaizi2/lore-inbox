Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUJEIb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUJEIb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268877AbUJEIb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:31:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28564 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268868AbUJEIbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:31:53 -0400
Message-ID: <41625B9B.5010901@watson.ibm.com>
Date: Tue, 05 Oct 2004 04:30:19 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Helsley <matthltc@us.ibm.com>
CC: Peter Williams <pwil3058@bigpond.net.au>, dipankar@in.ibm.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, efocht@hpce.nec.com,
       Martin Bligh <mbligh@aracnet.com>, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       Matthew Dobson <colpatch@us.ibm.com>, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	 <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]>	 <200408061730.06175.efocht@hpce.nec.com>	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>	 <20041001164118.45b75e17.akpm@osdl.org>	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>	 <415F3D4C.6060907@watson.ibm.com> <1096946035.2673.769.camel@stark>
In-Reply-To: <1096946035.2673.769.camel@stark>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Helsley wrote:

> On Sat, 2004-10-02 at 16:44, Hubertus Franke wrote:
> <snip>
> 
>>along cpuset boundaries. If taskclasses are allowed to span disjoint
>>cpumemsets, what is then the definition of setting shares ?
> 
> <snip>
> 
> 	I think the clearest interpretation is the share ratios are the same
> but the quantity of "real" resources and the sum of shares allocated is
> different depending on cpuset.
> 
> 	For example, suppose we have taskclass/A that spans cpusets Foo and Bar
> -- processes foo and bar are members of taskclass/A but in cpusets Foo
> and Bar respectively. Both get up to 50% share of cpu time in their
> respective cpusets because they are in taskclass/A. Further suppose that
> cpuset Foo has 1 CPU and cpuset Bar has 2 CPUs.

Yes, we ( Shailabh and I ) were talking about exactly that this 
afternoon. This would mean that the denominator of the cpu shares for a 
given class <cls> is not determined solely by the parents 
total_guarantee but by:
    total_guarantee * size(cls->parent->cpuset) / size(cls->cpuset)

This is effectively what you describe below.

> 
> 	This means process foo could consume up to half a CPU while process bar
> could consume up to a whole CPU. In order to enforce cpuset
> partitioning, each class would then have to track its share usage on a
> per-cpuset basis. [Otherwise share allocation in one partition could
> prevent share allocation in another partition. Using the example above,
> suppose process foo is using 45% of CPU in cpuset Foo. If the total
> share consumption is calculated across cpusets process bar would only be
> able to consume up to 5% of CPU in cpuset Bar.]
> 

This would require some changes in the CPU scheduler to teach the 
cpu-monitor to deal with the limited scope. It would also require some
mods to the API :
Since classes can span different cpu sets with different shares
how do we address the cpushare of a class in the particular context
of a cpu-set.
Alternatively, one could require that classes can not span different
cpu-sets, which would significantly reduce the complexity of this.

> Cheers,
> 	-Matt Helsley
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 

