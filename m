Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVI3Geh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVI3Geh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVI3Geg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:34:36 -0400
Received: from fmr19.intel.com ([134.134.136.18]:41133 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932557AbVI3Geg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:34:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Date: Fri, 30 Sep 2005 14:34:26 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84037191F2@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Thread-Index: AcXFAnH+TleJ7a/tS+6cPI/JAcUODwAg4Hsw
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Andi Kleen" <ak@suse.de>, <prasanna@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <systemtap@sources.redhat.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
X-OriginalArrivalTime: 30 Sep 2005 06:34:27.0193 (UTC) FILETIME=[013D8E90:01C5C589]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Andi Kleen [mailto:ak@suse.de]
>>Sent: 2005Äê9ÔÂ29ÈÕ 22:31
>>To: prasanna@in.ibm.com
>>Cc: Zhang, Yanmin; linux-kernel@vger.kernel.org; discuss@x86-64.org;
>>systemtap@sources.redhat.com; Keshavamurthy, Anil S
>>Subject: Re: [discuss] [PATCH] utilization of kprobe_mutex is incorrect on
>>x86_64
>>
>>On Thursday 29 September 2005 16:13, Prasanna S Panchamukhi wrote:
>>> >On Thu, Sep 29, 2005 at 08:43:44AM +0800, Zhang, Yanmin wrote:
>>> >>  <<kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch>> I found it
>>> >> when reading the source codes. Basically, the bug could break
>>> >> kprobe_insn_pages under multi-thread environment. PPC arch also has the
>>> >> problem.
>>> >
>>> >Can you describe what the problem actually is?
>>>
>>> Andi,
>>>
>>> The up()/down() orders are incorrect in arch/x86_64/kprobes.c file while
>>> trying to get/remove a kprobes instruction slot in arch_prepare_kprobe()
>>> and arch_remove_kprobe() routines. Zhang's patch corrects this.
>>
>>What I meant is that someone should describe why they are incorrect.
>>I could probably figure it out from the code, but in general the standards
>>for changelogs are higher than just "bla is wrong". It should be more like
>>"bla doesn't do X, so bad thing Y happens, which causes crash Z". Please
>>follow this in future patches.

Andy,
Sorry for lack of detailed explanation. What Prasanna said is correct.
The up()/down() orders are incorrect in arch/x86_64/kprobes.c file. kprobe_mutext is used to protect the free kprobe instruction slot list. arch_prepare_kprobe applies for a slot from the free list, and arch_remove_kprobe returns a slot to the free list. The incorrect up()/down() orders to operate on kprobe_mutex fail to protect the free list. If 2 threads try to get/return kprobe instruction slot at the same time, the free slot list might be broken, or a free slot might be applied by 2 threads. My patch fixes it.

