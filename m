Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRCVDns>; Wed, 21 Mar 2001 22:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbRCVDni>; Wed, 21 Mar 2001 22:43:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33286 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130565AbRCVDn2>; Wed, 21 Mar 2001 22:43:28 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: lock_kernel() usage and sync_*() functions
Date: 21 Mar 2001 19:42:44 -0800
Organization: Transmeta Corporation
Message-ID: <99bsbk$a6n$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.05.10103211901070.705-100000@cosmic.nrg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.05.10103211901070.705-100000@cosmic.nrg.org>,
Nigel Gamble  <nigel@nrg.org> wrote:
>
>Why is the kernel lock held around sync_supers() and sync_inodes() in
>sync_old_buffers() and fsync_dev(), but not in sync_dev()?  Is it just
>to serialize calls to these functions, or is there some other reason?

A lot of the FS locks need the kernel lock and are not SMP-safe on their
own.  Look at "lock_super()" for the worst offender (I think most of the
other ones have been converted to properly lock on SMP).

sync_inodes() _shouldn't_ need it. sync_supers() definitely does.

The fact that sync_dev() doesn't get the kernel lock looks worrisome. 
Of course, I don't think much of anything actually _uses_ "sync_dev()"
anyway (quick grep shows it up in revalidate, which gets the kernel lock
earlier)

But it might be a good idea to try to (a) remove the bkl from the
functions, and push it down into sync_supers() that definitely needs it
now (and remove it when it doesn't any more).

The long-term plan (ie 2.5.x) is to basically remove the bkl from all
the VFS interfaces. For 2.4.x, only the truly performance-critical stuff
was done (ie mainly name lookup and read/write page).

		Linus
