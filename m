Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVLIQPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVLIQPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVLIQPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:15:49 -0500
Received: from silver.veritas.com ([143.127.12.111]:61608 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932124AbVLIQPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:15:49 -0500
Date: Fri, 9 Dec 2005 16:14:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc5 and Alsa 1.0.10
In-Reply-To: <4399B195.9050801@pin.if.uz.zgora.pl>
Message-ID: <Pine.LNX.4.61.0512091610160.24942@goblin.wat.veritas.com>
References: <4399B195.9050801@pin.if.uz.zgora.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Dec 2005 16:15:02.0685 (UTC) FILETIME=[B5BA4CD0:01C5FCDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Jacek Luczak wrote:
> 
> I'm using now 2.6.15-rc5 kernel with latest Alsa 1.0.10 and I received a lot
> of 'bad page state at free_hot_cold_page' (see example below) messages. Is
> this kernel or alsa error?
> 
> System:
> Slackware Linux, GCC 3.4.4, Binutils 2.16.1.
> CPU: Pentium 4 3Ghz HT
> Sound card: CMI9880 (HDA)
> 
> Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in
> process 'xmms', page c12da9c0)
> Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 mapcount:0
> count:0

I think that means you have a mismatch: that you're using core/memalloc.c
from alsa-driver-1.0.10/alsa-kernel rather than from 2.6.15-rc5/sound.
Applying the update below should eliminate your "Bad page state"s:
I've no idea whether there are other mismatches, quite possibly not.

Hugh

--- alsa-driver-1.0.10/alsa-kernel/core/memalloc.c	2005-10-31 13:11:53.000000000 +0000
+++ 2.6.15-rc5/sound/core/memalloc.c	2005-12-04 06:48:20.000000000 +0000
@@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
 
 	snd_assert(size > 0, return NULL);
 	snd_assert(gfp_flags != 0, return NULL);
+	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
 	pg = get_order(size);
 	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
 		mark_pages(virt_to_page(res), pg);
@@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
 	snd_assert(dma != NULL, return NULL);
 	pg = get_order(size);
 	gfp_flags = GFP_KERNEL
+		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
 	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
