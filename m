Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbQKQRFU>; Fri, 17 Nov 2000 12:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbQKQRFM>; Fri, 17 Nov 2000 12:05:12 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:50931 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129591AbQKQRFC> convert rfc822-to-8bit; Fri, 17 Nov 2000 12:05:02 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, mingo@chiara.elte.hu,
        linux-kernel@vger.kernel.org
Message-ID: <C125699A.005B0F7E.00@d12mta07.de.ibm.com>
Date: Fri, 17 Nov 2000 17:35:53 +0100
Subject: Re: Memory management bug
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> before I hit yet another BUG in swap_state.c:60.
>
>The bug in swap_state:60 shows a kernel bug in the VM or random memory
>corruption. Make sure you can reproduce on x86 to be sure it's not a s390
>that is randomly corrupting memory. If you read the oops after the BUG
message
>with asm at hand you will see in the registers the value of page->mapping
and
>you can guess if it's random memory corruption or bug in VM this way (for
>example if `reg & 3 != 0' it's memory corruption for sure, you should also
>if it's pointing to a suitable kernel-heap address).
I did a little closer investigation. The BUG was triggered by a page with
page->mapping pointing to an address space of a mapped ext2 file
(page->mapping->a_ops == &ext2_aops). The page had PG_locked, PG_uptodate,
PG_active and PG_swap_cache set. The stack backstrace showed that kswapd
called do_try_to_free_pages, refill_inactive, swap_out, swap_out_mm,
swap_out_vma, try_to_swap_out and add_to_swap_cache where BUG hit.
The registers look good, the struct page looks good. I don't think that
this
was a random memory corruption.

>> Whats the reasoning behind these ifs ?
>
>To catch memory corruption or things running out of control in the kernel.
I was refering to the "if (!order) goto try_again" ifs in alloc_pages, not
the "if (something) BUG()" ifs.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
