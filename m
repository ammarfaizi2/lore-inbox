Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281200AbRKPDIS>; Thu, 15 Nov 2001 22:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281201AbRKPDII>; Thu, 15 Nov 2001 22:08:08 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11666 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281200AbRKPDHy>; Thu, 15 Nov 2001 22:07:54 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Fri, 16 Nov 2001 14:07:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15348.33549.67021.527467@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: synchronous mounts
In-Reply-To: message from Stephen C. Tweedie on Thursday November 15
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au>
	<20011115214525.C14221@redhat.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 15, sct@redhat.com wrote:
> Hi,
> 
> On Thu, Nov 15, 2001 at 12:03:57AM -0800, Andrew Morton wrote:
> > Linux is not syncing write() data for files on synchronously mounted
> > filesystems, and it isn't syncing write() data for ext2/3 files which
> > are operating under `chattr +S'.
> 
> In the past, chattr +S and mount -o sync always resulted in sync
> metadata with no guarantees about data. 
> 
> I'm not sure this makes much sense, but it's what has always happened.
> For directories, the behaviour is fine, in particular as it gives us
> the same directory sync consistency semantics as synchronous BSD UFS.  
> 
> It's not clear to me that chattr/mount sync options make _any_ sense
> for regular file metadata.  Rather than tightening up the semantics,
> I'd actually prefer to restrict them so that they only apply to
> directories.  Users who set the sync bits are usually doing so for
> applications like MTAs where it's directory syncing which is
> what matters: the apps typically fsync the files themselves, anyway.

Ok, but what about openning with O_SYNC?  Surely that should sync the data.

This issue came up because I was looking at how much disc activity the
various sync options causes on an ext3 filesystem, and on the journal
(which I had on a separate drive so I could differentiate journal IO
and filesystem IO).

You've probably already seen them on ext3-users, but I will repeat the
numbers below for linux-kernel readers.

If we forget about the "sync" mounts, as there is some question over
their intended semantics, the issue becomes that ext3 does not appear
to properly honour "fsync" in data=writeback mode (unless the data is
going to the journal on fsync) and does not properly honour O_SYNC
*except* in data=writeback mode.

Andrew's patch fixes O_SYNC in data=journal and data=ordered modes,
but does not fix fsync in data=writeback mode.

NeilBrown
-------------------------------------
Results:
For each test I wrote the first 40000 bytes of a pre-existing file 100
times and counted the nubmer of scsi operations (which may be
multi-block operations) on the filesytem device (first column) and the
journal device (second column).

For "async" I open, write, close  100 times.
For "fsync" I open, write, fsync, close 100 times.
For "osync" I open(,O_SYNC), write, close 100 times.

ext2 sync
     async         0    0
     fsync       200    0
     osync       101    0
ext2 async
     async         0    0
     fsync       200    0
     osync       101    0
ext3 sync,data=journal
     async         0  200
     fsync         0  300
     osync         0    2
ext3 async,data=journal
     async         0    0
     fsync         0  200
     osync         0    2
ext3 sync,data=ordered
     async       100  200
     fsync       100  300
     osync         0    0
ext3 async,data=ordered
     async         0    0
     fsync       100  200
     osync         1    2
ext3 sync,data=writeback
     async         0  200
     fsync         0  300
     osync       100    2
ext3 async,data=writeback
     async         0    0
     fsync         0  200
     osync       100    2
