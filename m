Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWHOOFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWHOOFD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWHOOFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:05:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932775AbWHOOFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:05:00 -0400
Date: Tue, 15 Aug 2006 07:04:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Andrzej Szymanski <szymans@agh.edu.pl>, linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
Message-Id: <20060815070448.bcd1a67f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0608151439080.8124@alpha.polcom.net>
References: <44E0A69C.5030103@agh.edu.pl>
	<20060815005025.22e8adfe.akpm@osdl.org>
	<Pine.LNX.4.63.0608151439080.8124@alpha.polcom.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 14:40:48 +0200 (CEST)
Grzegorz Kulewski <kangur@polcom.net> wrote:

> On Tue, 15 Aug 2006, Andrew Morton wrote:
> > Which filesystem?
> >
> > If ext3 in ordered-data mode: any fsync() will sync the whole filesystem
> > (it has to).
> 
> Could you explain some more why it has to?... Is this caused by design of 
> ext3 or any filesystem in ordered-data mode has to do it?
> 

The journal is a shared resource - a single swipe of disk which is written
(logically) atomically and which contains the metadata modifications for
many files.  As filesystem activity proceeds we attach more and more
metadata blocks to the journal and when a commit happens we write them all
out in one hit.

Hence an fsync() of a single file ends up journalling the metadata for all
files which have pending metadata writes.

And in data=ordered mode the filesystem must write all the user-data for a
file before it writes the metadata which refers to that data.

IOW, a single fsync() triggers the journalling of all file metadata which
requires the writing of all file data.

In data=writeback mode the fs doesn't have the requirement that file
user-data be written prior to the journalling of the metadata which refers
to that data, so we can leave the pagecache for all the non-fsynced files
floating about in memory, still dirty.
