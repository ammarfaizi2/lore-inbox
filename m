Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVHLV6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVHLV6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVHLV6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:58:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59043
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751296AbVHLV6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:58:21 -0400
Date: Fri, 12 Aug 2005 14:58:09 -0700 (PDT)
Message-Id: <20050812.145809.88701697.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: rmk+lkml@arm.linux.org.uk, galak@freescale.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linuppc-embedded@freescale.com,
       vbordug@ru.mvista.com
Subject: Re: [PATCH] cpm_uart: Fix spinlock initialization
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1123884186.22460.79.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net>
	<20050812204617.C21152@flint.arm.linux.org.uk>
	<1123884186.22460.79.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 12 Aug 2005 23:03:05 +0100

> http://zeniv.linux.org.uk/~alan/serial.diff

I like this a lot, and the count return based error handling
is nice as well.  Should a driver sink any bytes that the
TTY flip interface couldn't eat or should it just wait for
the overrun event?

With respect to that, in fact, there seems to be some questions
of consistency regarding tty_insert_flip_char() and the
tty_prepare_*() interfaces.  If tty_insert_flip_char() fails
to stow away the character (due to memory allocation failure),
this just happens transparently.  However, when using the
tty_prepare_*() stuff the driver just doesn't sink the bytes
at that time.

Perhaps there should be some kind of counterpart for
tty_insert_flip_char() (something like tty_prepare_to_insert_*() or
whatever) so that the "out-of-space" handling can be made more
consistent.

Some other things caught my eye while reading this:

--- linux.vanilla-2.6.13-rc6/drivers/char/hvc_console.c	2005-08-10 13:57:08.000000000 +0100
+++ linux-2.6.13-rc6/drivers/char/hvc_console.c	2005-07-18 19:06:42.000000000 +0100
 ...
+		count = tty_buffer_request_room(tty. N_INBUF);

that "." should be a "," obviously.  Also:

--- linux.vanilla-2.6.13-rc6/drivers/char/pcmcia/synclink_cs.c	2005-08-10 13:57:08.000000000 +0100
+++ linux-2.6.13-rc6/drivers/char/pcmcia/synclink_cs.c	2005-07-25 15:49:51.000000000 +0100
 ...
-		printk("%s(%d):rx_ready_async count=%d\n",
-			__FILE__,__LINE__,tty->flip.count);
+		printk("%s(%d):rx_ready",
+			__FILE__,__LINE__);

The name of the function really is "rx_ready_async", no real need
to condense it to "rx_ready" and in fact this might confuse someone
actually reading this debug message.

Next, I have a question about the logic of tty_buffer_find().

I interpret it's intended semantics as "Give me TTY buffer of size
at least 'size'." But it seems to be checking something else
while traversing the buffer list:

+	while((*tbh) != NULL) {
+		struct tty_buffer *t = *tbh;
+		if(t->size <= size) {
 ...
+			return t;

This returns the first tty buffer found in the list which is
"smaller than or equal to" size, so I think this test is reversed
and should instead be:

+		if(t->size >= size) {

Keep up the good work :-)

