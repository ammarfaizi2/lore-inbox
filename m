Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUBLSup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUBLSup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:50:45 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:39383 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S266536AbUBLSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:50:42 -0500
Date: Thu, 12 Feb 2004 10:49:03 -0800
From: Tim Hockin <thockin@sun.com>
To: Jim Houston <jim.houston@ccur.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040212184903.GS9155@sun.com>
Reply-To: thockin@sun.com
References: <20040211135325.7b4b5020.akpm@osdl.org> <20040211222849.GL9155@sun.com> <20040211144844.0e4a2888.akpm@osdl.org> <20040211233852.GN9155@sun.com> <20040211155754.5068332c.akpm@osdl.org> <20040212003840.GO9155@sun.com> <20040211164233.5f233595.akpm@osdl.org> <20040212010822.GP9155@sun.com> <20040211172046.37e18a2f.akpm@osdl.org> <1076606773.990.165.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076606773.990.165.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 12:26:14PM -0500, Jim Houston wrote:
> > Maybe Jim can tell us why it's there.  Certainly, the idr interface would
> > be more useful if it just returned id's which start from zero.
> 
> Hi Andrew, Everyone,
> 
> If this new use of idr.c as a sparse bitmap catches on, it might deserve
> a new flavor which would not waste the space for the pointer array
> at the lowest layer.

the only place I found using idr as-is is posix timers.  I haven't looked at
it's usage pattern much, but I assume it does use the pointers.  I guess
we're using up sizeof(void *) for every id we allocate, which is yuck.

Do we need to clone idr.c into bitmap.c and simplify?

> George Anzinger rewrote most of my code.  The r in idr.c is for
> immediate reuse.  His version picks the lowest available bit in the

That is the behavior that makes most sense, to me.

> The rational for avoiding immediate reuse of id values is to catch
> application errors.   Consider:
> 
> 	fd1 = open_like_call(...);
> 	read(fd1,...);
> 	close(fd1);
> 	fd2 = open_like_call(...);
> 	write(fd1...);
> 
> If fd2 has a different value than the recently closed fd1, the
> error is detected immediately.

Is that really worth working around in such a gross way?  No offense to the
idea, but that's a pretty dumb bug to be hacking a failsafe for :)

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
