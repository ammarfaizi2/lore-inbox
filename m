Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWFZSkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWFZSkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWFZSkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:40:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64209 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932636AbWFZSkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:40:15 -0400
Date: Mon, 26 Jun 2006 11:39:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: akpm@osdl.org, clameter@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
Message-Id: <20060626113950.571d3e4c.pj@sgi.com>
In-Reply-To: <20060625211929.GA3865@localhost.localdomain>
References: <20060625115736.d90e1241.akpm@osdl.org>
	<20060625211929.GA3865@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran wrote:
> The idea behind __read_mostly is to separate variables like cpu maps,
> bootcpuinfo etc which are written to very very rarely -- during 
> initialization/hot-plugging, but read quite often something like ~100 % read
> ratio.  

So these variables are __read_hot_write_cold?

In other words, the name __read_mostly is a little misleading, in my
book.  That name only suggests read much more than written.  In your
words:

    something like 99:1 read

It doesn't state that the variable is so "read hot", it is worth keeping
off "write hot" cache lines.

Let's say for example we have a variable is accessed only once per
hour, and that this access is always a read except once a week (once
every 168 hours) when it is a write.

I would not mark that variable __read_mostly, even though it passed
your 99:1 test.  That variable is read_cold_write_evencolder.  It's an
ideal candidate for the canon fodder that we use to fill up the rest
of a cache line that has a hot variable.

If Andrew's suggestion to remove __read_mostly doesn't fly, then I'd
vote for a name change:

  __read_mostly ==> __read_hot_write_cold

I think we want to identify the hottest memory words, keeping them
on separate cache lines, except that __read_hot_write_cold words can
share cache lines with each other.

A given cache line would have at most one hot write word, or one or
more read hot, write cold words.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
