Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271038AbTHCHZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTHCHZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:25:41 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58642 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271038AbTHCHZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:25:39 -0400
Date: Sun, 3 Aug 2003 09:25:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, andrea@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre lockups (decoded oops for pre8)
Message-ID: <20030803072525.GB679@alpha.home.local>
References: <Pine.LNX.4.55L.0307251040240.12645@freak.distro.conectiva> <20030725174517.5b21116d.skraw@ithnet.com> <Pine.LNX.4.55L.0307251545090.14733@freak.distro.conectiva> <20030802142734.5df93471.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802142734.5df93471.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

This is in remove_page_from_hash_queue() at filemap.c:114 :
    *pprev = next;

pprev is taken from page->pprev_hash and is considered invalid here (4129b0fc).
Assuming it has been corrupted earlier, it seems that the only files able to
touch this either directly or indirectly are :
  - mm/filemap.c (add_page_to_hash_queue, add_to_page_cache*)
  - mm/shmem.c (add_to_page_cache_unique)
  - mm/swap_state.c (idem)
  - fs/ext3/inode.c and fs/buffer.c (find_or_create_page)

So the problem may be narrowed down to a few files. Perhaps digging through
the VM changes since before you had a problem will give you more clues...

Cheers,
Willy

On Sat, Aug 02, 2003 at 02:27:34PM +0200, Stephan von Krawczynski wrote:
> Unable to handle kernel paging request at virtual address 4129b0fc
> c0130084
> *pde = 313f6067
> Oops: 0002
> CPU:    1
> EIP:    0010:[<c0130084>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: c2cfdba0   ecx: 00000000   edx: 4129b0fc
> esi: d5fb0a24   edi: 0001ca22   ebp: c02eaaa8   esp: c345df30
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 5, stackpage=c345d000)
> Stack: c2cfdba0 d5fb0a24 c2cfdba0 c013924f c2cfdba0 000001d0 00000200 000001d0 
>        00000006 00000020 000001d0 00000020 00000006 c0139493 00000006 00000001 
>        c02eaaa8 000001d0 00000006 c02eaaa8 00000000 c013950e 00000020 c02eaaa8 
> Call Trace:    [<c013924f>] [<c0139493>] [<c013950e>] [<c013961c>] [<c01396a8>]
>   [<c01397d8>] [<c0139740>] [<c0105000>] [<c010592e>] [<c0139740>]
> Code: 89 02 c7 43 24 00 00 00 00 f0 ff 0d 9c a5 37 c0 5a 5b 5e c3 
> 
> 
> >>EIP; c0130084 <__remove_inode_page+44/60>   <=====
> 
> >>ebx; c2cfdba0 <_end+2952980/3852ee40>
> >>esi; d5fb0a24 <_end+15c05804/3852ee40>
> >>ebp; c02eaaa8 <contig_page_data+168/340>
> >>esp; c345df30 <_end+30b2d10/3852ee40>
> 
> Trace; c013924f <shrink_cache+2df/3b0>
> Trace; c0139493 <shrink_caches+63/a0>
> Trace; c013950e <try_to_free_pages_zone+3e/60>
> Trace; c013961c <kswapd_balance_pgdat+4c/b0>
> Trace; c01396a8 <kswapd_balance+28/40>
> Trace; c01397d8 <kswapd+98/c0>
> Trace; c0139740 <kswapd+0/c0>
> Trace; c0105000 <_stext+0/0>
> Trace; c010592e <arch_kernel_thread+2e/40>
> Trace; c0139740 <kswapd+0/c0>
> 
> Code;  c0130084 <__remove_inode_page+44/60>
> 00000000 <_EIP>:
> Code;  c0130084 <__remove_inode_page+44/60>   <=====
>    0:   89 02                     mov    %eax,(%edx)   <=====
> Code;  c0130086 <__remove_inode_page+46/60>
>    2:   c7 43 24 00 00 00 00      movl   $0x0,0x24(%ebx)
> Code;  c013008d <__remove_inode_page+4d/60>
>    9:   f0 ff 0d 9c a5 37 c0      lock decl 0xc037a59c
> Code;  c0130094 <__remove_inode_page+54/60>
>   10:   5a                        pop    %edx
> Code;  c0130095 <__remove_inode_page+55/60>
>   11:   5b                        pop    %ebx
> Code;  c0130096 <__remove_inode_page+56/60>
>   12:   5e                        pop    %esi
> Code;  c0130097 <__remove_inode_page+57/60>
>   13:   c3                        ret    
> 
> 
> 1 warning issued.  Results may not be reliable.
> 
> 
> Hope this helps.
> Anything further I can do?
> 
> Regards,
> Stephan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
