Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWDQCW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWDQCW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 22:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWDQCW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 22:22:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:45396 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750968AbWDQCW6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 22:22:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pl72TTVKJd1DRtSL7/CWADCX74hb1FKlNJrPVrhgX3+Ekg4UpPo+c+pTtFWBy8Vf2vliClBpsfELhVNBK6E9nUQdFMqotVpaOmCve6uwQ9hrrqA1DPU9IbuynFQkTaLqei/KDPqhZgDlttnG92n0Z7nqKaUPts/WcwmWr0/TF44=
Message-ID: <9a8748490604161922u2016d36fk954da30f5e8dcdce@mail.gmail.com>
Date: Mon, 17 Apr 2006 04:22:56 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISDN: unsafe interaction between isdn_write and isdn_writebuf_stub
Cc: "Karsten Keil" <kkeil@suse.de>,
       "Kai Germaschewski" <kai.germaschewski@gmx.de>,
       "Fritz Elfert" <fritz@isdn4linux.de>,
       "Michael Hipp" <Michael.Hipp@student.uni-tuebingen.de>,
       isdn4linux@listserv.isdn4linux.de, "Andrew Morton" <akpm@osdl.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>
In-Reply-To: <200604112205.21736.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604112205.21736.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No replies to this patch (below) at all, despite lots of people and
lists on CC :-(
Ohh well, adding akpm to CC so that perhaps the patch can make it into
-mm and at least get some testing.

/Jesper


On 4/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> isdn_write() and isdn_writebuf_stub() seem to have some unsafe interaction.
>
> I was originally just looking to fix this warning:
>   drivers/isdn/i4l/isdn_common.c:1956: warning: ignoring return value of `opy_from_user', declared with attribute warn_unused_result
> And indeed, the return value is not checked, and I can't convince myself
> that it's 100% certain that it can never fail.
>
> While reading the code I also noticed that the while loop in isdn_write()
> only tests for isdn_writebuf_stub() return value != count as termination
> condition. This makes it impossible for isdn_writebuf_stub() to tell the
> caller why it failed so the caller can pass that info on.
> It also looks unsafe that if isdn_writebuf_stub() fails to allocate an skb,
> then it just returns 0 (zero) which is unlikely to cause the != count
> check in the caller to abort the loop, so it looks like it'll just enter
> the function once more and again fail to alloc an skb, repeat ad infinitum.
>
> To fix these things I first made isdn_writebuf_stub() return -ENOMEM if it
> cannot allocate an skb and also return -EFAULT if the user copy fails.
>  (this ofcourse also fixes the warning I was originally investigating)
>
> Then I ditched the while loop in isdn_write() and replaced it with a
> hand-coded loop made up of a label and a goto, and inside this hand-made
> loop I then test if isdn_writebuf_stub() returns a value <=0 and if it does
> then that value is used as the `retval' from isdn_write() and if not then
> it tests the !=count condition and otherwise behaves like the original
> while loop.
>
>
> I hope my analysis of the situation and the resulting fix is correct; if
> not, then I'd appreciate feedback pointing out my error(s).
>
> Unfortunately I have no hardware to properly test the patch, so it's
> compile tested only. So please read the patch carefully before applying it.
>
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  drivers/isdn/i4l/isdn_common.c |   14 ++++++++++----
>  1 files changed, 10 insertions(+), 4 deletions(-)
>
> --- linux-2.6.17-rc1-git4-orig/drivers/isdn/i4l/isdn_common.c   2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.17-rc1-git4/drivers/isdn/i4l/isdn_common.c        2006-04-11 21:43:26.000000000 +0200
> @@ -1177,9 +1177,14 @@ isdn_write(struct file *file, const char
>                         goto out;
>                 }
>                 chidx = isdn_minor2chan(minor);
> -               while (isdn_writebuf_stub(drvidx, chidx, buf, count) != count)
> + loop:
> +               retval = isdn_writebuf_stub(drvidx, chidx, buf, count);
> +               if (retval < 0)
> +                       goto out;
> +               if (retval != count) {
>                         interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
> -               retval = count;
> +                       goto loop;
> +               }
>                 goto out;
>         }
>         if (minor <= ISDN_MINOR_CTRLMAX) {
> @@ -1951,9 +1956,10 @@ isdn_writebuf_stub(int drvidx, int chan,
>         struct sk_buff *skb = alloc_skb(hl + len, GFP_ATOMIC);
>
>         if (!skb)
> -               return 0;
> +               return -ENOMEM;
>         skb_reserve(skb, hl);
> -       copy_from_user(skb_put(skb, len), buf, len);
> +       if (!copy_from_user(skb_put(skb, len), buf, len))
> +               return -EFAULT;
>         ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, skb);
>         if (ret <= 0)
>                 dev_kfree_skb(skb);
>
>
>
>
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
