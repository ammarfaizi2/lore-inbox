Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVGVNIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVGVNIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVGVNIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:08:17 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:52484 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S261277AbVGVNIP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:08:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1122032491.22878.4.camel@tara.firmix.at>
References: <20050722_112730_062779.jdob@ig.com.br> <1122032491.22878.4.camel@tara.firmix.at>
X-OriginalArrivalTime: 22 Jul 2005 13:08:08.0381 (UTC) FILETIME=[67A64ED0:01C58EBE]
Content-class: urn:content-classes:message
Subject: Re: Kernel doesn't free Cached Memory
Date: Fri, 22 Jul 2005 09:06:35 -0400
Message-ID: <Pine.LNX.4.61.0507220904280.15626@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel doesn't free Cached Memory
thread-index: AcWOvmevsy6YzHeuQvm7ZTrcdtDdlw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Vinicius" <jdob@ig.com.br>
Cc: "Bernd Petrovitsch" <bernd@firmix.at>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005, Bernd Petrovitsch wrote:

> On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote:
> [...]
>>    I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, this
>> server runs lots of applications that consume lots of memory to. When I stop
>> this applications, the kernel doesn't free memory (the  memory still in use)
>> and the server cache lots of memory (~27GB). When I start this applications,
>> the kernel sends  "Out of Memory" messages and kill some random
>> applications.
>>
>>    Anyone know how can I reduce the kernel cached memory on RHEL 3 (kernel
>> 2.4.21-32.ELsmp - Trial version)? There is a way to reduce the kernel cached
>> memory utilization?
>
> Probably RedHat's support can answer this for RHEL 3.
>
> 	Bernd
> --
> Firmix Software GmbH                   http://www.firmix.at/
> mobil: +43 664 4416156                 fax: +43 1 7890849-55
>          Embedded Linux Development and Services
>




How do you know the memory is "still in use?"
I think that if you run a program that uses so
much memory that some swap is used, but not
allowing all free memory to be exhausted, you
can run the same program over and over again
forever. Therefore, the memory must have been
freed and available for the next time you
run the program.

The problem is that you are exhausting all
free memory causing the kernel to kill processes
just to stay alive. Then you look at some
memory "tool" and think that it shows something
about what is, or has been freed. You need
to set process limits on the amount of resources
each process can use and, depending upon the
implementation details of your "server", you
might even need to turn memory over-commit off:
  echo "0" > /proc/sys/vm/overcommit_memory

The fact is that unused memory is stored in
caches and buffers. That's how it doesn't
get wasted. In fact, with a busy system
an attempt is made to use all available
real RAM and minimize swap.

Some server programs are written much like
your defective test program. You can't
attempt to allocate all virtual memory
using malloc(), expecting it to return
NULL when there is no more. Malloc() will
return NULL when it has gotten trashed
by somebody overwriting buffer boundaries
or when address-space is exhausted.

It has no clue how much RAM is available
and, in fact if it did, it would represent
an information leak. Programs should
allocate what they need, not what they
can get.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
