Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266294AbUFYHrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUFYHrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 03:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUFYHrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 03:47:46 -0400
Received: from nacho.alt.net ([207.14.113.18]:37092 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S266294AbUFYHro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 03:47:44 -0400
Date: Fri, 25 Jun 2004 00:47:39 -0700 (PDT)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <Pine.LNX.4.44.0406231824350.13351-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.44.0406250046110.6668-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Chris Caputo wrote:
> On Mon, 21 Jun 2004, Trond Myklebust wrote:
> > På su , 20/06/2004 klokka 20:45, skreiv Marcelo Tosatti:
> > > Lets see if I get this right, while we drop the lock in iput to call 
> > > write_inode_now() an iget happens, possibly from write_inode_now itself 
> > > (sync_one->__iget) causing the inode->i_list to be added to to inode_in_use. 
> > > But then the call returns, locks inode_lock, decreases inodes_stat.nr_unused--
> > > and deletes the inode from the inode_in_use and adds to inode_unused. 
> > > 
> > > AFAICS its an inode with i_count==1 in the unused list, which does not
> > > mean "list corruption", right? Am I missing something here?
> > 
> > Yes. Please don't forget that the inode is still hashed and is not yet
> > marked as FREEING: find_inode() can grab it on behalf of some other
> > process as soon as we drop that spinlock inside iput(). Then we have the
> > calls to clear_inode() + destroy_inode() just a few lines further down.
> > ;-)
> > 
> > If the above scenario ever does occur, it will cause random Oopses for
> > third party processes. Since we do not see this too often, my guess is
> > that the write_inode_now() path must be very rarely (or never?) called.
> > 
> > > If you are indeed right all 2.4.x versions contain this bug.
> > 
> > ...and all 2.6.x versions...
> > 
> > I'm not saying this is the same problem that Chris is seeing, but I am
> > failing to see how iput() is safe as it stands right now. Please
> > enlighten me if I'm missing something.
> 
> I think this is a different (albeit apparently valid) problem.  In my case
> MS_ACTIVE (in iput() below) will be set since I am not unmounting a volume
> and so I believe iput() will return immediately after adding the inode to
> the unused list.
> 
> That said, I have added your patch to my test setup in case it helps.

I was able to duplicate the problem I am seeing even with Trond's patch
applied.  So the patch potentially solves a different problem but not the
one I am seeing.

Chris

