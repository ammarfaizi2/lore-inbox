Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVDMOf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDMOf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVDMOf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:35:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51934 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261354AbVDMOfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:35:18 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113402868.3019.27.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 13 Apr 2005 15:34:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 11:01, Hifumi Hisashi wrote:

> I have measured the bh refcount before the buffer_uptodate() for a few days.
> I found out that the bh refcount sometimes reached to 0 .
> So, I think following modifications are effective.
> 
> diff -Nru 2.4.30-rc3/fs/jbd/commit.c 2.4.30-rc3_patch/fs/jbd/commit.c
> --- 2.4.30-rc3/fs/jbd/commit.c	2005-04-06 17:14:47.000000000 +0900
> +++ 2.4.30-rc3_patch/fs/jbd/commit.c	2005-04-06 17:18:49.000000000 +0900
> @@ -302,11 +303,14 @@
>   			if (unlikely(!buffer_uptodate(bh)))
>   				err = -EIO;
>   			/* the journal_head may have been removed now */
> +			put_bh(bh);
>   			lock_journal(journal);
>   			goto write_out_data;

...

In further testing, this chunk is causing some problems.  It is entirely
legal for a buffer to be !uptodate here, although the path is somewhat
convoluted.  The trouble is, once the IO has completed,
journal_dirty_data() can steal the buffer from the committing
transaction.  And once that happens, journal_unmap_buffer() can then
release the buffer and clear the uptodate bit.  

I've run this under buffer tracing and can show you this exact path on a
trace.  It only takes a few seconds to reproduce under fsx.

For this to have happened, though, journal_dirty_data needs to have
waited on the data, so it has an opportunity to see the !uptodate state
at that point.

I think it's safe enough to sidestep this by double-checking to see
whether the bh is still on the committing transaction after we've waited
for the buffer and retaken journaling locks, but before testing
buffer_uptodate().

--Stephen

