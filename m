Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273747AbRIQXHF>; Mon, 17 Sep 2001 19:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273749AbRIQXGz>; Mon, 17 Sep 2001 19:06:55 -0400
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:55567 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S273747AbRIQXGh>;
	Mon, 17 Sep 2001 19:06:37 -0400
Message-ID: <3BA68562.6030806@foogod.com>
Date: Mon, 17 Sep 2001 16:21:06 -0700
From: Alex Stewart <alex@foogod.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Forced umount (was lazy umount)
In-Reply-To: <Pine.LNX.4.21.0109171144210.1357-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:

> The forced umount patch has been available for ages and the latest version
> can be downloaded from:
> 
> http://www.moses.uklinux.net/patches/forced-umount-2.4.9.patch
> 
> If there are any issues with it please let me know.


Admittedly, I haven't tried it yet, but the one thing I can see that 
looks like an issue in the context of my original request is that if a 
filesystem's underlying device is having IO problems (bad hardware, 
etc), a forced umount using this patch will potentially also lock up (in 
a D state) trying to close up everything cleanly before unmounting it, 
contributing to the problem instead of fixing it.

I certainly understand (and tend to agree with) Alexander Viro's opinion 
that this is a 2.5 issue (my original post was just to make sure it was 
pointed out that we do still need to work on this), mainly with the 
following reasoning:

I see no reason why a properly functioning system should ever need to 
truly force a umount.  Under normal conditions, if one really needs to 
do an emergency umount, it should be possible to use fuser/kill/etc to 
clean up any processes using the filesystem from userland and then 
perform a normal umount to cleanly unmount the filesystem in question 
(or, with lazy umount, this could conceivably even be done in the 
reverse order).  The only reason for really-I-mean-it-forcing a umount 
is if there is some problem which has caused one or more processes to 
get permanently stuck in a state where they can't be killed (i.e. D 
state), and thus can't release their hold on the filesystem.  Ignoring 
NFS for the moment, assuming that the block device drivers are written 
correctly, there should be no way for anything to get stuck in disk-wait 
for an extended period of time unless there is an actual physical 
hardware problem preventing IO (I believe.. correct me if I'm wrong).

If there is a physical failure preventing IO to the underlying device, 
then it is very likely that any attempts made by the umount call to read 
from or write to the device will also block (unless there are some 
special hooks into the block device drivers to avoid this, which I 
assume there aren't).  Therefore, if a forced umount is actually 
required, it must not attempt to do any IO to the filesystem in question 
either, and must instead just tear down the kernel's structures 
associated with it, leaving the filesystem dirty on the disk, possibly 
losing data in the process.  This is why I had said in my first message 
that this should really only be a very last resort.

Now, a version of this patch which didn't attempt to actually do any IO 
on the device and modified umount (and presumably the various fs 
drivers) so it doesn't do any flushing, fs structure cleanup, etc, might 
be able to adequately do this, but given the degree of unchartedness in 
this territory, I can certainly sympathize with not wanting to put it 
into 2.4.

That's not to say that what the forced umount patch does isn't kinda 
nifty and convenient, and I would like to see this sort of functionality 
too, but it still doesn't really address the problem I was bringing up..

-alex

