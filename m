Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279006AbRJ2Fh5>; Mon, 29 Oct 2001 00:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279019AbRJ2Fhs>; Mon, 29 Oct 2001 00:37:48 -0500
Received: from calais.pt.lu ([194.154.192.52]:57822 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S279006AbRJ2Fhe>;
	Mon, 29 Oct 2001 00:37:34 -0500
Message-Id: <200110290538.f9T5c5Q07069@hitchhiker.org.lu>
To: ptb@it.uc3m.es
cc: "linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Sun, 28 Oct 2001 21:57:59 +0100."
             <200110282057.f9SKvxo15573@oboe.it.uc3m.es> 
Date: Mon, 29 Oct 2001 06:38:05 +0100
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"A month of sundays ago Alain Knaff wrote:"
>> Appended to this mail is the "long live the struct block_device"
>> patch. It includes the stuff covered in the last patch as well. The
>> issue of stopping transfers in progress is not yet addressed.
>
>Errr .. haven't read the patches.

Please do ;-) Or maybe, rather browse the initial mails of this
thread, which discuss the problem being fixed here, and the reason why
that problem was there in the first place.

>But are you doing something so that
>the semantics of the action taken after a media check fails can
>be overridden? The current invalidate_inodes is too strong for me,
>since I am proxying a remote device, and I don't want to kill 
>_all_ the local file descriptors when the remote media disappears. 
>I need to at least continue to send down local ioctls!
>
>No, no suggestions of an extra control device, please. Simplicity.

Don't worry. This patch does not do anything like that. No extra
control device is introduced. No killing of local file descriptors in
case a remote media disappears. Please read the context of the post
(Subject: Poor floppy performance). The discussion has unfortunately
been stretched over more than a week, with long silences in between
(I've been busy with other stuff in between, and thus had to come back
later, sorry), so the initial messages might be somewhat hard to find,
but they're there in the archives:
http://www.uwsg.iu.edu/hypermail/linux/kernel/, in the week of Oct
16-23.


All the patch it does is address the following problem: if all file
descriptors pointing to a block device are closed, the cache is
closed, no matter whether the media has been changed or not... This
clearly leads to suboptimal performance, especially with slow devices
such as the floppy.

The reason for this behaviour was threefold
 1. Apparently, for some media, check_media_change is not reliable, so
the VFS people decided not to trust it (don't ask...). Hence the
kill_bdev call, invoked after the last close, to throw away all
buffers
 2. Kill_bdev is also needed to stop any read-aheads in progress after
last close (makes sense: if there is no open filedescriptors, those
read-aheads can no longer safely be served, because the device driver
may assume that nobody needs the device any longer and thus
de-allocate critical resources: IRQ, DMA, bounce buffers...)
 3. Cached pages are identified by the pair (inode,index), and the
block device backend inode changes after the last close.

All the can_trust_media_change part does is skip the kill_bdev if the
device driver says "yes, you _can_ trust the answer of
check_media_change" (fix problem #1).

Problem number 2 is not yet addressed, Alex Viro is working on a patch
(probably by having a variant of invalidate_bdev that just stops
transfers in progress, loudly warn about dirty pages, but without
killing clean cached pages)

Number 3 is fixed by making struct block_device "long
lived". Formerly, it only existed as long as there were active open
descriptors using it; now it exists as long as there are frontend
inodes referencing it.

Another related issue (not yet addressed by my patch), is what happens
after rmmod. Right now, with the patch, the cache is so long-lived
that it hangs around even after an rmmod...

Personnally, I don't really like the "check_media_change not trusted"
semantics either... we better handle flaky media change indicators
internally in the driver, especially since the driver may have its own
limited internal caching (DMA bounce buffers, track buffers, ...). But
apparently other people have strong feelings about the issue, having
been burned badly by devices which occasionnally miss a media
change..., and who have chosen to ginore check_media_change
altogether, rather than fix those device drivers...

>> +
>>  static struct block_device_operations floppy_fops = {
>>  	open:			floppy_open,
>>  	release:		floppy_release,
>>  	ioctl:			fd_ioctl,
>>  	check_media_change:	check_floppy_change,
>>  	revalidate:		floppy_revalidate,
>> +	can_trust_media_change: floppy_can_trust_media_change
>>  };
>
>and I'd like to have "invalidate" as a method too.
>
>Peter

Regards,

Alain
