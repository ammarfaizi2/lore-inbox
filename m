Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbTCMWTx>; Thu, 13 Mar 2003 17:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCMWTx>; Thu, 13 Mar 2003 17:19:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:34526 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262561AbTCMWTw>;
	Thu, 13 Mar 2003 17:19:52 -0500
Date: Thu, 13 Mar 2003 14:25:12 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-Id: <20030313142512.69f82864.akpm@digeo.com>
In-Reply-To: <m3of4fgjob.fsf@lexa.home.net>
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2003 22:30:24.0393 (UTC) FILETIME=[23CCB790:01C2E9B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> hi!
> 
> here is the new version of the patch.

This is great work.

a) The algorithm which you are using to distribute the root-reserved
   blocks across the blockgroups will end up leaving a small number of unused
   blocks in every blockgroup.  So large files which span multiple
   blockgroups will have little gaps in them.

   I think it's probably better to just lump all the root-reserved blocks
   into as few blockgroups as possible.

   Probably these should be the last blockgroups, because those are
   nearest the spindle, and hence the slowest.  This is by no means always
   the case - some disks are backwards, but it seems that most are not.  Plus
   nearness to the superblock is good.

b) struct ext2_bg_info needs a ____cacheline_aligned_in_smp stuck on it.

c) It looks like EXT2FS_DEBUG broke.  Nobody uses that much, but we should
   fix and test it sometime.

Be expecting some benchmark numbers.  Maybe those 32-ways will be able to run
as fast as my $300 2-way now ;)


