Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSEMNtH>; Mon, 13 May 2002 09:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSEMNtG>; Mon, 13 May 2002 09:49:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29409 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313419AbSEMNtF>;
	Mon, 13 May 2002 09:49:05 -0400
Date: Mon, 13 May 2002 15:48:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Message-ID: <20020513134832.GV1106@suse.de>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CDFAEC0.6050403@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2002, Martin Dalecki wrote:
> Mon May 13 12:38:11 CEST 2002 ide-clean-62
> 
> - Add missing locking around ide_do_request in do_ide_request().

This is broken, do_ide_request() is already called with the request lock
held. tq_disk run -> generic_unplug_device (grab lock) ->
__generic_unplug_device -> do_ide_request(). You just introduced a
deadlock.

This code would have caused hangs or massive corruption immediately if
ide_lock wasn't ready held there. Not to mention instant spin_unlock
BUG() triggers in queue_command()

-- 
Jens Axboe

