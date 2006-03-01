Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWCAMXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWCAMXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWCAMXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:23:41 -0500
Received: from mail.suse.de ([195.135.220.2]:23007 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932206AbWCAMXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:23:40 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Wed, 1 Mar 2006 13:23:33 +0100
User-Agent: KMail/1.9.1
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <89E85E0168AD994693B574C80EDB9C270393C0D0@uk-email.terastack.bluearc.com> <20060301121547.GI4816@suse.de> <20060301121934.GK4816@suse.de>
In-Reply-To: <20060301121934.GK4816@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011323.34722.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 13:19, Jens Axboe wrote:
> On Wed, Mar 01 2006, Jens Axboe wrote:
> > On Wed, Mar 01 2006, Andy Chittenden wrote:
> > 
> > Some weird stuff going on here, or I'm confused. Lots of entries are not
> > page start aligned, yet they have a length of 4kb. The troublesome
> > entries are additionally:
> > 
> > > hda: DMA table too small
> > > ide dma table, 256 entries, bounce pfn 1310720
> > > sg0: dma=6e9e800, len=4096/0, pfn=1185312
> > > sg1: dma=6e9f800, len=4096/0, pfn=1185270
> > 
> > This one, since it'll wrap around and consume two cpu dma table entries.
> > Since we are already at the max of 256 already from the beginning,
> > there's no way we can split this one.
> > 
> > > sg2: dma=6ea0800, len=4096/0, pfn=1184892
> > > sg3: dma=6ea1800, len=4096/0, pfn=1185144
> > > sg4: dma=6ea2800, len=4096/0, pfn=1185102
> > > sg5: dma=6ea3800, len=4096/0, pfn=1185059
> > > sg6: dma=6ea4800, len=4096/0, pfn=1185017
> > > sg7: dma=6ea5800, len=4096/0, pfn=1184975
> > > sg8: dma=6ea6800, len=4096/0, pfn=1184933
> > > sg9: dma=6ea7800, len=4096/0, pfn=1184850
> > > sg10: dma=6ea8800, len=4096/0, pfn=1186142
> > > sg11: dma=6ea9800, len=4096/0, pfn=1186814
> > > sg12: dma=6eaa800, len=4096/0, pfn=1186731
> > > sg13: dma=6eab800, len=4096/0, pfn=1186689
> > > sg14: dma=6eac800, len=4096/0, pfn=1186227
> > > sg15: dma=6ead800, len=4096/0, pfn=1186185
> > > sg16: dma=6eae800, len=4096/0, pfn=1186100
> > > sg17: dma=6eaf800, len=4096/0, pfn=1185807
> > 
> > Ditto for that one, will also be split into two 2kb entries.
> > 
> > So this first mapping dump shows us that we start with 256 entries, that
> > IDE would like to map into 258 entries. The question is why these dma
> > address as mapped by pci_map_sg() aren't page aligned? Andi?
> 
> Oh, it's dumping ->length but should be dumping ->dma_length in my debug
> patch. Can you change that and reproduce again?

Also only dump upto the value map_sg returned.

The new kernel will not do any changes to the input parts in the sglist, but 
just merge up the dma pointers and fix up dma_length.  So the mappings
can be completely out of sync now.

This only changed recently.

-Andi

P.S.: There might be also still some confusion with ->dma_length vs ->length.

