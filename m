Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVCJQMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVCJQMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCJQMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:12:14 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:24301 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262686AbVCJQJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:09:11 -0500
Message-ID: <42308073.CEA0DF75@tv-sign.ru>
Date: Thu, 10 Mar 2005 20:14:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] readahead: improve sequential read detection
References: <42260F30.BE15B4DA@tv-sign.ru> <1110412324.4816.89.camel@localhost>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
>
> On Wed, 2005-03-02 at 11:08, Oleg Nesterov wrote:
> >
> >  out:
> > - return newsize;
> > + return ra->prev_page + 1;
>
> This change introduces one key behavioural change in
> page_cache_readahead(). Instead of returning the number-of-pages
> successfully read, it now returns the next-page-index which is yet to be
> read. Was this essential?

The problem is that with this change:
+       if (offset == ra->prev_page && --req_size)
+               ++offset;
we can't just return newsize.

Because the caller of page_cache_readahead(offset, req_size) expects
that returned value is the number-of-pages successfully read from
this original offset.

Consider do_generic_mapping_read() reading two pages at offset 10,
with ra->prev_page == 10.

1st page, index == 10:
	ret_size = page_cache_readahead(10, 2);		// returns 1
	next_index += ret_size;				// next_index == 11

2nd page, index == 11:
	if (index == next_index)			// Yes
		page_cache_readahead(11, 1);		// BOGUS!

It can be solved without behavioural change of course, but it will be
more complex.

> At least, a comment towards this effect at the top of the function is
> worth adding.

Yes, it's my fault. I should have added comment in changelog at least.

Oleg.
