Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSEVD7L>; Tue, 21 May 2002 23:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSEVD7K>; Tue, 21 May 2002 23:59:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:38583 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316845AbSEVD7J>;
	Tue, 21 May 2002 23:59:09 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15595.5939.708078.827286@argo.ozlabs.ibm.com>
Date: Wed, 22 May 2002 13:57:39 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <Pine.LNX.4.33.0205211609210.15094-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that there is a race in this code in zap_pte_range,
because there is a gap between when we read the pte and when we clear
it:

	for (offset=0; offset < size; ptep++, offset += PAGE_SIZE) {
		pte_t pte = *ptep;
		if (pte_none(pte))
			continue;
		if (pte_present(pte)) {
			unsigned long pfn = pte_pfn(pte);

			pte_clear(ptep);

Isn't it possible that another cpu could set the dirty bit in the pte
between the "pte = *ptep" and the "pte_clear(ptep)"?  In my case
another cpu could also set the "has hash-table entry" bit.

Shouldn't we do this as "pte = ptep_get_and_clear(ptep)", at least in
the case where we are unmapping stuff?

Paul.
