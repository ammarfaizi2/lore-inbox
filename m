Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVLHBhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVLHBhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 20:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLHBhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 20:37:43 -0500
Received: from fmr19.intel.com ([134.134.136.18]:29389 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932464AbVLHBhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 20:37:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] Variable stopmachine_state should be volatile
Date: Thu, 8 Dec 2005 09:37:30 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8404210E76@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Variable stopmachine_state should be volatile
Thread-Index: AcX3FyKnyRKZ1LJdR+WciiNOD370YgEf3qog
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2005 01:37:31.0842 (UTC) FILETIME=[F4F77A20:01C5FB97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Arjan van de Ven [mailto:arjan@infradead.org]
>>Sent: 2005Äê12ÔÂ2ÈÕ 16:04
>>To: Zhang, Yanmin
>>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; Shah, Rajesh
>>Subject: Re: [BUG] Variable stopmachine_state should be volatile
>>
>>On Wed, 2005-11-30 at 10:04 +0800, Zhang, Yanmin wrote:
>>> The model to access variable stopmachine_state is that a main thread
>>> writes it and other threads read it. Its declaration has no sign
>>> volatile. In the while loop in function stopmachine, this variable is
>>> read, and compiler might optimize it by reading it once before the loop
>>> and not reading it again in the loop, so the thread might enter dead
>>> loop.
>>
>>cpu_relax() includes a compiler barier..... so... what's wrong with the
>>compiler that it ignores such barriers?

You are right. I hit the problem when I compiled kernel 2.6.9 on IA64 by intel compiler.
cpu_relax has the compiler barrier if we use gcc, but cpu_relax becomes just ia64_hint which is null when I use intel compiler to compile kernel on ia64. file include/asm-ia64/intel_intrin.h defines ia64_hint as null.

Function stopmachine in kernel/stop_machine.c uses cpu_relax to prevent compiler from moving the reading of stopmachine_state out of the while loop. But when we use intel compiler, cpu_relax doesn't work because it is just null.

The right approach is to define ia64_hint to ia64_barrier in file include/asm-ia64/intel_intrin.h. I tested the new approach and it does work.

Thank Arjan, Pavel, and Venki.

