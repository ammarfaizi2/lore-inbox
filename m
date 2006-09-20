Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWITNXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWITNXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWITNXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:23:40 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:47293 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751258AbWITNXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:23:39 -0400
Message-ID: <451140D3.2050301@hitachi.com>
Date: Wed, 20 Sep 2006 22:23:31 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, prasanna@in.ibm.com,
       Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> 	 <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> 	 <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> 	 <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> 	 <45110C6B.6010909@aitel.hist.no> <1158748226.7705.0.camel@localhost.localdomain>
In-Reply-To: <1158748226.7705.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:
> Ar Mer, 2006-09-20 am 11:39 +0200, ysgrifennodd Helge Hafting:
>> How about this workaround:
>> 1. Overwrite the start of the function with a hlt, which is atomic.
>> 2. Write that 5-byte jump after the hlt.
>> 3. Overwrite the hlt with nop so things will work
>> 4. interrupt any cpus that got stuck on the hlt - or just wait for the 
>> timer.
> 
> CPU errata time again. You have to synchronize.

Sure, and the djprobe which I had developed method can treat it as below;
1. Overwrite the 1st instruction with int3. (atomic)
2. Wait until all processes running on every cpus are scheduled.
   (I'm using synchronize_sched(). This step ensures no-one exist on
    the instructions which will be overwritten by the dest-addr)
3. Write the destination address
4. Interrupt any cpus to serialize those caches (using CPUID).
5. Overwrite the int3 with jmp opcode. (atomic)

In this method, the instructions are updated like below;
0. [ insn1 ][ insn2]
1. [int3]1 ][ insn2]
2. wait
3. [int3][ destaddr]
4. sync
5. [jmp to destaddr]

Actually, #2 is not enough for the preemptive kernel. So, current
djprobe doesn't support CONFIG_PREEMPT. But Ingo proposed some
good ideas (use freeze_processes()). I'll try his ideas.

What would you think about djprobe's method?

Thanks,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com



