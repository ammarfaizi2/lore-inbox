Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWJTTw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWJTTw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWJTTw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:52:58 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:62471 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932273AbWJTTw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:52:57 -0400
Message-ID: <453928E3.5090708@shadowen.org>
Date: Fri, 20 Oct 2006 20:52:03 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc2-mm2] fix tty_ioctl powerpc build
References: <20061020015641.b4ed72e5.akpm@osdl.org> <Pine.LNX.4.64.0610201626500.12392@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0610201626500.12392@blonde.wat.veritas.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> Fix tty_ioctl.c compilation errors and warnings on PowerPC, coming from
> the tty-switch-to-ktermios patches; and make its ktermios the same as
> its termios (as the comment says).
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> 
>  drivers/char/tty_ioctl.c       |    4 ++--
>  include/asm-generic/termios.h  |    4 ++--
>  include/asm-powerpc/termbits.h |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> --- 2.6.19-rc2-mm2/drivers/char/tty_ioctl.c	2006-10-20 12:31:43.000000000 +0100
> +++ linux/drivers/char/tty_ioctl.c	2006-10-20 13:34:29.000000000 +0100
> @@ -495,8 +495,8 @@ static int get_sgttyb(struct tty_struct 
>  	struct sgttyb tmp;
>  
>  	mutex_lock(&tty->termios_mutex);
> -	tmp.sg_ispeed = tty->c_ispeed;
> -	tmp.sg_ospeed = tty->c_ospeed;
> +	tmp.sg_ispeed = tty->termios->c_ispeed;
> +	tmp.sg_ospeed = tty->termios->c_ospeed;
>  	tmp.sg_erase = tty->termios->c_cc[VERASE];
>  	tmp.sg_kill = tty->termios->c_cc[VKILL];
>  	tmp.sg_flags = get_sgflags(tty);
> --- 2.6.19-rc2-mm2/include/asm-generic/termios.h	2005-03-02 07:39:27.000000000 +0000
> +++ linux/include/asm-generic/termios.h	2006-10-20 13:53:58.000000000 +0100
> @@ -11,7 +11,7 @@
>  /*
>   * Translate a "termio" structure into a "termios". Ugh.
>   */
> -static inline int user_termio_to_kernel_termios(struct termios *termios,
> +static inline int user_termio_to_kernel_termios(struct ktermios *termios,
>  						struct termio __user *termio)
>  {
>  	unsigned short tmp;
> @@ -48,7 +48,7 @@ static inline int user_termio_to_kernel_
>   * Translate a "termios" structure into a "termio". Ugh.
>   */
>  static inline int kernel_termios_to_user_termio(struct termio __user *termio,
> -						struct termios *termios)
> +						struct ktermios *termios)
>  {
>  	if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
>  	    put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
> --- 2.6.19-rc2-mm2/include/asm-powerpc/termbits.h	2006-10-20 12:31:49.000000000 +0100
> +++ linux/include/asm-powerpc/termbits.h	2006-10-20 13:44:42.000000000 +0100
> @@ -37,8 +37,8 @@ struct ktermios {
>  	tcflag_t c_oflag;		/* output mode flags */
>  	tcflag_t c_cflag;		/* control mode flags */
>  	tcflag_t c_lflag;		/* local mode flags */
> -	cc_t c_line;			/* line discipline */
>  	cc_t c_cc[NCCS];		/* control characters */
> +	cc_t c_line;			/* line discipline (== c_cc[19]) */
>  	speed_t c_ispeed;		/* input speed */
>  	speed_t c_ospeed;		/* output speed */
>  };
> -

Sorts booting for my ppc's.

Acked-by: Andy Whitcroft <apw@shadowen.org>

-apw
