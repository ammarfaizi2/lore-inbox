Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269664AbUHZXdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbUHZXdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbUHZX3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:29:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:32936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269784AbUHZX1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:27:48 -0400
Date: Thu, 26 Aug 2004 16:24:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
In-Reply-To: <20040826225308.GC21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408261619230.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
 <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
 <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org>
 <20040826225308.GC21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> What dentry->d_mountpoint?  No such thing...

Sorry - set "dentry->d_mounted++" + "add vfsmount/dentry to hashes".

Yes, it's not a direct list off the dentry, but it effectively is the same
thing.

So basically: the "d_mounted++" just makes sure we get into
"lookup_mnt()". That's where we will usually find the actual mount thing.

And that's also where the special case comes in: if we _don't_ find the 
mount thing there, that's where we need to create it. That will only 
happen if somebody looks it up using another namespace, though, so it 
should be rare.

And when it does happen, we can just create a new vfsmount - we have all
the information there (we'll have to walk the per-inode-or-whatever
vfsmount list to find all the information to populate the thing with, of
course. But we need that list _anyway_, so it should be a fairly 
straightforward special case).

			Linus
