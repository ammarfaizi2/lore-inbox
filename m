Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTJQEpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 00:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTJQEpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 00:45:17 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19328 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263301AbTJQEpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 00:45:13 -0400
Subject: Re: /proc reliability & performance
From: Albert Cahalan <albert@users.sf.net>
To: Brian McGroarty <brian@mcgroarty.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, lm@bitmover.com
In-Reply-To: <20031017032436.GA17480@mcgroarty.net>
References: <1066356438.15931.125.camel@cube>
	 <20031017032436.GA17480@mcgroarty.net>
Content-Type: text/plain
Organization: 
Message-Id: <1066365074.15931.195.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2003 00:31:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 23:24, Brian McGroarty wrote:
> On Thu, Oct 16, 2003 at 10:07:18PM -0400, Albert Cahalan wrote:
> > I created a process with 360 thousand threads,
> > went into the /proc/*/task directory, and did
> > a simple /bin/ls. It took over 9 minutes on a
> > nice fast Opteron. (it's the same at top-level
> > with processes, but I wasn't about to mess up
> > my system that much)
> 
> Are there many cases where the /proc directory
> contents are read in this fashion?

Sure. Run any of: top, ps, lsof, fuser...

> I'd be more curious about how performance fares
> with reading a thousand entries by name with 1k
> processes and with 360k processes.

Judging by the crazy example and the observation
that an O(n*n) algorithm is involved, directory
reads on that very fast machine should get annoying
once you have a few thousand processes. They'd be
perceptable one-by-one, which adds up when you have
multiple reads due to scripts, top, or multiple
users.

Anyway, it's not just about performance! That's
only half of the problem. The other half is
reliability. The way /proc works is this:

Count tasks as you read them. The number is
your directory offset. Return a few dozen entries
at a time. For each read, you'll need to find
back your place. You do this by counting tasks
until you reach your offset. Of course, tasks
will have been created and destroyed between
reads, so who knows where you'll continue from?

That's simply not reliable.


