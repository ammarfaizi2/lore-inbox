Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUGJUQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUGJUQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUGJUQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:16:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:41665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266386AbUGJUQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:16:16 -0400
Date: Sat, 10 Jul 2004 13:14:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <ahu@ds9a.nl>
Cc: albertogli@telpin.com.ar, linux-kernel@vger.kernel.org
Subject: Re: Syncing a file's metadata in a portable way
Message-Id: <20040710131459.13ffec23.akpm@osdl.org>
In-Reply-To: <20040710115404.GA11420@outpost.ds9a.nl>
References: <20040709030637.GB5858@telpin.com.ar>
	<20040709023948.59497dca.akpm@osdl.org>
	<20040710115404.GA11420@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> wrote:
>
> On Fri, Jul 09, 2004 at 02:39:48AM -0700, Andrew Morton wrote:
> 
> > It depends on the Linux filesystem.  On ext3, for example, fsync() will
> > sync all of the filesytem's metadata (and data in journalled and ordered
> > data mode).
> 
> I've noticed that on ext3, SQLite transactions are nearly useless, with the
> smallest transactions causing 5 megabyte/s writout activity based on
> relatively small writes. kjournald bore a large part of that according to
> laptop_mode's block dump.

If only the one file has been written to, an fsync on ext3 shouldn't
produce any more writeout than an fsync on ext2.

If there are other files on the same fs which have been written to then
they will be accidentally fsynced too, unless you're using data=writeback.

Either that, or SQLite is broken.

> Do we actually need to flush the journal on fsync? I'm no fs theorist but I
> wonder if having data in the journal isn't good enough - in case of failure,
> the data will be there on recovery?

fsync in ordered data mode will sync file data to the main fs and will sync
metadata tothe journal.  It will not sync previously-journalled metadata
back to the main fs, because that's not required for a succesful recovery.
