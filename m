Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUHCA6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUHCA6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUHCA5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:57:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:34745 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264791AbUHCA5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:57:10 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040731200036.GM23697@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
	 <20040731182741.GA21845@bliss>  <20040731200036.GM23697@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091490870.1649.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 00:54:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-07-31 at 21:00, Jens Axboe wrote:
> If you want it to work that way, you have the have a pass-through filter
> in the kernel knowing what commands are out there (including vendor
> specific ones). That's just too ugly and not really doable or
> maintainable, sorry.

I disagree providing you turn it the other way around. The majority of
scsi commands have to be protected because you can destroy the drive
with some of them or bypass the I/O layers. (Eg using SG_IO to do writes
to raw disk to bypass auditing layers)

So you need CAP_SYS_RAWIO for most commands. You can easily build a list
of sane commands for a given media type that are harmless and it fits
the kernel role of a gatekeeper to do that.

Providing the 'allowed' function is driver level and we also honour
read/write properly for that case (so it doesnt bypass block I/O
restrictions and fail the least suprise test) then it seems quite
doable.

For such I/O you'd then do

	if(capable(CAP_SYS_RAWIO) || driver->allowed(driver, blah, cmdblock))

If the allowed function filters positively "unknown is not allowed" and
the default allowed function is simply "no" it works.

We'd end up with a list of allowed commands for all sorts of operations
that don't threaten the machine while blocking vendor specific wonders
and also cases where users can do stuff like firmware erase.

Alan

