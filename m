Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTKAA1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTKAA1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 19:27:43 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:2944
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S262071AbTKAA1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 19:27:42 -0500
Date: Fri, 31 Oct 2003 19:26:51 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jariruusu@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-ID: <20031101002650.GA7397@fukurou.paranoiacs.org>
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031031015500.44a94f88.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 01:55:00 -0800, Andrew Morton wrote:
> Ben Slusky <sluskyb@paranoiacs.org> wrote:
> > The current memory allocation procedure really is inadequate. It worked
> > ok up thru 2.4 because the loop device was used almost exclusively
> > as a nifty hack to make an initrd or to double-check the ISO you just
> > created.
> 
> mm..  Last time I looked the 2.4 loop driver is fairly robust from the
> memory management point of view.

Memory management is fine after we've allocated the memory. The problem is
in the approach of going back to square one if only n-1 out of n pages
could be allocated. That approach is inherently prone to deadlock.

> Here's the patch; feel free to benchmark it.  It kills 200 lines of code
> and unifies the block-backed and file-backed codepaths.  That surely is a
> good thing.

I will benchmark it soon... meantime I have a real concern about what
you've done to block-backed loop reads. Now the loop thread has to read
and transform (decrypt) each bio, whereas in the old code reading was
done asynchronously in the backing block device driver, leaving the loop
thread free to do some transforms at the same time. I don't see how this
could not hurt performance.

> It fixes bug 1198 too, it appears.

The file-backed loop code path allocates memory in a sane fashion.
File-backed loops never manifested the bug.

-- 
Ben Slusky                      | A free society is a society
sluskyb@paranoiacs.org          | where it is safe to be
sluskyb@stwing.org              | unpopular.
PGP keyID ADA44B3B              |               -Adlai Stevenson

