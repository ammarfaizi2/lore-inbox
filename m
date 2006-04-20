Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDTOhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDTOhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWDTOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:37:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36212 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750715AbWDTOhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:37:40 -0400
Date: Thu, 20 Apr 2006 16:29:03 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: splice status
Message-ID: <20060420142902.GC4717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since a lot of splice/tee stuff has been merged, I thought I'd post a
little status report and other potentially useful info.

- splice interfaces should be stable now, I don't envision any further
  changes to the ->splice_read or ->splice_write file_operations hooks
  or the splice syscall. splice now accepts an input or output offset
  like sendfile(), so it doesn't have to rely on ->f_pos in the file
  structure.

- Ditto for the sys_tee syscall.

- sendfile() will be replaced with splice(). sys_sendfile will remain of
  course, this is only an internal thing. The current do_splice_direct()
  is a sendfile() helper. The splice branch in the block git repo has
  a patch to remove generic_file_sendfile() and all it's users by
  converting them to ->splice_read(). There's also a patch there that
  fixes up loop. The only remaining users of the file_operations
  .sendfile hook are nfds/shmem/ext2-xip/relay. That still needs doing.
  The current plan is to merge this stuff post 2.6.17.

I have a little collection of splice test tools that people may find
useful to play with this stuff. It's in a git repo here:

        git://brick.kernel.dk/data/git/splice.git

and snapshots are generated every hour on changes and can be fetched
from

        http://brick.kernel.dk/snaps/

There are tools there to test both splice and tee, a little README
explains the basic principle of them. I'd appreciate people testing and
playing with these tools, just in case we still have some bugs lurking.

Finally, known bugs:

- Some smallish splice reads are buggy. Patch is in splice branch and
  will hopefully be merged whenever Linus gets in front of his computer.

- The ->splice_pipe cache needs to be initialized to NULL on forks. Only
  affects do_splice_direct() usage, so not a problem in current kernels.
  Patch also Linus bound today.


-- 
Jens Axboe

