Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264477AbUEaAdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUEaAdX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 20:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUEaAdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 20:33:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38597 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264477AbUEaAdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 20:33:21 -0400
Date: Sun, 30 May 2004 17:32:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] Fix typo in pmac_zilog
Message-Id: <20040530173252.4a040e99.davem@redhat.com>
In-Reply-To: <1085901218.10399.11.camel@gaston>
References: <1085715655.6320.138.camel@gaston>
	<20040529234258.42a2dc64.davem@redhat.com>
	<1085901218.10399.11.camel@gaston>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 17:13:38 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> There is a deadlock issue. I triggered once when I had a bug where the
> driver was flooding the input with zero's. All serial drivers seem to be
> affected. Apparently, tty_flip_* may call back into your write() routine

Yes indeed, one code path is:

tty_flip_buffer_push()
if (tty->low_latency)
	flush_to_ldisc() {
		tty->ldisc.receive_buf() == n_tty_receive_buf() {
			...
			n_tty_receive_char() {
				...
				start_tty() {
					tty->driver->start() == uart_start()

and that's where we try to grab the uart port lock again.

It seems lots of serial drivers have this bug, even 8250.c :-)

I'll fix up the Sparc drivers meanwhile.
