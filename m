Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSFCLB4>; Mon, 3 Jun 2002 07:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSFCLBy>; Mon, 3 Jun 2002 07:01:54 -0400
Received: from holomorphy.com ([66.224.33.161]:26240 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317363AbSFCLBx>;
	Mon, 3 Jun 2002 07:01:53 -0400
Date: Mon, 3 Jun 2002 04:00:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which requires atomic operations to access
Message-ID: <20020603110055.GB912@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, hugh@veritas.com,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <20020602224422.GP14918@holomorphy.com> <Pine.LNX.4.21.0206031051370.10595-100000@localhost.localdomain> <20020603102809.GA912@holomorphy.com> <20020603.022739.102772773.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 3 Jun 2002 03:28:09 -0700
>    It should be clearing it, I'd retransmit if there weren't other objections
>    to address...

On Mon, Jun 03, 2002 at 02:27:39AM -0700, David S. Miller wrote:
> Such as the fact that none of these operations need to
> be atomic :-)

After looking around a little bit the unique reference guarantee
plus various memory barriers surrounding it appear to suffice. But
I'm still left quite uneasy by the usage of non-atomic operations
on an atomically updated lock word. At the very least making the
operand shifted an unsigned long is needed. So this ensues:


Cheers,
Bill

===== mm/page_alloc.c 1.63 vs edited =====
--- 1.63/mm/page_alloc.c	Tue May 28 16:57:49 2002
+++ edited/mm/page_alloc.c	Mon Jun  3 03:58:59 2002
@@ -110,8 +110,8 @@
 		BUG();
 	if (PageWriteback(page))
 		BUG();
-	ClearPageDirty(page);
-	page->flags &= ~(1<<PG_referenced);
+
+	page->flags &= ~((1UL << PG_referenced) | (1UL << PG_dirty));
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
