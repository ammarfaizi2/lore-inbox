Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUKEX0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUKEX0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUKEXQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:16:54 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:44959 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261258AbUKEXOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:14:38 -0500
Date: Sat, 6 Nov 2004 00:14:28 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers [u]
In-Reply-To: <1099694246.4450.11.camel@nosferatu.lan>
Message-ID: <Pine.LNX.4.60.0411060003550.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
  <20041103233029.GA16982@taniwha.stupidest.org> 
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> 
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> 
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>  <20041105014146.GA7397@pclin040.win.tue.nl>
  <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> 
 <20041105195045.GA16766@taniwha.stupidest.org>  <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
  <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net> <1099694246.4450.11.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004, Martin Schlemmer [c] wrote:

> On Fri, 2004-11-05 at 22:59 +0100, Grzegorz Kulewski wrote:
>>> The kernel does do more these days than it did in '95. But 6 times more? I
>>> dunno..
>>
>> Can't we remove ramfs for a good start? Everyone should use tmpfs instead
>> and some stupid distributions (I will not tell their names) try to mount
>> ramfs on /dev (udev) and that leads to very stupid panic if you will
>> write for example:
>>
>> dd if=/dev/evms/sda5 of=/dev/sda17 bs=1024
>>
>> instead of "of=/dev/evms/sda17".
>>
>> Explanation (if anybody needs one):
>> Kernel can't create more partition devices than 15 for SCSI and SATA disks
>> because of lack of minor numbers. So I am using evms to create these
>> devices. So I should use /dev/evms/sda* for these partitions. And if I
>> will not remember to do so then I will get oom panic very shortly because
>> ramfs is not limited (in contrary to tmpfs).
>>
>> And this kind of stupid mistake can happen. It happened to me 3 times in a
>> row before I started to debug what is wrong with this kernel.
>>
>> [BTW. Does somebody know how to tell the kernel that I do not want
>> /dev/sda[0-9]* files (but I do want /dev/hda files) created == I do not
>> want kernel partition driver to touch this particular device?]
>>
>
> So basically /dev/sda* have major of scsi, and /dev/evms/sda* have major
> of evms, and you end up using the wrong nodes?

Not exactly. I end up creating really big, growing, file on no limit RAM 
backed filesystem. EVMS locks standard devices, so I probably can not run 
something like:

dd if=/dev/sda5 of=/dev/sda6 bs=1024

because it will return "device busy" error or something like that. But I 
didn't test it. But I tested (in the most painful way) that

mount -t ext2 /dev/sda5 /mnt/foo

will not work because of this error.

And EVMS has no major numbers. It is purely user space. It uses 
device-mapper for creating devices and uses device-mapper's major number.

And yes, I probably can force UDEV to stop creating /dev/sda[0-9]* 
devices, but this is not the right solution I think. These config files 
are managed by my distribution and are complicated. I do not want to have 
to merge them with updates every time new UDEV is released. Besides I want 
to disable kernel partition discovery just for this device. This will be 
ugly excaption.


Thanks,

Grzegorz Kulewski

