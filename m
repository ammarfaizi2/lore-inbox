Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbTBBX5T>; Sun, 2 Feb 2003 18:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbTBBX5S>; Sun, 2 Feb 2003 18:57:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:23966 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265816AbTBBX5R>;
	Sun, 2 Feb 2003 18:57:17 -0500
Date: Sun, 2 Feb 2003 16:06:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.4, 2.5: SMP race: __sync_single_inode vs. __mark_inode_dirty
Message-Id: <20030202160656.52349e3a.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302022203560.1545-300000@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0302022203560.1545-300000@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2003 00:06:42.0375 (UTC) FILETIME=[21A28D70:01C2CB18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>
> Hi.
> 
> there's a SMP race condition between __sync_single_inode (or __sync_one on
> 2.4.20) and __mark_inode_dirty. __mark_inode_dirty doesn't take inode
> spinlock. As we know -- unless you take a spinlock or use barrier,
> processor can change order of instructions.
> 

Looks good to me, although my understanding of these memory ordering issues
is woeful.

We do want to avoid taking inode_lock in mark_inode_dirty() - that is called
very frequently.  I'm rather surprised that inode_lock contention has not
been a problem thus far.

Longer-term we should probably turn i_state into a ulong and only run atomic
bitops against it.

