Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTDUN7N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTDUN7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 09:59:13 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:61200 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261283AbTDUN7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 09:59:11 -0400
From: Peter Benie <peterb@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16035.64514.811736.721619@chiark.greenend.org.uk>
Date: Mon, 21 Apr 2003 15:11:14 +0100
To: linux-kernel@vger.kernel.org (linux-kernel)
Subject: Verifying a RAID device (Was: Are linux-fs's drive-fault-tolerant by concept?)
In-Reply-To: <200304201725.h3KHP5lU000751@81-2-122-30.bradfords.org.uk>
References: <200304201306_MC3-1-3537-115@compuserve.com>
	<200304201725.h3KHP5lU000751@81-2-122-30.bradfords.org.uk>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford writes:
> [Chuck Ebbert writes]
> >   I have some ugly code that forces all reads from a mirror set to
> > a specific copy, set via a global sysctl.  This lets you do things
> > like make a backup from disk 0, then verify against disk 1 and take
> > action if something is wrong.
> 
> That's interesting.  Have you thought of making it read from _both_
> disks and check that the data matches, before passing it back?
> 
> RAID1 mirrors guard against drive failiure, but if a drive returns bad
> data, but doesn't report an error, that will usually go unnoticed.

Checking the disks periodically guards against another important
failure mode. Consider this scenario:

Start with a RAID1 mirror using two apparently working disks. 
The first disk develops a media fault, however, this goes unnoticed
because there happens to be no data stored on that part of the media.

Later, a fault is detected during a read of the second disk; the disk
is marked off off-line, but all the data is still readable on the
first disk so there's no need to panic yet.

You replace the known faulty disk with a new one. The md driver
automatically reconstructs the array from the first disk. Since the
md driver doesn't know about the filesystem, it reads every disk
block, regardless of whether it contains data or not.

The latent error on the first disk is now discovered, and the first
disk is now marked off-line. The replacement is only partially
reconstructed, so it remains inactive. Oops, there are no active disks
left - the md device has failed!

To guard against this, it is a good idea to periodically read all of
every disk in a RAID to detect faults early. Ideally, this should be
done as another background task, like reconstruction. Checking that
the data is valid is then a trivial extra step. If a read fails, you
mark the disk relevant disk off-line, as usual. If the parity check
fails, you just return a bad blocks list.

Peter
