Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVDRMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVDRMrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVDRMrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:47:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46547 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262066AbVDRMrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:47:05 -0400
Date: Mon, 18 Apr 2005 13:46:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org, dwmw2@lists.infradead.org
Subject: Re: [PATC] small VFS change for JFFS2
Message-ID: <20050418124656.GA23387@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Artem B. Bityuckiy" <dedekind@infradead.org>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	dwmw2@lists.infradead.org
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru> <20050418085121.GA19091@infradead.org> <1113814730.31595.6.camel@sauron.oktetlabs.ru> <20050418105301.GA21878@infradead.org> <1113824781.2125.12.camel@sauron.oktetlabs.ru> <20050418115220.GA22750@infradead.org> <1113827466.2125.47.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113827466.2125.47.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 04:31:06PM +0400, Artem B. Bityuckiy wrote:
> On Mon, 2005-04-18 at 12:52 +0100, Christoph Hellwig wrote:
> > Oh, I thought the problem is that JFFS2 thought an inode was freed when
> > it still was in use.  So you're problem is actually that it's no in the
> > hash anymore but you don't know yet?
> Yes, exactly. VFS developers may always say "it is your problem -
> redesign JFFS2", but I think it is too late to redesign it.

I don't think it's too late ever ;-)

> > Anyway, please explain in detail why you need all this information, what
> > errors you see, etc so we can find a way to fix it properly.
> Well, I suspect I explained why I need the mutex. If people will find
> the explanation vague, I'll make another attempt.
> 
> The error I see is:
> 
> Eep. Trying to read_inode #15601 when it's already in state 2!
> 
> I debugged this a lot before I've realized the reason. And I believe I
> know JFFS2 very well to claim that redesigning it is very painful. 
> 
> The erroneous  code flow is like this:
> 
> kswapd: removes the inode 15601 from the inode hash (inode.c:478).
> kswapd: is preempted at inode.c:485
> JFFS2 writer: awakes, runs GC to reclaim some space.
> JFFS2 writer: picks a JFFS2 node belonging to the inode 15601
> JFFS2 writer: looks at the inode state, realizes it is in state PRESENT,
> i.e. it is in the inode cache (which is wrong).
> JFFS2 writer: runs iget() to acquire a pointer to the struct inode of
> the inode 15601.
> JFFS2 writer: iget() calls ->read_inode(), i.e., jffs2_read_inode().

Why doesn't __wait_on_freeing_inode get called? prune_icache sets I_FREEING
before it's dropping the inode lock.

Any, this sounds like you'd want to use ilookup because you don't want to
read the inode in the cache anyway, right?

> JFFS2 writed: JFFS2 is surprised why read_inode() is called for the
> already built inode 15601.
> 
> Or may be VFS is buggy, I'm not sure. May be it shouldn't remove inode
> from the inode hash in that point (inode.c:487). It sets the I_FREENG
> state to the inode being freed, and iget() may wait in find_inode_fast()
> while the inode is actually destroyed (inode.c:562). The inode may be
> removed from the inode hash later, in dispose_list() (inode.c:292).
> 
> Or may be this isn't a bug but a feature to make the inode_lock less
> contended. Not sure, I'm not a VFS guru.

Yes, it's a feature.

