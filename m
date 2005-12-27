Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVL0QUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVL0QUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVL0QUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:20:49 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:19348 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932308AbVL0QUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:20:48 -0500
Date: Tue, 27 Dec 2005 18:21:39 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051226234238.GA28037@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
References: <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
 <20051206204336.GA12248@tau.solarneutrino.net>
 <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
 <20051212165443.GD17295@tau.solarneutrino.net> <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
 <1134409531.9994.13.camel@mulgrave> <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
 <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net>
 <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005, Ryan Richter wrote:

> On Thu, Dec 15, 2005 at 08:01:43PM -0800, James Bottomley wrote:
> > On Thu, 2005-12-15 at 14:09 -0500, Ryan Richter wrote:
> > > On Mon, Dec 12, 2005 at 12:24:42PM -0600, James Bottomley wrote:
> > > > I'll find a fix for the real problem, but this patch isn't the cause.
> > > 
> > > Is the patch set you posted yesterday supposed to fix this?  If so, is
> > > it available in patch form anywhere?
> > 
> > No, I've been too busin integrating other people's patches to work on
> > ones of my own.  Try this.
> 
> It was looking good, but...
> 
> 
>                    Bad page state at free_hot_cold_page (in process 'taper', page ffff8100040e22e8)
> flags:0x010000000000000c mapping:ffff810102bba238 mapcount:2 count:0
> Backtrace:
> 
Looks familiar ;-(

I don't have any new ideas but I will tell you what I have tried. In order 
to get more information about what is happening, I inserted the patch at 
the end of this message to my kernel. The purpose of the patch was to 
print something about the page mappings (prt_pages) and to catch possible 
double freeing from st earlier (clear page pointers).

Running dump gave me the following output:

st: page attributes before page_release 8
 0: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:173706
 1: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:67369
 2: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:208590
 3: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:201889
 4: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:172689
 5: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:172132
 6: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:189032
 7: flags:0x010000000000006c mapping:ffff81001e0e7698 mapcount:2 count:4 pfn:188229

This was repeated 37 times during the 11.5 GB dump. This shows that the 
taper process is using the same buffer the whole time to write the 32 kB 
blocks to tape. mapcount is 2 as in your error condition but the use count 
is 4.

If nobody has better ideas, you could maybe try this.

Kai

--- linux-2.6.15-rc7/drivers/scsi/st.c	2005-12-25 10:39:09.000000000 +0200
+++ linux-2.6.15-rc7-k0/drivers/scsi/st.c	2005-12-27 18:05:31.000000000 +0200
@@ -4498,22 +4498,44 @@ static int sgl_map_user_pages(struct sca
 	return res;
 }
 
+static void prt_pages(struct scatterlist *sgl, const unsigned int nr_pages, char *s)
+{
+	int i;
+
+	printk("st: page attributes %s page_release %d\n", s, nr_pages);
+	for (i=0; i < nr_pages; i++) {
+		struct page *page = sgl[i].page;
+		printk("%2d: flags:0x%0*lx mapping:%p mapcount:%d count:%d pfn:%ld\n",
+		       i, (int)(2*sizeof(unsigned long)), (unsigned long)page->flags,
+		       page->mapping, page_mapcount(page), page_count(page), page_to_pfn(sgl[i].page));
+	}
+}
+
 
 /* And unmap them... */
 static int sgl_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages,
 				int dirtied)
 {
 	int i;
+	static int ctr;
 
+
+	if ((ctr++ % 10000) == 0)
+		prt_pages(sgl, nr_pages, "before");
 	for (i=0; i < nr_pages; i++) {
 		struct page *page = sgl[i].page;
 
+		if (!page) {
+			printk("st: trying double free: %d %d\n", i, nr_pages);
+			continue;
+		}
 		if (dirtied)
 			SetPageDirty(page);
 		/* FIXME: cache flush missing for rw==READ
 		 * FIXME: call the correct reference counting function
 		 */
 		page_cache_release(page);
+		sgl[i].page = NULL;
 	}
 
 	return 0;
