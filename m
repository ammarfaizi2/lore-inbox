Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUISQBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUISQBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUISQBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:01:30 -0400
Received: from main.gmane.org ([80.91.229.2]:31202 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269262AbUISQAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:00:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: udev is too slow creating devices
Date: Sun, 19 Sep 2004 22:00:52 +0600
Message-ID: <cikaf1$e60$1@sea.gmane.org>
References: <414C9003.9070707@softhome.net>	<1095568704.6545.17.camel@gaston>	<414D42F6.5010609@softhome.net>	<20040919140034.2257b342.Ballarin.Marc@gmx.de>	<414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.78.110.194
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
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

It creates a temporary device node in its rootfs. It does so by looking 
into sysfs for major and minor numbers. So the question is whether the 
information is in sysfs at the moment when the kernel requests it.

> Why do you think mounting the root device is such a "frail" process?

Because of your own words below that "loading the driver might fail at 
any point *after* modprobe returns" (read: after module_init() finishes).

> The kernel blindly ties all known filesystem on the specified device.

yes, if it exists

> If the user specifies a wrong root device, or the device is broken or the
> filesystem corrupted or unknown the kernel will panic.
> The reason this is so is, that nothing else can be done. Userspace,
> however, has more possibilities.

OK. The fact is that, when mounting the root filesystem, the kernel can 
(?) definitely say "there is no such device, and it's useless to wait 
for it--so I panic". Is it possible to duplicate this logic in the case 
with udev and modprobe? If so, it should be built into a common place 
(either the kernel or into modprobe), but not into all apps.


> Instead of:
> modprobe ide-cd && mount /dev/hdc /mnt/cdrom
> in /etc/init.d/your-script
> 
> you would now do:
> if [ ACTION="add" ] && [ DEVNAME="/dev/hdc" ]; then
> 	mount /dev/hdc /mnt/cdrom
> fi
> in /etc/dev.d/default/your-script.dev
> 
> This is even more reliable than the first solution on a static /dev,
> since loading the driver might fail at any point *after* modprobe
> returns.
> For example, modprobe ide-cd will succeed even when no CD-ROMs are
> present. The old script would break in this case, the new one wouldn't be
> called at all.
<snip>
> You just have to adopt your approach to device handling. Currently you
> *assume* that after a succesfull modprobe the device nodes are available
> (this was never true, however).

Then the "char-major" aliases were always broken, do I understand 
correctly? Once we realize that, isn't it the time to mark the 
"Automatic kernel module loading" in the kernel configuration as BROKEN 
or OBSOLETE?

> With hotplug/udev you *know* that the device node is available when your
> script in dev.d is called with the appropriate environment variables.

Yes. Now we have a lot of short scriptlets under /etc/dev.d. But I don't 
yet see how these scriptlets interact with each other.

-- 
Alexander E. Patrakov

