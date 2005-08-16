Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVHPE6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVHPE6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVHPE6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:58:48 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:40126
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S932602AbVHPE6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:58:47 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>,
       Doug Warzecha <Douglas_Warzecha@dell.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 15 Aug 2005 23:58:43 -0500
Message-Id: <1124168323.10755.179.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to linux-kernel. Please cc me (and Doug) on all
replies. Sorry if I'm breaking peoples threading, but I am cut-and-
pasting this from web archives, since this wasn't cc-d to me
originally. 

>On Aug 15, 2005, at 19:38:49, Doug Warzecha wrote:
>> On Mon, Aug 15, 2005 at 04:23:37PM -0400, Kyle Moffett wrote:
>>> Why can't you just implement the system management actions in the  
>>> kernel
>>> driver?
>>
>> We want to minimize the amount of code in the kernel and avoid  
>> having to
>> update the driver each time a new system management command is added.
>
> One of the recent trends in kernel driver development is to make as much
> as possible accessible through standard tools (like with echo and cat  
> via sysfs).

Where it makes sense. Everything can be taken too far, and I believe
that you are taking this past the point of sanity. Are you also to
advocate that X stop mmap()-ing /dev/mem to manipulate PCI memory-space
of the video cards, but rather we should have a kernel driver that
makes every register of each PCI card available as a file in sysfs so
that we can re-write X as a big bash script? Let me know how that works
out.

>
>> The libsmbios project is being updated to use this code.  http:// 
>> linux.dell.com/libsmbios/main/.  Using the libsmbios code, you
>> will be able to set all of the options in BIOS F2 screen from Linux
>> userspace.  Also, libsmbios is looking at implementing a few other  
>> things
>> like fan status.  Libsmbios is 100% open-source (OSL/GPL dual  
>> license).
>
>  From my point of view, this driver could use sysfs almost entirely  
> and put
> all of the hardware-manipulation code completely in kernel space, along
> with the hardware detection code.  You could have plain-text files in
> /sys/bus/platform/dellbios/ that have all of the BIOS F2 options  
> accessible
> to the admin from the command line, without special tools.  (You could
> always add an extra program that presents a BIOS-like interface)

Conservatively counting, I see just about 350 different BIOS options in
my current list, plus about 60 different (unrelated) SMI calls. We are
talking about several tens of thousands of lines of code in the kernel
to surface each of these in the kernel along with all of the necessary
BIOS-bug-workaround and platform detection code. This is not pretty,
nor easy code. I, personally, do not want to be responsible for the
parsing bug that causes a root hole here. 

In userspace, I can easily stick all of the cross-references into an
XML file, along with the workarounds and bug-fixes, which makes the
code a bit tighter. We have one project here at Dell that implemented
an all C (userspace) equivalent of what you are talking about, and they
ended up writing a code generation script that took XML definitions of
each option and generated the resulting C code. They still ended up
with a huge bucketload of code. We don't have the same conveniences in
kernel-land. All the nice toys are userspace.

>> The method of generating a host control SMI is not exactly the same  
>> for
>> each PowerEdge system listed in dcdbas.txt.  host_control_smi_type  
>> tells
>> the driver how to generate the host control SMI for the system in use.
>> I'll update dcdbas.txt with the SMI type value associated with the  
>> systems
>> listed in that file.
>
> This is an _excellent_ reason why more of this should be in the kernel.
> What happens if the wrong SMI is used?  Shouldn't it be relatively easy
> for the kernel to determine the correct SMI itself?

No, this is an _EXCELLENT_ reason why _LESS_ of this should be in the
kernel. Why should we have to duplicate a _TON_ of code inside the
kernel to figure out which platform we are on, and then look up in a
table which method to use for that platform? We have a _MUCH_ nicer
programming environment available to us in userspace where we can use
things like libsmbios to look up the platform type, then look in an
easily-updateable text file which smi type to use. In general, plugging
the wrong value here is a no-op.

What you are advocating is that we bloat the kernel beyond belief just
so you can use echo and cat. I thought that we were trying to remove
extra stuff from the kernel. I thought this was the reasoning behind
initramfs and things like irqbalanced.

-- 
Michael


