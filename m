Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTDUT37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDUT37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:29:59 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:64778 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261722AbTDUT36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:29:58 -0400
Date: Mon, 21 Apr 2003 20:42:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
Subject: Re: [PATCH] n_hdlc.c 2.5.68 (try 2)
Message-ID: <20030421204200.A12475@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Fulghum <paulkf@microgate.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"torvalds@transmeta.com" <torvalds@transmeta.com>
References: <1050952852.1841.41.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1050952852.1841.41.camel@diemos>; from paulkf@microgate.com on Mon, Apr 21, 2003 at 02:20:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 02:20:53PM -0500, Paul Fulghum wrote:
> Attempt 2 with suggestions from Chritoph Hellwig
> 
> * Remove MODULE_USE_COUNT macros
> * Add owner member to struct tty_ldisc
> * Init tty_ldisc at compile time
> * make some functions static

.oO(I guess you'll have me for moaning again, but..)

>  
>  static int __init n_hdlc_init(void)
>  {
> -	static struct tty_ldisc	n_hdlc_ldisc;
> +	static struct tty_ldisc	n_hdlc_ldisc = {

Usual Linux style is to have this outside of any function scope.
That'll get important once we get a saner tty_unregister_ldisc
prototype.

> +		TTY_LDISC_MAGIC,    /* magic */
> +		"hdlc",             /* name */

Please use C99 named initializers.

> +		0,                  /* num */
> +		0,                  /* flags */

And no need to initialize anything to 0/NULL.

It should look like:

static struct tty_ldisc n_hdlc_ldisc = {
	.owner		= THIS_MODULE,
	.magic		= TTY_LDISC_MAGIC,
	.name		= "hdlc",
	.open		= n_hdlc_tty_open,
	.close		= n_hdlc_tty_close,
	.read		= n_hdlc_tty_read,
	.write		= n_hdlc_tty_write,
	.ioctl		= n_hdlc_tty_ioctl,
	.poll		= n_hdlc_tty_poll,
	.receive_buf	= n_hdlc_tty_receive,
	.receive_room	= n_hdlc_tty_room,
	.write_wakeup	= n_hdlc_tty_wakeup,
};
