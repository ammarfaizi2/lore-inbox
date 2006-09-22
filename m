Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWIVJGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWIVJGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWIVJGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:06:55 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:32459 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750745AbWIVJGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:06:55 -0400
Message-ID: <4513A7AC.9010709@free.fr>
Date: Fri, 22 Sep 2006 11:06:52 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.6) Gecko/20060405 SeaMonkey/1.0.4
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
CC: Joseph Fannin <jhf@columbus.rr.com>,
       Kernel development list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.18-rc7-mm1: no /dev/tty0
References: <20060921234151.2dd12d32@werewolf.auna.net>	<45130CF9.4060806@free.fr>	<20060921224049.GA2501@nineveh.rivenstone.net> <20060922004108.187a8a75@werewolf.auna.net>
In-Reply-To: <20060922004108.187a8a75@werewolf.auna.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22.09.2006 00:41, J.A. Magallón a écrit :
> On Thu, 21 Sep 2006 18:40:50 -0400, jhf@columbus.rr.com (Joseph Fannin) wrote:
> 
>> On Fri, Sep 22, 2006 at 12:06:49AM +0200, Laurent Riffard wrote:
>>> Le 21.09.2006 23:41, J.A. Magallón a écrit :
>>     Trimming CC's is generally frowned upon on LKML.

?? this is weird: I'm sure I used "reply to all", I checked the copy 
  in my sent-mail folder, your address were in the "to:" field.

>>>> When booting 2.6.18-rc7-mm1, the initscripts complain about /dev/tty0 not
>>>> being present. Then the boot sequence blocks...:
>>>>
>>>> Sep 21 23:23:57 werewolf init: open(/dev/console): No such file or
>>>> directory
>>>> Sep 21 23:24:07 werewolf last message repeated 17 times
>>>> Sep 21 23:24:12 werewolf init: Id "3" respawning too fast: disabled for 5
>>>> minutes
>>>>
>>>> (from syslog)
>>>>
>>>> The same userspace boots fine with -rc6-mm2.
>>>>
>>>> Any ideas ?
>>> Well, I have similar issues: when booting 2.6.18-rc7-mm1, some /dev
>>> files are missing:
>>> - /dev/kmem
>>> - /dev/kmsg
>>> - /dev/mem
>>> - /dev/port
>>> - /dev/ptmx
>>> - /dev/tty
>>>
>>> Setting CONFIG_SYSFS_DEPRECATED=y didn't help. My .config is attached.
>>> ~~
>>> laurent
>>     There were some problems with older versions of udev not creating
>> some device nodes with -mm kernels.  I don't know if this has been
>> fixed, or if it's the same as this:
>>
>> "- The kernel doesn't work properly on RH FC3 or pretty much anything
>>   which uses old udev, due to improvements in the driver tree."
>>
>>     I know that, several -mm's back, Ubuntu Dapper's udev 079 didn't
>> create /dev/alsa or /dev/psaux.
>>
> 
> Not mya case, at least:
> 
> werewolf:~> rpm -q udev
> udev-098-6mdv2007.0


Well, it may be a Mandriva issue.

udev version was udev-098-3mdv2007.0 here, I upgraded to 
udev-098-6mdv2007.0: no more luck.

I noticed the following difference between 2.6.18-rc6-mm2 and 
2.6.18-rc7-mm1:

with 2.6.18-rc6-mm2:
> # ls -ld /sys/class/mem/kmem
> drwxr-xr-x 2 root root 0 sep 22 10:47 /sys/class/mem/kmem/
> # ls -l /sys/class/mem/kmem
> total 0
> -r--r--r-- 1 root root 4096 sep 22 10:28 dev
> lrwxrwxrwx 1 root root    0 sep 22 10:47 subsystem -> ../../../class/mem/
> --w------- 1 root root    0 sep 22 10:41 uevent

and with 2.6.18-rc7-mm1:
> # ls -l /sys/class/mem/kmem
> lrwxrwxrwx 1 root root 0 Sep 22  2006 /sys/class/mem/kmem -> ../../devices/virtual/mem/kmem
> 
> # ls -al /sys/devices/virtual/mem/kmem:
> total 0
> drwxr-xr-x  3 root root    0 Sep 22  2006 .
> drwxr-xr-x 11 root root    0 Sep 22  2006 ..
> -r--r--r--  1 root root 4096 Sep 22  2006 dev
> drwxr-xr-x  2 root root    0 Sep 22  2006 power
> lrwxrwxrwx  1 root root    0 Sep 22  2006 subsystem -> ../../../../class/mem
> --w-------  1 root root 4096 Sep 22 09:25 uevent

There is an udev rule for kmem:
# grep kmem /etc/udev/rules.d/*
/etc/udev/rules.d/50-mdk.rules:KERNEL=="kmem", NAME="%k", MODE="0640"

This rule seems to be not triggered in rc7-mm1.
-- 
laurent
