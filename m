Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVCHPNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVCHPNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCHPNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:13:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9692 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261400AbVCHPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:12:56 -0500
Date: Tue, 8 Mar 2005 16:12:58 +0100
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050308151258.GD23403@atrey.karlin.mff.cuni.cz>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk> <20050304160451.4c33919c.akpm@osdl.org> <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk> <20050307123118.3a946bc8.akpm@osdl.org> <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk> <1110286417.1941.40.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110286417.1941.40.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Mon, 2005-03-07 at 21:08, Stephen C. Tweedie wrote:
> 
> > Right, that was what I was thinking might be possible.  But for now I've
> > just done the simple patch --- make sure we don't clear
> > jh->b_transaction when we're just refiling buffers from one list to
> > another.  That should have the desired effect here without dangerous
> > messing around with locks.
> 
  <snip>

> Fix destruction of in-use journal_head
> 
> journal_put_journal_head() can destroy a journal_head at any time as
> long as the jh's b_jcount is zero and b_transaction is NULL.  It has no
> locking protection against the rest of the journaling code, as the lock
> it uses to protect b_jcount and bh->b_private is not used elsewhere in
> jbd.
> 
> However, there are small windows where b_transaction is getting set
> temporarily to NULL during normal operations; typically this is
> happening in 
> 
> 			__journal_unfile_buffer(jh);
>  			__journal_file_buffer(jh, ...);
> 
> call pairs, as __journal_unfile_buffer() will set b_transaction to NULL
> and __journal_file_buffer() re-sets it afterwards.  A truncate running
> in parallel can lead to journal_unmap_buffer() destroying the jh if it
> occurs between these two calls.
  Isn't also the following scenario dangerous?

  __journal_unfile_buffer(jh);
  journal_remove_journal_head(bh);

  If journal_unmap_buffer() decides to destroy the buffer before we call
journal_remove_journal_head(), we get an assertion failure in
__journal_remove_journal_head()...
  I believe the right fix really is that anyone having a pointer to
bh/jh should hold a reference counted in b_jcount - so basically the
idea Andrew proposed. 
  It could work like follows: When you first create jh you get a
reference in b_jcount (that is already happening). If you file a jh in
some transaction list, you will 'delegate' this reference to the
transaction and hence you won't do journal_put_journal_head() after
you're done. Now if you unfile a buffer from the list you 'get back' it's
reference (and you have to journal_put_journal_head() if you're not
going to file the buffer back again). The only thing you have to assure is
the proper list locking so that two different callers cannot 'get back' one
reference but that should be already done...
  This solution should be doable without additional locking or big code
changes but maybe the reference policy is a bit too complicated...

> Fix this by adding a variant of __journal_unfile_buffer() which is only
> used for these temporary jh unlinks, and which leaves the b_transaction
> field intact so that we never leave a window open where b_transaction is
> NULL.
> 
> Additionally, trap this error if it does occur, by checking against
> jh->b_jlist being non-null when we destroy a jh.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
