Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTKGWCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTKGWAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:00:39 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:8664 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264354AbTKGOSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 09:18:37 -0500
Subject: Re: SFFDC and blksize_size
From: David Woodhouse <dwmw2@infradead.org>
To: simon@baydel.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <37CC93E8710D@baydel.com>
References: <37CC93E8710D@baydel.com>
Content-Type: text/plain
Message-Id: <1068214714.6065.887.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-3.dwmw2.1) 
Date: Fri, 07 Nov 2003 14:18:35 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 13:12 +0000, Simon Haynes wrote:
> I have been writing a block driver for SSFDC compliant SMC cards. This stuff 
> allocates 16k blocks.  When I get requests the transfers are split into the 
> size I specifty in the blksize_size{MAJOR] array. 

You can't set a block size larger than page size.

> It sems that most things 
> set this to 1k. In my case this causes a performance problem  as I have to 
> end up doing 16 * (16K write,  16K read, 16k erase)  to write and verify a 
> 16k block which has been previously written.

Urgh. Whereas with FTL, NFTL etc. you can just fill in new sectors
individually in the newly-allocated eraseblock. 

Surely you're not actually erasing the block and then praying you don't
lose power before writing the new contents back? There's some kind of
chaining from the old to the new block? Can't you say which sectors are
valid in the new block, and which should still be used from the old?

I wouldn't advocate setting the block size even to 4KiB, since that'll
waste a lot of space. But we could certainly make use of request merging
if what you're doing really is necessary -- we can make a
'write_sectors' function which writes more than a sector at a time.

-- 
dwmw2

