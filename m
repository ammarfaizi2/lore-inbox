Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWBCUiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWBCUiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWBCUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:38:24 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:46016 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751484AbWBCUiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:38:23 -0500
Message-ID: <43E3BF33.6050705@cs.wisc.edu>
Date: Fri, 03 Feb 2006 14:38:11 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] st: don't doublefree pages from scatterlist
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com> <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com> <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031951280.14829@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602031951280.14829@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On some architectures, mapping the scatterlist may coalesce entries:
> if that coalesced list is then used for freeing the pages afterwards,
> there's a danger that pages may be doubly freed (and others leaked).
> 
> Fix SCSI Tape's sgl_unmap_user_pages by freeing from the pagelist used
> in sgl_map_user_pages.  Fixes Ryan Richter's crash on x86_64, with Bad
> page state mapcount 2 from sgl_unmap_user_pages, and consequent mayhem.
> 

Is this crash occuring with 2.6.16-rc1? I ask becuase in that kernel the 
scatterlist passed into scsi_execute_async

if (scsi_execute_async(STp->device, cmd, direction,
			&((STp->buffer)->sg[0]), bytes,

is not the same one that gets send down to the device/HBA.

scsi_execute_async takes the scatterlist passed to it from st or sg, 
uses it as a hint to build a request + bios, then later when the request 
is sent to the device a new scatterlist is sent to the device and the 
device does the pci/dma operation on that scatterlist from the 
block/scsi layer.
