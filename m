Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRKTBWq>; Mon, 19 Nov 2001 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280130AbRKTBW1>; Mon, 19 Nov 2001 20:22:27 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:15211 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S279798AbRKTBWV>;
	Mon, 19 Nov 2001 20:22:21 -0500
Date: Tue, 20 Nov 2001 03:20:52 +0200 (EET)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: <lk@behemoth.ts.ray.fi>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: Patrick Mau <mau@oscar.prima.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
In-Reply-To: <E165yGL-00012u-00@localhost>
Message-ID: <Pine.LNX.4.33.0111200250560.18953-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm using kernel 2.4.15-pre6 and I can see my journal file
> > on '/'. Should I worry ?
> No, apparently the .journal file is visible if you created while the 
> filesystem is mounted, but invisible if you create it when the filesystem is 
> unmounted.

Minor corrections though, atleast on my 2.4.15-pre6 with tune2fs 1.23
the .journal is visible even when created as unmounted.
And it is not immutable, the only ext2 file attribute set is the "d"
(which refers to making it not a candidate for backup for dump,
 immutable would be "i", the source of all those funny
 # whoami
 root
 # ls foobar
 foobar
 # rm foobar
 rm: cannot unlink `foobar': Operation not permitted
 # echo "wtf?"). 

I was a bit surprised when the 'rm .journal' succeeded and removed it but 
I take it that just hides it and the inode is still kept for the journal.

(This removal would've happened anyway when my /tmp sweeps would've erased 
 it had I not known it's there to begin with)

Is the 'rm .journal' the way preferred way to "hide" it?
Are there any side-effects caused by removal?
Could someone shed a little more light on this subject.
What would happen if root were to write to it?

--------------- 8< ----------------- 8< -----------------

root@behemoth / # grep /tmp /etc/fstab
/dev/hda2               /tmp                    auto    defaults        1 2
root@behemoth / # grep /tmp /etc/mtab
/dev/hda2 /tmp ext3 rw 0 0
root@behemoth / # umount /tmp
root@behemoth / # tune2fs -O ^has_journal /dev/hda2
tune2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
root@behemoth / # mount /tmp
root@behemoth / # grep /tmp /etc/mtab
/dev/hda2 /tmp ext2 rw 0 0
root@behemoth / # umount /tmp
root@behemoth / # tune2fs -j /dev/hda2
tune2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Creating journal inode: done
This filesystem will be automatically checked every -1 mounts or
0 days, whichever comes first.  Use tune2fs -c or -i to override.
root@behemoth / # mount /tmp
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
root@behemoth / # ls -la /tmp | grep journal
-rw-------    1 root     root      8388608 Oct 23 17:10 .journal
root@behemoth / # lsattr /tmp/.journal
-----d------- /tmp/.journal
root@behemoth / # tune2fs
tune2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
...

--------------- 8< ----------------- 8< -----------------

root@behemoth / # cd /tmp
root@behemoth /tmp # rm .journal
root@behemoth /tmp # ls -la | grep journal
root@behemoth /tmp # cd ..
root@behemoth / # umount /tmp
root@behemoth / # tune2fs -j /dev/hda2
tune2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
The filesystem already has a journal.

-- 
  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */







