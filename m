Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUEDVtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUEDVtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUEDVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:49:16 -0400
Received: from fmr01.intel.com ([192.55.52.18]:15791 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261179AbUEDVtO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:49:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] mxcsr patch for i386 & x86-64
Date: Tue, 4 May 2004 14:47:11 -0700
Message-ID: <7F740D512C7C1046AB53446D37200173015DBDFC@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mxcsr patch for i386 & x86-64
Thread-Index: AcQyG+b236zq/g/fRIOAXAMQzlVcCAAAqgFw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>
Cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 04 May 2004 21:47:11.0950 (UTC) FILETIME=[5B40CEE0:01C43221]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jeff Garzik [mailto:jgarzik@pobox.com]
>Sent: Tuesday, May 04, 2004 2:08 PM
>Linus Torvalds wrote:
>> --- 1.19/arch/i386/kernel/i387.c	Tue Feb  3 21:30:39 2004
>> +++ edited/arch/i386/kernel/i387.c	Tue May  4 13:15:10 2004
>> @@ -24,6 +25,21 @@
>>  #define HAVE_HWFP 1
>>  #endif
>>
>> +static unsigned long mxcsr_feature_mask = 0xffffffff;
>
>> --- 1.10/arch/x86_64/kernel/i387.c	Fri Jan 23 12:17:58 2004
>> +++ edited/arch/x86_64/kernel/i387.c	Tue May  4 13:07:35 2004
>> @@ -24,6 +24,18 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/uaccess.h>
>>
>> +unsigned long mxcsr_feature_mask = 0xffffffff;
>> +
>
>
>Minor/dumb question:  Is the above intentional?
>
>Would be nice to have them the same for consistency if nothing else.
>i386 and x86-64 common code gets pasted and #include'd all the time.

If we look at set/get_fpu_xxx in i386 and x86-64, their codes are not
consistent; functions vs. macros. This is mainly because x86-64 can
assume the modern CPU features are available, and thus those are
simplified. 

It's not required to make mxcsr_feature_mask global on i386 because
nobody else is using it in other files, but I agree that it would be
better to make it global to avoid potential confusion/mistakes in the
future.

> ===== arch/i386/kernel/i387.c 1.19 vs edited =====
> --- 1.19/arch/i386/kernel/i387.c	Tue Feb  3 21:30:39 2004
> +++ edited/arch/i386/kernel/i387.c	Tue May  4 13:15:10 2004
> @@ -10,6 +10,7 @@
> ...
> -void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
> -{
> -	if ( cpu_has_xmm ) {
> -		tsk->thread.i387.fxsave.mxcsr = (mxcsr & 0xffbf);
> -	}
> -}
If we do this, then we should check if we can remove other (unused)
set/get_fpu_xxx to make i386 and x86-64 more consistent. For example,
set/get_fpu_fwd() are not used as far as I checked.

Jun

>
>	Jeff
>
>

