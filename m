Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWBNMRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWBNMRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWBNMRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:17:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2950 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161030AbWBNMRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:17:01 -0500
Date: Tue, 14 Feb 2006 13:17:00 +0100
From: Jan Kara <jack@suse.cz>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Claudio Martins <ctpm@rnl.ist.utl.pt>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Message-ID: <20060214121700.GA28462@atrey.karlin.mff.cuni.cz>
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <20060210064612.GE12046@ca-server1.us.oracle.com> <200602110540.57573.ctpm@rnl.ist.utl.pt> <20060213222606.GC20175@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213222606.GC20175@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Feb 11, 2006 at 05:40:57AM +0000, Claudio Martins wrote:
> > This is my /etc/ocfs2/cluster.conf on every node:
> 
> Hi Claudio,
> 	Thanks for sending me your config files. Everything seems in order.
> I was easily able to reproduce your problem on my cluster and was able to
> git-bisect my way to some JBD changes which seem to be causing the issue.
> Reverting those patches fixes things. Can you apply the attached patch and
> confirm that it also fixes this particular problem for you? You'll have to
> apply to all kernels in your cluster and either run fsck.ocfs2 or create a
> new file system before testing again.
> 
> Linus, Andrew, Jan,
> 	OCFS2 uses journal_flush() to sync metadata out to disk when another
> node wants to obtain a lock on an inode which has pending journaled changes.
> Something in Jan Kara's patch titled "jbd: split checkpoint lists" broke
> this for OCFS2 (and I suspect for other users of JBD as well). As a result
> metadata is not always completely flushed to disk by the end of the
> journal_flush() call.
> 
> One easy way to reproduce is to create files from one node and list the
> directory from another. Switching the listing and creating nodes around
> makes things reproduce more quickly -- eventually the listing node will
> start missing new files.
  Ok, I'll have a look at the problem. Probably something in
log_do_checkpoint() is not waiting for all the data or something like
that. I'll try to reproduce with ext3 - it uses journal_flush() in
ext3_bmap() so if journal_flush() is not flushing all the data we should
be able to see that... Thanks for spotting the problem.

							Bye
								Honza

			
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
