Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVK1BeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVK1BeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 20:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVK1BeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 20:34:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34502
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751208AbVK1BeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 20:34:04 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: Question: madvise(DONT_SYNC)
Date: Sun, 27 Nov 2005 19:25:09 -0600
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271925.09565.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember long ago a discussion about soft pinning of pages.  Not actually 
locking them into memory but just letting the VM know that when they get 
dirtied there's no need to ever write them out in the absence of memory 
pressure.

I don't remember how the discussion resolved, and I can't find anything that 
looks like MADV_NOSYNC in mman.h in the 2.6.15-rc2 headers.

I bring this up because User Mode Linux could use this behavior.  Under 2.4 it 
could get nosync file backed memory by simply deleting the file after mmaping 
it, but that hack was taken out in 2.6 and now you have to use a tmpfs mount 
to avoid a really nasty behavior (where every page you dirty gets written out 
and something like a kernel compile will peg the disk doing unnecessary 
writes for minutes at a time, which isn't fun even with CFQ).

UML is currently written on the assumption that tmpfs will be mounted on /tmp, 
but the only distribution I've been able to find that actually does that by 
default is knoppix (not because anything is mounted on /tmp, but because / is 
a union mount of iso9660 and tmpfs).  Fedora Core 4, Ubuntu, Gentoo all have 
tmpfs inheriting / (which is generally ext3).

Needing root access to set up the host system so that UML is usable defeats 
half the advantage it has over Xen, for my use cases.

I can change the default to /dev/pts (which is tmpfs with the sticky bit on 
Fedora Core 4, Ubuntu, and Gentoo.  But which has nothing mounted on it and 
isn't even world writable on the only x86-64 system I currently have access 
to, which is running PLD Linux...)  But if the madvise worked its mmap file 
could just be in the user's home directory, and it wouldn't need to hunt for 
a tmpfs mount at all...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
