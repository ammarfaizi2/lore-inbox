Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269447AbUHZTSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269447AbUHZTSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUHZTOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:14:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51680 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269338AbUHZTNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:13:31 -0400
Date: Thu, 26 Aug 2004 20:13:23 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[reposted in thread]

On Thu, Aug 26, 2004 at 11:46:33AM -0700, Linus Torvalds wrote:
> Note that we could try this out with existing filesystems with very 
> minimal changes:
> 
>  - make directory bind mounts work on top of files ("graft_tree()")
>  - make open_namei() and friend _not_ do the mount-point following for the 
>    last component if it's a non-directory.
>  - probably some trivial fixups I haven't thought about. There might be 
>    some places that use "S_ISDIR()" to check for whether something can be 
>    looked up, but the main path walking already just checks whether there
>    is a ".lookup" operation or not.
> 
> This would already allow people to "try out" how different applications 
> would react to a file that can show up both as a directory and a file. The 
> patch might end up being less than 25 lines or so, the difficulty is in 
> finding all the right places.

The real issue is what to do with unlink() et.al. on these guys.  Note
that "unlink is OK if all we have there is a bunch of directory mounts"
won't work well - we have no good way to check that condition.

Even funnier one is what we do if we have directory mounted there *and*
have something mounted on stuff in that directory.

Yes, that's one of the probable directions for such stuff, but there's a
lot of fun semantics questions and answers to them will matter a lot.

Hey, if we lose the "can't unlink/rmdir/rename over something that is
a mountpoint in other life" - I'm happy and we can get a lot of much
more interesting stuff to work.  It will take some work (e.g. making
sure we can find all vfsmounts over given mountpoint and sorting out
the locking issues, which won't be trivial), but the main obstacle in
that direction is not in architecture - it's in SuS and tradition; as
the matter of fact, our life would be much easier if we stopped trying
to give -EBUSY here and just dissolved all subtrees mounted on anything
that has that dentry.
