Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUEFVuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUEFVuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUEFVuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:50:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:35230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263100AbUEFVuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:50:23 -0400
Date: Thu, 6 May 2004 14:49:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: alexeyk@mysql.com, linuxram@us.ibm.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040506144933.1918317f.akpm@osdl.org>
In-Reply-To: <1083867233.2420.29.camel@abyss.local>
References: <200405022357.59415.alexeyk@mysql.com>
	<200405050301.32355.alexeyk@mysql.com>
	<20040504162037.6deccda4.akpm@osdl.org>
	<200405060204.51591.alexeyk@mysql.com>
	<20040506014307.1a97d23b.akpm@osdl.org>
	<1083867233.2420.29.camel@abyss.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> wrote:
>
> On Thu, 2004-05-06 at 01:43, Andrew Morton wrote:
> 
> > 
> > One thing I note about this test is that it generates a huge number of
> > inode writes.  atime updates from the reads and mtime updates from the
> > writes.  Suppressing them doesn't actually make a lot of performance
> > difference, but that is with writeback caching enabled.  I expect that with
> > a writethrough cache these will really hurt.
> 
> Perhaps.  By the way is there a way to disable update time modification
> as well ?

No, there is not.

> It would make quite a good sense for partition used for
> Database needs - you do not need last modification time in most cases.

First up, one needs to remove the inode_update_time() call from
generic_file_aio_write_nolock() and run the tests.  If this (and noatime)
indeed makes a significant difference (probably on writethrough-caching
disks) then yup, we should do something.

`nomtime' would be simple enough.  But another option would be to arrange
for a/m/ctime dirtiness to not cause an inode writeout in fsync(). 
Instead, only sync the a/m/ctime-dirty inodes via sync, umount and pdflush.

That way, the inodes get written every thirty seconds rather than once per
second.

It's probably not standards-compliant, but shoot me.  Who cares if the
mtimes come up 30 seconds out of date after a system crash?

`nomtime' would be simpler and safer to implement, but not as nice.

But we need those numbers first.  I'll take a look.

