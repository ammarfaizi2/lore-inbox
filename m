Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbTCHXJF>; Sat, 8 Mar 2003 18:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbTCHXJE>; Sat, 8 Mar 2003 18:09:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:8627 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262292AbTCHXJD>;
	Sat, 8 Mar 2003 18:09:03 -0500
Date: Sat, 8 Mar 2003 15:19:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: adilger@clusterfs.com, tytso@mit.edu, bzzz@tmi.comex.ru,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [Bug 417] New: htree much slower than regular
 ext3
Message-Id: <20030308151956.5ed1c05a.akpm@digeo.com>
In-Reply-To: <20030308224956.E1E4FF1859@mx12.arcor-online.net>
References: <11490000.1046367063@[10.10.2.4]>
	<20030307214833.00a37e35.akpm@digeo.com>
	<20030308010424.Z1373@schatzie.adilger.int>
	<20030308224956.E1E4FF1859@mx12.arcor-online.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2003 23:19:34.0061 (UTC) FILETIME=[2DDF95D0:01C2E5C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> Yes, I think that's exactly what's happening.  There are some questions 
> remaining, such as why doesn't it happen to akpm.

Oh but it does.  The 30,000 mkdirs test takes 76 seconds on 1k blocks, 16
seconds on 4k blocks.

With 1k blocks, the journal is 1/4 the size, and there are 4x as many
blockgroups.

So not only does the fs have to checkpoint 4x as often, it has to seek all
over the disk to do it.

If you create a 1k blocksize fs with a 100MB journal, the test takes just
nine seconds.

But note that after these nine seconds, we were left with 50MB of dirty
buffercache.  When pdflush later comes along to write that out it takes >30
seconds, because of the additional fragmentation from the tiny blockgroups.
So all we've done is to pipeline the pain.

I suspect the Orlov allocator isn't doing the right thing here - a full
dumpe2fs of the disk shows that the directories are all over the place. 
Nodoby has really looked at fine-tuning Orlov.

btw, an `rm -rf' of the dir which holds 30,000 dirs takes 50 seconds system
time on a 2.7GHz CPU.  What's up with that?

c01945bc str2hashbuf                                9790  61.1875
c0187064 ext3_htree_store_dirent                   10472  28.7692
c0154920 __getblk                                  11319 202.1250
c018d11c dx_probe                                  15934  24.2896
c018d4d0 ext3_htree_fill_tree                      15984  33.8644
c0188d3c ext3_get_branch                           18238  81.4196
c0136388 find_get_page                             18617 202.3587
c015477c bh_lru_install                            20493  94.8750
c0194290 TEA_transform                             21463 173.0887
c01536b0 __find_get_block_slow                     24069  62.6797
c0154620 __brelse                                  36139 752.8958
c01893dc ext3_get_block_handle                     43815  49.7898
c0154854 __find_get_block                          71292 349.4706

