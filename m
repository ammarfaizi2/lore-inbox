Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313444AbSDLIUl>; Fri, 12 Apr 2002 04:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313448AbSDLIUk>; Fri, 12 Apr 2002 04:20:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:41175 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313444AbSDLIUk>;
	Fri, 12 Apr 2002 04:20:40 -0400
Date: Fri, 12 Apr 2002 10:20:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: vojtech@suse.cz, martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
Message-ID: <20020412102021.A18037@ucw.cz>
In-Reply-To: <20020412001029.GA1172@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 02:10:29AM +0200, Petr Vandrovec wrote:

>   last friday I found strange problem with 2.5.8-pre1 kernel
> corrupting my data. Today I tracked it down to enabled (by
> default) 32bit I/O. Problem occurs only in 2.5.x kernels
> (2.5.8-pre1, 2.5.8-pre3) and does not occur in 2.4.x
> (2.4.19-pre6, 2.4.18-pre4). My tests were done in 
> non-multicount mode:
> 
> /dev/hdc:
>  multcount    =  0 (off)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  geometry     = 4865/255/63, sectors = 78165360, start = 0
>  busstate     =  1 (on)
> 
>   After looking through code up and down I found that first 
> sector is written in 32bit mode, while others in 16bit mode, 
> and VIA IDE interface does not cope with this correctly. Can 
> anybody explain me, what's wrong with patch at the end of this 
> message? As there is dozen of places where io_32bit is cleared, 
> I believe that there must be some reason for doing that... And 
> do not ask me why it worked in 2.4.x, as it cleared io_32bit
> in task_out_intr too.

It's a very unwise thing to disable 32-bit mode on VIA and AMD chipsets,
AMD even has it in their errata (VIA has no documented errata, of
course). Thanks for the good find. Martin, can we do anything about
this?

> diff -urN linux-2.5.8-pre3.dist/drivers/ide/ide-taskfile.c linux-2.5.8-pre3/drivers/ide/ide-taskfile.c
> --- linux-2.5.8-pre3.dist/drivers/ide/ide-taskfile.c	Sun Apr  7 03:43:03 2002
> +++ linux-2.5.8-pre3/drivers/ide/ide-taskfile.c	Fri Apr 12 01:50:04 2002
> @@ -602,7 +602,7 @@
>  		rq = HWGROUP(drive)->rq;
>  		pBuf = ide_map_rq(rq, &flags);
>  		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
> -		drive->io_32bit = 0;
> +//		drive->io_32bit = 0;
>  		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
>  		ide_unmap_rq(rq, pBuf, &flags);
>  		drive->io_32bit = io_32bit;

-- 
Vojtech Pavlik
SuSE Labs
