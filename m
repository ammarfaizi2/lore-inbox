Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWIUTFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWIUTFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWIUTFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:05:18 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:1487 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751469AbWIUTFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:05:16 -0400
Date: Thu, 21 Sep 2006 20:04:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
In-Reply-To: <20060921105236.76e344a2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609211944500.20970@blonde.wat.veritas.com>
References: <20060912205602.57568b2a.akpm@osdl.org> <1158832483.5958.7.camel@imp.csi.cam.ac.uk>
 <1158849696.5958.39.camel@imp.csi.cam.ac.uk> <20060921105236.76e344a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2006 19:04:42.0708 (UTC) FILETIME=[CBA30940:01C6DDB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Andrew Morton wrote:
> On Thu, 21 Sep 2006 15:41:36 +0100
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > 
> > BUG: unable to handle kernel paging request at virtual address 020030d2
> > 
> > The values of the relevant variables from the oops are:
> > 
> > page = 0xc2248fa0
> > page->mapping = 0xe3a79eac
> > page->mapping->a_ops = 0x020030aa
> 
> I wonder if page->mapping really wanted to be 0xc3a79eac, only something
> set bit 29.

Perhaps, but I'm more suspicious of that 0x0200 top half of the a_ops ptr.

> 
> > Note that 0x020030aa+0x28 = 020030d2 which is the oops causing address
> > and 0x28 is the offset of the releasepage function pointer in the
> > address space operations structure...
> > 
> > This oops is not identical to the oopses pointed out by Jonathan at:
> > 
> > http://www.atrad.com.au/~jwoithe/kernel/oopses-20060913.txt
> > 
> > But those oopses have to do with pages also so could be related...
> 
> Looks a bit different - Jonathan appears to have pulled a bad page* out
> of the radix tree whereas you got your page off the LRU.

Jonathan does show a second oops, from a later boot:

  BUG: unable to handle kernel paging request at virtual address 0010c744
   printing eip:
  c013be50
  *pde = 00000000
  Oops: 0002 [#1]
  Modules linked in: ntfs 8139too via_agp agpgart usb_storage ehci_hcd uhci_hcd usbcore
  CPU:    0
  EIP:    0060:[<c013be50>]    Tainted: G   M  VLI
  EFLAGS: 00010282   (2.6.17 #2) 
  EIP is at anon_vma_unlink+0x16/0x3c
  eax: 0010c740   ebx: cf1070cc   ecx: cf107104   edx: cf8bc740
  esi: cf8bc740   edi: b7e82000   ebp: 00000000   esp: cdad7f58

I haven't worked out the disassembly in detail to support the idea
(though certainly anon_vma_unlink would be trying to list_del around
here), but that eax and esi do suggest a corrupted list: somehow the
top half of a pointer overwritten by the top half of LIST_POISON1.

And in Anton's case, the top half of a pointer overwritten by the
bottom half of LIST_POISON2.

Maybe just coincidence, and I've nothing more illuminating to add;
but just a hint of a list_del going very wrong somewhere?

Hugh
