Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279611AbRJ2XSu>; Mon, 29 Oct 2001 18:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279610AbRJ2XSl>; Mon, 29 Oct 2001 18:18:41 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63153 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S279612AbRJ2XS2>; Mon, 29 Oct 2001 18:18:28 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Simon Kirby <sim@netnation.com>
Date: Tue, 30 Oct 2001 10:51:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15325.60309.91155.683380@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>
Subject: Re: Oops: Quota race in 2.4.12?
In-Reply-To: message from Simon Kirby on Sunday October 28
In-Reply-To: <20011028215818.A7887@netnation.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 28, sim@netnation.com wrote:
> Some of our dual CPU web servers with 2.4.12 are Oopsing while running
> quotacheck.  They don't seem to die immediately, but oops many times and
> eventually break.  The old tools didn't warn about quotachecking on a
> live file system, so some of our servers were set up to run quotacheck
> nightly.  The new tools still allow you to do it, but warn that it may
> not be consistent.  We didn't have any problems with 2.2 kernels.

quotacheck cannot be reliable on a live system as it scans through the
filesystem counting the usage for each user and then updates the
quotas file.  If usage changes between scanning a file and updating
the quota record, you get an error.   This is particularly a problem
if quotacheck takes a long time, and on one of my servers (heavily
loaded NFS server) quotacheck takes a *long* time if the server is
live (it isn't exactly quick if it isn't live either).

I wrote a little program which uses libext2fs to scan the block device
for inodes and add up usage that way (as opposed to walking the
filetree as I believe quotacheck does).  It runs *much* faster
(minutes instead of hours).

What I have been doing lately is running it every few hours and having
it reports the differences that it found, rather then actually
changing anything.
Then I look for differences that have persisted over several runs.
These differences I assume are real differences and I correct them.

I find that I often gets tens of uids which have an apparent error on
a single run (due to changes happening during the run).  This drops to
less than ten that appear to have an error on each of two consecutive
runs.  Any uid that appears to have an error on three consecutive runs
is almost always truely in error.

I have included below the program that scans the filesystem and a
script that I use to run it and monitor the output.

The usage of the program is

    newquotacheck -[ugt] /dev/device /path/to/filesystem

It can compute one of uid (-u), gid (-g) or tid (-t) [see tree quotas
thread] quotas for the filesystem on the device.  The
/path/to/filesystem is only needed for the output.

The program produces output like:

   changequota -bu -12345 1002 /path/to/filesystem

which means change BlockUsage by subtracting 12345 for uid 1002 on
filesystem  "/path/to/filesystem".  I have a program called
changequota which does this.  

The program only copes with uids (and gids) less than 65536, and only
with ext2/ext3 filesystems.

The script runs newquotacheck every 8 hours, and keeps the output in
files called 
   quota.diff.$n
when $n is 0 for the most recent, 1 for the next most recent and so
on.  It then looks for uids that have changed on each for the past $n
runs, and records them in
   quota.changes.$n

The script is written for a non-standard shell. You might need to
translate, but I don't know 'bash' well enough to do it for you.
$[1:20] expands to all the numbers from 1 to 20.
$[arith-expression] expands to the value of the arithmetic expression.

I have been running this for about 2 weeks and had about 5 users with
errors of some sort.  I haven't looked deeply into what might have
caused the errors yet.

NeilBrown




---------------------cut------------here---------------------------
/*
 * calculate block/inode usage for each user
 * use libext2 to walk through inodes.
 */


#include <stdio.h>
#include <sys/quota.h>
#include "ext2fs/ext2_fs.h"
#include "ext2fs/ext2fs.h"

long blocks[65536];
long inodes[65536];

#ifndef TREEQUOTA
#define TREEQUOTA 2
#endif

main(int argc, char *argv[])
{
    int i;
    ext2_filsys fs;
    ext2_inode_scan scan;
    errcode_t err;
    ext2_ino_t ino;
    struct ext2_inode inode;
    char *dev, *fsn;
    int type=USRQUOTA;
    int arg = 1;

    if (arg<argc && strcmp(argv[arg], "-t")==0) {
	    type = TREEQUOTA;
	    arg++;
    } else if (arg < argc && strcmp(argv[arg], "-g")==0) {
	    type = GRPQUOTA;
	    arg++;
    }

    if (arg != argc-2) {
	    fprintf(stderr, "Usage: checkquota [-t|-g|-u] dev filesys\n");
	    exit(1);
    }

    dev = argv[arg];
    fsn = argv[arg+1];

    err = ext2fs_open(dev, EXT2_FLAG_FORCE, 0, 0, unix_io_manager, &fs);

    if (err) exit(1);

    err = ext2fs_open_inode_scan(fs, 10000, &scan);

    if (err) exit(2);

    while ((err = ext2fs_get_next_inode(scan, &ino, &inode)) != 123456)
    {
	    int id;
	if (err != 0) {
	printf("inode %d err %d\n", ino, err);
	}
	if (ino == 0 ) { break; }
	if (inode.i_mode == 0 ||
	    inode.i_dtime != 0) {
	    /*   printf("inode %d deleted\n", ino);*/
	    continue;
	}
	switch (type) {
	case USRQUOTA: id = inode.i_uid; break;
	case GRPQUOTA: id = inode.i_gid; break;
	case TREEQUOTA: id = inode.i_reserved2; break;
	}
	blocks[id] += inode.i_blocks;
	inodes[id] ++;
    }
    
    ext2fs_close_inode_scan(scan);

    for (i=1; i<65536; i++)
    {
	if (blocks[i] || inodes[i]) {
	    struct dqblk info;

	    if (quotactl(QCMD(Q_GETQUOTA,type), dev, i, (void*)&info)==0) {
		if (blocks[i] == info.dqb_curblocks*2
		    && inodes[i] == info.dqb_curinodes)
		    continue;
		printf("changequota ");
		if (blocks[i] != info.dqb_curblocks*2)
		    printf("-bu %s%d ",
			   blocks[i]/2 > info.dqb_curblocks?"+":"",
			   blocks[i]/2 - info.dqb_curblocks);
		if (inodes[i] != info.dqb_curinodes)
		    printf("-iu %s%d ",
			   inodes[i] > info.dqb_curinodes?"+":"",
			   inodes[i] - info.dqb_curinodes);
	    } else {
		printf("changequota -bu %d -iu %d ", i, blocks[i], inodes[i]);
	    }
	    printf(" %d %s\n", i, fsn);
	}
    }
    exit(0);
}

---------------------cut-----------here------------too------------------------
#!/usr/local/bin/ae

while :
do

 for i in $[1:20]
 do 
   n=$[20-i]
   if [ -f quota.diffs.$n ]
   then mv quota.diffs.$n quota.diffs.$[n+1]
   fi
 done

 /root/newcheckquota /dev/md0 /export/glass/1 > quota.diffs.0
 awk '{a=NF-1; print $a}' quota.diffs.0 | sort > quota.changes.0
 for i in $[1:20]
 do
   if [ -f quota.diffs.$i ]
   then
      awk '{a=NF-1; print $a}' quota.diffs.$i | sort | comm -12 - quota.changes.$[i-1] > quota.changes.$i
   else break;
   fi
 done
 sleep $[8*3600]
done

