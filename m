Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUKIMTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUKIMTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKIMTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:19:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18637 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261253AbUKIMS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:18:58 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099998437.6081.68.camel@localhost.localdomain>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099998926.15462.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 11:15:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-09 at 11:07, David Woodhouse wrote:
> + *	tty_status_change -	notify of line status changes
> + *	@tty: terminal
> + *
> + *	Helper for informing the line discipline that the modem
> + *	status lines may have changed.
> + */
> +
> +void tty_status_changed(struct tty_struct *tty)
> +{
> +	struct tty_ldisc *ld = tty_ldisc_ref(tty);
> +	if(ld) {
> +		if(ld->status_changed)
> +			ld->status_changed(tty);
> +		tty_ldisc_deref(ld);
> +	}
> +}
> +

This is the wrong way to do it. I've been trying this and discarded it.
The problem is that data arrival is asynchronous to the event which
means you've not got a clue how to combine the status change and the
data stream. This in itself makes the whole feature useless.

Modem changes have to go inline with the data just like break and
parity.

> + *
> + * void (*status_changed)(struct tty_struct *)
> + *
> + *	Called when the modem status lines (CTS, DSR, DCD etc.) are
> + *	changed. May not sleep. 
>   */

You also forgot to update the Documentation directory.

