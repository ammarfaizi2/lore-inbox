Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbSJAFCn>; Tue, 1 Oct 2002 01:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSJAFCn>; Tue, 1 Oct 2002 01:02:43 -0400
Received: from packet.digeo.com ([12.110.80.53]:9679 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261487AbSJAFCm>;
	Tue, 1 Oct 2002 01:02:42 -0400
Message-ID: <3D992DB0.9A8942D@digeo.com>
Date: Mon, 30 Sep 2002 22:08:00 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: David Miller <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
References: <20021001044226.GS10265@zax>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 05:08:01.0639 (UTC) FILETIME=[84148F70:01C26908]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> 
> Dave, please consider this patch.  It renames get_vm_area() to
> __get_vm_area() and adds a gfp_mask parameter which is passed on to
> kmalloc().  get_vm_area(size,flags) is then defined as as
> __get_vm_area(size,flags,GFP_KERNEL) to avoid messing with existing
> callers.
> 
> We need this in order to sanely make pci_alloc_consistent() (and other
> consistent allocation functions) obey the DMA-mapping.txt rules on PPC
> embedded machines (specifically the requirement that it be callable
> from interrupt context).
> 

I can look after that for you.  But I'd prefer that you just add the
extra gfp_flags argument to get_vm_area() and update the 16 callers.

You cannot call get_vm_area() from interrupt context at present;
it does write_lock(&vmlist_lock) unsafely.

It would be a bit sad to make vmlist_lock interrupt-safe for this.  Is
there no alternative?

(And what the hell is arch/alpha/mm/init.c:callback_init() doing rewriting
vmlist?  Somebody shoot that code)
