Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWB1QyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWB1QyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWB1QyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:54:00 -0500
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:8062 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751602AbWB1Qx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:53:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=g0Qx4U7Y9QES8djJxDaa7Z0e21UWL7UDRF6RdIVhUBvNT83xkol52PZSfPmpdgYw/g+sxRuOs79HMrLhrUurMhViXXDe1b4zk88mytk62nB+B5MFTtuuKtSisM68QkNC8xziGzhzxlEgfY1WfZa7tpnp38N5Vhy4gBksuJWJfUA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: remap_file_pages - Bug with _PAGE_PROTNONE - is it used in current kernels?
Date: Tue, 28 Feb 2006 17:53:44 +0100
User-Agent: KMail/1.8.3
Cc: linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <200602202354.48851.blaisorblade@yahoo.it> <Pine.LNX.4.61.0602211257360.8644@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602211257360.8644@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602281753.47439.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 14:09, Hugh Dickins wrote:
> On Mon, 20 Feb 2006, Blaisorblade wrote:
> > I've been hitting a bug on a patch I'm working on and have considered
> > (and more or less tested with good results) doing this change:
> >
> > -#define pte_present(x)  ((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
> > +#define pte_present(x)  ((x).pte_low & (_PAGE_PRESENT))
> >
> > (and the corresponding thing on other architecture).
> >
> > In general, the question is whether __P000 and __S000 in protection_map
> > are ever used except for MAP_POPULATE, and even then if they work well.
> >
> > I'm seeking for objections to this change and/or anything I'm missing.

> Objection, your honor.
English humor :-) ?

> I didn't fully understand you there, but I think you've got it the wrong
> way round: _PAGE_PROTNONE is included in the pte_present() test precisely
> because there is a valid page there, pfn is set (it might be pfn 0, yes,
> but much more likely to be pfn non-0).

> I've never used PROT_NONE myself (beyond testing), but I think the
> traditional way it's used is this: mmap(,,PROT_READ|PROT_WRITE,,,),
> initialize the pages of that mapping, then mprotect(,,PROT_NONE) -
> which retains all those pages but make them generate SIGSEGVs - so
> the app can detect accesses and decide if it wants to do something
> special with them, other than the obvious mprotect(,,PROT_READ) or
> whatever.

> PROT_NONE gives you a way of holding the page present (unlike munmap),
> yet failing access.  And since those pages remain present, they do
> need to be freed later when you get to zap_pte_range.  They are
> normal pages, but user access to them has been restricted.

Ok, thanks for the explaination.

The bug is born from the patched install_file_pte(). Before there was no need 
to store the protection bits, now it's needed.

So, it sets a pte_file PTE containing no page, and on PROT_NONE it uses 
_PAGE_PROTNONE|_PAGE_FILE.

Indeed, what I've actually coded and tested was safer, but I wanted to know if 
it could be simpler (and faster). For i386 it should be (I've re-tested only 
UML so far):

-#define pte_present(x)  ((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_present(x)  (((x).pte_low & _PAGE_PRESENT) || \
+	(((x).pte_low & (_PAGE_PROTNONE|_PAGE_FILE)) == _PAGE_PROTNONE))

--- linux-2.6.git.orig/include/asm-um/pgtable.h
+++ linux-2.6.git/include/asm-um/pgtable.h
@@

-#define pte_present(x) pte_get_bits(x, (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_present(x) (pte_get_bits(x, (_PAGE_PRESENT)) || (pte_get_bits(x, 
(_PAGE_PROTNONE)) && !pte_file(x)))

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
