Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUGKKgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUGKKgx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUGKKgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:36:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:24039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266557AbUGKKgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:36:41 -0400
Date: Sun, 11 Jul 2004 03:35:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: bert hubert <ahu@ds9a.nl>
Cc: albertogli@telpin.com.ar, linux-kernel@vger.kernel.org
Subject: Re: Syncing a file's metadata in a portable way
Message-Id: <20040711033527.4017170d.akpm@osdl.org>
In-Reply-To: <20040711102743.GB16199@outpost.ds9a.nl>
References: <20040709030637.GB5858@telpin.com.ar>
	<20040709023948.59497dca.akpm@osdl.org>
	<20040710115404.GA11420@outpost.ds9a.nl>
	<20040710131459.13ffec23.akpm@osdl.org>
	<20040711102743.GB16199@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> wrote:
>
> On Sat, Jul 10, 2004 at 01:14:59PM -0700, Andrew Morton wrote:
> 
> > If only the one file has been written to, an fsync on ext3 shouldn't
> > produce any more writeout than an fsync on ext2.
> (...)
> > Either that, or SQLite is broken.
> 
> I'll show strace and vmstat tomorrow - I found very little writes, no mmap,
> some fsync and massive writeouts. On ext2, performance was two orders of
> magnitude better.
> 

One scenario which could cause this is if the application is writing a
large amount of data to a file and is repeatedly *overwriting* that data. 
And the application is repeatedly adding new blocks to, and fsyncing a
separate file.

strace might tell us that, if the traces are skilfully captured and studied.

You should try data=writeback.  Given that the app is using fsync() for its
own data integrity purposes anyway, you don't need data=ordered.

It's strange though.  databases often preallocate the file space, so a
regular write won't add new blocks to the file and won't allocate any new
metadata.  In this situation, an fsync() will only force a commit once per
second, when the inode mtime changes.
