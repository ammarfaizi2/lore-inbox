Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUAMGuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 01:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUAMGuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 01:50:20 -0500
Received: from stinkfoot.org ([65.75.25.34]:20923 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S263702AbUAMGuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 01:50:13 -0500
Message-ID: <40039529.2040709@stinkfoot.org>
Date: Tue, 13 Jan 2004 01:50:17 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Subject: Re: 2.6.1 and irq balancing
References: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D37200173618820@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:

>> Admittedly, the machine's load was not high when I took this sample.
>> However, creating a great deal of load does not change these statistics 
>> at all.  Being that there are patches available for 2.4.x kernels to 
>> fix this, I don't think this at all by design, but what do I know? =)
>>  

> 2.6 kernels don't need a patch to it as far as I understand. Are you
> saying that with significant amount of load, you did not see any
> distribution of interrupts? Today's threshold in the kernel is high
> because we found moving around interrupts frequently rather hurt the
> cache and thus lower the performance compared to "do nothing". Can you
> try to create significant load with your network (eth0 and eh1) and see
> what happens? 
> 
> Jun 

Here's the situation two days later, I created some brief periods of 
high load on eth1 and I see we have some change:


            CPU0       CPU1       CPU2       CPU3
   0:  184932542          0    2592511          0    IO-APIC-edge  timer
   1:       1875          0          0          0    IO-APIC-edge  i8042
   2:          0          0          0          0          XT-PIC  cascade
   3:    3046103          0          0          0    IO-APIC-edge  serial
   8:          2          0          0          0    IO-APIC-edge  rtc
   9:          0          0          0          0   IO-APIC-level  acpi
  14:         76          0          0          0    IO-APIC-edge  ide0
  16:    2978264          0          0          0   IO-APIC-level  sym53c8xx
  22:    7838940          0          0          0   IO-APIC-level  eth0
  48:     916078          0     125150          0   IO-APIC-level  aic79xx
  49:    1099375          0          0          0   IO-APIC-level  aic79xx
  54:   51484241        316   50560879        279   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:  187530735  187530988  187530981  187530986
ERR:          0
MIS:          0


My argument is (see below).  This is an old 2x pentium2 @400, also 
running 2.6, an old Compaq Proliant to be exact.  This machine obviously 
has no HT, so why the balanced load?


            CPU0       CPU1
   0: 1066522197 1117196193    IO-APIC-edge  timer
   1:         42         19    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   5:   23523428   23510845   IO-APIC-level  TLAN
   8:          0          4    IO-APIC-edge  rtc
   9:         15         15   IO-APIC-level  sym53c8xx
  10:    6874323    6809042   IO-APIC-level  sym53c8xx
  11:    7545802    7509034   IO-APIC-level  ida0
  14:          8          2    IO-APIC-edge  ide0
NMI:          0          0
LOC: 2183867261 2183867237
ERR:          0
MIS:          0



Ethan
