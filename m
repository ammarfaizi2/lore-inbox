Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUD2Dtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUD2Dtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUD2Dtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:49:51 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:47263 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263124AbUD2Dtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:49:49 -0400
Date: Wed, 28 Apr 2004 22:53:23 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <20040428182443.6747e34b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
 <20040427230203.1e4693ac.akpm@osdl.org> <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
 <20040428124809.418e005d.akpm@osdl.org> <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
 <20040428182443.6747e34b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:

> Brent Cook <busterbcook@yahoo.com> wrote:
> >
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
> >      7 root      25   0     0    0     0 RW   99.4  0.0 415:26   0 pdflush
>
> This getting very irritating.  Cannot reproduce it with a 2.4 server, gcc
> 3.4.0, 2.6.6-rc3 client.  grrr.
>
> Could you please apply the below two patches, then wait for pdflush to go
> nuts, then do:
>
> 	echo 1 > /proc/sys/debug/0
> 	echo 0 > /proc/sys/debug/0
> 	dmesg -s 1000000 > foo
>
> then mail me foo?  It probably won't tell me much, but one has to start
> somewhere.
>

That seems like a good start. I compiled arts from KDE from an NFS
directory, and about 4 minutes into it, pdflush appears to be hung-up
writing a single inode. dmesg just contains this over and over:

...
sync_sb_inodes: write inode c55d25bc
__sync_single_inode: writepages in nr_pages:25 nr_to_write:949
pages_skipped:0 en:0
__sync_single_inode: writepages in nr_pages:25 nr_to_write:949
pages_skipped:0 en:0
sync_sb_inodes: write inode c55d25bc
__sync_single_inode: writepages in nr_pages:25 nr_to_write:949
pages_skipped:0 en:0
__sync_single_inode: writepages in nr_pages:25 nr_to_write:949
pages_skipped:0 en:0
sync_sb_inodes: write inode c55d25bc
....

After rebooting, I tried repeating the experiment compiling from /tmp and
pdflush behaved. It didn't matter whether the NFS share was mounted at the
time, just whether the source was compiled from the share or elsewhere.

FYI, my fstab on this test machine (the PIII with 256MB/i815 chipset) is
pretty boring:

/dev/hda1        swap             swap        defaults         0   0
/dev/hda2        /                reiserfs    defaults         1   1
ozma:/home       /home            nfs         rw               0   0
/dev/cdrom       /mnt/cdrom       iso9660     noauto,owner,ro  0   0
/dev/fd0         /mnt/floppy      auto        noauto,owner     0   0
devpts           /dev/pts         devpts      gid=5,mode=620   0   0
proc             /proc            proc        defaults         0   0
none             /sys             sysfs       defaults         0   0

The share is exported from the 2.4.25 server as follows:

/home snowball2(rw,async,no_root_squash)

 - Brent
