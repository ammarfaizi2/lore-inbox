Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTLADnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 22:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTLADnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 22:43:32 -0500
Received: from holomorphy.com ([199.26.172.102]:23752 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263274AbTLADn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 22:43:28 -0500
Date: Sun, 30 Nov 2003 19:43:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031201034324.GO8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James W McMechan <mcmechanjw@juno.com>,
	linux-kernel@vger.kernel.org
References: <20031130.170608.-1591395.4.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130.170608.-1591395.4.mcmechanjw@juno.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Either it's a double bitflip or even worse is afoot.

On Sun, Nov 30, 2003 at 05:06:04PM -0800, James W McMechan wrote:
> Umm from include/linux/list.h
> #define LIST_POISON1  ((void *) 0x00100100)
> #define LIST_POISON2  ((void *) 0x00200200)
> though perhaps we need a better poison
> 0xdead0001 for example but that might be valid
> Were you thinking of a hardware fault?
> The test program oops both a Athlon and a
> PentiumMMX and I followed this in from a user
> bugreport over on uml-devel

No, it looks like the list poison fooled me.


On Sun, Nov 30, 2003 at 05:06:04PM -0800, James W McMechan wrote:
> I single stepped through on a UML machine and it looked
> like the prev pointer in the list is getting corrupted, I was
> suspecting that fs/libfs.c:dcache_readdir:137
> list_del(q);
> list_add(q, &dentry->d_subdirs);
> when q is a empty list entry this occurs when fpos is 2
> and has no comment :(
> there is a similar chunk at dcache_dir_lseek:90 with a
> list_del(&cursor->d_child);
> list_add_tail(&cursor->d_child, p);

I'm really not sure what the ->d_subdirs rearrangement is supposed
to accomplish.


On Sun, Nov 30, 2003 at 05:06:04PM -0800, James W McMechan wrote:
> I suspect that deleting from a empty? list and adding
> back the deleted entry will mangle things...
> The problem came from looping over roughly
> dirfile = opendir(dirname)
> seekdir(dirfile,pos)
> ent = readdir(dirfile)
> pos=telldir(dirfile)
> closedir(dirfile)
> it started with pos== 0
> seekdir is fine
> readdir returns "."
> teldir returned 1 -> pos
> seekdir is fine
> readdir then got ".." and 
> teldir returned 2 -> pos
> seekdir then blew up on the empty entry
> Have you tried the test program?

No, I've gotten as far as I can with your oopsen. Either someone else
will have to pick it up from here or I'll have to spend more time
looking at fs/libfs.c


-- wli
