Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSFCKR2>; Mon, 3 Jun 2002 06:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSFCKR1>; Mon, 3 Jun 2002 06:17:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52888 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317349AbSFCKRY>;
	Mon, 3 Jun 2002 06:17:24 -0400
Date: Mon, 03 Jun 2002 02:12:36 -0700 (PDT)
Message-Id: <20020603.021236.122031184.davem@redhat.com>
To: hugh@veritas.com
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: remove mixture of non-atomic operations with page->flags which
 requires atomic operations to access
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0206031051370.10595-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Mon, 3 Jun 2002 11:14:43 +0100 (BST)

   On Sun, 2 Jun 2002, William Lee Irwin III wrote:
   > 
   >  	ClearPageDirty(page);
   > -	page->flags &= ~(1<<PG_referenced);
   > +	ClearPageUptodate(page);
   > +	ClearPageSlab(page);
   > +	ClearPageNosave(page);
   > +	ClearPageChecked(page);
   
   Don't all those atomic volatile bitops slow down a hotpath for no real
   gain?  I'm all for clearing all possible flag bits at that point, but
   would prefer just one mask myself.  But given all the preceding tests,
   and the ClearPageDirty, perhaps I'm foolish to question your additions.
   
   And wasn't it originally clearing the referenced bit, now leaving it?

Furthermore, when this code runs there should be no way for any
part of the kernel to reference the page in a way that cares
about these flag bits.

So if anything, we should be doing _ALL_ of the flag bitsops
non-atomically.
