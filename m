Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268917AbRG3PZt>; Mon, 30 Jul 2001 11:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268918AbRG3PZ3>; Mon, 30 Jul 2001 11:25:29 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:21778
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268917AbRG3PZY>; Mon, 30 Jul 2001 11:25:24 -0400
Date: Mon, 30 Jul 2001 11:24:16 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>, Hans Reiser <reiser@namesys.com>
cc: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>,
        "Gryaznova E." <grev@namesys.botik.ru>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <272900000.996506656@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Saturday, July 28, 2001 03:28:05 AM +1000 Andrew Morton
<akpm@zip.com.au> wrote:

[ patch to trigger data writes before commit in reiserfs ]

> 
> There's no disruption to disk format - it just simulates
> the user typing `sync' at the right time.  I think the
> concept is sound, and I'm sure Chris can find a more efficient
> way...

Well, its gets points for simplicity ;-)  

What I think we need is for commit_write to put new buffers a per super
list of new buffers, and then the journal code can flush that list on
commit.

Since all the filesystems already mark things BH_New, it seems a good
choice to let commit_write look for BH_New buffers and put them on this new
list.  But, the only place BH_New seems to get cleared right now is
unmap_buffer, which only gets called from block_flushpage.

Is there any reason we can't just clear BH_New before writing the buffer
out?  It looks like a bug to leave it set the way we do now.

-chris

