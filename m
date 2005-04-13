Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVDMTDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDMTDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVDMTDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:03:22 -0400
Received: from s14.s14avahost.net ([66.98.146.55]:7096 "EHLO
	s14.s14avahost.net") by vger.kernel.org with ESMTP id S261202AbVDMTDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:03:10 -0400
Message-ID: <425D6CDD.3000004@katalix.com>
Date: Wed, 13 Apr 2005 20:02:53 +0100
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Ladislav Michl <ladis@linux-mips.org>
CC: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ds1337 4/4
References: <20050407231904.GE27226@orphique> <FxPJVIPZ.1112958526.4787880.khali@localhost> <20050408123545.GA4961@orphique> <4256C315.3000902@katalix.com> <20050410195120.GA5422@linux-mips.org> <20050410231006.0469a472.khali@linux-fr.org> <425C0F2F.2000807@katalix.com> <20050413110413.GA30618@orphique>
In-Reply-To: <20050413110413.GA30618@orphique>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: jchapman@katalix.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s14.s14avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ladislav Michl wrote:

> On Tue, Apr 12, 2005 at 07:10:55PM +0100, James Chapman wrote:
> [snip]
> 
>>It is used by the Radstone ppc7d platform, arch/ppc/radstone_ppc7d.c
>>but wasn't added until very recently (2.6.12-rc2 I think).
>>
>>To be honest, I meant to remove the 'id' thing before submitting the
>>driver. There's no need to support more than one of these devices.
> 
> Patch bellow remove ds1337_do_command function and things needed by it.
> I think device should be identified by bus and address as Jean said.
> Please let me know if that fits your needs.

I think you misunderstood what I meant by "remove the 'id' thing" 
(probably my fault). ds1337_do_command() is needed by ppc7d so don't 
remove it. I meant remove the id parameter from the call and change the 
ds1337 driver to support only one instance of the device.

> I'm assuming that you want to use drivers/char/genrtc.c to access ds1337
> from userspace, but in arch/ppc/platforms/radstone_ppc7d.c 
> ppc_md.get_rtc_time used by genrtc via get_rtc_time in asm-ppc/rtc.h
> is set to NULL (same for set_rtc_time) and I didn't find where (if)
> ds1337 registers to ppc_md.get_rtc_time.

For ppc at least, it's the platform code that hooks up get_rtc_time().
Last time I looked in -mm, get_rtc_time() and set_rtc_time() were being 
set up in ppc7d to use this driver. I won't be able to check until the 
end of the week so please bear with me.

> Functions in asm-ppc/rtc.h also do magic with tm_mon and tm_year
> so this driver doesn't need to handle epoch separately and doesn't need
> to be aware that tm_mon starts from zero...

I don't understand. What code in ds1337 is unneeded?

> m68k, mips and parisc does the same in asm/rtc.h unlike arm, so I this
> driver probably won't work for me without some tweaks to arm code.
> 
> [snip]
> 
>>>Back to the issue, some random thoughts summarizing my opinion:
>>>

[snip]

>>>3* Having the driver write an arbitrary non-0 value to the register
>>>should not be done unless the system has been identified. I have no idea
>>>how your system can be identified (DMI?), but if it can't, then I'd
>>>better see the register ignored altogether.
> 
> My board is OMAP (ARM core) based and there are ARM specific functions
> (if (machine_is_xxx()) do_something(); ), but it is not what you want to
> see in generic driver. It may be possible to use platform_data to pass
> information to driver, but I do not like this idea.
> 
> So, if we use entry in sysfs, then only root can write it and root is
> allowed to do weird things. Device itself refuses any action until high
> four bits are 0xa. If that is still not enough I just found this patch
> http://groups-beta.google.com/group/fa.linux.kernel/msg/06e0368f86c8f824
> so you can use configfs to explicitly create "charge" entry. (
> * I'm considering that an overkill
> * I'm not sure if it can be easily done with configfs)
> 
> I'd add config option (disabled by default) for "charge" entry, if you
> feel it is too dangerous. However I think that people should be a bit
> responsible for their actions and not writing any randoms values to any
> random files in /sys :)
> 
>>>4* Remember that you can always write a simple C tool relying on the
>>>i2c-dev interface to do the job. The advantage of this approach is that
>>>you can put big fat warnings and request user confirmation before any
>>>action.
>>
>>This makes sense. Ladislav, would this work for you? I guess we'd still
>>add code to the ds1337 driver to detect ds1339 in order to ensure that
>>this tool could not modify register 0 of a ds1337 by accident?
> 
> 
> Yes, that would definitely work for me and I'm fine with that in case
> proposal above would be rejected.

Ok. Jean, what do you think? Do we really want a "charge" sysfs entry? I 
don't have a strong opinion on this.

> Remove nowhere referenced ds1337_do_command function. Apply after ds1337
> patches 1-3.

Please don't apply this patch. I will modify the ds1337_do_command() API 
to remove the "id" parameter and fixup ppc7d platform accordingly.

/james
