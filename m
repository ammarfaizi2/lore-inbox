Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281763AbRKUNLv>; Wed, 21 Nov 2001 08:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRKUNLm>; Wed, 21 Nov 2001 08:11:42 -0500
Received: from pier.botik.ru ([193.232.174.1]:35461 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id <S281760AbRKUNLX>;
	Wed, 21 Nov 2001 08:11:23 -0500
Message-ID: <3BFBA2E3.4B1305DE@yura.polnet.botik.ru>
Date: Wed, 21 Nov 2001 15:49:39 +0300
From: "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.15-pre7 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Frank de Lange <lkml-frank@unternet.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Chris Mason <mason@suse.com>
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <20011112205551.A14132@unternet.org> <3BF02BA4.D7E2D70E@mandrakesoft.com> <20011112235642.A17544@unternet.org> <3BFB6B09.1060103@namesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Frank de Lange wrote:
>
> >On Mon, Nov 12, 2001 at 03:05:56PM -0500, Jeff Garzik wrote:
> >
> >>Can you try 2.4.13ac6 (not 7/8), and 2.2.20, and post a comparison?
> >>
> >
> >Here's the results from some tests I did:
> >
> >2.2.20
> >======
> >without filesystem activity
> >no slowdowns observed
> >time ls -al /usr/|sort -k 5 -n
> >real   0m0.121s
> >user   0m0.000s
> >sys    0m0.090s
> >
> >with filesystem activity on ext2
> >no slowdowns observed
> >time ls -al /opt/|sort -k 5 -n
> >real   0m0.079s
> >user   0m0.010s
> >sys    0m0.100s
> >
> >2.4.13-ac5
> >==========
> >no slowdowns observed
> >without filesystem activity
> >time ls -al /usr/|sort -k 5 -n
> >real   0m0.142s
> >user   0m0.000s
> >sys    0m0.000s
> >
> >with filesystem activity on ext2
> >no slowdowns observed
> >time ls -al /opt/|sort -k 5 -n
> >real   0m0.022s
> >user   0m0.020s
> >sys    0m0.010s
> >
> >with filesystem activity on reiserfs
> > - it took 31 seconds to just open this small ( < 1 kb) text file (which
> >   resides in my home directory, on an ext2 filesystem) in vi...
> >time ls -al /usr/|sort -k 5 -n
> >real    0m6.136s
> >user    0m0.020s
> >sys     0m0.020s
> >
> >
> >2.4.15-pre4
> >===========
> >without filesystem activity
> >no slowdowns observed
> >time ls -al /usr/|sort -k 5 -n
> >real   0m0.081s
> >user   0m0.010s
> >sys    0m0.010s
> >
> >with filesystem activity on ext2
> >no slowdowns observed
> >time ls -al /usr/|sort -k 5 -n
> >real    0m0.146s
> >user    0m0.000s
> >sys     0m0.020s
> >
> >with filesystem activity on reiserfs
> >system behaviour erratic, some slowdowns
> >time ls -al /opt|sort -k5 -n
> >real    0m13.232s
> >user    0m0.020s
> >sys     0m0.010s
> >
> >Seems that reiserfs is the common factor here, at least on my box. This is a 35
> >GB reiserfs filesystem, app 80% used, both large and small files.
> >
> >As said in my previous message, the numbers themselves don't mean squat. It is
> >the large delays (the fact that user+sys <<< real) which are the problem here.
> >
> >Any other magic anyone wants me to perform? Hans, you reading this?
> >
> >Cheers//Frank
> >
> Yura, see if you can reproduce this and analyze the cause.  If I
> understand correctly, he is saying the problem is not throughput but
> latency.  Is that correct Frank?  Once Yura reproduces it, I will
> speculate as to the cause.
>
> Hans

Hello,

Yes, the latency problem exist. I was using "dd" and "cp" commands
to create and copy 1 GB file as "filesystem activity".

In both cases the set of :
"time ls -al /opt|sort -k5 -n"  show the same delay.

One way to improve the situation is to use the patch below,
suggested by Chris Mason :

--- linux/fs/buffer.c Fri, 16 Nov 2001 10:58:28 -0500
+++ linux/fs/buffer.c Sun, 18 Nov 2001 12:44:40 -0500
@@ -1020,9 +1020,10 @@
                struct buffer_head * bh;

                bh = get_hash_table(dev, block, size);
-               if (bh)
+               if (bh) {
+                       touch_buffer(bh) ;
                        return bh;
-
+               }
                if (!grow_buffers(dev, block, size))
                        free_more_memory();
        }

Thanks,
Yura.

