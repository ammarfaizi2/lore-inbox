Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbQLESrE>; Tue, 5 Dec 2000 13:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbQLESqy>; Tue, 5 Dec 2000 13:46:54 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:51210 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130211AbQLESqq>; Tue, 5 Dec 2000 13:46:46 -0500
Date: Tue, 5 Dec 2000 12:12:06 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: NWFS mkfs.nwfs and fsck.nwfs tools issues -- need input
Message-ID: <20001205121206.A8487@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan,

I guess since my brain is 40+ years old and dying, I will keep getting
slower... and slower ..... integrating this into a release is about
4 times the work I had thought (GNU partspec -- what is mess!!!).  2.4
seems to have stopped changing and is very stable, and Linus appears
to have stopped playing in it so I am motivated to add this now for 
a 2.4 release since 2.4 is so stable.  I have had to do some things
to get around the inode mapping problem to work with Linux that really 
makes native NetWare stand on it's head.  

What I've done to support true Linux hard links and static inode 
numbers is to simply backlink changed records within a 4K directory
block to the new parent.  Oddly, there were some cases that would 
make Native NetWare break when it saw this, but I have tested this 
change now for about two months with every rev from 3.x through 5.x
NetWare, and have identified the cases where I need to recreate 
directory entries and move the file entries to a new block vs. 
just backlink them.  As it turns out, I can safely backlink any 
regular files, thereby preserving the directory relative number in
the dir file I use as a static inode number.   This was an extremely 
complex problem that required an enormous testing effort, since
NetWare always assumes all entries within a single 4K block are
owned by the same parent.  There were cases in the NFS server where
this was allowed to happen to support NFS on NetWare, and it is 
this behavior that I am exploiting.  As it turns our the only place I 
have to move directory entries is when I move deleted files to
the DELETED.SAV directory, which Linux is totally ignorant of 
in any event -- they just show up as new files, which is 
OK (it's not an implied mv (rename) operation since deleted 
files from a linux perspective are expected to disappear
from a volume).

I also eliminated all the in memory name hases except for the the root
DOS namespace and reduced memory usage by a factor of 10, and implemented 
the extended directory for 255 > character names.

I have modified anaconda to install NWFS partitions and am working on
Unix-like fsck.nwfs and mkfs.nwfs tools.  I've had to do some things
the linux way to get this working correctly.  Some issue, questions, 
need guidance stuff for the merge of this code.  

A).  NWFS doesn't use the "rule of 1" (1 partition - 1 file system) and
can stripe volumes, mirror volumes, etc.  

B).  In order to make install and most of the linux tools work properly,
I have to provide this "rule of 1" behavior.  

So there is a limitation for installing and using multi-segmented NWFS 
volumes on Linux for root filesystems, what I have done is set the 
default behavior to this:

mkfs.nwfs /dev/hda SYS   

just like the linux tools behave with ext2, however, this will always 
limit a root volume to one NetWare volume segment on one Linux partition,
and it should probably always by named "SYS" if it's the root, so MARS will
be able to provide default NetWare behavior.  This tool also allows 
NetWare volumes to be created in these funky Linux extended partitions
with a "rule of 1" behavior.

If people want to configure stripping, mirroring, multi-segmented volumes, 
or if they want to dynamically add segments to live root NWFS volumes,
The NWCONFIG tools let them do this after the fact or install.  If 
existing NetWare volumes exist on the server, I have modified the 
anaconda installer to look for SYS, and use it as the root volume 
for the linux install. 

I made fsck.nwfs a little smarter, and it can repair stripped and mirrored
volumes as well as these "linux clone" netware volumes on extended 
partitions.  

questions:

1.  Do I tar.gz the nwfs tools source base, and post as nwfs-utils.tar.gz 
separate from the patch, and will these be posted with the ext2 tools?  
Are you ready if I post NWFS to merge 2.2.18 patches?

2.  Will a 2.4 patch for NWFS be accepted this close to release.  It only
adds some config options and it'w own atomic code.  High and low water 
marks to adjust LRU memory usage key off variables in the OS, and I have
not needed to put in any patches to standard code -- I even got around the
512 buffer head thing. 

Jeff








-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
