Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUEOAww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUEOAww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEOAsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:48:39 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:16570 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264627AbUEOApS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:45:18 -0400
Message-ID: <40A55FB9.2090908@yahoo.com.au>
Date: Sat, 15 May 2004 10:09:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, hugh@veritas.com,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
References: <40A42892.5040802@yahoo.com.au>	<20040513193328.11479d3e.akpm@osdl.org>	<40A43152.4090400@yahoo.com.au>	<40A438AC.9020506@yahoo.com.au>	<40A55647.8020904@yahoo.com.au> <20040514165038.17eb142b.akpm@osdl.org>
In-Reply-To: <20040514165038.17eb142b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>I think the entire problem can be fixed by ensuring ->readpage and
>>do_generic_mapping read see the same i_size. This would either mean
>>passing i_size to or from ->readpage, *or* having ->readpage return
>>the number of bytes read, for example.
> 
> 
> Or not check i_size in ->readpage at all?
> 

It needn't check readpage if it gets the number of bytes to read
passed to it, or gets i_size passed to it.

With do_generic_mapping_read and ->readpage each having a different
idea of how much of the page to process(*), bad things can happen.
They have different ideas about how much they need to process due to
the each one checking i_size on its own.

* That is "copy to userspace" and "read" for do_generic_mapping_read
   and ->readpages respectively.

> If fixing this is going to cost extra fastpath cycles I'd be inclined to
> not bother, frankly.
> 

What I'm thinking of shouldn't cost any cycles, it would require a
change to ->readpage API though. Preferably one where we can tell it
how many bytes to read. I can't see how else to fix it.

If this is not acceptable for 2.6, we could use a nicer variation of
my second patch which at least fixes the truncate problem, and its
remaining race is *much* more improbable.
