Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUEZMy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUEZMy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUEZMyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:54:11 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27016 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265586AbUEZMxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:53:02 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Rik van Riel'" <riel@redhat.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>, <orders@nodivisions.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 05:55:50 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.44.0405260818030.30062-100000@chimarrao.boston.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDHF1/sdwIOqJURVeZcCRJ2OHd7QAAqewA
Message-Id: <S265586AbUEZMxC/20040526125302Z+1835@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Executables and shared libraries live in the filesystem
> cache.  Evicting those from memory - because swapping is
> disabled and "the VM should remove something from cache
> instead" - will feel exactly the same as swapping ...

I totally agree, you can't get away from evicting pages from memory to disk
if your doing file system I/O because you eventually fill up memory. Any
additional file system I/O requires evictions, period.

Trying to preference executables and shared libraries is difficult because
they are backed by named files, hence they also pagecache. (kind of reminds
me of that little white speck on chicken poop. If it came out of the
chicken, it's chicken poop too :)

But there is the case where massive amounts of file system I/O (consider
several fibre cards connecting to SAN attached storage that saturates the
centerplane on some insanely large system) will force pages from running
executables to be evicted, only to be faulted back a few milliseconds later.
It's this thrashing effect that a separation eliminates if you have the
ability to distinguish between executables (not just files mapped in
executable but actual running processes) and non-executable pages.

Consider how silly it would be for a system running a single process that
consumes only 100k that generates so much filesystem I/O that the process is
constantly paged out. When it needs to wake up again, becomes runnable and
the program counter starts to access pages within the process address space,
it gets faulted back in.

Lather, Rinse, Repeat ...

--Buddy



