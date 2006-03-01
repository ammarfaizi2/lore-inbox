Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWCAMQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWCAMQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWCAMQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:16:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13914 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964915AbWCAMQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:16:28 -0500
Date: Wed, 1 Mar 2006 13:15:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       ak@suse.de, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301121547.GI4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C0D0@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393C0D0@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andy Chittenden wrote:

Some weird stuff going on here, or I'm confused. Lots of entries are not
page start aligned, yet they have a length of 4kb. The troublesome
entries are additionally:

> hda: DMA table too small
> ide dma table, 256 entries, bounce pfn 1310720
> sg0: dma=6e9e800, len=4096/0, pfn=1185312
> sg1: dma=6e9f800, len=4096/0, pfn=1185270

This one, since it'll wrap around and consume two cpu dma table entries.
Since we are already at the max of 256 already from the beginning,
there's no way we can split this one.

> sg2: dma=6ea0800, len=4096/0, pfn=1184892
> sg3: dma=6ea1800, len=4096/0, pfn=1185144
> sg4: dma=6ea2800, len=4096/0, pfn=1185102
> sg5: dma=6ea3800, len=4096/0, pfn=1185059
> sg6: dma=6ea4800, len=4096/0, pfn=1185017
> sg7: dma=6ea5800, len=4096/0, pfn=1184975
> sg8: dma=6ea6800, len=4096/0, pfn=1184933
> sg9: dma=6ea7800, len=4096/0, pfn=1184850
> sg10: dma=6ea8800, len=4096/0, pfn=1186142
> sg11: dma=6ea9800, len=4096/0, pfn=1186814
> sg12: dma=6eaa800, len=4096/0, pfn=1186731
> sg13: dma=6eab800, len=4096/0, pfn=1186689
> sg14: dma=6eac800, len=4096/0, pfn=1186227
> sg15: dma=6ead800, len=4096/0, pfn=1186185
> sg16: dma=6eae800, len=4096/0, pfn=1186100
> sg17: dma=6eaf800, len=4096/0, pfn=1185807

Ditto for that one, will also be split into two 2kb entries.

So this first mapping dump shows us that we start with 256 entries, that
IDE would like to map into 258 entries. The question is why these dma
address as mapped by pci_map_sg() aren't page aligned? Andi?

-- 
Jens Axboe

