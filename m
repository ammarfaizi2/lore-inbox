Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292633AbSCKUOI>; Mon, 11 Mar 2002 15:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292708AbSCKUOB>; Mon, 11 Mar 2002 15:14:01 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49931 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292633AbSCKUNj>; Mon, 11 Mar 2002 15:13:39 -0500
Message-ID: <3C8D0FA2.6040803@evision-ventures.com>
Date: Mon, 11 Mar 2002 21:12:18 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Davide Libenzi <davidel@xmailserver.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: ide timer trbl ...
In-Reply-To: <E16kWD2-0001bG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Would you mind as well to just apply ide-clean-18 and ide-clean-19
>>on top of each other and recheck?
>>
> 
> We see that one on 2.4 if you enable some of the work in progress options.
> It seems that the timeout path is forgetting to clear the old handler. I've
> not pinned it down since its deep in the WIP stuff.

Ahh... this is really helpfull. Indeed I see the same. At most
places ide_set_handler get's just called without clearing
it before. This means that the IRQ handler routine abused as timeout handler
doesn't clear it as well. For example one could imagine that reset_pollfunc
get's called multiple times one after another on asynchronous interfaces.

Hmm but if one thinks a bit further: the timer is an entity related to a
command. If we stop sending commands with the assumption that master vers. slave
oprtations are mutual on each other, then it becomes abvious that this timeout
timer is indeed an entity, which should be hooked to a particular drive and not 
just the interface (ide_hwif_t). So the fix will be a bit much
more involved. This may very well explain the problems of Zwambe as
well... (disks overlapping with CD-ROM operations).

Please correct me if my reasoning is wrong.

