Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAYQpj>; Thu, 25 Jan 2001 11:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRAYQpa>; Thu, 25 Jan 2001 11:45:30 -0500
Received: from soong.cistron.net ([195.64.68.35]:32772 "EHLO smtp.cistron.nl")
	by vger.kernel.org with ESMTP id <S129169AbRAYQpT>;
	Thu, 25 Jan 2001 11:45:19 -0500
Message-ID: <3A705802.5C4DD2F2@augan.com>
Date: Thu, 25 Jan 2001 17:44:51 +0100
From: Roman Zippel <roman@augan.com>
Organization: Augan Instruments BV
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.14-rtl2.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
		<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Timur Tabi wrote:

> I mark the page as reserved when I ioremap() it.  However, if I leave it marked
> reserved, then iounmap() will not unmap it.  If I mark it "unreserved" (i.e.
> reset the reserved bit), then iounmap will unmap it, but it will decrement the
> page counter to -1 and the whole system will crash soon thereafter.
> 
> I've been asking about this problem for months, but no one has bothered to help
> me out.

The order is important:

	get_free_page();
	set_bit(PG_reserved, &page->flags);
	ioremap();
	...
	iounmap();
	clear_bit(PG_reserved, &page->flags);
	free_page();

Alternatively something like this should also be possible:

	get_free_page();
	ioremap();
	...
	iounmap();

nopage() {
	...
	atomic_inc(&page->count);
	return page;
}

But I never tried this version, so I can't guarantee anything. :)

bye, Roman
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
