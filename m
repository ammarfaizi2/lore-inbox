Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTB0KYG>; Thu, 27 Feb 2003 05:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTB0KYG>; Thu, 27 Feb 2003 05:24:06 -0500
Received: from ns.javad.ru ([62.105.138.7]:23315 "EHLO ns.javad.ru")
	by vger.kernel.org with ESMTP id <S263137AbTB0KYC>;
	Thu, 27 Feb 2003 05:24:02 -0500
To: henrique.gobbi@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: n_tty.c - possible enhancement
References: <Pine.LNX.4.33.0301211141580.8730-100000@pcz-madhavis.sasken.com>
	<3E2CF0A1.5030203@ToughGuy.net> <3E5B9E23.6080303@cyclades.com>
X-attribution: osv
From: Sergei Organov <osv@javad.ru>
Date: 27 Feb 2003 13:34:13 +0300
In-Reply-To: <3E5B9E23.6080303@cyclades.com>
Message-ID: <8765r63tcq.fsf@osv.javad.ru>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrique Gobbi <henrique2.gobbi@cyclades.com> writes:
> Dear all !!!
> 

Disclaimer: I'm not an expert in Linux kernel internals. Everything I'll say
below could well be plain wrong as my opinion is based only on superficial
investigation of tty source code and 3-months-long monitoring of this mailing
list.

> I was having data loss problems using my serial ports at 115200 with software
> flow control (I can't use hw flow control) and I ended up figuring out that
> the problem was happening because of the small value of the tty buffer high
> water mark (TTY_THRESHOLD_THROTTLE). Changing that define value and
> recompiling the kernel was the only solution i found to my problem.

I've faced with a similar problem and my attempt to get any help from any guru
here failed (you can try to find my post called "Q: problems interfacing with
tty ldisc using flipbufs" posted 02 Dec 2002 that describes the problem). It
seems that your post won't have any response either :-(

> 
> The way this code is implemented today is bad. The water marks are hard coded
> and the only way to change them is recompiling the kernel again, and this is
> not a good solution for that. I want to change that.

Not only hard-coded, but also are private for n_tty.c, so a tty driver has no
way to find out what are the values :-( It would be fine if there were a way
to send data to the n_tty line discipline without knowledge of the values, but
unfortunately it seems that it's impossible using current interface to line
disciplines.

> My idea is:
> -------------------------------------------------------------------------
> 1 - Create two new variables in the tty struct: high_watermark and
>     low_watermark;
> 2 - Initialize this variables with the values they have today: 128 and 128;
> 3 - Create 4 ioctl's to set and get the values of this 2 variables;
> 4 - Change the file n_tty.c. The line that has
> 	if (n_tty_receive_room(tty) < TTY_THRESHOLD_THROTTLE) {
>      will have:
> 	if (n_tty_receive_room(tty) < tty->high_watermark) {
>      and the same thing will be done for the low watermark
> -------------------------------------------------------------------------

1. I don't think that adding n_tty--specific field(s) to the tty structure is
   a good idea.

2. I think that the interface between tty drivers and line disciplines is
   broken in the sense that it fails to provide reliable method of data
   transfer between tty driver and line discipline. I believe that either the
   interface should be re-designed (that may involve quite large amount of
   work as it will affect line disciplines other than n_tty), or a work-around
   local to n_tty.c should be implemented. As what you suggest is neither of
   the above two solutions (as adding the fields to the tty structure won't
   fix the interface), I don't think it's a correct way to fix the problem.

My own solution to this problem is to make TTY_THRESHOLD_THROTTLE to be at
least as large as TTY_FLIPBUF_SIZE. It will guarantee that driver's throttle
routine will be called without data loss. I have no idea though which
unfortunate side effects this change may have.

-- 
Sergei.

