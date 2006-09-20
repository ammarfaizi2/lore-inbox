Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWITXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWITXSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWITXSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:18:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34195 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750855AbWITXSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:18:41 -0400
Date: Wed, 20 Sep 2006 16:18:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: alan@lxorguk.ukuu.org.uk, rohitseth@google.com,
       ckrm-tech@lists.sourceforge.net, devel@openvz.org, npiggin@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920161831.a4839828.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773699.7705.19.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chistroph, responding to Alan:
> > I'm also not clear how you handle shared pages correctly under the fake
> > node system, can you perhaps explain that further how this works for say
> > a single apache/php/glibc shared page set across 5000 containers each a
> > web site.
> 
> Cpusets can share nodes. I am not sure what the problem would be? Paul may 
> be able to give you more details.

Cpusets share pre-assigned nodes, but not anonymous proportions of the
total system memory.

So sharing an apache/php/glibc page set across 5000 containers using
cpusets would be awkward.  Unless I'm missing something, you'd have to
prepage in that page set, from some task allowed that many pages in
its own cpuset, then you'd run each of the 5000 web servers in smaller
cpusets that allowed space for the remainder of whatever that web
server was provisioned, not counting the shared pages.  The shared pages
wouldn't count, because cpusets doesn't ding you for using a page that
is already in memory -- it just keeps you from allocating fresh pages
on certain nodes.  When it came time to do rolling upgrades to new
versions of the software, and add a marketing driven list of 57
additional applications that the customers could use to build their
website, this could become an official nightmare.

Overbooking (selling say 10 Mbs of memory for each server, even though
there is less than 5000 * 10 Mb total RAM in the system) would also be
awkward.  One could simulate with overlapping sets of fake numa nodes,
as I described in an earlier post today (the one that gave each task
some four of the five 20 MB fake cpusets.) But there would still be
false resource conflicts, and the (ab)use of the cpuset apparatus for
this seems unintuitive, in my opinion.

I imagine that a web site supporting 5000 web servers would be very
interested in overbooking working well.  I'm sure the $7.99/month
cheap as dirt virtual web servers of which I am a customer overbook.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
