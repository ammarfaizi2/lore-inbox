Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWBDPAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWBDPAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBDPAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:00:50 -0500
Received: from silver.veritas.com ([143.127.12.111]:36461 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932503AbWBDPAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:00:49 -0500
Date: Sat, 4 Feb 2006 15:01:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
cc: Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Doug Gilbert <dougg@torque.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] st: don't doublefree pages from scatterlist
In-Reply-To: <Pine.LNX.4.63.0602041403460.3923@kai.makisara.local>
Message-ID: <Pine.LNX.4.61.0602041446530.8478@goblin.wat.veritas.com>
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
 <Pine.LNX.4.63.0602041403460.3923@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Feb 2006 15:00:49.0298 (UTC) FILETIME=[C8D91F20:01C6299B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Kai Makisara wrote:
> On Fri, 3 Feb 2006, Hugh Dickins wrote:
> > 
> > Very interesting.  James can confirm, but I think that means everybody
> > can ignore my drivers/scsi/st.c patch for 2.6.16-rc, and the unposted
> > sg.c patches for the same issue that I was going to send Doug.
> > 
> The patch st is not necessary now but I don't think it would be a bad idea 
> to include it anyway. My reasoning is based on that the patch is very 
> inexpensive, it basically moves freeing of an array to another place. 
> The reasons for inclusion are:
> - someone reviewing the code may wonder why the change to 2.6.15.x is
>   not in 2.6.x >= 16; 2.6.16 would need at least a comment about this
> - it does decouple st from any dependencies about what happens to
>   the s/g array at the lower levels
> - if the s/g array will at some future time be again passed directly to 
>   dma mapping, we would not face the problem again
> 
> I don't have any firm opinion either way.

Fair points, I don't have a firm opinion either, it's entirely up to you
as maintainer.

But I'd be less keen to force the equivalent changes into 2.6.16's sg.c.

Saving sg_pages from get_user_pages fits in quite unobtrusively in st.c,
and its enlarge_buffer/normalize_buffer pages are already safely isolated
from the scatterlist by the separate frp_segs array.  But sg.c presently
uses the scatterlist for the latter case too, so would need more change:
except that, thanks to Mike, we find it doesn't need changing now.
Your suggestion of a comment would be most appropriate there.

(I've not forgotten our outstanding SetPageDirty to set_page_dirty_lock
issue, but still striving to avoid too much nuisance in sg.c's case.)

Hugh
