Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWCIXUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWCIXUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWCIXUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:20:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27575 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932112AbWCIXUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:20:53 -0500
Date: Thu, 9 Mar 2006 15:22:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: sct@redhat.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
Message-Id: <20060309152254.743f4b52.akpm@osdl.org>
In-Reply-To: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I am trying to speed up ext3 writepage() by avoiding
> journaling in non-block allocation cases. Does this
> look reasonable ? So far, my testing is fine. What am 
> I missing here ?

Nothing.  ext3's writepage(), prepare_write() and commit_write() do often
needlessy open and close transactions when we're doing overwrites.  It's
something I've meant to look at for a few years, on and off.

I'd expect that prepare_write() and commit_write() are more important than
writepage().

It might be better to test PageMappedToDisk() rather than walking the
buffers.  It's certainly faster and it makes optimisation of
prepare_write() and commit_write() easier to handle.

I'm not sure that PageMappedToDisk() gets set in all the right places
though - it's mainly for the `nobh' handling and block_prepare_write()
would need to be taught to set it.  I guess that'd be a net win, even if
only ext3 uses it..

Then again, we might be able to speed up block_prepare_write() if
PageMappedToDisk(page).

If we go this way we need to be very very careful to keep PG_mappedtodisk
coherent with the state of the buffers.  Tricky.  We need to think about
whether block_truncate_page() should be clearing PG_mappedtoisk if we did a
partial truncate.

Don't forget that ext3 supports journalled-mode files on ordered- or
writeback-mounted filesystems, via `chattr +j'.  Please be sure to test the
various combinations which that allows when playing with the write paths -
it can trip things up.

Also be sure to test nobh-mode.
