Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUHZUib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUHZUib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbUHZUey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:34:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29160 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269593AbUHZUcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:32:32 -0400
Date: Thu, 26 Aug 2004 21:32:28 +0100
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
Message-ID: <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org> <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 08:13:23PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
 
> Hey, if we lose the "can't unlink/rmdir/rename over something that is
> a mountpoint in other life" - I'm happy and we can get a lot of much
> more interesting stuff to work.  It will take some work (e.g. making
> sure we can find all vfsmounts over given mountpoint and sorting out
> the locking issues, which won't be trivial), but the main obstacle in
> that direction is not in architecture - it's in SuS and tradition; as
> the matter of fact, our life would be much easier if we stopped trying
> to give -EBUSY here and just dissolved all subtrees mounted on anything
> that has that dentry.

Argh...  OK, now I remember why I went for -EBUSY for unlink() (we obviously
are not bound by SuS on that one).  Consider the following scenario:
	* local file foo got something else bound on it for a while
	* we are tight on space - time to clean up
	* oh, look - contents of foo is junk
	* rm foo
	* ... oh, fuck, there goes the underlying file.
