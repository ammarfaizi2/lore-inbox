Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTATQRI>; Mon, 20 Jan 2003 11:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTATQRI>; Mon, 20 Jan 2003 11:17:08 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56632 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266120AbTATQRH>; Mon, 20 Jan 2003 11:17:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: tupshin@tupshin.com
Subject: Re: kernel bug in jfs, kernel 2.4.21-pre3-ac4 + recent listfix (fwd)
Date: Mon, 20 Jan 2003 10:26:09 -0600
User-Agent: KMail/1.4.3
References: <200301201605.h0KG5xB11833@shaggy.austin.ibm.com>
In-Reply-To: <200301201605.h0KG5xB11833@shaggy.austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301201026.09479.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:

> I was nfs sharing(kernel nfs) a jfs volume /data/old which is on an
> lvm partition (lvm1, not lvm2).
>
> I did an lvextend on the partition, and then tried to extend the jfs
> partition, while it was nfs shared (though nothing was actively
> reading or writing to it).
> The mount -o remount,resize command failed to extend the volume (note
> the first "jfs_extendfs: volume hasn't grown, returning") message
> below.

A recent change to JFS has the resize code determine the volume size 
from sb->s_bdev->bd_inode->i_size.  However, LVM doesn't update this 
size when resizing the volume, so JFS doesn't see the new size until 
the volume is completely unmounted and re-mounted.    A fix to revert 
to an earlier behavior that should work is in Marcelo's bk tree and 
will be available in -pre4.

> I then unmounted the volume from the machines that had it nfs
> mounted, and un-nfs-exported it. I then tried to remount,resize
> again, and had the same problem(note second message). I then
> unmounted the jfs partition completely, and it failed to mount it,
> claiming  incorrect partition type, yadda yadda.

It looks like you tried to mount the volume with the "resize" flag.  
This flag is only valid for remount, as the message in the log states.

>  Fsck.jfs was run,
> and didn't report any problems, but after running it, I was now able
> to mount the partition again, and resize it succesfully.
>
> I then re-exported it, nfs-mounted it remotely, and tried to copy
> files to it: kaboom...machine up, but BUG reported and access to
> filesystem hangs.

I'm sure this is a real bug in JFS.  I'll take a closer look at the code 
and let you know what I find.

> FWIW, volume was exported (rw,sync), and mounted
> (rsize=8192,wsize=8192,hard,nolock,intr), the nolock because I had
> earlier in the evening been having problems getting locks on nfs
> exported jfs volumes.

I suspect that NFS had nothing to do with the resize problems.  I wasn't 
aware of problems with locks & nfs on jfs volumes.  One more thing for 
me to look into.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

