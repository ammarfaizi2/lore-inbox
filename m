Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271933AbTG2RgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271934AbTG2RgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:36:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:39127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271933AbTG2RgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:36:19 -0400
Date: Tue, 29 Jul 2003 10:36:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] select fix
Message-Id: <20030729103630.7fb415cb.akpm@osdl.org>
In-Reply-To: <UTC200307291412.h6TECwA17034.aeb@smtp.cwi.nl>
References: <UTC200307291412.h6TECwA17034.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Recently people complained on lk about a problem: one sees
> 
> select(2, NULL, [1], NULL, NULL)        = 1 (out [1])
> write(1, "hi\n", 3)                     = -1 EAGAIN (Resource temporarily unavailable)
> 
> for a stopped tty opened with O_NONBLOCK. This violates POSIX,
> and the 100% CPU use in a select loop does not look pretty either.
> The below fixes this.
> ...
>
> -	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
> +	if (!tty->stopped && tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>  		mask |= POLLOUT | POLLWRNORM;

Manfred sent a patch through esterday which addresses it this way:

-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
+	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS &&
+			tty->driver->write_room(tty) > 0)

Any preferences?

