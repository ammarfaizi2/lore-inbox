Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSHEODv>; Mon, 5 Aug 2002 10:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318470AbSHEODv>; Mon, 5 Aug 2002 10:03:51 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:43282 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318468AbSHEODt>;
	Mon, 5 Aug 2002 10:03:49 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Mon, 5 Aug 2002 16:07:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1264DE104D6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Aug 02 at 12:28, Marcin Dalecki wrote:
> Uz.ytkownik Petr Vandrovec napisa?:
> > On  5 Aug 02 at 11:33, Marcin Dalecki wrote:
> > 
> >>Uz.ytkownik Petr Vandrovec napisa?:
> >>
> >>>   BTW, are there any TRM290 owners using 2.5.30? Old code set length to
> >>>((length >> 2) - 1) << 16, while new code does not have special handling
> >>>for TRM290. Or do I miss something?
> >>
> >>The new code is overwriting those values in the host controller driver
> >>itself.
> > 
> > 
> > Really? I'm not able to locate such overwrite in trm290.c. Are they hidden
> > somewhere else?
> 
> This should handle it:
> 
>     hwif->seg_boundary_mask = 0xffffffff;

Nope. This is another problem. TRM290 code did:

xcount = bcount & 0xffff;
if (is_trm290_chipset)
  xcount = ((xcount >> 2) - 1) << 16;
...
*table++ = cpu_to_le32(xcount);

Current code does not do xcount modification for trm290 - while
other hosts want byte count in lower 16bit word of length,
trm290 apparently wants dword count (less 1) in upper 16bit word of length.

> > 
> > Also BUG_ON() in udma_new_table is bogus. Change code:
> > 
> > - u32 cur_len = sg_dma_len(sg) & 0xffff;
> > + u32 cur_len = sg_dma_len(sg);
> > 
> >   /* Delete this ... */
> >   BUG_ON(cur_len > ch->max_segment_size);
> >   
> >   *table++ = cpu_to_le32(cur_addr);
> > - *table++ = cpu_to_le32(cur_len);
> > + *table++ = cpu_to_le32(cur_len & 0xffff);
> > 
> > Without first change BUG_ON will not trigger on any transfer: values
> > up to 0xFE00 are legal, and values over 0x10000 get cut down to
> > 0x0xxxx...
> > 
> > Second change is needed only if we have some driver setting 
> > max_segment_size to value > 0xffff: currently we do not have such driver,
> > default is 0xfe00, and value set by cs5530 is 0xfe00 too.
> 
> Well trm390 *does* set ->seg_boundary_mask.

But max_segment_size is what we are testing here. If you want test
crossing 64K boundary, you want

BUG_ON((cur_addr & ch->seg_boundary_mask) + cur_len - 1 > ch->seg_boundary_mask),

as even 2 sector transfer can cross 64K boundary which IDE specs
forbids (even 1 sector can do that, but I believe that bio layer
sends properly aligned sectors to us).

> 
> >>Hmm... It is very well possible that the Toshiba doesn't like the
> >>fact that the intel chipsets cheat and do something like UDMA88 instead 
> >>of UDMA100. Could you verify this by checking whatever forcing them to 
> >>UDMA66 helps please? Vojtech?
> > 
> > 
> > It happens with UDMA0 too (and I tried slowest possible timming at
> > i845, and it still happens).
> 
> I'm more and more amanzed, why my system works at all...

PDC20265 works correctly without setting stop-bit in last descriptor
for reads, as IDE drive signals no more data, and we stop udma engine
manually in such case. But for writes PDC20265 prefetches beyond last 
pointer, finds garbage here (probably descriptor crossing 64KB, or
odd length or ...), and aborts whole transfer in the middle (about 
4 bytes before end of real write, when it tries to prefetch beginning 
of next sector).
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
