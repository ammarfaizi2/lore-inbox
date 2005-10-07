Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbVJGQhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbVJGQhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVJGQhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:37:50 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:21839 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1030500AbVJGQht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:37:49 -0400
Message-ID: <4346A46D.7010105@tls.msk.ru>
Date: Fri, 07 Oct 2005 20:38:05 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze (not even an OOPS) on remount-ro+umount when using
 quotas
References: <4346747C.2080903@tls.msk.ru> <Pine.LNX.4.58.0510071017550.7222@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510071017550.7222@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 7 Oct 2005, Michael Tokarev wrote:
> 
> 
>>This is something that has biten me quite successefully
>>in last few days... ;)
>>
>>To make a long story short:
>>
>> # mke2fs -j /dev/hda6
>> # mount -o usrquota /dev/hda6 /mnt
>> # cp -a /home /mnt                # to make some files to work with
>> # quotacheck -uc /mnt
>> # quotaon /mnt

Looks like it's more reproduceable when there's some writing
going on at this point - after enabling the quotas and before
remointing it read-only.  Maybe there's some unwritten quota
data left in memory at the remount, or something like that...

>> # mount -o remount,ro             # this is the important step!
>> # ls -l /mnt /mnt/home            # to do "something" (also important)
>> # umount /mnt
>>
>>At this time (attempting to umount the read-only filesystem with quotas
>>enabled), the machine freezes without any messages on the console.  No
>>OOPS, no response, no nothing - until a hard reboot (powercycle).
>>
>>This happens on 2.6.11, 2.6.12 and 2.6.13 kernels -- ie, with "current"
>>kernel release.
> 
> I just tried this on 2.6.13.1 and was not able to reproduce your hangup.

I'm able to reproduce it on almost any my machine.  Tried on several
production machines first ;)  And on at least two test machines.
Now I'm at home and my home PC also shows this bug (2.6.13.1 vanilla).

> Have you tried turning on the nmi watchdog with "nmi_watchdog=2 lapic"?

nmi_watchdog makes no visible difference.  Lapic is already enabled, at
least on this machine (BTW, the same behaviour happens on SMP and UP
machines, with and without hyperthreading enabled).

> If this blocks interrupts while it spins, you might be able to see what's
> happening.  Also if interrupts are not blocked, try out sysrq-t and
> friends.

And hee-hoo, sysrq works!  Strange I haven't noticied it before - I think
I tried it on the laptop, maybe I pressed some wrong button...

Now, as I don't have another PC here @home, only this machine and an ADSL
router (small mips-based device wich is also running linux), and I will
not have access to another machine(s) till monday... I'll try netconsole
to the router.  Damn, why ShiftPgUp does not work as it worked in 2.4?? :(

/mjt
