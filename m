Return-Path: <linux-kernel-owner+willy=40w.ods.org-S516268AbUKBDg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S516268AbUKBDg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270589AbUKBDg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:36:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29648 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272746AbUKBDg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 22:36:29 -0500
Date: Mon, 1 Nov 2004 19:36:16 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] usb serial write fix
Message-ID: <20041101193616.2d517e77@lembas.zaitcev.lan>
In-Reply-To: <mailman.1099321382.10097.linux-kernel2news@redhat.com>
References: <mailman.1099321382.10097.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2004 08:51:08 -0600, Paul Fulghum <paulkf@microgate.com> wrote:

Not a bad idea. I must admit that I thought about that, but then I had
concerns about monopolizing keventd, decided to think later about it, and
forgot about the issue.

> +++ b/drivers/usb/serial/usbserial.c	2004-11-01 08:29:07.000000000 -0600
> +		if (port->tty != NULL) {
> +			int rc;
> +			int sent = 0;
> +			while (sent < job->len) {
> +				rc = __serial_write(port, 0, job->buff + sent, job->len - sent);
> +				if ((rc < 0) || signal_pending(current))
> +					break;

Why testing for signals? Do you expect any?

> +				sent += rc;
> +				if ((sent < job->len) && current->need_resched)
> +					schedule();

That's the main problem here, isn't it. Serial communications are slow.
Tying up a shared thread just because of this just does not look right.
And in such CPU intensive way, too.

Looking at pl2303 in 2.4, I do not see any difference between its ->write
method and generic_write which would be specific to pl2303. The key
difference is that generic_write participates in the protocol governed by
port->write_busy. So why don't you simply drop pl2303_write?

-- Pete
