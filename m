Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSG2Kez>; Mon, 29 Jul 2002 06:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSG2Kez>; Mon, 29 Jul 2002 06:34:55 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:10725 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S314548AbSG2Kex> convert rfc822-to-8bit; Mon, 29 Jul 2002 06:34:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [Lse-tech] [patch] Memory Binding API v0.2
Date: Mon, 29 Jul 2002 12:37:57 +0200
User-Agent: KMail/1.4.1
References: <3D407E62.8080707@us.ibm.com>
In-Reply-To: <3D407E62.8080707@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207291237.57044.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Friday 26 July 2002 00:40, Matthew Dobson wrote:
> Here is the latest version of the Mem Binding API.  It's a follow-up to the
> patch posted a week or so ago.  It incorporates some changes, and should be
> a bit more efficient, readable, and functional.  Bigger, better, faster,
> eh?  It needs to be patched on top of the Simple binding API that I posted
> a minute ago..

the patch is a good start for introducing the NUMA API which we definitely
need for some coherence among NUMA developments. Also I think stuff like
memory hot-add/remove will absolutely need a concept like memblk.

I'm just having some small technical comments:

You're using spinlocks for protecting the memblk structure. Mostly these
structures would be just read during the lifetime of a task. Besides: the
current syscalls allow changing them only from the current context, there
is no danger of getting the wrong values here, because current isn't
allocating pages while it changes its memblk_list. Even if you change
the memblk variables from another task, it isn't that bad if they're
unprotected. After all just before changing the values you might have
allocated memory by using the old values... I think we can live without
the spinlocks.

The implemented syscalls only change the memblk_list of the current task.
Would you please consider extending them to arbitrary PIDs? With
reasonable protection, of course.

The include file include/linux/membind.h is kind of small and isn't
supposed to grow too much. How about putting this into
include/linux/numa.h where we could gather some more NUMA stuff and more
things to come with the NUMA API?

In _alloc_pages() you might want to check for online memblks when
initialising the mask:
	memblk_mask = curr->memblk_binding.bitmask & memblk_online_map;
In the search_twice branch I'd reset the mask to memblk_online_map. There
are chances that the desired memblk has been freed in the mean time.

Do you have plans for adding the setlaunch() part of the NUMA API? Guess
that should take care of both memblk_list and cpus_allowed...

Thanks,
best regards,

Erich


