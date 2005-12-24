Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVLXWcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVLXWcc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 17:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVLXWcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 17:32:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59081 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750742AbVLXWcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 17:32:31 -0500
Date: Sat, 24 Dec 2005 22:32:30 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Brad Boyer <flar@allandria.com>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/36] m68k: drivers/scsi/mac53c94.c __iomem annotations
Message-ID: <20051224223230.GV27946@ftp.linux.org.uk>
References: <E1EpIQf-0004tx-Oh@ZenIV.linux.org.uk> <20051224215633.GA17645@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051224215633.GA17645@pants.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2005 at 01:56:33PM -0800, Brad Boyer wrote:
> 
> This is a ppc only driver at the moment. The m68k mac version is mac_esp.
> I've been thinking about retrofitting this driver to use on the models
> that can do DMA, but that will require me to finish some of the work I
> have pending on the macio layer to get it working for nubus models.

Ah, OK...  Will move to ppc queue next time I rediff that stuff...

Speaking of mac_esp, there's a pending patch for NCR53C9x.c fixing PIO
breakage in esp_do_data().
		/* read fifo */
		for(j=0;j<fifocnt;j++)
			SCptr->SCp.ptr[i++] = esp_read(eregs->esp_fdata);

is not a good thing to do when we set .ptr to (char *)virt_to_phys_(....).

It works mostly by accident on e.g. 840AV, until you get a minimally
non-trivial memory mapping.  The same thing happens on the write side.
Fix is obvious (find phys_to_virt(SCptr->SCp.ptr) in the PIO branch
and use it).  I've put that in -bird, will show up in tonight's snapshot...

BTW, what's the situation with DMA on 840AV?  If you have any patches
to test, I've got such box and being what it is, it's not tied by any
work...
