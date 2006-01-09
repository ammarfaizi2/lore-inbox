Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWAIJoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWAIJoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWAIJoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:44:16 -0500
Received: from silver.veritas.com ([143.127.12.111]:13355 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751214AbWAIJoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:44:15 -0500
Date: Mon, 9 Jan 2006 09:44:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Ryan Richter <ryan@tau.solarneutrino.net>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
 <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net>
 <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
 <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 09:44:11.0525 (UTC) FILETIME=[3E8D8350:01C61501]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, Linus Torvalds wrote:
> 
> Code like that should use "set_page_dirty()", which does the appropriate 
> callbacks to the filesystem for that page. I wonder if the bug is simply 
> because the ST code just sets the dirty bit without telling anybody else 
> about it...

Yes, it should be using set_page_dirty_lock(), and that is already known
about (I have patches for this and similar sg.c, but the sg.c case is
tougher and not yet finished); but entirely irrelevant to Ryan's case.

Quite apart from the fact that he's doing backups to tape (not dirtying
the memory from this driver), you'll find that it even passes dirty 0
when reading into the memory (another bug; whereas sg.c conversely says
it's always dirtying when it isn't).  So there's no point in Ryan
fiddling with the SetPageDirty.

It's an intriguing problem because it's signature is so regular,
and I've spent many hours trying to work out how it might come about,
but unsuccessfully so far.  Your adjustment to the put_page_testzero
BUG_ON was a good idea, but it still hasn't shone a light.  I'm
keeping quiet until I find something useful to add.

Perhaps we just need a few more people to add sgl[i].page = NULL ;)

Hugh
