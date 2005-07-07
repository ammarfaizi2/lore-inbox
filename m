Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVGGRc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVGGRc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGGR20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:28:26 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:53419 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261513AbVGGR2M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:28:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fH3pLYy0SghW5FKYg/xtlwarXcMi9FW+FWG84LUxnta5mOggs8trgwjXzQrwELZZwBm0Ya2jWTZFM3zrGOC7TmA+qrVIx1Iwptedx2jm/GjGgZqrG/kGV6Ij27G6CObzdB1pJFe1C/gyiKBoAUP625114pEO/IBKHi4foRktDQ0=
Message-ID: <f0655b9a0507071028209af86e@mail.gmail.com>
Date: Thu, 7 Jul 2005 12:28:09 -0500
From: Sizhao Yang <zaoyang@gmail.com>
Reply-To: Sizhao Yang <zaoyang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ASPLOV miss ratio porting to planet labs kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was wondering if someone could help me with this.  I'm porting an
ASPLOV paper miss ratio curve from 2.4.20 2.6.11.6 and eventually to
Planet Labs kernel.  It's a novel idea for memory management.  In
porting I at run time I'm consistently hitting kernel bugs at four
different places bad_page, bad_range, in rmap.c
BUG(page_mapcount(page)< 0), and failing at apm_do_idle.  All of these
functions except apm_do_idle seem to be new functions from 2.4.20 to
2.6.11.6.  I'm pretty sure I'm forgetting to account for certain
things when modifying the pages, but I'm not sure where.

What I'm doing in the port is resetting protection bits so that when
it page faults.  It will calculate a miss ratio based on the number of
accessed bits and other information.  After I gather the information I
will reset the accessed bits.  Then based on previous miss ratios and
current miss ratio it will give out memory to different processes
based on that.  That's the general idea.  For more specifics:

http://carmen.cs.uiuc.edu/paper/ASPLOS04-Zhou.pdf

I've narrowed it down to primarily when I call the following functions:
ptep_test_and_clear_young,
static inline pte_t pte_mknominor(pte_t pte) { (pte).pte_low &=
~_PAGE_PROTNONE; return pte; }
static inline pte_t pte_mkminor(pte_t pte) { (pte).pte_low |=
_PAGE_PROTNONE; return pte; }
static inline pte_t pte_mkpresent(pte_t pte) { (pte).pte_low |=
_PAGE_PRESENT; return pte; }
static inline pte_t pte_mkabsent(pte_t pte) { (pte).pte_low &=
~_PAGE_PRESENT; return pte; }

When I don't have those functions in my code the kernel doesn't crash,
but when I do they crash.  So, my question is am I to page accounting
aspects? I looked at rmap functions for incrementing the _mapcount but
they seem to be only for when a pte is copied.  Should I be
incrementing the pagecount at any point?  rmap.c
BUG(page_mapcount(page)< 0) is invoked when the accessed bits are
cleared in zap_pte, but I don't know how the page is being corrupted. 
So, my main issue is if anyone can help point me to the direction
where a page could be corrupted I would greatly appreciate.

I'd appreciate any general direction anyone can point me at.  Thanks
in advance.  I look forward to hearing from anyone.

Zao
