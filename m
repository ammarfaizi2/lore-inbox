Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWH3TkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWH3TkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWH3TkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:40:08 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:29175 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751395AbWH3TkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:40:06 -0400
Date: Wed, 30 Aug 2006 12:34:16 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sven Luther <sven.luther@wanadoo.fr>
cc: Olaf Hering <olaf@aepfle.de>, Michael Buesch <mb@bu3sch.de>,
       Greg KH <greg@kroah.com>, Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060830191544.GA17203@powerlinux.fr>
Message-ID: <Pine.LNX.4.63.0608301219520.31356@qynat.qvtvafvgr.pbz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> 
 <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>  <20060829183208.GA11468@kroah.com>
 <200608292104.24645.mb@bu3sch.de>  <20060829201314.GA28680@aepfle.de> 
 <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>  <20060830054433.GA31375@aepfle.de>
  <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz> 
 <20060830181310.GA11213@powerlinux.fr>  <Pine.LNX.4.63.0608301119170.31356@qynat.qvtvafvgr.pbz>
 <20060830191544.GA17203@powerlinux.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Sven Luther wrote:

>>>
>>> Do you really need to bring up ipw2200 so early ? It is some kind of
>>> wireless
>>> device, right ?
>>
>> if modules are not in use the device is initialized when the kernel starts
>> up. this is before any userspace starts.
>
> Well. but you could do the initialization at open time too, like the other
> case that was mentioned here, no ?

no, at least not in the current kernel. as was mentioned earlier in this thread 
the ipw2200 needs the firmware at initialization, but some others don't need it 
until open. I don't know if it's even possible to re-write the driver to do 
this.

>>> As for initramfs, you can just cat it behind the kernel, and it should work
>>> just fine, or at least this is how it was supposed to work.
>>
>> yes, if I want to set one up.
>>
>> other then this new requirement to have the ipw2200 driver as a module I
>> have no reason to use one. normal userspace is good enough for me.
>
> Well, ok.
>
> The real question seems to be if we want to keep the firmware inside the
> driver or not.
>
> If we want to remove it, then we put, not the module, but the firmware itself
> with some basic userspace to load it on demand in the initramfs, and this is
> reason enough to create an initramfs. The fact that the builtin device is
> initialized before the initramfs is loaded seems like a bug to me, since the
> idea of the initramfs (well, one of them at least), was to initialize it early
> enough for this kind of things.

this isn't my understanding.

my understanding is that the kernel fully initializes all built-in drivers, then 
loads userspace and starts running it.

that userspace can be on a device that it knows how to read, or it can be 
userspace on initramfs so that you can load additional modules to give you 
access to the hardware that you want to run on.

this is needed if your root drive is a SCSI drive and you have it's driver 
compiled as a module for example.

this is needed if your root drive uses dm and you need to initialize the array 
(one advantage of md, from the user standpoint, is that it doesn't require this 
additional layer before use)

however this is not soon enough to supply the firmware for devices like this.

> If on the other side, it is more important to not have an initramfs (because
> of security issues, or bootloader constraints or what not), then sure, there
> is not much choice than putting the firmware in the driver or in the kernel
> directly.
>
> But again, the initramfs is just a memory space available at the end of the
> kernel, and there is no hardware-related constraint to access it which are in
> any way different from having the firmware linked in together with the kernel,
> so it is only a matter of organisation of code, as well as taking a decision
> on the above, and to act accordyingly.

if the firmware needed for any drivers compiled in was appended to the kernel 
the same way that initramfs is, without requireing the other things needed to 
make initrmfs useable I think that would be reasonable (bundling them togeather 
as opposed to embedding the firmware in the kernel). it may even be possible to 
have the firmware as files in a initramfs that contains nothing else, and the 
kernel knows how to read the data directly (without the hotplug firmware request 
userspace stuff)

> Does using an initramfs really have some negative side, security related ?
> Would some kind of signed or encrypted initramfs be preferable there ?

adding an initramfs to a system that doesn't need it otherwise adds 
complications to the configure and boot process.

requireing modules when they weren't required before adds complication, and 
if/when the patch that's floating around to eliminate access to /dev/kmem is 
ever accepted, there are security advantages of running a kernel that doesn't 
have any support for run-time modifications (i.e. module loading).

I realize that many people want to make initramfs mandatory (with things like 
partition detection moved to userspace), but unless there is a standard 
initramfs that is shipped and maintained with the kernel to implement things 
like this (see the klibc discussion a few weeks ago) you are adding 
complications without much of a benifit to the user.

David Lang
