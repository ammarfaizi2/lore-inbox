Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbULABAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbULABAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULAA7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:59:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13662 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261260AbULAAuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:50:04 -0500
Date: Wed, 1 Dec 2004 00:49:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Benoit Boissinot <bboissin@gmail.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Mike Kirk <mike.kirk@sympatico.ca>
Subject: Re: 2.6.10-rc2-mm3 [was: Re: 2.6.9-rc2: "kernel BUG at
    mm/rmap.c:473!"]
In-Reply-To: <20041130150639.GA11294@ens-lyon.fr>
Message-ID: <Pine.LNX.4.44.0412010028460.3344-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Benoit Boissinot wrote:
> 
> I had the same BUG_ON with 2.6.10-rc2-mm3 while transcoding a video.
> 
> kernel BUG at mm/rmap.c:479!
> CPU:    0
> EIP:    0060:[<c01454a4>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.10-rc2-mm3-arakou) 
> EIP is at page_remove_rmap+0x34/0x40
...
>  BUG: atomic counter underflow at:
>  [<c0103b57>] dump_stack+0x17/0x20
>  [<c011a51e>] do_exit+0x39e/0x420
>  [<c0103efc>] die+0x13c/0x140
...
> Bad page state at prep_new_page (in process 'mpd', page c17712c0)
> flags:0x40020114 mapping:00000000 mapcount:-1 count:0
> Backtrace:
>  [<c0103b57>] dump_stack+0x17/0x20
>  [<c0136352>] bad_page+0x72/0xb0
>  [<c013669b>] prep_new_page+0x2b/0x80

Thanks for the report.  I'm still searching for something useful
to say.  I've recently spent several days trying to deduce what's
behind such page_remove_rmap BUGs, but not yet come up with any
convincing hypothesis.  Yours is the first I've seen without
CONFIG_PREEMPT, so that's another potential culprit exonerated.

Some things which _might_ help me to shed more light on your case:
outputs of "objdump -rd" on your mm/memory.o, mm/rmap.o, kernel/exit.o;
and "cat /proc/$(pidof transcode)/maps" while transcode is running.

The atomic counter underflow in do_exit does suggest corruption
elsewhere than in transcode's page table (though I'm not at all
sure that is corrupt) - as always, it is worth giving memtest86
a thorough run to check your memory.

Thanks,
Hugh

