Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUFST4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUFST4N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUFST4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:56:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27100 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263413AbUFST4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:56:00 -0400
Date: Sat, 19 Jun 2004 16:48:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>, frankvm@xs4all.nl
Cc: sdake@mvista.com, liste@jordet.nu, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: [2.4] page->buffers vanished in journal_try_to_free_buffers()
Message-ID: <20040619194849.GA2843@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel> <Pine.LNX.4.58L.0402052139420.16422@logos.cnet> <1078225389.931.3.camel@buick.jordet> <1087232825.28043.4.camel@persist.az.mvista.com> <20040615131650.GA13697@logos.cnet> <1087322198.8117.10.camel@persist.az.mvista.com> <20040617131600.GB3029@logos.cnet> <20040617200859.7fada9fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617200859.7fada9fe.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:08:59PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> >  > tmp (page->buffers) above is null.  b_this_page is at offset 0x28 (the accessed address in the oops).  This means that
> >  > page->buffers is set to null by some other routine which results in the oops.
> >  > 
> >  > I read the page allocate code
> >  > (ext3_read_page->block_read_full_page->create_emty_buffers->create_buffers), and it appears that it is not possible to allocate a page->buffers value of zero in the allocate function.  I am having difficulty reproducing and cannot debug further, however.  Can page->buffers be set to zero somewhere else?  
> >  >Perhaps kswapd and some other thread are racing on the free?
> > 
> >  Steve, 
> > 
> >  Hum, I'm starting to believe we might have an issue here.
> > 
> >  Searching lkml archives I find other similar oopses at the same place 
> >  (trying to access 00000028, tmp->b_this_page), as you said.
> > 
 >  However I wonder what other kernel codepath could remove the page buffers
> >  under us, the page MUST be locked here. In the backtrace above the page 
> >  is locked by shrink_cache(). And with the page locked, we guarantee the VM
> >  freeing routines (shrink_cache) wont try to mess with the page.
> > 
> >  Can you reproduce the oopsen?
> > 
> >  Stephen, Andrew, do you have any idea how the buffers could have vanished
> >  under us with the page locked? That should not be possible. 
> > 
> >  I dont see how this "page->buffers = NULL" could be caused by hardware problem, 
> >  which is usually one or two bit flip.
> 
> It's a bit odd.  The page is definitely locked, and definitely had non-null
> ->buffers a few tens of instructions beforehand.
> 
> Is this an SMP machine?

Steven, did you see the NULL ->b_this_page on SMP or UP?

Stian Jordet had an SMP server, but he also was seeing oopses with v2.6:

 kernel BUG at mm/page_alloc.c:201!
 invalid operand: 0000 [#1]
 CPU:    0
 EIP:    0060:[free_pages_bulk+482/512]    Not tainted
 EIP is at free_pages_bulk+0x1e2/0x200
 eax: 00000001   ebx: c00609c8   ecx: 00000000   edx: \
                666026a5
 esi: 666026a4   edi: ffffffff   ebp: 33301352   esp: \
                c86d5d90
 Process mrtg (pid: 26804, threadinfo=c86d4000 \
                task=c9b860c0)
 Call Trace:
  [free_hot_cold_page+217/240] \
                free_hot_cold_page+0xd9/0xf0
  [do_generic_mapping_read+714/1008] \
                do_generic_mapping_read+0x2ca/0x3f0
  [file_read_actor+0/256] file_read_actor+0x0/0x100
  [__generic_file_aio_read+454/512] \
                __generic_file_aio_read+0x1c6/0x200
  [file_read_actor+0/256] file_read_actor+0x0/0x100
  [generic_file_aio_read+91/128] \
                generic_file_aio_read+0x5b/0x80
  [do_sync_read+137/192] do_sync_read+0x89/0xc0
  [do_page_fault+300/1328] do_page_fault+0x12c/0x530
  [do_brk+324/560] do_brk+0x144/0x230
  [vfs_read+184/304] vfs_read+0xb8/0x130
  [sys_read+66/112] sys_read+0x42/0x70
  [syscall_call+7/11] syscall_call+0x7/0xb
 
and different oopses on v2.4, including sync_page_buffers (also NULL+offset access): 

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000021
c0132e86

eax: 00000000   ebx: 00000009   ecx: 000001d2   edx: 00000012
esi: 00000000   edi: c17e38c0   ebp: c1047a00   esp: c86cbdb4

>>EIP; c0132e86 <sync_page_buffers+e/a4>   <=====

Trace; c0132fdc <try_to_free_buffers+c0/ec>

Code;  c0132e86 <sync_page_buffers+e/a4>
00000000 <_EIP>:
Code;  c0132e86 <sync_page_buffers+e/a4>   <=====
   0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
Code;  c0132e8a <sync_page_buffers+12/a4>

and the journal_try_to_free_buffers() one:

Unable to handle kernel NULL pointer dereference at virtual address 00000028
c015e3a2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c015e3a2>]    Not tainted
EFLAGS: 00010203

eax: 0100004d   ebx: 00000000   ecx: 000001d2   edx: 00000000

Code;  c015e3a2 <journal_try_to_free_buffers+5a/98>
00000000 <_EIP>:
Code;  c015e3a2 <journal_try_to_free_buffers+5a/98>   <=====
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
Code;  c015e3a5 <journal_try_to_free_buffers+5d/98>


He upgraded the box and stopped seeing the crashes, running 
recent v2.6. 

However, he also mentioned that his crashes started after upgrading 
from v2.4.19->2.4.22. Should search the diff between them looking for 
anything suspicious.

I can't figure out from the archived reports if this is UP or SMP only. 

Frank van Maarseveen has also seen the journal_try_to_free_buffers() NULL 
b_this_page. Frank, were you running SMP or UP when you reported the oops 
with 2.4.23? 

> One possibility is that we died on the second pass around the loop:
> page->buffers points at a buffer_head which has a NULL ->b_this_page.  But
> I cannot suggest how ->b_this_page could have been zapped.

Oh, yes, indeed. 

Maybe adding this (untested) to v2.4 mainline helps? Comments?

--- transaction.c.orig	2004-06-19 15:21:32.861148560 -0300
+++ transaction.c	2004-06-19 15:23:18.214132472 -0300
@@ -1694,6 +1694,24 @@
 	return 0;
 }
 
+void debug_page(struct page *p)
+{
+	struct buffer_head *bh;
+
+	bh = p->buffers;
+
+	printk(KERN_ERR "%s: page index:%u count:%d flags:%x\n", __FUNCTION__,
+		,p->index , atomic_read(&p->count), p->flags);
+
+	do {
+		printk(KERN_ERR "%s: bh b_next:%p blocknr:%u b_list:%u state:%x\n",
+			__FUNCTION__, bh->b_next, bh->b_blocknr, bh->b_list,
+				bh->b_state);
+		bh = bh->b_this_page;
+	} while (bh);
+}
+
+
 
 /** 
  * int journal_try_to_free_buffers() - try to free page buffers.
@@ -1752,6 +1770,11 @@
 	do {
 		struct buffer_head *p = tmp;
 
+		if (!unlikely(tmp)) {
+			debug_page(page);
+			BUG();
+		}
+			
 		tmp = tmp->b_this_page;
 		if (buffer_jbd(p))
 			if (!__journal_try_to_free_buffer(p, &locked_or_dirty))
