Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289201AbSANLf1>; Mon, 14 Jan 2002 06:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288638AbSANLfP>; Mon, 14 Jan 2002 06:35:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28693 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288696AbSANLee>; Mon, 14 Jan 2002 06:34:34 -0500
Date: Mon, 14 Jan 2002 12:34:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: J Sloan <jjs@pobox.com>
Cc: Andrew Morton <akpm@zip.com.au>, Ed Sweetman <ed.sweetman@wmich.edu>,
        yodaiken@fsmlabs.com, jogi@planetzork.ping.de,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114123425.B10227@athlon.random>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> <3C40A6BB.1090100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C40A6BB.1090100@pobox.com>; from jjs@pobox.com on Sat, Jan 12, 2002 at 01:12:27PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 01:12:27PM -0800, J Sloan wrote:
> 
>    Ah - if it stands a chance of going into 2.4,
>    I'll test the heck out of it!
>    I'll give it the Q3A test, the RtCW test, the
>    xine/xmms/dbench tests, and more - glad
>    to be of service.
>    jjs
>    Andrew Morton wrote:
> 
> Ed Sweetman wrote:
> 
> If you want to test the preempt kernel you're going to need something that
> can find the mean latancy or "time to action" for a particular program or
> all programs being run at the time and then run multiple programs that you
> would find on various peoples' systems.   That is the "feel" people talk
> about when they praise the preempt patch.
> 
> Right.  And that is precisely why I created the "mini-ll" patch.  To
> give the improved "feel" in a way which is acceptable for merging into
> the 2.4 kernel.
> And guess what?   Nobody has tested the damn thing, so it's going
> nowhere.
> Here it is again:
> --- linux-2.4.18-pre3/fs/buffer.c       Fri Dec 21 11:19:14 2001
> +++ linux-akpm/fs/buffer.c      Sat Jan 12 12:22:29 2002
> @@ -249,12 +249,19 @@ static int wait_for_buffers(kdev_t dev, 
>         struct buffer_head * next;
>         int nr;
>  
> -       next = lru_list[index];
>         nr = nr_buffers_type[index];
> +repeat:
> +       next = lru_list[index];
>         while (next && --nr >= 0) {
>                 struct buffer_head *bh = next;
>                 next = bh->b_next_free;
>  
> +               if (dev == NODEV && current->need_resched) {
> +                       spin_unlock(&lru_list_lock);
> +                       conditional_schedule();
> +                       spin_lock(&lru_list_lock);
> +                       goto repeat;
> +               }
>                 if (!buffer_locke
> d(bh)) {

this introduces possibility of looping indefinitely, this is why I
rejected it while I merged the mini-ll other points into -aa, if you
want to do anything like that at the very least you should roll the head
of the list as well or something like that.

Andrea
