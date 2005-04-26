Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVDZPnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVDZPnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVDZPlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:41:31 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54966 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S261592AbVDZPkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:40:24 -0400
Subject: Re: filesystem transactions API
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Jamie Lokier <jamie@shareable.org>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <426E4EBD.6070104@oktetlabs.ru>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	 <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	 <20050426134629.GU16169@viasys.com>
	 <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 11:40:02 -0400
Message-Id: <1114530002.29907.21.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 18:22 +0400, Artem B. Bityuckiy wrote:
> Jamie Lokier wrote:
> > I think I've wanted something like that for _years_ in unix.
> > 
> > It's an old, old idea, and I've often wondered why we haven't implemented it.
> > 
> 
> I thought it is possible to rather easily to implement this on top
> of non-transactional FS (albeit I didn't try) and there is no need
> to overcomplicate an FS. Just implement a specialized user-space
> library and utilize it.
There are actually plenty of things that make it harder than it first
seems to provide ACID transactions.  The two most difficult things are
going to be atomicity and isolation.

Atomicity is difficult, because you have lots of caches each with their
own bits of state (e.g., the inode/dentry caches).  Assuming your
transaction is committed that isn't so much of a problem, but once you
have on rollback you need to undo any changes to those caches.

Isolation (this is the property that says that concurrent transactions
should be the same as if there was a serial execution) is also tricky to
get right.  A transaction can touch any number of objects, and user-
applications may not respect any lock ordering --- which means you will
have deadlocks, and you must detect and resolve them (probably by
aborting one of the transactions).

None of these problems are insurmountable, and there are definitely good
reasons to use transactions.  For example, RPM uses transactions to
update its own databases, it would be great if it could use transactions
to update the whole file system.  Mail servers also have to go through
hoops to provide atomic updates.  Isolation takes care of race
conditions.

At our lab, we've been experimenting with transactional file systems.
We've ported the Berkeley database to the kernel, because it already
provides ACID transactions.  We've also built a simple file system on
top of it, with a rudimentary transactions API that is exposed to user-
level.  One of the key things that we've learned is that it isn't very
easy to just "bolt" transactions onto your file system after the fact,
because there are just so many interactions between the file system,
caches, and the transaction manager.

Charles

