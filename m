Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVBGBVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVBGBVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 20:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBGBVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 20:21:13 -0500
Received: from almesberger.net ([63.105.73.238]:35079 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261312AbVBGBVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 20:21:05 -0500
Date: Sun, 6 Feb 2005 22:20:26 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Carl Spalletta <cspalletta@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Linux-tracecalls, a clarification
Message-ID: <20050206222026.A25338@almesberger.net>
References: <200501192037.j0JKbpuA008501@laptop11.inf.utfsm.cl> <20050121204422.85137.qmail@web53808.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121204422.85137.qmail@web53808.mail.yahoo.com>; from cspalletta@yahoo.com on Fri, Jan 21, 2005 at 12:44:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl Spalletta wrote:
> +    #The name of an operations structure member, wrongly interpreted by
> +    #cscope as the name of an actual function - it should be ignored,
> +    #since it has been confused by cscope with the name of some actual
> +    #caller. HOWEVER the callbacks are found anyway, under their actual names.
> +    #and if any function pointed to by a callback is part of a chain to
> +    #our initial target it _will_ be found, the same as any other caller.

Hmm, but it doesn't seem to follow function pointers anyway. Example:

http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?file=fs/jbd/transaction.c&func=do_get_write_access

should contain, among many others, this call chain:

fs/read_write.c:sys_read
  fs/read_write.c:vfs_read
    fs/ext3/file.c:ext3_file_operations.read =
    fs/read_write.c:do_sync_read
      fs/ext3/file.c:ext3_file_operations.aio_read =
      mm/filemap.c:generic_file_aio_read
        mm/filemap.c:__generic_file_aio_read
          include/linux/fs.h:do_generic_file_read
            mm/filemap.c:do_generic_mapping_read
              include/linux/fs.h:file_accessed
                include/linux/fs.h:touch_atime
                  fs/inode.c:update_atime
                    include/linux/fs.h:mark_inode_dirty_sync
                      fs/fs-writeback.c:__mark_inode_dirty
                        fs/ext3/super.c:ext3_sops.dirty_inode =
                        fs/ext3/inode.c:ext3_dirty_inode
                          include/linux/ext3_jbd.h:ext3_journal_get_write_access
                            fs/jbd/transaction.c:journal_get_write_access
                              fs/jbd/transaction.c:do_get_write_access

Note the three functions pointers that were used in this. This kind
of construct is extremely common in the kernel, and it's usually the
main source of confusion that will actually make one want to use a
call chain discovery tool.

I see that you're handling inline functions correctly.

Another thing that seems to be missing are macros. E.g. this query

http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?file=include/linux/seqlock.h&func=seqcount_init

should probably have found the reference in fs.h (it's somewhat
obscured by #ifdefs, so, depending on how your tree was set up,
the response may actually be correct). Also, this query should have
returned something:

http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?file=include/linux/blkdev.h&func=blk_queue_plugged

Since the call trees fan out very quickly (in either direction), I
think an interactive browser that lets you select which branch(es)
to follow (while remembering the chain you've already visited) would
be more useful than a huge dump that may require significant
post-processing.

It would also be nice to be able to go both ways, from called to
caller, and from caller to called. Again, the tricky bit here are
the function pointers.

I think that a tool that can handle the most common idioms found in
the kernel would be very useful.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
