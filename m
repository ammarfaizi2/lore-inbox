Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTLADjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 22:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTLADjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 22:39:41 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:63479 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S263176AbTLADjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 22:39:39 -0500
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 17:06:04 -0800
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130.170608.-1591395.4.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is significantly different in nature from the 2.4 oops, since
> 2.4 hit NULL and this pointer is total garbage.
> 
> Either it's a double bitflip or even worse is afoot.

Umm from include/linux/list.h
#define LIST_POISON1  ((void *) 0x00100100)
#define LIST_POISON2  ((void *) 0x00200200)
though perhaps we need a better poison
0xdead0001 for example but that might be valid

Were you thinking of a hardware fault?
The test program oops both a Athlon and a
PentiumMMX and I followed this in from a user
bugreport over on uml-devel

I single stepped through on a UML machine and it looked
like the prev pointer in the list is getting corrupted, I was
suspecting that fs/libfs.c:dcache_readdir:137
list_del(q);
list_add(q, &dentry->d_subdirs);
when q is a empty list entry this occurs when fpos is 2
and has no comment :(
there is a similar chunk at dcache_dir_lseek:90 with a
list_del(&cursor->d_child);
list_add_tail(&cursor->d_child, p);

I suspect that deleting from a empty? list and adding
back the deleted entry will mangle things...
The problem came from looping over roughly

dirfile = opendir(dirname)
seekdir(dirfile,pos)
ent = readdir(dirfile)
pos=telldir(dirfile)
closedir(dirfile)

it started with pos== 0
seekdir is fine
readdir returns "."
teldir returned 1 -> pos
seekdir is fine
readdir then got ".." and 
teldir returned 2 -> pos
seekdir then blew up on the empty entry

Have you tried the test program?

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
