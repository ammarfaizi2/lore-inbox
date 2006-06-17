Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWFQRvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWFQRvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 13:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFQRvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 13:51:21 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:44210 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750752AbWFQRvU (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 13:51:20 -0400
Message-ID: <4494411B.4010706@namesys.com>
Date: Sat, 17 Jun 2006 10:51:23 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, hch@infradead.org,
       Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com>	<20060524175312.GA3579@zero>	<44749E24.40203@namesys.com>	<20060608110044.GA5207@suse.de>	<1149766000.6336.29.camel@tribesman.namesys.com>	<20060608121006.GA8474@infradead.org>	<1150322912.6322.129.camel@tribesman.namesys.com> <20060617100458.0be18073.akpm@osdl.org>
In-Reply-To: <20060617100458.0be18073.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>We have one filesystem which wants such a refactoring (although I don't
>think you've adequately spelled out _why_ reiser4 wants this).
>  
>
>
When calling the filesystem for writes, there is processing that must be
done:

1) per word

2) per page

3) per call to the FS

If the FS is called per page, then it turns out that 3) costs more than
1) and 2) for sophisticated filesystems.  As we develop fancier and
fancier plugins this will just get more and more true.  It decreases CPU
usage by 2x to use per sys_write calls into reiser4 rather than per page
calls into reiser4.  (Vladimir, on Monday can you find and send your
benchmarks?)  This is significant for cached writes.

If it violates the intuition to believe this, then let me point out that
there was a similar motivation for the creation of bios: calling the
block layer traverses more lines of code than copying a page of bytes
does.  Unfortunately, all that code turns out to be useful
optimizations, so one cannot just take the attitude (whether for the
block layer or reiser4) that it should just be simplified.

Please note that I have no real problem with leaving the generic code
unchanged and having reiser4 do its own write operation.  I am modifying
the generic code because you suggested it was preferred.  Having
reviewed the code in detail, I see that you were right and it is better
to just fix the generic code to call more than 4k at a time into the FS,
and then be able to reuse the generic aio and direct io code (and etc.)
as a result.  So, to be sociable, and to get more code reuse, we make
this proposal.

>To be able to say "yes, we want this" I think we'd need to understand which
>other filesystems would benefit from exploiting it, and with what results?
>
>
>  
>
Or just let us have our own sys_write implementation without being
excluded for it.  I have shown that it is significantly faster for
reiser4 to process things more than 4k at a time.
