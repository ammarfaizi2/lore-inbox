Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVAZBj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVAZBj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVAZBj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:39:58 -0500
Received: from fmr13.intel.com ([192.55.52.67]:471 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261918AbVAZBjy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:39:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: possible CPU bug and request for Intel contacts
Date: Tue, 25 Jan 2005 17:38:48 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB7506494302E88991@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: possible CPU bug and request for Intel contacts
Thread-Index: AcUC50DjRAX3Ue7FSIGH4j/hhkFOTwAXCs4w
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Kirill Korotaev" <dev@sw.ru>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Andrey Savochkin" <saw@sawoct.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jan 2005 01:38:50.0049 (UTC) FILETIME=[C90BEB10:01C50347]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <mailto:dev@sw.ru> wrote on Tuesday, January 25, 2005
6:12 AM:

> Hello Rohit,
> 
>>> BTW, can you explain why making pages non-global is the cure? Is it
>>> safe workaround for this bug?

>> There is a boundary condition that can have non-global pages
>> containing the CR3 load to also hit this issue on affected PIII. 
>> Though for this to happen, mov to cr3 has to be the very last
>> instruction on a page. And the page following that page (containing
>> CR3 load) has to have different mapping between user and kernel
>> spaces. 

> but in our case "mov %edx, %cr3" is not the last instruction on a
> page. 
> It is in the middle of it.

So, in this scenario (where trampoline code is mapped by non global
page), we will not hit this issue.

> Well, another remark is that after cr3 load there are only few
> instructions before the "call system_call_table(%edx)" which
> references 
> the page with different user and kernel mappings.
> 
> also, this bug can be cured via inserting about 20 simple operations
> between cr3 load and call to the page with overlapping mappings.
> 

This is not a recommended solution.

> I'm just trying to understand is it the bug referenced in E80 or not
> and 
> is it safe to use non-global mappings as a cure.

Our analysis has shown that this is E80 issue.  In this 4G-4G kernel
context, we are safe to use non-global mapping as a workaround for this
issue. (Or we can use any of the other recommendations given in the spec
update except rdtsc with global pages).

We have also seen that inserting rdtsc instruction is not a workaround.
We will update the spec update with this information.

On a little different note, while running the 4G-4G kernel on our
machine, we saw occasional hangs.  Those are root caused to the fact
that this kernel was first chaging the stack pointer from virtual stack
to kernel and then changing the CR3 to that of kernel.  Any interrupt
between these two instructions will result in those hangs as the
interruption handler will execute with user's CR3(as the kernel thinks
that it is already in kernel because of the value of esp).  Swapping the
order, first loading the CR3 with kernel and then switching the stack to
kernel fixes this issue.  Venki will generate that patch and send to
lkml.

Thanks, rohit

