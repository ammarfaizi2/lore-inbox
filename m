Return-Path: <linux-kernel-owner+w=401wt.eu-S1752410AbWLSErS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbWLSErS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWLSErR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:47:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41711 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752401AbWLSErR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:47:17 -0500
Date: Tue, 19 Dec 2006 15:47:00 +1100
From: David Chinner <dgc@sgi.com>
To: David Chinner <dgc@sgi.com>
Cc: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
Message-ID: <20061219044700.GW33919298@melbourne.sgi.com>
References: <Pine.LNX.4.64.0612120932220.19050@p34.internal.lan> <00ab01c71e53$942af2f0$0400a8c0@dcccs> <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs> <20061218223637.GP44411608@melbourne.sgi.com> <001a01c722fd$df5ca710$0400a8c0@dcccs> <20061219025229.GT33919298@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061219025229.GT33919298@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 01:52:29PM +1100, David Chinner wrote:
> On Tue, Dec 19, 2006 at 12:39:46AM +0100, Haar János wrote:
> > From: "David Chinner" <dgc@sgi.com>
> > > #define POISON_FREE 0x6b
> > >
> > > Can you confirm that you are running with CONFIG_DEBUG_SLAB=y?
> > 
> > Yes, i build with this option enabled.

......

> FWIW, I've run XFSQA twice now on a scsi disk with slab debuggin turned
> on and I haven't seen this problem. I'm not sure how to track down
> the source of the problem without a test case, but as a quick test, can
> you try the following patch?

Third try an I got a crash on a poisoned object:

[1]kdb> md8c40 e00000300d7d5100
0xe00000300d7d5100 000000005a2cf071 0000000000000000   q.,Z............
0xe00000300d7d5110 000000005a2cf071 6b6b6b6b6b6b6b6b   q.,Z....kkkkkkkk
0xe00000300d7d5120 e0000039eb7b6320 6b6b6b6b6b6b6b6b    c{.9...kkkkkkkk
0xe00000300d7d5130 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d5140 6b6b6b6f6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkokkkkkkkkkkk
0xe00000300d7d5150 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d5160 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d5170 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d5180 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d5190 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d51a0 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d51b0 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d51c0 6b6b6b6b6b6b6b6b 6b6b6b6b6b6b6b6b   kkkkkkkkkkkkkkkk
0xe00000300d7d51d0 6b6b6b6b6b6b6b6b a56b6b6b6b6b6b6b   kkkkkkkkkkkkkkk.
0xe00000300d7d51e0 000000005a2cf071 a000000100468c30   q.,Z....0.F.....
[1]kdb> mds 0xe00000300d7d51e0
0xe00000300d7d51e0 5a2cf071   q.,Z....
0xe00000300d7d51e8 a000000100468c30 xfs_inode_item_destroy+0x30

So the use-after-free here is on an inode item. You're tripping
over a buffer item.

Unfortunately, it is not the same problem - the problem I've just
hit is to do with a QA test that does a forced shutdown on an active
filesystem, and:

[1]kdb> xmount 0xe00000304393e238
.....
flags 0x440010 <FSSHUTDOWN IDELETE COMPAT_IOSIZE >

The filesystem was being shutdown so xfs_inode_item_destroy() just
frees the inode log item without removing it from the AIL. I'll fix that,
and see if i have any luck....

So I'd still try that patch i sent in the previous email...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
