Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSEWTbE>; Thu, 23 May 2002 15:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSEWTbD>; Thu, 23 May 2002 15:31:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25357 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316992AbSEWTbD>;
	Thu, 23 May 2002 15:31:03 -0400
Message-ID: <3CED432F.E0150C06@zip.com.au>
Date: Thu, 23 May 2002 12:29:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include buffer_head.h in actual users instead of fs.h (6/10)
In-Reply-To: <20020523132700.G24361@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> Make the 7 file that need it in mm/ include buffer_head.h directly.
> Once again most files shouln't need it and want fixing.

Yup.  In fact, some declarations need to be moved out of
buffer_head.h.

> --- 1.91/mm/filemap.c   Sun May 19 13:49:50 2002
> +++ edited/mm/filemap.c Thu May 23 13:19:05 2002
> @@ -20,6 +20,16 @@
>  #include <linux/iobuf.h>
>  #include <linux/hash.h>
>  #include <linux/writeback.h>
> +/*
> + * This is needed for the following functions:
> + *  - try_to_release_page

This isn't buffer-specific; should be in mm.h or similar.

> + *  - block_flushpage

Should never be called - all callers should call
call a_ops->flushpage() (and rename it to
invalidatepage, for heavens sake)

> + *  - page_has_buffers

well hopefully we can do something a little tidier than
all the invalidate_foo2() functions.  But that's in fact
a happens-to-not-matter bug. Should be using PagePrivate()
in invalidate_this_page2()

> + *  - generic_osync_inode

Sigh.  Needs to be pushed out to generic_file_write()
callers, I suspect.

etc...

-
