Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWFPMhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWFPMhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 08:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWFPMhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 08:37:05 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51660 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751000AbWFPMhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 08:37:01 -0400
Message-ID: <4492A5E4.9050702@bull.net>
Date: Fri, 16 Jun 2006 14:36:52 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Tony Luck <tony.luck@intel.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de> <200606161209.25266.ak@suse.de> <44928FB1.5070107@sgi.com> <200606161317.19296.ak@suse.de> <44929CE6.4@sgi.com>
In-Reply-To: <44929CE6.4@sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 14:40:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 14:40:46,
	Serialize complete at 16/06/2006 14:40:46
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to make sure I understand it correctly...
Assuming I have allocated per CPU data (numa control, etc.) pointed at by:

	void *per_cpu[MAXCPUS];

Assuming a per CPU variable has got an "offset" in each per CPU data area.
Accessing this variable can be done as follows:

	err = vgetcpu(&my_cpu, ...);
	if (err)
		goto ....
	pointer = (typeof pointer) (per_cpu[my_cpu] + offset);
	// use "pointer"...

It is hundred times more long than "__get_per_cpu(var)++".

As we do not know when we can be moved to another CPU,
"vgetcpu()" has to be called again after a "reasonable short" time.

My idea is to map the current task structure at an arch. dependent
virtual address into the user space (obviously in RO).

	#define current	((struct task_struct *) 0x...)

No more need to for "vgetcpu()" at all. The example above becomes:

	pointer = (typeof pointer) (per_cpu[current->thread_info.cpu] + offset);
	// use "pointer"...

As obtaining "pointer" does not cost much, it can be re-calculated at
each usage => no problem to know when to recheck it, there is less chance for
using the data of a neighbor.

Regards,

Zoltan Menyhart
