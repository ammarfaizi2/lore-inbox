Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751970AbWG0UGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbWG0UGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbWG0UGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:06:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:12581 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751968AbWG0UGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:06:45 -0400
X-IronPort-AV: i="4.07,189,1151910000"; 
   d="scan'208"; a="106103679:sNHT1711749424"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Generic battery interface
Date: Thu, 27 Jul 2006 16:06:20 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Generic battery interface
Thread-Index: AcaxmTEBrrsMVRFSTcy0D56PeFpp9QAGTIUA
From: "Brown, Len" <len.brown@intel.com>
To: "Shem Multinymous" <multinymous@gmail.com>
Cc: "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       <vojtech@suse.cz>, "kernel list" <linux-kernel@vger.kernel.org>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 20:06:23.0976 (UTC) FILETIME=[22A1B680:01C6B1B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On 7/27/06, Brown, Len <len.brown@intel.com> wrote:
>> Path names and file names in sysfs are an API, so it is important
>> to choose them wisely.  The string "acpi" should not appear in
>> any path-name or file-name in sysfs that is intended to be generic,
>> as it would make no sense on a non-ACPI system.
>>
>> Neither the ACPI /proc/acpi/battery API or
>> the tp_smapi /sys/devices/platform/smapi API qualify as generic.
>> It it a historical artifact that /proc/acpi exists, I'd delete it
>> immediately if that wouldn't instantly break every distro on earth.
>
>Yes. But it looks like we'll have a hard time finding this common
>interface, due to overlaps and omissions between battery drivers.

Why not just specify the union of the different sets,
and those that don't implement parts leave those parts out?

>So I've proposed /sys/class/battery/{acpi,apm,thinkpad}/BAT?/* 
>as a comrpromise:
>A userspace app that only needs a generic voltage readout will try
>(all of) /sys/class/battery/*/BAT0/voltage. This is your generic
>interface.

If we have to export all these totally different implementations
via totally different paths, then we failed.

>A specialized app can be more specific and access
>/sys/class/battery/thinkpad/BAT0/force_discharge.
>
>And a complex system monitor like GKrellM will  let you configure a
>list of paths, e.g., /sys/class/battery/acpi/BAT0 +
>/sys/class/battery/mustek/UPS0.
>
>The only drawback I see is the inelegant userspace code for
>enumerating /sys/class/battery/* in languages like C. I suppose this
>could be wrapped by a trivial userspace library.

sysfs is great for demos from a shell prompt,
but isn't such a great programming interface, either
from inside the kernel or from user-space.

>> Vojtech suggested that we create a virtual battery interface,
>> just like the input layer has virtual input devices.
>[snip]
>> In either case, user-space would look for a well known set
>> of device file names, such as /dev/battery0, /dev/battery1
>> or some such, do a select on the file and get events that way.
>
>Isn't this an overkill? Battery status changes very slowly, so it
>seems perfectly adequate to have the usual userspace daemons poll the
>kernel every few seconds. No need for extra kernal event mechanisms,
>device file allocation, IOCTLs...

No need to poll for status that hasn't even changed.
This is what events are for.

Also, critical battery alarms are important events.

Please do not add more polling to user-space, else DaveJ
will be putting it up as a further example of "Why userspace sucks"
at the next OLS:-)

>> Drivers such as above could conjur up devices, and user-space
>> could also create what look like batteries, say through a
>> utility that knows how to talk to a UPS.
>
>Excellent idea, but it's orthogonal to the API issue. You might as
>well have  /sys/class/battery/usespace-battery/UPS0.

I think the question is where the GUI is going to go look for it.
I could imagine it would be simple for userspace to look for
/dev/battery0
/dev/battery1
/dev/battery2
until it finds no more, and then present the capacity of each
if it wants to.

-Len
