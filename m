Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWAJN1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWAJN1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWAJN1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:27:30 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36823 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932195AbWAJN13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:27:29 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1136834210.6197.10.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20060107033637.458c4716.akpm@osdl.org>
	 <1136834210.6197.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 08:26:30 -0500
Message-Id: <1136899590.6197.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, here's a better explanation of the patch as well as my
Signed-off.

Description:

It has been discovered that the remove_proc_entry has a race in the
removing of entries in the proc file system that are siblings.  There's
no protection around the traversing and removing of elements that belong
in the same subdirectory.

This subdirectory list is protected in other areas by the BKL.  So the
BKL was at first used to protect this area too, but unfortunately,
remove_proc_entry may be called with spinlocks held.  The BKL may
schedule, so this was not a solution.

The final solution was to add a new global spin lock to protect this
list, called proc_subdir_lock.  This lock now protects the list in
remove_proc_entry, and I also went around looking for other areas that
this list is modified and added this protection there too.  Care must be
taken since these locations call several functions that may also
schedule.

Since I don't see any location that these functions that modify the
subdirectory list are called by interrupts, the irqsave/restore versions
of the spin lock was _not_ used.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>


-- Steve


