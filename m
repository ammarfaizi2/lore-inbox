Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbULaM2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbULaM2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbULaM2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:28:47 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:30693 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261878AbULaM2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:28:45 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: waiting 10s before mounting root filesystem?
To: Jesper Juhl <juhl-lkml@dif.dk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>,
       Andrew Morton <akpm@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 31 Dec 2004 13:33:01 +0100
References: <fa.nc4oh06.1j1872e@ifi.uio.no> <fa.nalafoa.1ih25aa@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CkLxl-0000XG-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> I agree with you that reducing screen clutter is a good thing. How about
> something like this that waits for 10+ seconds so even slow devices have a
> chance to get up but also does some primitive ratelimiting on the messages
> by only printing one every 3 seconds (but still attempting to mount every
> 1 sec) ?

a) Print every 4 seconds, this will replace one division by a bit-test:
... int retries = 32 ...
... if (! (retries & 0x3)) /* is a multiple of 4 */ ...

I choose 32 because I saw SCSI controlers taking an enormous amount of time
until detecting all devices. Maybe it's still too low for bus 7 id 15, but
I'd wait for someone to complain.

b) I saw no benefit from using 'short' instead of 'int' when I did a small
test (with uudecoding on i386) some time ago, but I could make the
resulting code be smaller and use less memory accesses by introducing some
temporary ints to hold the chars I was operating upon. Are there contrary
experiences that lead to using 'short' here?

c) This patch will sleep for a second after the last try before it
continues to panic. It's OK for me, but maybe there is a better way of
doing this.

@ Andrew Morton:

The patch with a timeout is needed because the machine might be on a
remote location and rebooted using lilo's once-only feature. An automatic
reset after the panic will bring it back.
