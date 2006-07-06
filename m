Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWGFPVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWGFPVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWGFPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:21:47 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:54492 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030335AbWGFPVr
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:21:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17581.10603.204276.252774@gargle.gargle.HOWL>
Date: Thu, 6 Jul 2006 19:16:59 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06D204@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06D204@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000010 00477876c73c4b7f415ed95e4601761b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > You are inhumane. :-)
 > OK. A lame argument was a joke.
 > 
 > > No. User thread will not write _all_ dirty pages (if it does---it's a
 > > bug in the current code and should be fixed):
 > 
 > Some bugs are fixed by the patch.
 > Current kernel generates pdflush thread unlimitedly. It was patched up
 > by introducing MAX_PDFLUSH_THREADS=8. Why just 8? Now

Sorry, I don't understand. pdflush.c appeared in 2.5.8 and

#define MAX_PDFLUSH_THREADS    8

was here from the very beginning: http://www.kernelhq.cc/browse-view.py?fv_nr=107897

 > MAX_PDFLUSH_THREADS still present. But it could be removed.
 > Unlimited thread generation is fixed in proposed patch.
 > 
 > Now we are discussing other wonderful constant write_chunk=48. Why 48?

This is explained in comment just above sync_writeback_pages()
definition. Basically, ratelimit_pages pages might be dirtied between
calls to balance_dirty_pages(), and the latter tries to write out *more*
pages to keep number of dirty pages under control: negative feedback
control loop, of sorts.

 > The patch deletes this magic constant using:
 > -			.nr_to_write	= write_chunk,
 > It was needed in user thread only.
 > 
 > If user thread A writes 1 byte into disk it has to write not all but 48
 > dirty pages. User main work is paused. User thread B continues
 > generating of dirty pages. Thread B is main generator of dirty pages.
 > Thread A found was able to write-out 47 pages only because user B locks
 > inodes. That is why user A forced to wait 0.1 sec and than repeat
 > compulsory community works. User thread lunch wide inodes scanning and
 > list creating but interrupted after 48 pages. It is inefficient method. 

It may so happen, right, but in the long term most of writeback will be
performed by thread B, because, being heavy writer, it will enter
balance_dirty_pages() more often than A.

If you want to get rid of write latencies, you need better accounting,
to know what pages were dirtied by the current thread (or at least their
number), so that synchronous writeback can be fairer.

[...]

 > 
 > Leonid

Nikita.

