Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVASAoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVASAoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVASAoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:44:20 -0500
Received: from almesberger.net ([63.105.73.238]:28432 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261508AbVASAoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:44:15 -0500
Date: Tue, 18 Jan 2005 21:43:29 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-ID: <20050118214329.A26705@almesberger.net>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk> <20050118010342.GA24328@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118010342.GA24328@node1.opengeometry.net>; from opengeometry@yahoo.ca on Mon, Jan 17, 2005 at 08:03:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> The problem at hand is that USB key drive (which is my immediate
> concern) takes 5sec to show up.  So, it's much better approach than
> 'initrd'.

I'm a little biased, but I disagree ;-) The main problems with initrd
seem to be that it adds at least one more moving part, and that most
initrd-making procedures give you something non-interactive that
hardly interacts with the outside world. Lo and behold, nobody likes
sudden silent failure of a complex and opaque subsystem, particularly
if it happens to be vitally important.

I think initrds could be greatly improved by including a BusyBox in
their failure paths (plus a way to manually enter the BusyBox, in case
apparent success still means failure). That way, you can actually try
to fix things if there are problems.

Another issue is configuration data that has to exist in the initrd,
yielding a possibly complex initrd construction process that has to
follow each configuration change. Also there, an initrd could be able
to try to access the regular file system to access such information,
possibly combined with caching and heuristics. (I realize that this
isn't trivial and bears a high risk of intractable failure paths, but
I also think that it's worth exploring this direction.)

Regarding the delayed mount problem, I think some retry procedure may
be the best possible band-aid for a while. While it would be desirable
for the USB subsystem (etc.) to just block until the device is ready,
this doesn't work so well if the presence of the device can't be
predicted at that point, e.g. if a "devfs" (udev, etc.) name has to be
looked up first.

I'm not sure I understand Al's concern with devices popping up in the
middle of the loop. For all practical purposes, mounting the root file
system has a single target anyway, so it can't really compete with
anything else. Automatically selected alternative roots can make
sense, but that's sufficiently policy-ish that I think it would be
better kept in an initrd, where instrumentation is more naturally
added than in the kernel.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
