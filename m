Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSBLXZ4>; Tue, 12 Feb 2002 18:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291265AbSBLXYn>; Tue, 12 Feb 2002 18:24:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291254AbSBLXXq>;
	Tue, 12 Feb 2002 18:23:46 -0500
Message-ID: <3C69A3C8.17160BC3@zip.com.au>
Date: Tue, 12 Feb 2002 15:22:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> from "Andrew Morton" at Feb 12, 2002 03:13:14 PM <E16amOF-0003Rk-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Given that /bin/sync calls write_unlocked_buffers() three times,
> > that's good enough.  sync still takes aaaaaages, but it terminates.
> 
> Whats wrong with sync not terminating when there is permenantly I/O left ?
> Its seems preferably to suprise data loss

Hard call.  What do we *want* sync to do?

SuS doesn't require sync to be synchronous, although in linux
it traditionally has been.  SUS says:

	The sync() function causes all information in memory that
	updates file systems to be scheduled for writing out to all
	file systems. 

	The writing, although scheduled, is not necessarily complete
	upon return from sync(). 

I think the larger problem is that an infinite-duration
/bin/sync can break existing stuff.

If someone calls /bin/sync while there's write activity
going on, and expects that to prevent data loss then
their assumptions are broken anyway.  There can be new
write data generated as soon as sync returns.

-
