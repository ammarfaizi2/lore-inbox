Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTKOG04 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 01:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTKOG0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 01:26:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:45520 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261586AbTKOG0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 01:26:54 -0500
Date: Fri, 14 Nov 2003 22:26:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steve Holland <sdh4@iastate.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mysterious driver-related oops in vm system
In-Reply-To: <1068876126.3796.18.camel@gavroche>
Message-ID: <Pine.LNX.4.44.0311142213440.2551-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 Nov 2003, Steve Holland wrote:
>   
nopage():
>   v_addr =  BoardData[board].dma_virt_addr + (address - vma->vm_start);
>   page = virt_to_page(v_addr);
>   get_page (page);
>   return (page);

You can't do single-page memory management once you've already allocated 
the board data as one big memory allocation.

In short: remove the "get_page()", since the thing that keeps the pages in 
memory is actually the "pci_alloc_consistent()". 

To make sure that the swapout logic doesn't try to touch these pages 
as "normal" pages either, you should mark them all reserved.

Then, in the release() function you should unmark the pages, and finally 
do the pci_free_consistent() on the area.

We really should have helper functions to do that. Right now every driver 
that wants to do this needs to have its own logic for it (sound drivers 
use "snd_malloc_pages()" that does it for them etc etc).

			Linus

