Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVLEUdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVLEUdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVLEUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:33:46 -0500
Received: from pat.uio.no ([129.240.130.16]:64399 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751438AbVLEUdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:33:45 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133813590.12393.7.camel@lade.trondhjem.org>
References: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>
	 <1133813590.12393.7.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-wMu2IWA2fX3n9XbKaOhx"
Date: Mon, 05 Dec 2005 15:33:26 -0500
Message-Id: <1133814806.12393.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.828, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wMu2IWA2fX3n9XbKaOhx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-12-05 at 15:13 -0500, Trond Myklebust wrote:
> On Mon, 2005-12-05 at 10:01 -0800, Kenny Simpson wrote:
> > Tested with rc5 - same results.  It was suggested that I run slabtop when the system freezed, so
> > here is that info: (again, by hand, I'm getting another machine to use either netconsole or a
> > serial cable).
> > 
> >  Active / Total Objects (% used)    : 478764 / 485383 (98.6%)
> >  Active / Total Slabs (% used)      : 14618 / 14635 (99.9%)
> >  Active / Total Caches (% used)     : 79 / 138 (57.2%)
> >  Active / Total Size (% used)       : 56663.79K / 57566.41K (98.4%)
> >  Minimum / Average / Maximum Object : 0.01K / 0.12K / 128.00K
> > 
> >   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
> > 403088 403088 100%    0.06K   6832       59     27328K nfs_page
> >  30380  30380 100%    0.50K   4340        7     17360K nfs_write_data
> >  15134  15134 100%    0.27K   1081       14      4324K radix_tree_node
> > ...
> > 
> > 
> > The other thing is that the stack trace showsd slabtop as being halted in throttle_vm_writeout
> > while allocating memory, and the writetest was halted waiting to allocate memory.
> 
> Can somebody VM-savvy please explain how on earth they expect something
> like throttle_vm_writeout() to make progress? Shouldn't that thing at
> the very least be kicking pdflush every time it loops?

Can you try something like this patch, Kenny?

Cheers,
  Trond



--=-wMu2IWA2fX3n9XbKaOhx
Content-Disposition: inline; filename=linux-2.6.15-throttle_kicks_pdflush.dif
Content-Type: text/plain; name=linux-2.6.15-throttle_kicks_pdflush.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

VM: Ensure that throttle_vm_writeout() can make progress

 Once a process is in the loop inside throttle_vm_writeout(), it has
 no guarantee that it will ever get out, since there is nothing that
 will kickstart the flushing of unstable writes.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 mm/page-writeback.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5240e42..9a66dee 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -306,6 +306,8 @@ void throttle_vm_writeout(void)
 
                 if (wbs.nr_unstable + wbs.nr_writeback <= dirty_thresh)
                         break;
+		if (wbs.nr_unstable != 0)
+			wakeup_pdflush(wbs.nr_unstable);
                 blk_congestion_wait(WRITE, HZ/10);
         }
 }

--=-wMu2IWA2fX3n9XbKaOhx--

