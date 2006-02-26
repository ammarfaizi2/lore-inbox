Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWBZIbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWBZIbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 03:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBZIbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 03:31:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:713 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751268AbWBZIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 03:31:13 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <440166E9.8050608@s5r6.in-berlin.de>
Date: Sun, 26 Feb 2006 09:29:29 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org> <1140930888.3279.4.camel@mulgrave.il.steeleye.com> <20060226053138.GM27946@ftp.linux.org.uk>
In-Reply-To: <20060226053138.GM27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.723) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sat, Feb 25, 2006 at 11:14:48PM -0600, James Bottomley wrote:
...
>>The problem is that it's a change
>>to sd and a change to scsi_lib in a fairly critical routine.  While I'm
>>reasonably certain the change is safe, I'd prefer to make sure by
>>incubating in -mm for a while.
>>
>>The title, by the way, is misleading; it's not a memory corruption in sd
>>at all really.  It's the initio bridge which produces a totally
>>standards non conformant return to a mode sense which produces the
>>problem.  And so, it's only the single initio bridge which is currently
>>affected; hence the caution.
> 
> No.  It's sd.c assuming that mode page header is sane, without any
> checks.  And yes, it does give memory corruption if it's not.
> 
> Initio-related part is in scsi_lib.c (and in recovery part of sd.c
> changes).  That one is about how we can handle gracefully a broken
> device that gives no header at all.
> 
> Checks for ->block_descriptors_length are just making sure we won't try
> to do any access past the end of buffer, no matter what crap we got from
> device.

That's why I split Al's patch. Part 1/2 prevents sd from using values 
from buggy firmwares to overwrite memory where sd has no business to 
write at. As Al explained, the culprit is sd which feeds a too big len 
to scsi_mode_sense()'s memset(buffer, 0, len). Patch 2/2 adds an Initio 
specific workaround. (The 2nd part is not necessarily material for 
-stable, although it assures correct cache handling for Initio based 
SBP-2 HDDs.)

Please merge the sd fix ASAP (part 1/2). Users _are_ seeing memory 
corruption or panic in interrupt context without this patch. Fully 
reproducable, probably with all Initio SBP-2 bridges which exist; and 
these are actually popular chips for 1394a S400 as well as 1394b S800 
products, both noname and branded products.

The 2nd part could perhaps go through -mm. If you wish I resend it to 
Andrew. Al, what do you think? I believe this patch to be safe for 
non-broken devices though.

BTW I missed a small whitespace mishap in pt 2/2 which is why I should 
repost it anyway:
-+		} else if(use_10_for_ms) {
++		} else if (use_10_for_ms) {
-- 
Stefan Richter
-=====-=-==- --=- ==-=-
http://arcgraph.de/sr/
