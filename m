Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUENXvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUENXvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUENXvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:51:25 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:11382 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264543AbUENX3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:19 -0400
Message-ID: <40A55647.8020904@yahoo.com.au>
Date: Sat, 15 May 2004 09:29:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
References: <40A42892.5040802@yahoo.com.au> <20040513193328.11479d3e.akpm@osdl.org> <40A43152.4090400@yahoo.com.au> <40A438AC.9020506@yahoo.com.au>
In-Reply-To: <40A438AC.9020506@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> This following patch should be right.
> 
> It causes the zeros to not get copied back unless i_size
> gets extended again.
> 

OK, nobody has looked at this yet, so I'll just summarise my
ramblings.

The truncate vs add_to_page_cache race which I first misidentified
to be the problem is actually harmless and there by design as
Andrew points out. My first patch did "fix" it AFAIKS, but doubtful
if it is worth the locking and complexity.

The real problem is that readpage doesn't use the same i_size as
do_generic_mapping_read (ie. it could be changed by another racing
operation). This race window is quite large at the moment, containing
cond_resched and a page allocation.

Is this transient returning of zero fill actually a problem? Transient,
ie. a second read could see the correct i_size and not return the zeros.

My second patch gets closer to the heart of the problem: I think it
fixes all truncate races. However a write(2) could still expand the
i_size between ->readpage and calculation of nr, thus causing zero fill
to appear transiently again (one would either want to return the
written data, or a short read, not zeros).

I think the entire problem can be fixed by ensuring ->readpage and
do_generic_mapping read see the same i_size. This would either mean
passing i_size to or from ->readpage, *or* having ->readpage return
the number of bytes read, for example.
