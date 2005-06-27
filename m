Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVF0Tal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVF0Tal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVF0T3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:29:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41631 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261587AbVF0T0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:26:53 -0400
Date: Mon, 27 Jun 2005 20:26:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       zam@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627192651.GB21932@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
	zam@namesys.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050620235458.5b437274.akpm@osdl.org> <20050627090640.GA5410@infradead.org> <1119882343.4256.358.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119882343.4256.358.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 06:25:43PM +0400, Vladimir Saveliev wrote:
> Sorry, would you please explain what is wrong in having the below
> 
> if (inode->i_nlink != 0 || atomic_read(&inode->i_count) > 1)
> 
> in reiser4_put_inode.

Between that atomic_read(&inode->i_count) and the
atomic_dec_and_lock(&inode->i_count, &inode_lock)) in iput someone could
have grabbed a reference.

> The problem is that on file removal reiser4 wants to do
> truncate_inode_pages in reiser4_delete_inode. We used reiser4_drop_inode
> for that. As long as drop_inode was about to die, we decided to do file

drop_inode is not going to die, we need it to support filesystems that
want to call generic_delete_inode even for a non-null i_nlink.  What's
hopefully going to die is the last instance of it that isn't either
generic_drop_inode or generic_delete_inode.

> You said:
> --------
> So what you want is actually to move the  truncate_inode_pages out of
> generic_delete_inode and into ->delete_inode?
> 
> 
> Looking at the code another strategt makes more sense:
> 
>  - move the truncate_inode_pages at the beginning of clear_inode.
>    All callers but one already do it just before that call, but
>    the one that doesn't will require a full audit of all ->delete_inode
>    instances
>  - make the first half of clear_inode into a helper (__clear_inode or
>    whatever), and make ->clear_inode responsible for calling it as first
>    thing for a normal fs or call it in clear_inode if ->clear_inode
> doesn't
>    exist.  that way we can also move the invalidate_inode_buffers out
> there
>    easily later for filesystems that don't use buffer_heads at all.
> 
> p.s. please try to keep -fsdevel Cc'ed on the mail related to core
> changes
> -------
> 
> I hoped that we can solve the problem internally in reiser4. If
> put_inode is about to be removed we will have to do ssomething like
> that.

In fact I know from some cluster filesystem folks that have a similar
problems as yours.  So getting the truncate_inode_pages under control
of the filesystems sounds like a very good choice.
