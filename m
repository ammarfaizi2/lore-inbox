Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWFGHoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFGHoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFGHoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:44:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30421 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751110AbWFGHoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:44:14 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       "Brendan Trotter" <btrotter@gmail.com>
Subject: Re: NMI problems with Dell SMP Xeons 
In-reply-to: Your message of "Wed, 07 Jun 2006 09:20:23 +0200."
             <200606070920.23436.ak@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Jun 2006 17:43:47 +1000
Message-ID: <8446.1149666227@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on Wed, 7 Jun 2006 09:20:23 +0200) wrote:
>On Wednesday 07 June 2006 06:49, Keith Owens wrote:
>> Following a suggestion by Brendan Trotter, I ran some more tests to
>> track down the problem with sending NMI IPI on Dell Xeons.
>>
>> BIOS Logical    OS ACPI     Cpus    IPI 2             NMI IPI
>>  Processor                BIOS  OS                 (APIC_DM_NMI)
>>
>> Enabled         Enabled    4    4  Not delivered   Delivered as NMI
>> Enabled         Disabled   4    2  Machine reset   Machine reset
>> Disabled        Enabled    2    2  Not delivered   Delivered as NMI
>> Disabled        Disabled   2    2  Not delivered   Delivered as NMI
>>
>> So the killer combination with this motherboard is when the BIOS knows
>> about logical processors but the OS does not.  Sending IPI 2 or NMI IPI
>> with that combination kills the machine.  Brendan suggested that the
>> BIOS is seeing the broadcast NMI on the logical processors which are
>> not under OS control and that the BIOS cannot cope.
>
>How did you manage that? Normally the OS should use all CPUs
>known to BIOS. Or did you boot with special boot options to limit it?

Two ways:

(1) Boot with a kernel with CONFIG_ACPI=n, so the OS only finds 2 cpus
    in the MPT instead of the 4 listed by ACPI.

(2) The kernel has ACPI=y, but is booted with maxcpus=2.

In both cases, send_IPI_allbutself() with IPI 2 or an NMI will result
in a hard reset.

>> Should we change the x86_64 send_IPI_allbutself() so it is only
>> delivered to cpus that the OS knows about, instead of doing a general
>> broadcast. 
>
>Hmm, we should be doing that already to avoid races for CPU hotplug.  But 
>maybe it's not working correctly for KDB.

This problem is not KDB specific, although that is where it was first
noticed.  Any code that sends a broadcast IPI 2 or an NMI IPI will
crash these Dell boxes when there is a mismatch between the cpus known
to the BIOS and the cpus known to the OS.

>Does it go away when you
>enable CPU hotplug?

HOTPLUG_CPU was already on in all of my test kernels.

>Anyways, should be a SMOP to force it. I wouldn't
>have a problem to use sequence ipis  always and get rid of the broadcasts.
>There were benchmarks at some point and there wasn't a noticeable
>difference. 

I will try forcing send_IPI_allbutself() to use the mask version rather
than the broadcast shortcut.  Later tonight ...

