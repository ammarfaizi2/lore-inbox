Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945926AbWBDMIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945926AbWBDMIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 07:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWBDMIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 07:08:37 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:17346 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1945926AbWBDMIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 07:08:36 -0500
Date: Sat, 4 Feb 2006 14:10:34 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Hugh Dickins <hugh@veritas.com>
cc: Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Doug Gilbert <dougg@torque.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] st: don't doublefree pages from scatterlist
In-Reply-To: <Pine.LNX.4.61.0602032100400.15678@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.63.0602041403460.3923@kai.makisara.local>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031951280.14829@goblin.wat.veritas.com> <43E3BF33.6050705@cs.wisc.edu>
 <Pine.LNX.4.61.0602032100400.15678@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Hugh Dickins wrote:

> On Fri, 3 Feb 2006, Mike Christie wrote:
...
> > I ask becuase in that kernel the scatterlist passed into scsi_execute_async
> > 
> > if (scsi_execute_async(STp->device, cmd, direction,
> > &((STp->buffer)->sg[0]), bytes,
> > 
> > is not the same one that gets send down to the device/HBA.
> 
> Wow, great info, thanks.
> 
> > scsi_execute_async takes the scatterlist passed to it from st or sg, uses it
> > as a hint to build a request + bios, then later when the request is sent to
> > the device a new scatterlist is sent to the device and the device does the
> > pci/dma operation on that scatterlist from the block/scsi layer.
> 
> Very interesting.  James can confirm, but I think that means everybody
> can ignore my drivers/scsi/st.c patch for 2.6.16-rc, and the unposted
> sg.c patches for the same issue that I was going to send Doug.
> 
The patch st is not necessary now but I don't think it would be a bad idea 
to include it anyway. My reasoning is based on that the patch is very 
inexpensive, it basically moves freeing of an array to another place. 
The reasons for inclusion are:
- someone reviewing the code may wonder why the change to 2.6.15.x is
  not in 2.6.x >= 16; 2.6.16 would need at least a comment about this
- it does decouple st from any dependencies about what happens to
  the s/g array at the lower levels
- if the s/g array will at some future time be again passed directly to 
  dma mapping, we would not face the problem again

I don't have any firm opinion either way.

-- 
Kai
