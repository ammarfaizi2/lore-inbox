Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261564AbSIXFIb>; Tue, 24 Sep 2002 01:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbSIXFIa>; Tue, 24 Sep 2002 01:08:30 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:50149 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261564AbSIXFI3>; Tue, 24 Sep 2002 01:08:29 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andi Kleen <ak@muc.de>
Date: Tue, 24 Sep 2002 15:13:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.62593.58936.153791@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nanosecond resolution for stat(2) 
In-Reply-To: message from Andi Kleen on Monday September 23
References: <20020923214836.GA8449@averell>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 23, ak@muc.de wrote:
> 
> The kernel internally always keeps the nsec (or rather 1ms) resolution
> stamp. When a filesystem doesn't support it in its inode (like ext2) 
> and the inode is flushed to disk and then reloaded then an application
> that is nanosecond aware could in theory see a backwards jumping time.
> I didn't do anything anything against that yet, because it looks more
> like a theoretical problem for me. If it should be one in practice 
> it could be fixed by rounding the time up in this case.

Would it make sense, when loading a time from disk, for the low order,
non-stored bits of the time to be initialised high rather than low.
i.e. to 999,999,999 rather than 0.
This way time stamps would never seem to jump backwards, only
forwards, which seems less likely to cause confusion and will mean that a
change is not missed (I'm thinking NFS here where cache correctness
depends heavily on mtime).

Also, would it make sense, for filesystems that don't store the full
resolution, to make that forward jump appear as early as
possible. i.e. if the mtime (ctime/atime) is earlier than the current
time at the resoltion of the filesystem, then make the mtime appear to
be what it would be if reloaded from storage...  Maybe an example
would help.

Assuming an internal resolution on 1millisecond (to save on digits)
and a stored resolution of 1 second

time        change is made         Apparent timestamp 

23.100         X                      23.100
23.200                                23.100
23.300         X                      23.300
23.500         X                      23.500
23.900                                23.500
24.001                                23.999
25.000                                23.999

Thus the only incorrect observation that an application can make is
that there is an extra change at the end of a second when other
changes were made.  I think this is better than an apparent change
suddenly becoming visible many minutes after the time of that apparent
change, and definately better than a timestamp moving backwards.

NeilBrown
