Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUISTk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUISTk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 15:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUISTk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 15:40:27 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:4298 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262406AbUISTkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 15:40:14 -0400
Message-ID: <414DE099.8040202@softhome.net>
Date: Sun, 19 Sep 2004 21:40:09 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>
CC: benh@kernel.crashing.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
References: <414C9003.9070707@softhome.net>	<1095568704.6545.17.camel@gaston>	<414D42F6.5010609@softhome.net>	<20040919140034.2257b342.Ballarin.Marc@gmx.de>	<414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
In-Reply-To: <20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin wrote:
> On Sun, 19 Sep 2004 16:25:51 +0200
> Ihar 'Philips' Filipau <filia@softhome.net> wrote:
> 
> 
>>   Well, can then anyone explain by which mean (black magic?) kernel 
>>mounts root file system? block device might appear any time, file system
>>might take ages to load.
> 
> 
> The kernel doesn't use /dev.

   True. But udev together with new loadable modules model was 
advertised as a /right/ replacement for devfs,

> Why do you think mounting the root device is such a "frail" process?
> The kernel blindly ties all known filesystem on the specified device.
> If the user specifies a wrong root device, or the device is broken or the
> filesystem corrupted or unknown the kernel will panic.
> The reason this is so is, that nothing else can be done. Userspace,
> however, has more possibilities.
> 

   You are right - kernel doesn't know.
   It is driver knows, It is user of driver who does know it too.

> 
>>   People, you must learn doing abstractions carefully. If device is 
>>hard-wired - user *will* expect (as kernel itself does) that it is 
>>available all the time after modprobe'ing driver.
> 
> 
> It is available as long as the device node is present. udev tells you (in
> dev.d) when this is the case. If the device is hardwired (from a user's
> point of view) the device node will be created early dring boot-up. If
> this happens, udev will notify the scripts in dev.d.
> 
> Instead of:
> modprobe ide-cd && mount /dev/hdc /mnt/cdrom
> in /etc/init.d/your-script
> 
> you would now do:
> if [ ACTION="add" ] && [ DEVNAME="/dev/hdc" ]; then
> 	mount /dev/hdc /mnt/cdrom
> fi
> in /etc/dev.d/default/your-script.dev

   Well, go to /etc/rc.d and try to integrate that with rest of system.
   The only right way of handling of such stuff I know - is FSM.
   Implementing FSMs in shell scripts - last thing I ever wanted. And I 
still cannot get how you are going to safely serialize /etc/dev.d/ 
callbacks against /etc/rc.d/ without polling.

> 
> This is even more reliable than the first solution on a static /dev,
> since loading the driver might fail at any point *after* modprobe
> returns.

   Untrue. Driver if something fails have a chance to return error from 
module_init() function, which will be passed to modprobe and then to callee.

> For example, modprobe ide-cd will succeed even when no CD-ROMs are
> present. The old script would break in this case, the new one wouldn't be
> called at all.
> 

   You are wrong. Hardware driver must fail, when hardware is not 
present/not detected. Simple as that.
   If ide-cd doesn't do that - it needs to be fixed.

> Error reporting is very difficult. How should the kernel know what the
> driver is supposed to do?

   Yes. Driver is not loaded without need. Kernel doesn't need driver - 
user need it to accomplish specific task.
   User knows what driver is meant for, especially when it loads it 
manually.
   If user will be told when driver is ready - user can verify that 
hardware in question is present.

> Obvious errors likes Oopses or I/O errors *could* be reported by hotplug.
> (ACTION="error", DEVNAME="module-name" ???)
> Anything else is impossible.
> 
> You just have to adopt your approach to device handling. Currently you
> *assume* that after a succesfull modprobe the device nodes are available
> (this was never true, however).
> With hotplug/udev you *know* that the device node is available when your
> script in dev.d is called with the appropriate environment variables.
> 

   What about scripts outside of /etc/dev.d/?

   If you ever mantained /etc/rc.d/rc - you will understand what I mean. 
Splitting system boot-up procedure will have some funny consequences. 
Debugging will be left as an execise for end-users. Running once fsck 
simultaneously on several partitions will cool your temper down.

   Again. FSM is no way to go for shell scripts. And shell scripts is 
what is used to manage system. Even /etc/dev.d/ scripts - are shell 
scripts, after all.

P.S. If you will add errors to /etc/dev.d/ scripts - than you will 
really end up with FSMs in shell scripts. You are welcome to try. I did 
once and failed.

P.P.S. Well, I will stop trolling. Honestly. Promise.
