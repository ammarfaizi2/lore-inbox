Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVDRNIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVDRNIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVDRNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 09:08:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8660 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262072AbVDRNIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 09:08:45 -0400
Subject: Re: [PATC] small VFS change for JFFS2
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20050418124656.GA23387@infradead.org>
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
	 <20050418085121.GA19091@infradead.org>
	 <1113814730.31595.6.camel@sauron.oktetlabs.ru>
	 <20050418105301.GA21878@infradead.org>
	 <1113824781.2125.12.camel@sauron.oktetlabs.ru>
	 <20050418115220.GA22750@infradead.org>
	 <1113827466.2125.47.camel@sauron.oktetlabs.ru>
	 <20050418124656.GA23387@infradead.org>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 23:08:26 +1000
Message-Id: <1113829708.5286.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 13:46 +0100, Christoph Hellwig wrote:
> Any, this sounds like you'd want to use ilookup because you don't want
> to read the inode in the cache anyway, right?

We use ilookup() in some circumstances -- if the inode has zero nlink
and hence we definitely don't want to pull it back again if it's gone.

But sometimes we really do mean to use iget() to bring it into core. And
it's in that case that I believe Artem has found the problem, because if
I understand correctly he's still seeing two consecutive calls to
read_inode() for the same inode, without a clear_inode() in between.

prune_icache() is removing the inode from i_hash at line 457 of inode.c,
then being preempted when it drops the inode_lock at line 464, which is
_before_ it calls dispose_list() to actually get rid of the inode(s) in
question. So when iget() is called, the VFS ends up calling read_inode()
again instead of waiting for the original inode to finish going away.

-- 
dwmw2

