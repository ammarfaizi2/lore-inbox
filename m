Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVBSDGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVBSDGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 22:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVBSDGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 22:06:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2740 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261612AbVBSDGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 22:06:21 -0500
Subject: Re: [RFC][PATCH] Dynamically allocated pageflags.
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
References: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 19:02:07 -0800
Message-Id: <1108782127.19253.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 13:43 +1100, Nigel Cunningham wrote:
> For some time now, we've been running out of bits for pageflags.
> 
> In Suspend2, I need the functional equivalent of pageflags, but don't
> need them when Suspend isn't running. One of the outcomes of the last
> submission of Suspend2 for review was that I changed the format in which
> that data is stored, creating something I call dynamically allocated
> pageflags.
> 
> It's a simple idea: we tie together a bunch of order zero allocated
> pages using a kmalloc'd list of poiinters to those pages, and store the
> location of that kmalloc'd list in what's really an unsigned long **
> (typedef'd). We also provide macros so that calls for setting and
> clearing flags can look just like ordinary pageflag set/clear/test
> invocations.
> 
> Helpers are also provided for allocating and freeing the maps.

I'm kicking myself because I thought about this 2 minutes after we
talked on IRC.  

One issue is that it doesn't work with DISCONTIGMEM (or the upcoming
sparsemem).  max_mapnr doesn't exist on those systems, and on the really
discontiguous ones, you might be allocating very large areas with very
sparse maps.

One thing that I've been thinking about for these things is something
tree-based.  A 1 or 2-level tree, like pagetables should be fast enough,
and handle the sparse and discontiguous layouts a little better than a
flat one.  We could even do a flat bitmap for normal systems, and #ifdef
in the table only when it's needed.  I can take a look at doing this
next week.

-- Dave

