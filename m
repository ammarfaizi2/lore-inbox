Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319449AbSH2WWa>; Thu, 29 Aug 2002 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319448AbSH2WV0>; Thu, 29 Aug 2002 18:21:26 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:35089 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319388AbSH2WVH>; Thu, 29 Aug 2002 18:21:07 -0400
Message-ID: <3D6E9EDC.ED1E546C@zip.com.au>
Date: Thu, 29 Aug 2002 15:23:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       Gerrit Huizenga <gerrit@us.ibm.com>,
       Hans-J Tannenberger <hjt@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>, linux-scsi@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.32 IO performance issues
References: <3D6E6B64.66203783@zip.com.au> <200208292055.g7TKte224951@eng2.beaverton.ibm.com> <20020829145342.A25892@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:
> 
> On Thu, Aug 29, 2002 at 01:55:40PM -0700, Badari Pulavarty wrote:
> > >
> > > block-highmem is bust for scsi. (aic7xxx at least).  Does
> > > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm2/broken-out/scsi_hack.patch
> > > fix it?
> >
> > Hmm !! This patch fixed it. I remember you gave me this patch for 2.5.31. But 2.5.31
> > was doing fine without it. But 2.5.32 seem to need it.
> >
> 
> The above patch works fine to get back to the previous (pre-2.5.32) state.
> But, it makes no sense to modify the bounce_limit based on the type of
> storage that is attached to an adapter.

I agree.  Hence the name "scsi_hack" ;)

> We want to allow high mem for block devices other than SCSI direct access
> devices (TYPE_DISK), such as CD ROM (SDpnt->type TYPE_ROM), WORM devices
> (TYPE_WORM), and optical disks (TYPE_MOD).
> 
> So it is better to patch scsi_initialize_merge_fn:
> 
> --- 1.16/drivers/scsi/scsi_merge.c      Fri Jul  5 09:43:00 2002
> +++ edited/drivers/scsi/scsi_merge.c    Thu Aug 29 14:30:12 2002
> @@ -140,7 +140,7 @@
>          * Enable highmem I/O, if appropriate.
>          */
>         bounce_limit = BLK_BOUNCE_HIGH;
> -       if (SHpnt->highmem_io && (SDpnt->type == TYPE_DISK)) {
> +       if (SHpnt->highmem_io) {
>                 if (!PCI_DMA_BUS_IS_PHYS)
>                         /* Platforms with virtual-DMA translation
>                          * hardware have no practical limit.
> 

That will certainly fix it.  But who added the TYPE_DISK check,
and why???
