Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWCWDgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCWDgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWCWDgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:36:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:60186 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751399AbWCWDgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:36:49 -0500
X-IronPort-AV: i="4.03,120,1141632000"; 
   d="scan'208"; a="14836981:sNHT98175560"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Dual Core on Linux questions
Date: Wed, 22 Mar 2006 19:36:42 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dual Core on Linux questions
Thread-Index: AcZKecaULK6yPmo7QhCEEri/a1CylQDr9qaA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mattia Dongili" <malattia@linux.it>,
       "Alejandro Bonilla" <abonilla@linuxwireless.org>
Cc: "Jeff Garzik" <jeff@garzik.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Mar 2006 03:36:44.0705 (UTC) FILETIME=[01C78110:01C64E2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Mattia Dongili
>Sent: Saturday, March 18, 2006 2:49 AM
>To: Alejandro Bonilla
>Cc: Jeff Garzik; linux-kernel@vger.kernel.org
>Subject: Re: Dual Core on Linux questions
>
>On Sat, Mar 18, 2006 at 03:03:40AM -0600, Alejandro Bonilla wrote:
>> On Sat, 18 Mar 2006 03:58:22 -0500, Jeff Garzik wrote
>> > Alejandro Bonilla wrote:
>> > > Hi,
>> > > 
>> > > I have a few questions about the PM Dual Core and how 
>could it really work
>> > > with Linux. Sorry if there are new patches on LKML about 
>any of these things:
>> > > 
>> > > Could each processor or die, have it's own cpufreq 
>scaling governor?
>> > 
>> > Sure.  On a laptop, if you don't need dual core power, it makes 
>> > sense to turn off the unused core, even.
>> > 
>> > 	Jeff
>> 
>> Jeff,
>> 
>> For some reason, while I was writing this email, I knew you 
>would be the first
>> to reply. LOL. Anyway. Does this need new patches sent to 
>LKML or nice
>> commands to make this work or any idea if stock cpufreqd 
>should manage the
>> cores separatelly? I haven't got that to work on 2.6.15 so 
>far. How flexible
>
>no, currently cpufreqd applies the governor and limits to all available
>cpus. Is it really possible to run the 2 cores at different speeds?
>I definitely need to upgrade my hardware and get one of those dual core
>babies to play with.
>Oh, and BTW patches to cpufreqd are welcome in the meantime :)
>

>From cpufreq perspective multiple things are possible in the way
processor will support the multi-core frequency changing. and most of
the things are handled at cpufreq inside kernel. I think there should be
minima changes required in cpufreqd if any.
Options:
1) Multiple core can manage frequency independently: In this case,
cpufreq exports separate interfaces for each cpu in
/sys/devices/system/cpu/cpuX. So, cpufreqd should work as it would work
on an SMP system (Assuming that cpufreqd works fine on an SMP system
today ;-))

2) Multiple cores can be at a single frequency, but hardware will
coordinate between two cores internally (pick the highest frequency
request from two cores and run both of them at that frequency). This
will be very much similar to 1, in the way in which cpufreq and kernel
handles it.

3) Multiple cores can be at a single frequency and hardware depends on
OS to do the coordination, pick the maximum of all the requests from the
cores and set the frequency using appropriate hardware interface. This
is the case, where cpufreqd may need a change. In this case, say CPU 0
and 1 are two different cores on same package and they share frequency
and OS has to coordinate the freq request from these two CPUs. In this
case, /sys/devices/system/cpu/cpu1/cpufreq will be kind of a symbolic
link to /sys/devices/system/cpu/cpu0/cpufreq. Cpufreq tells that these
two are dependent by using "affected_cpus" in the same sysfs directory
(in this case "0 1"). Now, if cpufreqd does a set_speed on cpu0 and
cpu1, both CPUs will be affected. Cpufreqd should be aware that these
CPUs are dependent and change freq based on maximum utilization of these
two CPUs.

Thanks,
Venki
