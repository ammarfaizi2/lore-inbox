Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUBWMUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 07:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUBWMUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 07:20:08 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:6925 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261270AbUBWMUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 07:20:01 -0500
Date: Mon, 23 Feb 2004 12:19:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Wahlberg <Mikael.Wahlberg@ardendo.se>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while atomic!)
Message-ID: <20040223121959.A8354@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Wahlberg <Mikael.Wahlberg@ardendo.se>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20040222164941.D6046@foo.ardendo.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040222164941.D6046@foo.ardendo.se>; from Mikael.Wahlberg@ardendo.se on Sun, Feb 22, 2004 at 04:49:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 04:49:41PM +0100, Mikael Wahlberg wrote:
> Description:
> 
> On heavy FTP Load (About 1Gbit/s) running both reads and writes on two ServeRAID6m Raid5 controllers merged together to one filesystem with Raidtools we see the error below. The filesystem gets totally hanged up. Currently with XFS, but JFS gets the same problem (Actually even more often).

What does the JFS oops look like?  

> Feb 22 15:00:53 mserv1 kernel:  [<c011e54a>] __wake_up_common+0x3a/0x60
> Feb 22 15:00:53 mserv1 kernel:  [<c011e5af>] __wake_up+0x3f/0x70

This doesn't make a lot of sense, there's only two mrlocks in XFS, and
they're in the inodes that have well-defined and understood lifetime rules.

OTOH the previos oops might have messed quite a bit up in your system.

did you run memtest86 on the box?  do you some strange patches applied or
external modules loaded?  What's your .config?

> Feb 22 15:00:54 mserv1 kernel:  [<c011b150>] do_page_fault+0x0/0x523
> Feb 22 15:00:54 mserv1 kernel:  [<c010baf5>] error_code+0x2d/0x38
> Feb 22 15:00:54 mserv1 kernel:  [<c011e5b5>] __wake_up+0x45/0x70
> Feb 22 15:00:54 mserv1 kernel:  [<c011e54a>] __wake_up_common+0x3a/0x60
> Feb 22 15:00:55 mserv1 kernel:  [<c011e5af>] __wake_up+0x3f/0x70
> Feb 22 15:00:55 mserv1 kernel:  [<c0259e62>] mrunlock+0x82/0xb0
> Feb 22 15:00:55 mserv1 kernel:  [<c0259b00>] mraccessf+0xc0/0xe0
> Feb 22 15:00:55 mserv1 kernel:  [<c023038e>] xfs_iunlock+0x3e/0x80
> Feb 22 15:00:55 mserv1 kernel:  [<c023727b>] xfs_iomap+0x3bb/0x540
> Feb 22 15:00:55 mserv1 kernel:  [<c0163fc7>] bio_alloc+0xd7/0x1c0
> Feb 22 15:00:55 mserv1 kernel:  [<c025a17a>] map_blocks+0x7a/0x170
> Feb 22 15:00:55 mserv1 kernel:  [<c025b40b>] page_state_convert+0x52b/0x6d0
> Feb 22 15:00:55 mserv1 kernel:  [<c0236cb9>] xfs_imap_to_bmap+0x39/0x240
> Feb 22 15:00:55 mserv1 kernel:  [<c025be48>] linvfs_release_page+0xa8/0xb0
> Feb 22 15:00:55 mserv1 kernel:  [<c025bce0>] linvfs_writepage+0x60/0x120
> Feb 22 15:00:55 mserv1 kernel:  [<c014990c>] shrink_list+0x41c/0x710
> Feb 22 15:00:55 mserv1 kernel:  [<c0149df8>] shrink_cache+0x1f8/0x3d0
> Feb 22 15:00:55 mserv1 kernel:  [<c01b3a00>] journal_stop+0x220/0x330
> Feb 22 15:00:55 mserv1 kernel:  [<c014a6dc>] shrink_zone+0xbc/0xc0
> Feb 22 15:00:55 mserv1 kernel:  [<c014a7a5>] shrink_caches+0xc5/0xe0
> Feb 22 15:00:55 mserv1 kernel:  [<c014a87c>] try_to_free_pages+0xbc/0x190
> Feb 22 15:00:55 mserv1 kernel:  [<c0143043>] __alloc_pages+0x203/0x370
> Feb 22 15:00:55 mserv1 kernel:  [<c01431d5>] __get_free_pages+0x25/0x40

Hmm, from the trace it looks like ->release_page was called from a context
where we can't sleep.  XFS defintily doesn't handle that, so the question
is whether the kernel should do it.

