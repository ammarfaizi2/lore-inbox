Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUJYTIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUJYTIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUJYTG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:06:26 -0400
Received: from lucidpixels.com ([66.45.37.187]:12930 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261265AbUJYTDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:03:53 -0400
Date: Mon, 25 Oct 2004 15:03:48 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.9 Page Allocation Failures w/TSO+rollup.patch
In-Reply-To: <200410251456_MC3-1-8D29-C332@compuserve.com>
Message-ID: <Pine.LNX.4.61.0410251502360.26447@p500>
References: <200410251456_MC3-1-8D29-C332@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, the below patch did not fix the problem.

I am waiting for the error to re-occur then I will sysrq+M and dmesg & 
send the info to the mailing list.

Rollup patch was from Nick Piggin, he stated:

Date: Sat, 23 Oct 2004 19:14:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failures Return With 2.6.9+TSO patch.
Parts/Attachments:
    1 Shown     32 lines  Text
    2 Shown    356 lines  Text
----------------------------------------

Justin Piszcz wrote:
> Kernel 2.6.9 w/TSO patch.
>
> (most likely do to the e1000/nic/issue)
>
> $ dmesg
> gaim: page allocation failure. order:4, mode:0x21
>  [<c01391a7>] __alloc_pages+0x247/0x3b0
>  [<c0139328>] __get_free_pages+0x18/0x40
>  [<c035c33a>] sound_alloc_dmap+0xaa/0x1b0
>  [<c03648c0>] ad_mute+0x20/0x40
>  [<c035c70f>] open_dmap+0x1f/0x100
>  [<c035cb58>] DMAbuf_open+0x178/0x1d0
>  [<c035a4fa>] audio_open+0xba/0x280
>  [<c015d863>] cdev_get+0x53/0xc0
>  [<c035968c>] sound_open+0xac/0x110
>  [<c035898e>] soundcore_open+0x1ce/0x300
>  [<c03587c0>] soundcore_open+0x0/0x300
>  [<c015d524>] chrdev_open+0x104/0x250
>  [<c015d420>] chrdev_open+0x0/0x250
>  [<c0152d82>] dentry_open+0x1d2/0x270
>  [<c0152b9c>] filp_open+0x5c/0x70
>  [<c01049c8>] common_interrupt+0x18/0x20
>  [<c0152e75>] get_unused_fd+0x55/0xf0
>  [<c0152fd9>] sys_open+0x49/0x90
>  [<c010405b>] syscall_call+0x7/0xb

Ouch, 64K atomic DMA allocation.

The DMA zone barely even keeps that much total memory free.

The caller probably wants fixing, but you could try this patch...

     [ Part 2: "Attached Text" ]


Pine -> 2    356 lines   Text/X-PATCH (Name: "rollup.patch")

That was rollup.patch (patched 3 source files) - but this as well as the 
TSO has not seemed to have fixed the problem.

On Mon, 25 Oct 2004, Chuck Ebbert wrote:

> Nicj Piggin wrote:
>
>> Does it cause any noticable problems? If not, then stay with
>> 2.6.9.
>>
>> However, it would be nice to get to the bottom of it. It might
>> just be happening by chance on 2.6.9 but not 2.6.8.1 though...
>
>  Isn't this the problem fixed by the below patch?  (Sorry I didn't
> get sender name when I collected it.)  Some were skeptical this
> would fix it but it has worked for those who tried...
>
>  Oh and BTW what is rollup.patch?
>
>
> # The following patch makes it allocate skb_headlen(skb) - len instead
> # of skb->len - len.  When skb is linear there is no difference.  When
> # it's non-linear we only ever copy the bytes in the header.
> #
> ===== net/ipv4/tcp_output.c 1.67 vs edited =====
> --- 1.67/net/ipv4/tcp_output.c  2004-10-01 13:56:45 +10:00
> +++ edited/net/ipv4/tcp_output.c        2004-10-17 18:58:47 +10:00
> @@ -455,8 +455,12 @@
> {
>        struct tcp_opt *tp = tcp_sk(sk);
>        struct sk_buff *buff;
> -       int nsize = skb->len - len;
> +       int nsize;
>        u16 flags;
> +
> +       nsize = skb_headlen(skb) - len;
> +       if (nsize < 0)
> +               nsize = 0;
>
>        if (skb_cloned(skb) &&
>            skb_is_nonlinear(skb) &&
>
> --Chuck Ebbert  25-Oct-04  14:54:36
>
