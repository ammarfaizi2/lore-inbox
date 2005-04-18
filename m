Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVDRMth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVDRMth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVDRMr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:47:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48339 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262068AbVDRMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:47:12 -0400
Subject: Re: [PATC] small VFS change for JFFS2
From: David Woodhouse <dwmw2@infradead.org>
To: dedekind@infradead.org
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <1113827466.2125.47.camel@sauron.oktetlabs.ru>
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
	 <20050418085121.GA19091@infradead.org>
	 <1113814730.31595.6.camel@sauron.oktetlabs.ru>
	 <20050418105301.GA21878@infradead.org>
	 <1113824781.2125.12.camel@sauron.oktetlabs.ru>
	 <20050418115220.GA22750@infradead.org>
	 <1113827466.2125.47.camel@sauron.oktetlabs.ru>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 22:46:44 +1000
Message-Id: <1113828405.5286.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 16:31 +0400, Artem B. Bityuckiy wrote:
> Yes, exactly. VFS developers may always say "it is your problem -
> redesign JFFS2", but I think it is too late to redesign it.

Bear in mind that the reason I added the state tracking to the internal
jffs2_inode_cache state was specifically to deal with the fact that the
VFS can call read_inode() for an inode which was previously in core and
for which it hasn't yet called clear_inode().

I suspect that there's a way we could work around this problem in JFFS2,
and if not hch is probably right -- exporting the lock isn't good
enough; if we're going to change the VFS we should fix the actual
problem.

I'm confused by this though -- I thought we'd already _fixed_ this in
the VFS. What you describe shouldn't happen because I believe you're
missing a step:

> JFFS2 writer: looks at the inode state, realizes it is in state PRESENT,
> i.e. it is in the inode cache (which is wrong).
> JFFS2 writer: runs iget() to acquire a pointer to the struct inode of
> the inode 15601.

wait_for_freeing_inode() waits for the existing inode in state I_FREEING
to finish being cleared...

> JFFS2 writer: iget() calls ->read_inode(), i.e., jffs2_read_inode().
> JFFS2 writed: JFFS2 is surprised why read_inode() is called for the
> already built inode 15601.

... and this shouldn't happen.

-- 
dwmw2

