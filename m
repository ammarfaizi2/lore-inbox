Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310813AbSCHSd0>; Fri, 8 Mar 2002 13:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310807AbSCHSdR>; Fri, 8 Mar 2002 13:33:17 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:7371 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S310813AbSCHSdL>; Fri, 8 Mar 2002 13:33:11 -0500
From: <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dalecki@evision-ventures.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend support for IDE
Date: Fri, 8 Mar 2002 19:33:23 +0100
Message-Id: <20020308183323.5029@mailhost.mipsys.com>
In-Reply-To: <E16jPEs-00073F-00@the-village.bc.nu>
In-Reply-To: <E16jPEs-00073F-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	while (HWGROUP(drive)->handler)
>> +		schedule();
>
>You need to yield. Remember the process might be hard real time and blocking
>your real work from occuring. while(foo) schedule() is always a bug
>
>> +static int idedisk_resume(struct device *dev, u32 level)
>> +{
>> +	ide_drive_t *drive = dev->driver_data;
>> +	if (!drive->blocked)
>> +		panic("ide: Resume but not suspended?\n");
>> +	drive->blocked = 0;
>> +}

I wouldn't do it this way in fact. The IDE disk is a device on the IDE
bus, so it's up to the IDE bus to get the PM requests, and pass them down
appropriately to the low level driver. The IDE common code has to make
sure any further request is properly blocked etc... Then, the controller
itself can eventually be suspended as well.

You can see code that blocks the IDE requests in ide-pmac sleep code,
it isn't perfect (I have a few known issues when waking up from sleep
with mounted CD/DVDs for example) but except from these it appear
to work well. It is currently specific to the pmac PM scheme, but I hope to
find time to port this over to the new macanism and make it more generic
in the future. That code is appropriate for what I need, you may, as Alan
states, need additional care to please your BIOS, like switching back to
PIO0, which means also updating your controller timings.

Ben.



