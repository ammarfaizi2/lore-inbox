Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVHPXMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVHPXMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVHPXMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:12:25 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:62747 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750724AbVHPXMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:12:24 -0400
X-IronPort-AV: i="3.96,114,1122872400"; 
   d="scan'208"; a="280493279:sNHT8865279484"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20050816203706.GA27198@kroah.com>
Content-class: urn:content-classes:message
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Tue, 16 Aug 2005 18:11:13 -0500
Message-ID: <4277B1B44843BA48B0173B5B0A0DED43528192@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Thread-Index: AcWit/OJAvUhE+yLSb26vxLQ9oUv6A==
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com> <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com> <1124161828.10755.87.camel@soltek.michaels-house.net> <20050816081622.GA22625@kroah.com> <1124199265.10755.310.camel@soltek.michaels-house.net> <20050816203706.GA27198@kroah.com>
From: <Michael_E_Brown@Dell.com>
To: <greg@kroah.com>
Cc: <mrmacman_g4@mac.com>, <linux-kernel@vger.kernel.org>,
       <Douglas_Warzecha@Dell.com>, <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 16 Aug 2005 23:12:27.0110 (UTC) FILETIME=[F7DD0860:01C5A2B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Aug 16, 2005 at 08:34:24AM -0500, Michael E Brown wrote:
>  
>
>>On Tue, 2005-08-16 at 01:16 -0700, Greg KH wrote:
>>    
>>
>>>No, export this data properly through sysfs like all other temperature
>>>and sensor data is.  Don't create a new one, no matter how much you
>>>would like to keep from changing kernel code in the future for new
>>>hardware.
>>>      
>>>
>>This driver is not trying to create a new way to do sensor and monitor
>>data. This just happens to be a side effect of the main use case.
>>    
>>
>
>But it's probably a main use case for a lot of users daily experience,
>right?
>
>  
>
No. And after this feedback, I'll be trying to make sure this doesn't 
happen.

There are two main users of this driver (dcdbas) at this point.

1) libsmbios.
    The main use of this driver by libsmbios will be to set BIOS F2 
options. Based on your feedback, I will _NOT_ be implementing any 
fan/sensor functionality in libsmbios, but will work with the lmsensors 
guys to do this instead. I only originally mentioned it because I 
thought it would be useful. My eyes have now been opened as to the best 
way to do this, and we will do it that way.

2) Dell OpenManage
    The main use of this driver by openmanage will be to read the System 
Event Log that BIOS keeps. Here are some other random relevant points:
    A) The sensor functions available through Dell SMI calls are only on 
laptops at this point.
    B) OpenManage is not supported on laptops (server only)
    C) OpenManage is transistioning to use openipmi to do all 
sensor-related stuff, so there is no need to use SMI.

All this adds up to the fact that neither of the two official Dell apps 
that use this Dell SMI driver will be using this driver for _ANY_ type 
of sensor functionality, and there is no danger at all of either of 
these apps ever growing this functionality.  So out of the many SMI 
functions available for use using this driver, only about 3 or 4 would 
be commonly used officially by Dell.

In the meantime, as a community service, I have offered up libsmbios to 
document the other many functions available using SMI to anybody who 
thought they would be useful (as several people have privately emailed 
me). Based on the availability of this extra functionality (sensors) the 
whole submission of dcdbas driver is being questioned.  I would like to 
re-iterate at this point what I said in one of my first emails. 
Everything that you can do using this dcdbas driver can already be done 
"under the covers" in userspace with the right incantations. (ie. set 
processor affinity, pick a BIOS reserved area as your physical buffer).  
What you get by using the dcdbas driver is an auditable entry point in 
the kernel for anybody wanting to do one of these SMI calls. If the 
dcdbas driver is accepted, all Dell software that does SMIs will use it. 
Then, anybody who is curious about which SMI calls that Dell software is 
performing can simply add logging hooks to dcdbas to syslog the contents 
of each buffer passed. People who think they are making things "safer" 
by restricting userspace access to SMIs are only deluding themselves.

>>>>For example, we already have at least one buggy implementation of this
>>>>exact stack in the kernel as the i8k driver. The i8k driver was reverse-
>>>>engineered and works, but it does not follow the spec at all, and so is
>>>>subject to major breakage if the BIOS changes. With dcdbase + libsmbios,
>>>>we can write this _correctly_, and in such a way that it follows the
>>>>spec and will not break on BIOS updates.
>>>>        
>>>>
>>>No, fix the i8k driver as you have access to the specs.  It was there
>>>first.
>>>      
>>>
>>Ok.
>>    
>>
>
>On second thought, after looking at that code, forget it, just do
>something new with the proper hwmon interface instead.
>  
>
Ok.

>>>>Each function would have to take into account the specific calling
>>>>requirements of that specific function.
>>>>        
>>>>
>>>Again, no different from any other sensor driver.
>>>      
>>>
>>Again, this driver is not a sensor driver. 
>>    
>>
>
>You provide sensor data, hence...
>
>  
>
I cannot go back and undo the way BIOS has designed this interface. It 
just so happens that by providing a generic way to get the data I want, 
you also can get at some other, unrelated stuff. We promise we won't use 
this interface to get that unrelated stuff, (as silly as that sounds).

>>For some odd reason, our customers have less concerns with updating a
>>userspace library. 
>>    
>>
>
>For a library like this, they should be just as concerned, as you have a
>direct hook into their hardware, with the ability to break it just as
>easily as a kernel update.
>
>  
>
Not really. None of the SMI calls that I am aware of has any ability to 
affect the running of the system with the exception of the Radio control 
and Display switching calls. It would most likely be best to give the 
docs for these to the appropriate driver people to implement in their 
drivers.

Most of the SMI options affect boot stuff, like boot order. None of the 
SMI calls interface with the kernel at all. I don't really see how any 
of the calls available through this interface can do any damage to hardware.

And just to re-iterate one more time, we can already directly hook into 
hardware from userspace without any kernel auditing. We are just trying 
to set this out on the table for everybody to see.
--
Michael
