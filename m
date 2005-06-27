Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVF0UeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVF0UeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVF0Ubw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:31:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261680AbVF0U0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:26:52 -0400
Date: Mon, 27 Jun 2005 21:26:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627202648.GA24745@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <20050627090640.GA5410@infradead.org> <1119882343.4256.358.camel@tribesman.namesys.com> <20050627192651.GB21932@infradead.org> <20050627194402.GK31165@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627194402.GK31165@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 12:44:02PM -0700, Joel Becker wrote:
> On Mon, Jun 27, 2005 at 08:26:51PM +0100, Christoph Hellwig wrote:
> > drop_inode is not going to die, we need it to support filesystems that
> > want to call generic_delete_inode even for a non-null i_nlink.  What's
> > hopefully going to die is the last instance of it that isn't either
> > generic_drop_inode or generic_delete_inode.
> 
> 	OCFS2 uses drop_inode as well, as it must handle last-close when
> another node did the unlink.  It fixes up i_nlink in that case, then
> calls generic_drop_inode().
> 	If there's a more elegant solution, we're all ears.

I think this still qualifies as calling generic_delete_inode because it's
a trivial wrapper.  Manipulating i_nlink seems rather odd to me, I'd
say you should rather call into generic_delete_inode directly if
OCFS2_INODE_MAYBE_ORPHANED is set (that's what generic_drop_inode will
do for i_nlink == 0 anyway).

In fact given every cluster and possibly many network filesystems will
need this it might make sense to take the OCFS2_INODE_MAYBE_ORPHANED into
the VFS, i.e. make it an i_state flag (after fixing can_unuse to not do
something totally stupid with i_state)
