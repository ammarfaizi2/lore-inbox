Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266225AbUBDAeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266230AbUBDAeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:34:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:59802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266225AbUBDAeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:34:19 -0500
Date: Tue, 3 Feb 2004 16:28:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stelian@popies.net
Subject: Re: [PATCH] meye: correct printk of dma_addr_t
Message-Id: <20040203162822.64ee18e1.rddunlap@osdl.org>
In-Reply-To: <20040203155752.17a8e274.akpm@osdl.org>
References: <20040203153606.76442b9c.rddunlap@osdl.org>
	<20040203155752.17a8e274.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004 15:57:52 -0800 Andrew Morton <akpm@osdl.org> wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >
| > diff -Naurp ./drivers/media/video/meye.c~meye_dma ./drivers/media/video/meye.c
| > --- ./drivers/media/video/meye.c~meye_dma	2004-01-08 22:59:44.000000000 -0800
| > +++ ./drivers/media/video/meye.c	2004-02-03 14:43:42.000000000 -0800
| > @@ -162,7 +162,7 @@ static void rvfree(void * mem, unsigned 
| >  
| >  /* return a page table pointing to N pages of locked memory */
| >  static int ptable_alloc(void) {
| > -	u32 *pt;
| > +	dma_addr_t *pt;
| >  	int i;
| >  
| >  	memset(meye.mchip_ptable, 0, sizeof(meye.mchip_ptable));
| > @@ -176,7 +176,7 @@ static int ptable_alloc(void) {
| >  		return -1;
| >  	}
| >  
| > -	pt = (u32 *)meye.mchip_ptable[MCHIP_NB_PAGES];
| > +	pt = (dma_addr_t *)meye.mchip_ptable[MCHIP_NB_PAGES];
| >  	for (i = 0; i < MCHIP_NB_PAGES; i++) {
| >  		meye.mchip_ptable[i] = dma_alloc_coherent(&meye.mchip_dev->dev, 
| >  							  PAGE_SIZE,
| 
| mchip_ptable[] just contains pointers to kernel memory.  It doesn't seem
| appropriate to be casting these to dma_addr_t's


Ugh... if I am reading this correcly, what I see is that
mchip_table[] is mostly used for kernel pointers, like you say.

However, the last entry is used for dma handles returned by
dma_alloc_coherent() [the ptable toc], and these are not the correct
data type when CONFIG_HIGHMEM64G=y.

I expect that Stelian will sort this out, but it looks to me
like the ptable toc should be a different array (and type).

--
~Randy
