Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281743AbRKVUkC>; Thu, 22 Nov 2001 15:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281740AbRKVUjn>; Thu, 22 Nov 2001 15:39:43 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:18159 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281739AbRKVUjX>; Thu, 22 Nov 2001 15:39:23 -0500
Date: Thu, 22 Nov 2001 20:39:10 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Tommi Kyntola <kynde@ts.ray.fi>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, Patrick Mau <mau@oscar.prima.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Message-ID: <20011122203910.D11821@redhat.com>
In-Reply-To: <E165yGL-00012u-00@localhost> <Pine.LNX.4.33.0111200250560.18953-100000@behemoth.ts.ray.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111200250560.18953-100000@behemoth.ts.ray.fi>; from kynde@ts.ray.fi on Tue, Nov 20, 2001 at 03:20:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2001 at 03:20:52AM +0200, Tommi Kyntola wrote:
 
> Minor corrections though, atleast on my 2.4.15-pre6 with tune2fs 1.23
> the .journal is visible even when created as unmounted.

There is absolutely no code in e2fsprogs to create that file on an
unmounted filesystem.  The only mention of the ".journal" name in
e2fsprogs-1.23 is in the code where it opens a regular file with that
name using normal syscalls to access mounted filesystems.  A
".journal" file might be an artifact resulting from doing a recursive
copy from an online-upgraded ext3 filesystem to the new one, though.

> Is the 'rm .journal' the way preferred way to "hide" it?
> Are there any side-effects caused by removal?
> Could someone shed a little more light on this subject.
> What would happen if root were to write to it?

The .journal is an immutable file.  Root will get -EPERM.

> root@behemoth / # tune2fs -O ^has_journal /dev/hda2
> tune2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
> root@behemoth / # mount /tmp
> root@behemoth / # grep /tmp /etc/mtab
> /dev/hda2 /tmp ext2 rw 0 0
> root@behemoth / # umount /tmp
> root@behemoth / # tune2fs -j /dev/hda2
> root@behemoth / # ls -la /tmp | grep journal
> -rw-------    1 root     root      8388608 Oct 23 17:10 .journal

Just clearing the "has_journal" flag from an online-upgraded
filesystem won't be enough to delete the .journal file.  

"dumpe2fs" will tell you what inode the filesystem is actually using
for the journal: I suspect it won't be using that .journal file.

Cheers,
 Stephen
