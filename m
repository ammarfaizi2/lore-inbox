Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVB0VKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVB0VKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 16:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVB0VKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 16:10:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38571 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261273AbVB0VKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 16:10:02 -0500
Date: Sun, 27 Feb 2005 16:09:54 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christian Schmid <webmaster@rapidforum.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
In-Reply-To: <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com>
References: <4221FB13.6090908@rapidforum.com>
 <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005, Rik van Riel wrote:

> Is it possible to detect when the write system call blocks?

OK, we got that on #kernelnewbies   Initially the trace looks
innocent enough, but there is something interesting going on
with the VM.  Something we may want to investigate...

<Dragony> Feb 27 21:12:34 s02 kernel: Call Trace:
<Dragony> Feb 27 21:12:34 s02 kernel:  [<803e1148>] io_schedule+0x28/0x40
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8015ac26>] sync_buffer+0x36/0x50
<Dragony> Feb 27 21:12:34 s02 kernel:  [<803e1396>] __wait_on_bit+0x66/0x70
<Dragony> Feb 27 21:12:34 s02 kernel:  [<803e1428>] out_of_line_wait_on_bit+0x88/0x90
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8015c2a5>] __bread_slow+0x65/0x90
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8015c5bd>] __bread+0x3d/0x50
<Dragony> Feb 27 21:12:34 s02 kernel:  [<801dcdc7>] ext2_get_branch+0x77/0x120
<Dragony> Feb 27 21:12:34 s02 kernel:  [<801dd187>] ext2_get_block+0x77/0x3c0
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8017d258>] do_mpage_readpage+0x1a8/0x4f0
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8017d64f>] mpage_readpages+0xaf/0x130
<Dragony> Feb 27 21:12:34 s02 kernel:  [<80140c56>] read_pages+0xf6/0x100
<Dragony> Feb 27 21:12:34 s02 kernel:  [<80140f47>] do_page_cache_readahead+0x117/0x1a0
<Dragony> Feb 27 21:12:34 s02 kernel:  [<801411ab>] page_cache_readahead+0x1db/0x240
<Dragony> Feb 27 21:12:34 s02 kernel:  [<80139b10>] do_generic_mapping_read+0x100/0x3f0
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8013a31b>] generic_file_sendfile+0x5b/0x70
<Dragony> Feb 27 21:12:34 s02 kernel:  [<8015a4b0>] do_sendfile+0x1f0/0x2c0

Looks like his program is doing a sendfile, which pauses
on reading things from disk.  So far, so good.

However, the big question is why the slowdowns go away
when min_free_kbytes is larger ?

As an additional hint, Christian is using sys_readahead.

Christian, how big are the data blocks you sys_readahead, and
how many do you have outstanding at a time ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
