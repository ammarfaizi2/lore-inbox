Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269248AbUISPJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269248AbUISPJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269251AbUISPJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 11:09:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:19146 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269248AbUISPJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 11:09:09 -0400
X-Authenticated: #1725425
Date: Sun, 19 Sep 2004 17:14:56 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: benh@kernel.crashing.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
In-Reply-To: <414D96EF.6030302@softhome.net>
References: <414C9003.9070707@softhome.net>
	<1095568704.6545.17.camel@gaston>
	<414D42F6.5010609@softhome.net>
	<20040919140034.2257b342.Ballarin.Marc@gmx.de>
	<414D96EF.6030302@softhome.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 16:25:51 +0200
Ihar 'Philips' Filipau <filia@softhome.net> wrote:

> 
>    Well, can then anyone explain by which mean (black magic?) kernel 
> mounts root file system? block device might appear any time, file system
> might take ages to load.

The kernel doesn't use /dev.
Why do you think mounting the root device is such a "frail" process?
The kernel blindly ties all known filesystem on the specified device.
If the user specifies a wrong root device, or the device is broken or the
filesystem corrupted or unknown the kernel will panic.
The reason this is so is, that nothing else can be done. Userspace,
however, has more possibilities.

> 
>    People, you must learn doing abstractions carefully. If device is 
> hard-wired - user *will* expect (as kernel itself does) that it is 
> available all the time after modprobe'ing driver.

It is available as long as the device node is present. udev tells you (in
dev.d) when this is the case. If the device is hardwired (from a user's
point of view) the device node will be created early dring boot-up. If
this happens, udev will notify the scripts in dev.d.

Instead of:
modprobe ide-cd && mount /dev/hdc /mnt/cdrom
in /etc/init.d/your-script

you would now do:
if [ ACTION="add" ] && [ DEVNAME="/dev/hdc" ]; then
	mount /dev/hdc /mnt/cdrom
fi
in /etc/dev.d/default/your-script.dev

This is even more reliable than the first solution on a static /dev,
since loading the driver might fail at any point *after* modprobe
returns.
For example, modprobe ide-cd will succeed even when no CD-ROMs are
present. The old script would break in this case, the new one wouldn't be
called at all.

Error reporting is very difficult. How should the kernel know what the
driver is supposed to do?
Obvious errors likes Oopses or I/O errors *could* be reported by hotplug.
(ACTION="error", DEVNAME="module-name" ???)
Anything else is impossible.

You just have to adopt your approach to device handling. Currently you
*assume* that after a succesfull modprobe the device nodes are available
(this was never true, however).
With hotplug/udev you *know* that the device node is available when your
script in dev.d is called with the appropriate environment variables.

Regards
