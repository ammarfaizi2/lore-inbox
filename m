Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWE3JV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWE3JV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWE3JV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:21:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6976 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932205AbWE3JVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:21:25 -0400
Date: Tue, 30 May 2006 11:23:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Adaptive readahead V14
Message-ID: <20060530092309.GH4199@suse.de>
References: <348745084.15239@ustc.edu.cn> <44788C8A.2070900@tls.msk.ru> <348818092.32485@ustc.edu.cn> <4479F8B5.90906@tls.msk.ru> <20060529030152.GA5994@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529030152.GA5994@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29 2006, Wu Fengguang wrote:
> On Sun, May 28, 2006 at 11:23:33PM +0400, Michael Tokarev wrote:
> > Wu Fengguang wrote:
> > > 
> > > It's not quite reasonable for readahead to worry about media errors.
> > > If the media fails, fix it. Or it will hurt read sooner or later.
> > 
> > Well... In reality, it is just the opposite.
> > 
> > Suppose there's a CD-rom with a scratch/etc, one sector is unreadable.
> > In order to "fix" it, one have to read it and write to another CD-rom,
> > or something.. or just ignore the error (if it's just a skip in a video
> > stream).  Let's assume the unreadable block is number U.
> > 
> > But current behavior is just insane.  An application requests block
> > number N, which is before U. Kernel tries to read-ahead blocks N..U.
> > Cdrom drive tries to read it, re-read it.. for some time.  Finally,
> > when all the N..U-1 blocks are read, kernel returns block number N
> > (as requested) to an application, successefully.
> > 
> > Now an app requests block number N+1, and kernel tries to read
> > blocks N+1..U+1.  Retrying again as in previous step.
> > 
> > And so on, up to when an app requests block number U-1.  And when,
> > finally, it requests block U, it receives read error.
> > 
> > So, kernel currentry tries to re-read the same failing block as
> > many times as the current readahead value (256 (times?) by default).
> 
> Good insight... But I'm not sure about it.
> 
> Jens, will a bad sector cause the _whole_ request to fail?
> Or only the page that contains the bad sector?

Depends entirely on the driver, and that point we've typically lost the
fact that this is a read-ahead request and could just be tossed. In
fact, the entire request may consist of read-ahead as well as normal
read entries.

For ide-cd, it tends do only end the first part of the request on a
medium error. So you may see a lot of repeats :/

-- 
Jens Axboe

