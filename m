Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288422AbSA2CZj>; Mon, 28 Jan 2002 21:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288531AbSA2CZa>; Mon, 28 Jan 2002 21:25:30 -0500
Received: from nat.overture.com ([208.50.18.5]:29118 "EHLO
	tiresias.corp.go2.com") by vger.kernel.org with ESMTP
	id <S288422AbSA2CZP>; Mon, 28 Jan 2002 21:25:15 -0500
Message-ID: <3C560804.C68BC6F4@overture.com>
Date: Mon, 28 Jan 2002 18:25:08 -0800
From: Xeno <xeno@overture.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4: NFS client kmapping across I/O
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond, thanks for the excellent fattr race fix.  I'm sorry I haven't
been able to give feedback until now, things got busy for a while.  I
have not yet had a chance to run your fixes, but after studying them I
believe that they will resolve the race nicely, especially with the use
of nfs_inode_lock in the recent NFS_ALL experimental patches.  FWIW.

Now I also have time to mention the other NFS client issue we ran into
recently, I have not found mention of it on the mailing lists.  The NFS
client is kmapping pages for the duration of reads from and writes to
the server.  This creates a scaling limitation, especially under
CONFIG_HIGHMEM64G and i386 where there are only 512 entries in the
highmem kmap table.  Under I/O load, it is easy to fill up the table,
hanging all processes that need to map highmem pages a substantial
fraction of the time.

Before 2.4.15, it is particularly bad, nfs_flushd locks up the kernel
under I/O load.  My testcase was to copy 12 100M files from one NFS
server to another, it was very reliable at producing the lockup right
away.  nfs_flushd fills up the kmap table as it sends out requests, then
blocks waiting for another kmap entry to free up.  But it is running in
rpciod, so rpciod is blocked and cannot process any responses to the
requests.  No kmap entries are ever freed once the table fills up.  In
this state, the machine pings and responds to SysRq on the serial port,
but just about everything else hangs.

It looks like nfs_flushd was turned off in 2.4.15, that is the
workaround I have applied to our machines.  I have also limited the
number of requests across all NFS servers to LAST_PKMAP-64, to leave
some kmap entries available for non-NFS use.  It is not an ideal
workaround, though, it artificially limits I/O to multiple servers. 
I've thought about bumping up LAST_PKMAP to increase the size of the
highmem kmap table, but the table looks like it was designed to be
small.

I've also thought about pushing the kmaps and kunmaps down into the RPC
layer, so the pages are only mapped while data is copied to or from
them, not while waiting for the network.  That would be more work, but
it looks doable, so I wanted to run the problem and the approach by you
knowledgeable folks while I'm waiting for hardware to free up for kernel
hacking.

Thanks,
Xeno
