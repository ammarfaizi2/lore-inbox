Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUAESsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUAESsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:48:10 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:62878 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265269AbUAESsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:48:05 -0500
Date: Mon, 5 Jan 2004 10:47:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alex Buell <alex.buell@munted.org.uk>, linux-kernel@vger.kernel.org,
       riel@redhat.com, arjanv@redhat.com
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively enough  on low-memory PCs
Message-ID: <20040105184741.GA1882@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Alex Buell <alex.buell@munted.org.uk>, linux-kernel@vger.kernel.org,
	riel@redhat.com, arjanv@redhat.com
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk> <20040103103023.77bf91b5.jlash@speakeasy.net> <20040103145557.369a12c4.akpm@osdl.org> <Pine.LNX.4.58.0401040014360.4975@slut.local.munted.org.uk> <20040103190543.3b2d917f.akpm@osdl.org> <20040104072312.GM1882@matchmail.com> <Pine.LNX.4.58L.0401051531040.5618@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401051531040.5618@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 03:32:57PM -0200, Marcelo Tosatti wrote:
> 
> 
> On Sat, 3 Jan 2004, Mike Fedyk wrote:
> > Also, if there are any improvements considered for the 2.4 VM, it should be
> > on top of the -aa series.  That's where the latest updates are, and it
> > doesn't make sence to work from a base that already has seperate
> > improvements available.
> 
> The fix in -aa seems to reclaim inodes very aggressively. The 2.4 RH tree
> seems to contain a better version. Need to look into that.

http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-memory.html

Comparing[1] week 51 (2.4.23-rc5), and week 01 (2.4.23-aa1) would show that the
slab cache can grow larger for the same workload in -aa right now.

I have a backup that runs every day at 4-6am that is somewhat memory
intensive since it uses smbfs, (that's notorious for its bad memory usage
patterns) and it doesn't shrink the slab at all.  The only thing that
affected slab size was closing one of my mutt instances that was running on
a maildir folder with 28k messages in it on tuesday of week 01.



http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-swap.html

2.4.23-aa may or may not have problems with inode/dentry reclaim (I haven't
checked other workloads), but it sure improves the amount of swap I/O
performed.



Here's the top slab users right now:

inode_cache       456388 457304    512 57163 57163    1 : 534792 4012606
132385 68961    0 :  124

dentry_cache      626116 641116    136 22897 22897    1 : 731108 7905948
51318 27096    0 :  252  12

buffer_head       127878 132732    108 3684 3687    1 : 163476 29891760
62063 58376    0 :  252  126

size-64           137960 141934     72 2678 2678    1 : 152534 2392141  3263
585    0 :  252  126 :

vm_area_struct      5586   6600     76  124  132    1 :   8650 17144108
1294 1162    0 :  252  126

blkdev_requests     4096   4120     96  103  103    1 :   4640    5018
11613    0 :  252  126 :

size-4096             98     98   4096   98   98    1 :    827  264784
173433 173335    0 :   60   3


