Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSE3TyA>; Thu, 30 May 2002 15:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSE3TyA>; Thu, 30 May 2002 15:54:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19217 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316851AbSE3Tx6>; Thu, 30 May 2002 15:53:58 -0400
Message-ID: <3CF67594.9050507@evision-ventures.com>
Date: Thu, 30 May 2002 20:55:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <Pine.LNX.4.44.0205300826100.877-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 May 2002, Martin Dalecki wrote:
> 
>>LAST WARNING:
>>
>>Every body out there: watch out to use LABEL= in /etc/fstab or you will
>>not be able to reboot between 2.4 and 2.5 soon!
> 
> 
> Absolutely not, Martin. We need to have people be able to upgrade easily,
> we're already scaring away too many people from this.
> 
> 
>>1. Extract device registration from SCSI code.
>>
>>2. Let the ATA/ATAPI code hook up on it. (ide-cs is the most difficult one.)
>>
>>3. Let the old ATA/ATAPI major go down the bin...
> 
> 
> The minor/major numbers should stay the same, they are just "mappings".
> Device drivers shouldn't even care, and in fact we should aim for a setup
> where we have a new cleaned-up "disk major", but at the same time we
> should support the old major/minors so that people can easily use the same
> disk images across different kernel versions.
> 
> That should be fairly easy to do, by just making sure that we (a) remove
> the kdev_t from "struct request", (b) replace it with a controller and
> disk index and (c) make "open()" do some fairly trivial mapping and save
> that mapping in the "bdev", so that make_request() and friends can
> trivially just fill in the data.
> 
> Voila, end of minor/major problems, and you can suddenly do things like
> show the _same_ device on many minor/major numbers (so that you can have
> it _both_ on a backwards-compatible place _and_ a new cleaned-up place).
> 
> And the device drivers wouldn't ever even _know_ what device number the
> user saw on disk was.

I was more thinking along the way of the way ide-scsi is highjacking the
SCSI major numbers becouse the above scheme you describe would basically
mean the we just reinvent different major/minor numbers with just new names
"controller_index", and "disk_index" where due to the driver dispatching issues
the whole IDE mess would still just preveal under the hood.
But the goal should be more along the way of trying to
actually remove the usage of those arbitrary values all around inside the
kernel.

Plese note as well that there are other IDE alike interfaces which basically
already do the same: USB solidstate, and ParPort attached IDE disks come
first in to mind.

So it's absolutely worthwhile to extract the SCSI major number
registration code and to reuse it as a generic kind of thing.
At least it would relief the dependance of the above drivers on the
SCSI code. Of course here it would make much sense to preserve some
kind of double access to the IDE stuff. Alternatively *this*
could be indeed handled by a kind of generic mapping on
device open path, since basically those major numbers would
be obsoleted, but this is just a second tought. (Yes indeed LABEL isn't
supported on quite a lot of filesystems, so one can't hope
of it to resolve the beckward compatibility or dual boot issue.)

Anyway I'm looking at the ugly childs in blk.h alreay, so
basically the DEVICE_NR macro definitions show where once would have
to do go look after.



