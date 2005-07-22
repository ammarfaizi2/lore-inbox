Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVGVE6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVGVE6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVGVE6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:58:49 -0400
Received: from [216.208.38.107] ([216.208.38.107]:25496 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261932AbVGVE6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:58:48 -0400
Subject: Re: [linux-pm] [PATCH] Syncthreads support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050721153932.GA2005@elf.ucw.cz>
References: <1121923564.2936.231.camel@localhost>
	 <20050721153932.GA2005@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122001826.3033.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Jul 2005 13:10:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-07-22 at 01:39, Pavel Machek wrote:
> Hi!
> 
> > This patch implements a new PF_SYNCTHREAD flag, which allows upcoming
> > the refrigerator implementation to know that a thread is syncing data to
> > disk. This allows the refrigerator to be more reliable, even under heavy
> > load, because it can separate userspace processes that are submitting
> > I/O from those trying to sync it and freezing the former first. We can
> > thus ensure that syncing processes complete their work more quickly and
> > the refrigerator is far less likely to incorrectly give up (thinking a
> > syncing process is completely failing to enter the refrigerator).
> 
> This patch is ****, and pretty intrusive too. Ouch and then it is
> unneccessary. We have been over this before, and explained to you in
> person. Greg explained it to you, too. This one is NOT GOING IN. Drop
> it from your patches, trying to submit it 10 times will not get it
> accepted.
> 
> [For the record, simple solution for this one is 
> 
> sys_sync();
> 
> and only then start refrigeration].

That's not right.

Greg said he believed the right thing to do was to sync in the kernel,
but he also said he agreed with you. I thought at the time he was
confused about who was suggesting what - let's check with him.

Anyway, we discussed before that sync_sync before starting refrigerating
is insufficient. Remember that since processes aren't refrigerated yet,
there is absolutely nothing to stop other processes submitting I/O
between the two actions and thus making the sync pointless. The sync
needs to be done after the userspace processes that might submit I/O
have been frozen, to ensure that all the dirty data is actually synced
to disk.

Remember also that it is important that we do need to sync all dirty
buffers. In the case of not resuming, data loss should nil.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

