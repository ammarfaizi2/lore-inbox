Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUJUJV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUJUJV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUJUJUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:20:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64661 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270513AbUJUJML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:12:11 -0400
Date: Thu, 21 Oct 2004 11:12:06 +0200
From: Jan Kara <jack@suse.cz>
To: LKML <linux-kernel@vger.kernel.org>,
       Vserver <vserver@list.linux-vserver.org>
Cc: akpm@osdl.org
Subject: Re: [Vserver] PROBLEM: Oops in log_do_checkpoint, using vserver
Message-ID: <20041021091206.GA18501@atrey.karlin.mff.cuni.cz>
References: <20041018032511.GY21419@ns.snowman.net> <20041018115523.GA2352@mail.13thfloor.at> <20041018122025.GA28813@ns.snowman.net> <20041019220100.GB12780@ns.snowman.net> <20041020024342.GA9260@mail.13thfloor.at> <20041020122108.GC12780@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020122108.GC12780@ns.snowman.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> * Herbert Poetzl (herbert@13thfloor.at) wrote:
> > On Tue, Oct 19, 2004 at 06:01:00PM -0400, Stephen Frost wrote:
> > > Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:361: 
> > > "drop_count != 0 || cleanup_ret != 0"
> > 
> > you can split up this assertion into
> > 
> >  - drop_count != 0
> >  - cleanup_ret != 0
> > 
> > and fail on that (or just output those values
> > before you panic) ... this might give some
> > deeper insight into the issue ...
> 
> Hmm, that's a good thought, though I have to say I'd really like to get
> a comment from the ext3 folks.  This is also a production server, so I'd
> kind of like to minimize the downtime. :)
> 
  I've been looking through the code and I think there might be a
following race (but it looks unlikely):
   Proc 1						Proc 2
 log_do_checkpoint()
   scans the list for buffers to flush
     and flushes everything
   scan again and throw out flushed buffers
							lock_bh_state()
   on the last buffer fails jbd_trylock_bh_state()
     so we retry
							unlock_bh_state()
							lock_buffer()
   scanning again but now buffer is buffer_locked()
     so we cannot throw it out
							mark_buffer_jbddirty()
							unlock_buffer()
   __cleanup_transaction() called
     It finds nothing wrong with the buffer (and
       there is only one) => return 0
   So we have drop_count==0, cleanup_ret==0 => assertion failure

   But in this case IMHO nothing bad happened so maybe the assertion is
just the problem but probably someone with more knowledge of this code should
decide (that's why I CC'd Andrew ;).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
