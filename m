Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWAXXZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWAXXZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAXXZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:25:13 -0500
Received: from [81.2.110.250] ([81.2.110.250]:51414 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750833AbWAXXZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:25:11 -0500
Subject: Re: pppd oopses current linu's git tree on disconnect
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1138140391.3223.15.camel@amdx2.microgate.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	 <1137692039.3279.1.camel@amdx2.microgate.com>
	 <20060119230746.ea78fcf4.diegocg@gmail.com> <43D01537.40705@microgate.com>
	 <20060123034243.22ba0a8f.diegocg@gmail.com>
	 <20060124044846.de6508eb.diegocg@gmail.com>
	 <1138140391.3223.15.camel@amdx2.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jan 2006 23:25:29 +0000
Message-Id: <1138145129.21284.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-24 at 16:06 -0600, Paul Fulghum wrote:
> I reasonably sure that your problem is lack
> of locking for the new tty buffering scheme.
> There is a question of how to best fix it
> with minimal code change and impact on performance.

Yeah the new tty code assumed the same locking rules as the old tty code
and nobody on the planet followed them since 2.2.

> I've done some initial testing with success.
> Let me know what you think.

I think you've been reading my mind, only you've actually come up with a
slightly neater variant than I have half coded here.

>  int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size)
>  {
>  	int space = tty_buffer_request_room(tty, size);
> -	struct tty_buffer *tb = tty->buf.tail;
> -	*chars = tb->char_buf_ptr + tb->used;
> -	memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
> -	tb->used += space;
> +	if (space) {
> +		struct tty_buffer *tb = tty->buf.tail;
> +		*chars = tb->char_buf_ptr + tb->used;
> +		memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
> +		tb->used += space;
> +	}

This seems unrelated and also not useful. 0 space is such a special case
that it isn't worth the check - and it works fine anyway with 0.

> +	if (space) {
> +		struct tty_buffer *tb = tty->buf.tail;
> +		*chars = tb->char_buf_ptr + tb->used;
> +		*flags = tb->flag_buf_ptr + tb->used;
> +		tb->used += space;
> +	}

Ditto


> --- linux-2.6.16-rc1/include/linux/kbd_kern.h	2006-01-17 09:31:29.000000000 -0600
> +++ linux-2.6.16-rc1-mg/include/linux/kbd_kern.h	2006-01-24 15:38:19.000000000 -0600
> @@ -151,6 +151,11 @@ extern unsigned int keymap_count;
>  
>  static inline void con_schedule_flip(struct tty_struct *t)

Should die as a duplicate by the look of it, and the tty one probably
should cease to be inline.

Looks good to me.

Alan

