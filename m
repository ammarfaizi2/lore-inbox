Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVDLTeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVDLTeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVDLTdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:33:38 -0400
Received: from s14.s14avahost.net ([66.98.146.55]:58834 "EHLO
	s14.s14avahost.net") by vger.kernel.org with ESMTP id S262496AbVDLSLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:11:18 -0400
Message-ID: <425C0F2F.2000807@katalix.com>
Date: Tue, 12 Apr 2005 19:10:55 +0100
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>, Ladislav Michl <ladis@linux-mips.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ds1337 4/4
References: <20050407231904.GE27226@orphique>	<FxPJVIPZ.1112958526.4787880.khali@localhost>	<20050408123545.GA4961@orphique>	<4256C315.3000902@katalix.com>	<20050410195120.GA5422@linux-mips.org> <20050410231006.0469a472.khali@linux-fr.org>
In-Reply-To: <20050410231006.0469a472.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: ahruschka@katalix.com,careers@katalix.com,info@katalix.com,jcarlson@katalix.com,jchapman@katalix.com,katalixc,lists@katalix.com,support@katalix.com,webmaster@katalix.com
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

Jean Delvare wrote:

>>Based on your and Jean's input, following so far sounds reasonable:
>>Create "charge" sysfs entry for ds1339 when it is detected. Do not
>>write any value to Trickle Charge register, until its value is written
>>to this entry.
> 
> While I admit I had this in mind in the first place, the more I think of
> it and the less I like it. It's slightly better than changing the
> charging rate right when loading the driver, but that's still dangerous.
> Users could write a value which doesn't match the hardware design, and
> bad things could happen.

I had assumed Ladislav wanted to be able to change this charge rate at
any time, which was the motivation behind adding ds1339 support.

>>How are you using this driver? There is non-static function
>>ds1337_do_command which expects id. How do you know which id belongs
>>to which chip?
> 
> I second this question, as it stroke me too. This function doesn't sound
> exactly usable to me. Identifying the device by bus and address would
> make more sense than an arbitrary id you have no way to learn about.

It is used by the Radstone ppc7d platform, arch/ppc/radstone_ppc7d.c
but wasn't added until very recently (2.6.12-rc2 I think).

To be honest, I meant to remove the 'id' thing before submitting the
driver. There's no need to support more than one of these devices.

>>Do you actually have machine with more than one ds1337?
>>Chip has fixed address, so only one can hang on one bus (am I right?)
> 
> You are.

Yep. I think the id should be removed asap.

> Back to the issue, some random thoughts summarizing my opinion:
> 
> 1* Initializing the battery charge register is a firmware/bios issue, as
> you underlined earlier. It would make sense (and would be easier) to
> just ignore it at the driver level.

Initializing the charge register should be done by the bios if possible.
However, I assume Ladislav still wants to be able to change the register
at runtime so some kernel support is needed?

> 2* If it makes sense to stop the charge, then we should provide a simple
> *switch* to the user, from the default charging register value (as
> previously set by the firmware/bios) to 0 and back. The switch would
> probably be a sysfs file unless a different API already exists.
>
> 3* Having the driver write an arbitrary non-0 value to the register
> should not be done unless the system has been identified. I have no idea
> how your system can be identified (DMI?), but if it can't, then I'd
> better see the register ignored altogether.
> 
> 4* Remember that you can always write a simple C tool relying on the
> i2c-dev interface to do the job. The advantage of this approach is that
> you can put big fat warnings and request user confirmation before any
> action.

This makes sense. Ladislav, would this work for you? I guess we'd still
add code to the ds1337 driver to detect ds1339 in order to ensure that
this tool could not modify register 0 of a ds1337 by accident?

/james


