Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUFURKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUFURKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 13:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUFURKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 13:10:46 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:25737 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266327AbUFURKo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 13:10:44 -0400
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Caputo <ccaputo@alt.net>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, riel@redhat.com
In-Reply-To: <20040621004535.GA8071@logos.cnet>
References: <Pine.LNX.4.44.0406181730370.1847-100000@nacho.alt.net>
	 <20040620001529.GA4326@logos.cnet>
	 <1087702435.5361.64.camel@lade.trondhjem.org>
	 <20040621004535.GA8071@logos.cnet>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1087837820.3926.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 13:10:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 20/06/2004 klokka 20:45, skreiv Marcelo Tosatti:
> Lets see if I get this right, while we drop the lock in iput to call 
> write_inode_now() an iget happens, possibly from write_inode_now itself 
> (sync_one->__iget) causing the inode->i_list to be added to to inode_in_use. 
> But then the call returns, locks inode_lock, decreases inodes_stat.nr_unused--
> and deletes the inode from the inode_in_use and adds to inode_unused. 
> 
> AFAICS its an inode with i_count==1 in the unused list, which does not
> mean "list corruption", right? Am I missing something here?

Yes. Please don't forget that the inode is still hashed and is not yet
marked as FREEING: find_inode() can grab it on behalf of some other
process as soon as we drop that spinlock inside iput(). Then we have the
calls to clear_inode() + destroy_inode() just a few lines further down.
;-)

If the above scenario ever does occur, it will cause random Oopses for
third party processes. Since we do not see this too often, my guess is
that the write_inode_now() path must be very rarely (or never?) called.

> If you are indeed right all 2.4.x versions contain this bug.

...and all 2.6.x versions...

I'm not saying this is the same problem that Chris is seeing, but I am
failing to see how iput() is safe as it stands right now. Please
enlighten me if I'm missing something.

Cheers,
  Trond
