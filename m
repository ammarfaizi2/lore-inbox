Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUBLR1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266542AbUBLR1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:27:42 -0500
Received: from mail.ccur.com ([208.248.32.212]:38674 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266544AbUBLR1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:27:36 -0500
Subject: Re: PATCH - raise max_anon limit
From: Jim Houston <jim.houston@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: thockin@sun.com, torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, george@mvista.com
In-Reply-To: <20040211172046.37e18a2f.akpm@osdl.org>
References: <20040211203306.GI9155@sun.com>
	 <Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
	 <20040211210930.GJ9155@sun.com> <20040211135325.7b4b5020.akpm@osdl.org>
	 <20040211222849.GL9155@sun.com> <20040211144844.0e4a2888.akpm@osdl.org>
	 <20040211233852.GN9155@sun.com> <20040211155754.5068332c.akpm@osdl.org>
	 <20040212003840.GO9155@sun.com> <20040211164233.5f233595.akpm@osdl.org>
	 <20040212010822.GP9155@sun.com>  <20040211172046.37e18a2f.akpm@osdl.org>
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1076606773.990.165.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Feb 2004 12:26:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 20:20, Andrew Morton wrote:
> Tim Hockin <thockin@sun.com> wrote:
> > No, it doesn't store the counter with the id.  They expect you to do that.
> > My best understanding is that thi sis to prevent re-use of the same key.
> > I'm not sure I grok why it is useful.  If you release a key, it should be
> > safe to reuse.  Period.  I assume there was some use case that brought about
> > this "feature" but if so, I don't know what it is.  The big comment about it
> > is just confusing me.
> 
> Maybe Jim can tell us why it's there.  Certainly, the idr interface would
> be more useful if it just returned id's which start from zero.

Hi Andrew, Everyone,

If this new use of idr.c as a sparse bitmap catches on, it might deserve
a new flavor which would not waste the space for the pointer array
at the lowest layer.

When I wrote the original code, I was thinking of allocating process
id values where there is a tradition of allocating sequential values.
 
George Anzinger rewrote most of my code.  The r in idr.c is for
immediate reuse.  His version picks the lowest available bit in the
sparse bitmap.  The RESERVED_BITS comments seem to be stale.

The rational for avoiding immediate reuse of id values is to catch
application errors.   Consider:

	fd1 = open_like_call(...);
	read(fd1,...);
	close(fd1);
	fd2 = open_like_call(...);
	write(fd1...);

If fd2 has a different value than the recently closed fd1, the
error is detected immediately.

Jim Houston - Concurrent Computer Corp.

