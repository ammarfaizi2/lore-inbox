Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVDDXX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDDXX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDDXXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:23:03 -0400
Received: from Giotto.spidernet.net ([194.154.128.30]:19594 "EHLO
	mail0q.spidernet.net") by vger.kernel.org with ESMTP
	id S261501AbVDDXUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:20:25 -0400
Subject: Re: UPDATE: out of vmalloc space - but vmalloc parameter does not
	allow boot
From: Ranko Zivojnovic <ranko@spidernet.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1112625375.5680.45.camel@localhost.localdomain>
References: <1112577841.6035.40.camel@localhost.localdomain>
	 <1112625375.5680.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 02:20:06 +0300
Message-Id: <1112656806.9749.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I think I've figured it out so I will try and answer my own
questions (the best part is at the end)...

On Mon, 2005-04-04 at 17:36 +0300, Ranko Zivojnovic wrote:
> (please do CC replies as I am still not on the list)
> 
> As I am kind of pressured to resolve this issue, I've set up a test
> environment using VMWare in order to reproduce the problem and
> (un)fortunately the attempt was successful.
> 
> I have noticed a few points that relate to the size of the physical RAM
> and the behavior vmalloc. As I am not sure if this is by design or a
> bug, so please someone enlighten me:
> 
> The strange thing I have seen is that with the increase of the physical
> RAM, the VmallocTotal in the /proc/meminfo gets smaller! Is this how it
> is supposed to be?
> 

As the size of memory grows, more gets allocated to the low memory, less
to the vmalloc memory - within first 1GB of RAM.

> Now the question: Is this behavior normal? 
I guess it is (nobody said the oposite).

> Should it not be in reverse -
> more RAM equals more space for vmalloc?
> 

It really depends on the setup and the workload - some reasonable
defaults (i.e. 128M) have been defined - you can change them using
vmalloc parameter - but with the _extreme_ care as it gets really tricky
if your RAM is 1G and above - read on...

> With regards to the 'vmalloc' kernel parameter, I was able to boot
> normally using kernel parameter vmalloc=192m with RAM sizes 256, 512,
> 768 but _not_ with 1024M of RAM and above. 
> 
> With 1024M of RAM (and apparently everything above), it is unable to
> boot if vmalloc parameter is specified to a value lager than default
> 128m. It panics with the following:
> 
> EXT2-fs: unable to read superblock
> isofs_fill_super: bread failed, dev=md0, iso_blknum=16, block=32
> XFS: SB read failed
> VFS: Cannot open root device "md0" or unknown-block(9,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(9,0)
> 
And not just - I have just seen the actual culprit message (way up
front):
initrd extends beyond end of memory (0x37fef33a > 0x34000000)
disabling initrd

> Question: Is this inability to boot related to the fact that the system
> is unable to reserve enough space for vmalloc?
> 

The resolution (or rather workaround) to the above is to _trick_ the
GRUB into loading the initrd image into the area below what is _going_
to be the calculated "end of memory" using the "uppermem" command.

Now:
1. I hope this is the right way around the problem.
2. I hope this is going to help someone.

Best regards,

Ranko


