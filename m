Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRAVK5M>; Mon, 22 Jan 2001 05:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131903AbRAVK5D>; Mon, 22 Jan 2001 05:57:03 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:3087 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130792AbRAVK4w>; Mon, 22 Jan 2001 05:56:52 -0500
Message-ID: <3A6BFBFC.B8283B37@namesys.com>
Date: Mon, 22 Jan 2001 12:23:08 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Otto Meier <gf435@gmx.net>, Holger Kiehl <Holger.Kiehl@dwd.de>,
        edward@namesys.com, Ed Tomlinson <tomlins@cam.org>,
        Nils Rennebarth <nils@ipe.uni-stuttgart.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        David Willmore <n0ymv@callsign.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
In-Reply-To: <14955.19182.663691.194031@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We'll test and get back to you.

Hans

Neil Brown wrote:
> 
> There have been assorted reports of filesystem corruption on raid5 in
> 2.4.0, and I have finally got a patch - see below.
> I don't know if it addresses everybody's problems, but it fixed a very
> really problem that is very reproducable.
> 
> The problem is that parity can be calculated wrongly when doing a
> read-modify-write update cycle.  If you have a fully functional, you
> wont notice this problem as the parity block is never used to return
> data.  But if you have a degraded array, you will get corruption very
> quickly.
> So I think this will solve the reported corruption with ext2fs, as I
> think they were mostly on degradred arrays.  I have no idea whether it
> will address the reiserfs problems as I don't think anybody reporting
> those problems described their array.
> 
> In any case, please apply, and let me know of any further problems.
> 
> --- ./drivers/md/raid5.c        2001/01/21 04:01:57     1.1
> +++ ./drivers/md/raid5.c        2001/01/21 20:36:05     1.2
> @@ -714,6 +714,11 @@
>                 break;
>         }
>         spin_unlock_irq(&conf->device_lock);
> +       if (count>1) {
> +               xor_block(count, bh_ptr);
> +               count = 1;
> +       }
> +
>         for (i = disks; i--;)
>                 if (chosen[i]) {
>                         struct buffer_head *bh = sh->bh_cache[i];
> 
>  From my notes for this patch:
> 
>    For the read-modify-write cycle, we need to calculate the xor of a
>    bunch of old blocks and bunch of new versions of those blocks.  The
>    old and new blocks occupy the same buffer space, and because xoring
>    is delayed until we have lots of buffers, it could get delayed too
>    much and parity doesn't get calculated until after data had been
>    over-written.
> 
>    This patch flushes any pending xor's before copying over old buffers.
> 
> Everybody running raid5 on 2.4.0 or 2.4.1-pre really should apply this
> patch, and then arrange the get parity checked and corrected on their
> array.
> There currently isn't a clean way to correct parity.
> One way would be to shut down to single user, remount all filesystems
> readonly, or un mount them, and the pull the plug.
> On reboot, raid will rebuild parity, but the filesystems should be
> clean.
> An alternate it so rerun mkraid giving exactly the write configuration.
> This doesn't require pulling the plug, but if you get the config file
> wrong, you could loose your data.
> 
> NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
