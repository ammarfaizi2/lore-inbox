Return-Path: <linux-kernel-owner+w=401wt.eu-S1750749AbXANA13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXANA13 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbXANA13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:27:29 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53271 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750749AbXANA12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:27:28 -0500
Date: Sun, 14 Jan 2007 00:37:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 16/20] XEN-paravirt: Add the Xen virtual console driver.
Message-ID: <20070114003752.27a5cac4@localhost.localdomain>
In-Reply-To: <20070113014648.767777869@goop.org>
References: <20070113014539.408244126@goop.org>
	<20070113014648.767777869@goop.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#endif
> +		tty_insert_flip_char(xencons_tty, buf[i], 0);

Please use the defines like TTY_NORMAL not just 0. 

> +		if ((xencons_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
> +		    (xencons_tty->ldisc.write_wakeup != NULL))
> +			(xencons_tty->ldisc.write_wakeup)(xencons_tty);
> +	}

You are't allowed to derefence and call ldisc methods without
holding the lock. You can replace that chunk with a call to the helper
function tty_wakeup(tty). Small but real race condition otherwise as you
xencons_tty->ldisc may be changing as you call it.

> +static inline int __xencons_put_char(int ch)
> +{
> +	char _ch = (char)ch;
> +	if ((wp - wc) == wbuf_size)
> +		return 0;
> +	wbuf[WBUF_MASK(wp++)] = _ch;
> +	return 1;
> +}

A lot of very confusing sign stuff here - you turn an int into a char and
put it into a uchar array

> +	for (i = 0; i < count; i++)
> +		if (!__xencons_put_char(buf[i]))
> +			break;

The int coming from a uchar array

Don't think its wrong - just acutely weird and perhaps could be tidier

> +static void xencons_close(struct tty_struct *tty, struct file *filp)
> +{
> +	unsigned long flags;
> +
> +	mutex_lock(&tty_mutex);

It would be good in future if you could avoid using tty_mutex and use a
private lock. At the moment vt "borrows" it and there are a couple of
incestuous spots but the plan is to eventually fix them and make it
private to tty_io.


Andrew: No objection to this tty stuff being merged provided the bugs
noted above (not worried about the sign stuff) are fixed before it goes
on to Linus.

Alan
