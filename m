Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSHJMCp>; Sat, 10 Aug 2002 08:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSHJMCp>; Sat, 10 Aug 2002 08:02:45 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:37117 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316860AbSHJMCl>; Sat, 10 Aug 2002 08:02:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Kingsley G. Morse Jr." <change@nas.com>
Subject: Re: What obvious symptoms addressed by the slablru patch?
Date: Sat, 10 Aug 2002 08:06:01 -0400
User-Agent: KMail/1.4.2
References: <20020809192530.A7098@debian1.loaner.com>
In-Reply-To: <20020809192530.A7098@debian1.loaner.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208100806.01828.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI Kingsley

You wrote:
>
>     If you are having slab memory problems or
>     dcache/icache get too large and seen not to be
>     pruned 'correctly' - This patch may well help.
>
> and
>
>     Feedback very welcome
>
> Can you elaborate on what:
>
>     slab memory problems and
>
>     dcache/icache
>
>         getting too large and
>         not being pruned 'correctly'
>
> look like to an end user?

Without slablru on a lightly loaded box you would see memory 'disappear'
ie. vmstat would show the free/buf/cache numbers decreasing.   If you
then looked at /proc/slabinfo you would see some caches (usually inode
and dentry) using lots of memory.  This memory eventually will get reclaimed
when we get vm pressure.  With out slablru this pressure comes too late
and is often caused by slab caches instead of real world loads...

What slablru does basicly is sync the shrinking of slab caches with the
rest of the vm.  So if you allocate lots of slab pages (like during an updatedb
run) the vm takes this into account and even with low vm pressure starts
trimming caches.  This means that, while slab caches can still get large, the
vm will trim them at the same rate it does other pages.  It no longer waits
until too long to do so.

One small detail in slablru.  There are currently two types of slab caches.
Those that free slabs directly and those that age their slabs before freeing
them.  The dcache (dentries) and inode caches age their members.  This
also contributed to the above problem.  The stock kernel ages and 
shrinks at the same time.  slablru factors out aging and shrinking.  This
helps keep these caches using their fair share (which can be large) of
the systems resources.

Ed Tomlinson

