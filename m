Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTJDIur (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 04:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbTJDIur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 04:50:47 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:35522 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261953AbTJDIup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 04:50:45 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andi Kleen <ak@muc.de>, Joe Korty <joe.korty@ccur.com>
Subject: Re: mlockall and mmap of IO devices don't mix
Date: Sat, 4 Oct 2003 10:47:56 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <CFYv.787.23@gated-at.bofh.it> <m34qyp7ae4.fsf@averell.firstfloor.org>
In-Reply-To: <m34qyp7ae4.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310041047.56705.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 October 2003 09:02, Andi Kleen wrote:
> Joe Korty <joe.korty@ccur.com> writes:
> > I do not believe that the above constitutes a correct fix.  The
> > problem is that follow_pages() is fundamentally not able to handle a
> > mapping which does not have a 'struct page' backing it up, and a
> > mapping to IO memory by definition has no 'struct page' structure to
> > back it up.
>
> The 2.4 vm scanner handles this by always checking VALID_PAGE().
>
> Maybe follow_pages() should do that too?

It does already. 

Just see the most indented check there. It tries to find a struct page from the
page frame number (pfn_to_page) after obtaining the  pfn from the pte.

This check is only done, if it is a valid pfn (pfn_valid()) of a present
pte.

Since make_pages_present uses get_user_pages(), which in turn calls
follow_pages() with the above checks, this is properly checked.

The only path where is is NOT checked, is hugetlb stuff. So the error must be
there.

If somebody does the changes, please remove the useless get_page_map(), since
it just does the above checks done already again after a reverse lookup and I
could not find ANY case, where the check in get_page_map() would fail. 

So maybe a BUG_ON() the checks in get_page_map() and a LTP run combinded with
bttv usage afterwards would be good.

Regards

Ingo Oeser


