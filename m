Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUCVTfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCVTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:35:46 -0500
Received: from [198.247.175.96] ([198.247.175.96]:63399 "EHLO jethro.hick.org")
	by vger.kernel.org with ESMTP id S262328AbUCVTfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:35:32 -0500
From: "Matt Miller" <mmiller@hick.org>
To: <linux-kernel@vger.kernel.org>
Cc: <mmiller@hick.org>
Subject: RE: [PATCH] 2.6: mmap complement, fdmap
Date: Mon, 22 Mar 2004 13:26:01 -0600
Message-ID: <PFEHKADDODPLDDIJFACJAEJHEAAA.mmiller@hick.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
In-Reply-To: <20040322190047.GC8366@waste.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > a) what the hell for?
> >
> > It's targetted mainly as a performance enhancer.  Some of the specific
> > scenarios where it would be useful are:
> >
> > a) When one cannot afford to take the performance hit of synchronizing
> >    a memory range to disk due to disk size limitations or speed
> >    requirements.
> > b) Some things can benefit from the ability to interface with
> memory as a
> >    file.
> >
> > The specific reason for implementing this was to allow for
> loading dynamic
> > libraries in the context of a process without having to write them to
> > disk.
>
> How about tmpfs/ramfs instead? Open a file on tmpfs and mmap it and
> you've got the same thing without any of the nasty corner cases.

Because tmpfs does not allow you to map a file descriptor to a specific
memory
range inside a process.  tmpfs allows you to open a file that exists only
in memory, yes, but it does not accomplish what fdmap tries to accomplish.
fdmap allows you to access arbitrary memory ranges as if they were a file.
tmpfs allows you to access a file that happens to only exist in memory.
You do not control the address range that tmpfs/ramfs map to.

A few other benefits to fdmap include:

1. Transactional operations for MTD storage - if the only "disk"
   is an MTD, then one would want to avoid writing to it too much
   (assuming wear-leveling alone isn't enough).  So one can commit
   tons of changes, then when everything's done, "collapse" to disk.
2. tmpfs adds swap -- if you don't want it to hit disk, ever (think
   crypto keys) but need to manipulate it with tools that want files.
3. ramfs isn't charged to the user process, rather, it rips available
   memory away from everything.  By using fdmap(), it'd be interesting
   to allow a "transactional storage" for processes to exist that's
   automatically beancounted.

Think of fdmap as the complement to mmap.  You use mmap to map a file
descriptor to a memory range so that you can operate on it directly by
memory.  You use fdmap to map a memory range to a file descriptor so that
you can access the memory as if it were a file on disk.

Matt

