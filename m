Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDMXQj>; Sat, 13 Apr 2002 19:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDMXQi>; Sat, 13 Apr 2002 19:16:38 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:40971 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310917AbSDMXQh>; Sat, 13 Apr 2002 19:16:37 -0400
Message-ID: <3CB8BC32.51231352@zip.com.au>
Date: Sat, 13 Apr 2002 16:16:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: aliasing bug in blockdev-in-pagecache?
In-Reply-To: <20020413235948.E4937@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> ...
> --- fs/buffer.c.~1~     Fri Apr 12 17:59:09 2002
> +++ fs/buffer.c Sat Apr 13 21:09:36 2002
> @@ -1902,9 +1902,14 @@
>         }
> 
>         /* Stage 3: start the IO */
> -       for (i = 0; i < nr; i++)
> -               submit_bh(READ, arr[i]);
> -
> +       for (i = 0; i < nr; i++) {
> +               struct buffer_head * bh = arr[i];
> +               if (buffer_uptodate(bh))
> +                       end_buffer_io_async(bh, 1);
> +               else
> +                       submit_bh(READ, bh);
> +       }
> +
>         return 0;
>  }
> 

Agree.  I have debug checks for this in the 2.5 code and
they do not come out in normal use, so no probs there.

I'm starting to tighten all of this up in the patches
which I'm working on.  Move the debug checks out of
ll_rw_block and into submit_bh.  submit_bh will complain about

- writing non-uptodate buffer
- reading uptodate buffer
- reading dirty buffer
- reading or writing unmapped buffer
- anything else I can think of.

This means that a number of callers need to be changed
to set the bits correctly, which is pointless work.

But really, I think we need that formality - we keep on
making obscure mistakes in this area and the costs are
high.

-
