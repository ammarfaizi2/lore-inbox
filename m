Return-Path: <linux-kernel-owner+w=401wt.eu-S932463AbXARUMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXARUMA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXARUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:11:59 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:30616 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbXARUL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:11:59 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c/WrT/jbfEugz/2uB12TwM49PMSwbdMlwxlWYtsCyvGGglzffS+zTA71tywG96KMeuYF/lg2fwurvq4ZN5JagxVpieHlvy+R/6qS10EVHuMEaoR9Sk17tao39muqBcoA5E5ENocKXGi7jUj/G94ezQil48Fg4tbpaW0cMcPJdD8=
Message-ID: <d00698fb0701181211l480966e5o6f10db9300d4c8aa@mail.gmail.com>
Date: Thu, 18 Jan 2007 21:11:58 +0100
From: noah <noah123@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Data corruption with raid5/dm-crypt/lvm/reiserfs on 2.6.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm experiencing data corruption in the following setup:

1. mdadm --create /dev/md0 -n3 -lraid5 /dev/hda1 /dev/hdc1 /dev/hde1
2. cryptsetup -c aes-cbc-essiva:sha256 luksFormat /dev/md0 mykey
3. cryptsetup -d mykey luksOpen /dev/md0 cryptvol
4. pvcreate /dev/mapper/cryptvol
5. vgcreate vg0 /dev/cryptvol
6. lvcreate -n root  -L10G vg0
7. mkreiserfs -q /dev/vg0/root
8. mkdir /.newroot; mount /dev/vg0/root /.newroot
9. mkdir /.realroot; mount -o bind / /.realroot
10. tar cf - -C /.realroot|tar xvpf - -C /.newroot

With Linux 2.6.18 (it's broken, OK, but there's still something wrong
even in 2.6.19.2 so keep on reading) I started getting warnings from
ReiserFS indicating severe data corruptions.  Reiserfsck confirms
this.  It usually happened while extracting the Linux source tree.

So after asking around I found out dm-crypt had a bug[1] fixed in
early December.
It got fixed in 2.6.19 and the fix was backported and included in 2.6.18.6[2].

Fine, so I upgraded to 2.6.18.6, rebuilt the array from scratch and
did the whole procedure again.
No messages from reiserfs in dmesg this time, but reiserfsck still
revealed severe data corruption.
I also found compressed archives and ISO-images for which I had
md5sums to be corrupt.

I then upgraded to 2.6.19.2 with the exact same result as with 2.6.18.6.
I even verified this on a fairly new computer with different hardware
(Intel CPU and chipset).

Figured it maybe was some kind of race condition so on my second try
on 2.6.19.2, when recreating the array, I let md finish resyncing it
before copying over the files.
This time, reiserfsck didn't complain.

Just for the sake of fun, I did the whole thing again, rebuilding the
array from scratch, let md resync the third drive and then I started
to copy over all files again.  Thinking the cause of the problem was
heavy disk I/O I tried to stress the other LVM volumes residing on md0
using tar during the copy.  Everything seemed fine; no problems arose.

Did a few reboots and confirmed that reiserfsck didn't have any
complaints on any of the filesystems residing on the LVM volumes on
md0.

Started using the machine as normal, and half a day later I unmounted
the filesystems and ran reiserfsck just to make sure everything still
was OK.  Unfortunately, it wasn't.


The drives in the array are three brand new drives, 2x250GB and one
200GB, all three IDE drives.
According to SMART there's no problems with them.  And they worked
fine in my previous RAID1 setup with dm-crypt and LVM, by the way.
The computer itself is an Athlon XP with less than 1GB of RAM on a M/B
with nForce2 chipset FWIW.  No memory errors were detected with
memtest86+ (I completed the full test).
I haven't tried using another filesystem as I've got quite a lot of
faith in reiserfs's stability.

Is anybody else experiencing these problems?
Unfortunately I'm only able to do limited testing due to busy days,
but I'd love to help if I can.


[1] Here's a thread on the recently fixed data corruption bug in dm-crypt
http://article.gmane.org/gmane.linux.kernel.device-mapper.dm-crypt/1974

[2] The backport of the dm-crypt fix for 2.6.18.6 is here
http://uwsg.iu.edu/hypermail/linux/kernel/0612.1/2299.html
