Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVDMOhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVDMOhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDMOg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:36:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:11429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbVDMOge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:36:34 -0400
Date: Wed, 13 Apr 2005 07:38:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
In-Reply-To: <1113384304.12012.166.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.58.0504130732230.4501@ppc970.osdl.org>
References: <20050409200709.GC3451@pasky.ji.cz>  <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
  <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> 
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>  <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz>  <20050411015852.GI5902@pasky.ji.cz>
 <20050411135758.GA3524@pasky.ji.cz>  <1113311256.20848.47.camel@hades.cambridge.redhat.com>
  <20050413094705.B1798@flint.arm.linux.org.uk>  <20050413085954.GA13251@pasky.ji.cz>
 <1113384304.12012.166.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2005, David Woodhouse wrote:
> 
> I'd even like to see support for using multiple branches checked out of
> the same .git/ repository.

David, we already can. The objects are _designed_ to be shared.

However, that is the ".git/objects" subdirectory. Not the per-view stuff. 
For each _view_ you do need to have view-specific data, and the view index 
very much is that. That's ".git/index". 

The index file isn't small - it's about 1.6MB for a kernel tree, because
it needs to list every single file we know about, its "stat" information,
and it's sha1 backing store. So multiply 17,000 by ~40, and add in the
size of the name of each file, and avoid compression because this is read
and written _all_ the time, and you end up with 1.6MB.

But you _need_ one per checked-out tree.  And it really _is_ private. It's
not supposed to be shared. In fact, it _cannot_ be shared, because it
doesn't have sufficient locking (it has some, but that's just to catch
_errors_ when somebody tries to do two operations that update the index
file at the same time in the same view). But even ignoring the locking
issues, it just isn't appropriate, it's not how that file works.

In other words, that index file simply _cannot_ be shared. Don't even 
think about it. Only madness will ensue.

		Linus
