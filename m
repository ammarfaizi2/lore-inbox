Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWCNP37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWCNP37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCNP37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:29:59 -0500
Received: from thunk.org ([69.25.196.29]:14990 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751795AbWCNP36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:29:58 -0500
Date: Tue, 14 Mar 2006 10:29:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Tong Li <tongli@cs.duke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bursty I/O in ext3
Message-ID: <20060314152952.GA5644@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tong Li <tongli@cs.duke.edu>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 02:32:17AM -0500, Tong Li wrote:
> I'm running kernbench (make -j 128 on a kernel source) back to back 
> multiple times on an SMP. Among every 10 runs, there's always at least one 
> run that has a run time around 40% longer than the other runs. (Before 
> kernbench starts timing, it does a sync.) 'vmstat 1' indicates that the 
> longer runs always have a couple of 1-sec intervals during which there are 
> 10 times more block-outs (bo field) than the average traffic in the rest 
> of the run, and during these intervals, many cc1 processes are in the D 
> state. My file system is ext3 and all the things like journal commit 
> interval, pdflush interval, etc. have the default values.
> 
> I'm trying to understand why such variability occurs. I tested the same 
> thing with ext2 and did not see any variability. So I'm thinking about two 
> things: (1) for some reason, ext3/jbd occasionally issues a large volume 
> of bursty writes to the disk (but why does it occur just sometimes, not 
> always?), and (2) when there are bursty writes, the block device driver is 
> not able to handle them, causing I/O waits. But I don't really have a 
> clear understanding of the problem here...

If you are using an e2fsprogs older than version 1.38, you should try
expanding the journal size from the default of 32M to 128M; with the
filesystem unmounted do:

	tune2fs -O ^has_journal /dev/hdXX
	tune2fs -O has_journal -J journal_size=128 /dev/hdXX

If the journal gets full and the filesystem has to do a forced journal
truncate, that can cause I/O's to stall and writes can thus get bursty
with performance becoming nasty as a result.  Increasing the journal
size can avoid this, at the cost of potentially having more disk
buffers be pinned in memory, thus increasing the overhead of
unswappable kernel memory.

Regards,

						- Ted
