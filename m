Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUA0PQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUA0PQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:16:37 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:60045 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264290AbUA0PQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:16:35 -0500
Message-ID: <401680CE.2080007@samwel.tk>
Date: Tue, 27 Jan 2004 16:16:30 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
 disks? (to allow spin-downs)
References: <40140B0A.90707@isg.de> <20040125205219.GE26600@luna.mooo.com> <bv4atl$77d$1@gatekeeper.tmr.com>
In-Reply-To: <bv4atl$77d$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <20040125205219.GE26600@luna.mooo.com>,
> Micha Feigin  <michf@post.tau.ac.il> wrote:
> 
> | There are two things to do. First you should mount the disk with the
> | noatime option.
> 
> Hopefully on an idle system there isn't any access, so there isn't any
> atime impact. It would be nice if the atime write was very lazy, as in
> only when the file is closed or something. Like an atimeonclose option.

> | The other thing is ext3 which is updating its journal every 5
> | seconds. I was told that laptop-mode was imported into 2.6 by now (I
> | think that it is in the main stream). Check the kernel docs there
> | should be some mount option to state the dirty time for the ext3
> | journal. The method changed since 2.4 so I don't remember the 2.6
> | option since I don't use it yet, sorry.
> 
> Someone will have to explain that one, in a normal mount I would not
> expect an idle system to be doing anything on the filesystems.

Anything that reads anything from a filesystem updates the atime, I 
guess, even though the read data comes from the cache. This means that 
pages are dirtied, and they need to be written back. The atime is part 
of the filesystem metadata, so that might explain metadata journaling 
activity. AFAICS your system is not truly idle w.r.t the disk in 
question. Mount it with noatime and see if you can spin it down when you 
know it should really be idle. (You can use hdparm -y on it to spin it 
down by hand, so you don't have to wait for the hardware timer.) If it 
still spins up without atime, you know it isn't really idle, so you need 
to find out what app is accessing the disk. A look at the output of 
"lsof" can be enlightening. If that doesn't help, you can try to use 
laptop mode's block_dump functionality (without enabling laptop mode 
itself!) to see which process is reading/writing which block.

Laptop mode is not in 2.6 mainstream yet, it can be found in the -mm 
series. After you're done using block_dump you can get rid of laptop 
mode again: you don't need the actual mode, the spun-down times it gets 
you are way too short for your needs. Furthermore it's indiscriminate 
w.r.t disks, so it would have an undesired effect on your other disk as 
well.

-- Bart
