Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUGIJlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUGIJlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUGIJlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:41:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:6554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264609AbUGIJlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:41:04 -0400
Date: Fri, 9 Jul 2004 02:39:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syncing a file's metadata in a portable way
Message-Id: <20040709023948.59497dca.akpm@osdl.org>
In-Reply-To: <20040709030637.GB5858@telpin.com.ar>
References: <20040709030637.GB5858@telpin.com.ar>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Bertogli <albertogli@telpin.com.ar> wrote:
>
> 
> Hi!
> 
> I wanted to know if there was a common, portable way of syncing a given
> file's metadata.
> 
> In particular, I just want to create a file with open() and be sure that
> after some operation the file has been properly created and even if there
> is a crash, it can be accessed (modulo internal disk caches and all that
> stuff).
> 
> I know that fsync() provides only data guarantees, and even the manpage
> says clearly that in order to sync metadata an "explicit fsync on the file
> descriptor of the directory is also needed".

It depends on the Linux filesystem.  On ext3, for example, fsync() will
sync all of the filesytem's metadata (and data in journalled and ordered
data mode).

But on ext2 you'll need to fsync the directory.  However, that only needs
to be done once, after the create.

> However, the O_DIRECTORY flag is Linux only, making this mechanism not
> portable.
>
> Is there a way of doing this in a portable way?

Doing a create, followed by a system-wide sync(), followed by
write/fsync/write/fsync/...  will do what you want on all Linux
filesystems.  That might be a bit of a performance problem if you're
creating a lot of files, although probably not.

This method should portable to other OS'es if they implement sync() sanely.

But note that they may not: according to the spec, sync() doesn't _have_ to
wait for all the queued I/O to complete prior to returning.  It does on
Linux.   Some additional sync()s may be needed on other OS'es.

