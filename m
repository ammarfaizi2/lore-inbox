Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269843AbRHDJsv>; Sat, 4 Aug 2001 05:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269845AbRHDJsn>; Sat, 4 Aug 2001 05:48:43 -0400
Received: from [216.101.162.242] ([216.101.162.242]:20873 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S269843AbRHDJsb>;
	Sat, 4 Aug 2001 05:48:31 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15211.50386.927163.766367@pizda.ninka.net>
Date: Sat, 4 Aug 2001 02:48:02 -0700 (PDT)
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The interface of flush_cache_page
In-Reply-To: <200108040610.f746AlJ19336@mule.m17n.org>
In-Reply-To: <200108040610.f746AlJ19336@mule.m17n.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NIIBE Yutaka writes:
 > When it is called from vmscan.c:try_to_swap_out, as the PTE is cleared
 > to be zero, we have no way to know what phisical address to match.

That is really an error, and it is only because the last time the
logic try_to_swap_out() logic got rearranges the cache flush got moved
lower down.

In fact, several architectures will take a fatal trap due to
this sequence.  On these systems the tlb must be able to translate the
virtual address given to it for the flush, and that translation must
be valid.

Thus, the code there should be:

	flush_cache_page(vma, address);
	pte = ptep_get_and_clear(page_table);
	flush_tlb_page(vma, address);

And the flush_cache_page() further down in that function then can be
removed.

Feel free to send this fix to Linus.  It is probably causing
HyperSparc sparc32 to fail to work at all once a swap happens,
if platforms using that chip work at all.

Later,
David S. Miller
davem@redhat.com
