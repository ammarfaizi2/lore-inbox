Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUAGLSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265504AbUAGLSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:18:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50309 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265502AbUAGLSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:18:35 -0500
Date: Wed, 7 Jan 2004 11:18:32 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Olaf Hering <olh@suse.de>
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107111832.GL4176@parcelfarce.linux.theplanet.co.uk>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur> <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk> <20040107101559.GA22770@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107101559.GA22770@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:15:59AM +0100, Olaf Hering wrote:
> Now, thats just fine and it was always been that way.
> What if I chroot into /foo, proc is mounted on /foo/proc,
> and run fsck /dev/sda3 in that chroot? 
> That silly app looks for /etc/mtab (oh my...) and start the work.
> Fine. Now, /dev/root is in reality /dev/sda3. Bad for me.

Huh?
 
> the whole thing would work as expected of /proc/self/mounts would have
> a sane format:
> olh@melon:~> cat /proc/mounts
> 0:0 / rootfs rw 0 0
> 8:3 / ext3 rw 0 0
> proc /proc proc rw 0 0
> devpts /dev/pts devpts rw 0 0
> 58:0 /abuild ext3 rw 0 0
> 58:1 /data1 ext3 rw 0 0
> 58:2 /data2 ext3 rw 0 0
> shmfs /dev/shm shm rw 0 0
> automount(pid937) /suse autofs rw 0 0
> wotan:/real-home/jplack /suse/jplack nfs rw,nosuid,v3,rsize=8192,wsize=8192,hard,intr,tcp,nolock,addr=wotan 0 0
> wotan:/real-home/olh /suse/olh nfs rw,nosuid,v3,rsize=8192,wsize=8192,hard,intr,tcp,nolock,addr=wotan 0 0

It's *NOT* a sane format.

> Now fsck could look for /dev/sda3, realize that it is a block
> device node and look for that in the kernel mount table.
> If it is mounted, abort with a nice and meaningful error message.
> 
> So my question is: why was this strange format invented in the first place?
> And: will 2.7 get a sane /proc/self/mounts format for block devices?

Yes.  It already has one.

Note that you're not only adding ad-hackery (which filesystems get that
major:minor printed and which do not?), you *STILL* hadn't solved your
problem.  Why?  Because you still won't catch e.g. ext3 on /dev/sda5 with
external journal on /dev/sda3.  And if you hack parsing ext3 lines in
/proc/mounts, there's always reiserfs, jfs, etc., etc.  _And_ there's
RAID with the same problems wrt. access to components.  Real funny
when you have raid0 on md0, have md0 mounted and try to fsck one of
components.

Scanning /etc/mtab or /proc/mounts in such situations is wrong.  If fsck
is doing that, it's broken.  The right way to fix it depends on what you
really want and whatever the hell it is, putting new and new fs-specific
code that would parse /proc/mounts lines into fsck(8) is not an answer.
