Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSEMEEx>; Mon, 13 May 2002 00:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSEMEEw>; Mon, 13 May 2002 00:04:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315539AbSEMEEw>;
	Mon, 13 May 2002 00:04:52 -0400
Message-ID: <3CDF3C34.5F0EB4EE@zip.com.au>
Date: Sun, 12 May 2002 21:08:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 deadlock?
In-Reply-To: <15582.64211.376045.489317@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> 
> I'm having a problem with 2.5.15 on an old slow powerbook 3400.  It
> gets stuck during boot at the point where it starts syslogd.  At that
> point show_state() reveals that kjournald and one of the two syslogd
> processes are stuck in D state.  The stack trace for kjournald is:
> 
> schedule
> __wait_on_buffer
> journal_commit_transaction
> kjournald

kjournald is actually running a commit.  So recovery was successful
and the filesystem is up and running.

It's this trace which is the problem.  All the other processes
are blocked by kjournald.

kjournald is pretty much write-only.  It will perform the
occasional read to load the indirect blocks which describe the
journal location.  But that would show a different backtrace.

It appears that kjournald has submitted a block for writeout
(via submit_bh() or ll_rw_block()) and the interrupt which
signifies completion simply hasn't happened.

> ...
> 
> Can anyone suggest where I could start looking to work out why
> kjournald is getting stuck in __wait_on_buffer?  Where in the code
> does the corresponding wakeup happen?

journal_commit_transaction() writes blocks from several different
places, via ll_rw_block() or submit_bh().  It waits for the
buffers to come unlocked in the end_buffer_io_sync() or
journal_end_buffer_io_sync() completion handlers.

Possibly the device driver has failed to deliver an interrupt.

-
