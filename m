Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbVJGTMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbVJGTMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbVJGTMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 15:12:17 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:2908 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1030487AbVJGTMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 15:12:16 -0400
Message-ID: <4346C8A0.7030807@tls.msk.ru>
Date: Fri, 07 Oct 2005 23:12:32 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze (not even an OOPS) on remount-ro+umount when using
 quotas
References: <4346747C.2080903@tls.msk.ru> <Pine.LNX.4.58.0510071017550.7222@localhost.localdomain> <4346A46D.7010105@tls.msk.ru>
In-Reply-To: <4346A46D.7010105@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Steven Rostedt wrote:
> 
>> On Fri, 7 Oct 2005, Michael Tokarev wrote:
>>
>>
>>> This is something that has biten me quite successefully
>>> in last few days... ;)
>>>
>>> To make a long story short:
>>>
>>> # mke2fs -j /dev/hda6
>>> # mount -o usrquota /dev/hda6 /mnt
>>> # cp -a /home /mnt                # to make some files to work with
>>> # quotacheck -uc /mnt
>>> # quotaon /mnt
> 
> Looks like it's more reproduceable when there's some writing
> going on at this point - after enabling the quotas and before
> remointing it read-only.  Maybe there's some unwritten quota
> data left in memory at the remount, or something like that...

Yes it is:
   # quotaon /mnt; touch /mnt/file; mount -o remount,ro /mnt; umount /mnt
and voila, instant freeze.

>>> # mount -o remount,ro             # this is the important step!
>>> # ls -l /mnt /mnt/home            # to do "something" (also important)
>>> # umount /mnt
>>>
>>> At this time (attempting to umount the read-only filesystem with quotas
>>> enabled), the machine freezes without any messages on the console.  No
>>> OOPS, no response, no nothing - until a hard reboot (powercycle).
[]
> And hee-hoo, sysrq works!  Strange I haven't noticied it before - I think
> I tried it on the laptop, maybe I pressed some wrong button...
> 
> Now, as I don't have another PC here @home, only this machine and an ADSL
> router (small mips-based device wich is also running linux), and I will
> not have access to another machine(s) till monday... I'll try netconsole
> to the router.  Damn, why ShiftPgUp does not work as it worked in 2.4?? :(

Nope, my ADSL router is too slow to accept printks from netconsole, or
my PC is too fast (which isn't at all fast - it's a 900MHz VIA C3 system) --
sysrq+t output captured by the router (simple recvfrom()+write(tmpfs) loop)
is *very* incomplete, only shows about 50 lines for all the tasks running...
The device is 150MHz mips-el, texas instruments ar7 (avalanche/sangam) board.

Any suggestions on how to improve the logging? :)

But.  With the above sequence of commands, looks like the problem is pretty
easy to reproduce...

/mjt
