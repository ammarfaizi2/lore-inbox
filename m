Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbRAVQtA>; Mon, 22 Jan 2001 11:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132930AbRAVQsv>; Mon, 22 Jan 2001 11:48:51 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:32268 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S132932AbRAVQsk>; Mon, 22 Jan 2001 11:48:40 -0500
Message-ID: <3A6C8BBE.85F94455@namesys.com>
Date: Mon, 22 Jan 2001 19:36:30 +0000
From: Edward <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Otto Meier <gf435@gmx.net>, Holger Kiehl <Holger.Kiehl@dwd.de>,
        Hans Reiser <reiser@namesys.com>, Ed Tomlinson <tomlins@cam.org>,
        Nils Rennebarth <nils@ipe.uni-stuttgart.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        David Willmore <n0ymv@callsign.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
In-Reply-To: <14955.19182.663691.194031@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 
But we deal with a fully functional one. 
Nevertheless this patch fixed reiserfs corruption..
Thanks.
Edward.

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
