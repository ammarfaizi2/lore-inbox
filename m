Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUEYGbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUEYGbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 02:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUEYGbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 02:31:09 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:62409 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263088AbUEYGbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 02:31:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Nathan Scott <nathans@sgi.com>
Date: Tue, 25 May 2004 16:29:57 +1000
Message-ID: <16562.59365.755616.435629@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: hch@infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
       Leonardo Macchia <leo@bononia.it>, 250477@bugs.debian.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#250477: kernel-source-2.4.26: Lots of debug in RAID5
In-Reply-To: message from Nathan Scott on Monday May 24
References: <20040523085801.2878013C002@nomade.ciram.unibo.it>
	<20040523105351.GB19402@gondor.apana.org.au>
	<20040523111622.GA24817@infradead.org>
	<20040524110059.B751892@wobbly.melbourne.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 24, nathans@sgi.com wrote:
> On Sun, May 23, 2004 at 07:16:22AM -0400, hch@infradead.org wrote:
> > On Sun, May 23, 2004 at 08:53:51PM +1000, Herbert Xu wrote:
> > > > --- kernel-source-2.4.26/drivers/md/raid5.c	2003-08-30 06:01:38.000000000 +0000
> > > > +++ kernel-source-2.4.26-nodebug/drivers/md/raid5.c	2004-05-23 08:54:36.000000000 +0000
> > > > @@ -282,7 +282,7 @@
> > > >  				}
> > > >  
> > > >  				if (conf->buffer_size != size) {
> > > > -					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> > > > +					PRINTK("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
> > > >  					shrink_stripe_cache(conf);
> > > >  					if (size==0) BUG();
> > > >  					conf->buffer_size = size;
> > > 
> > > Thanks for the patch.  This does indeed look like a typo.
> > > 
> > > Hi Neil, does this patch look OK to you?
> > 
> > No, this was rejected a few times already.  The problem is that XFS
> > uses differen I/O sizes for the log and other I/O which makes raid
> > performance suck really badly.  The real fix is to use the v2 XFS log
> > format when using software raid5.
> 
> What is really wanted is the -ssize=4096 option to mkfs.xfs.
> This does the 4k aligned log IO Christoph is talking about
> here, and also sizes a few other XFS ondisk structures such
> that there is no I/O to the device that is not 4K aligned.
> 
> Neil, I wonder if we could make the message more informative?
> Maybe some words about a suboptimal filesystem configuration,
> or something to that effect.

That would possibly be reasonable.
I would only want the extra message if the 'switching cache buffer
size' messages happened at a high rate, and occasional individual
messages are not an indication of a problem at all.

Maybe something like the following, but the recent/cnt/warned should
really be per-array.

NeilBrown
===========================================================
convert high-frequency raid5 warning to more specific warning.

Atleast 'warned', and possible cnt,recent should be per-array.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

 ----------- Diffstat output ------------
 ./drivers/md/raid5.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2004-05-25 16:22:56.000000000 +1000
+++ ./drivers/md/raid5.c	2004-05-25 16:27:54.000000000 +1000
@@ -282,7 +282,21 @@ static struct stripe_head *get_active_st
 				}
 
 				if (conf->buffer_size != size) {
-					printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
+					static long recent;
+					static int cnt;
+					static int warned;
+					if (time_after(recent+HZ, jiffies))
+						cnt++;
+					else {
+						recent = jiffies;
+						cnt = 0;
+					}
+					if (cnt > 50 && ! warned) {
+						printk("raid5: WARNING:array used in unsupported configuration, expect poor performance\n");
+						warned = 1;
+					}
+					if (!warned)
+						printk("raid5: switching cache buffer size, %d --> %d\n", oldsize, size);
 					shrink_stripe_cache(conf);
 					if (size==0) BUG();
 					conf->buffer_size = size;
