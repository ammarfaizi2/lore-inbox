Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbTCOU6n>; Sat, 15 Mar 2003 15:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTCOU6n>; Sat, 15 Mar 2003 15:58:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261549AbTCOU6m>;
	Sat, 15 Mar 2003 15:58:42 -0500
Message-ID: <33987.4.64.238.61.1047762573.squirrel@www.osdl.org>
Date: Sat, 15 Mar 2003 13:09:33 -0800 (PST)
Subject: bitmaps/bitops
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not picking on this code, but as an example:

drivers/ieee1394/ieee1394_transactions.c, line 152 (in 2.5.64),
uses:  test_and_set_bit(bit_number, tp->pool),

where tp->pool is declared by using a DECLARE_BITMAP(), like so:
struct hpsb_tlabel_pool {
	DECLARE_BITMAP(pool, 64);

That makes sense (at least to me), but gcc complains about the
type of <pool> when used in test_and_set_bit():
  drivers/ieee1394/ieee1394_transactions.c:152: warning: passing arg 2 of
`test_and_set_bit' from incompatible pointer type

Is this an error, a bug, a nuisance, or just another "ignore gcc 2.96"
problem?

For reference, DECLARE_BITMAP() generates an array of unsigned longs:
#define DECLARE_BITMAP(name,bits) \
	unsigned long name[BITS_TO_LONGS(bits)]
but the prototype for test_and_set_bit() depends on $(ARCH), and it's
not consistent, with the second arg (bitmap address) being one of:
  volatile void *
  void *
  volatile unsigned long *


If there's (kernel) surgery required here, unless it's trivial, I think
that I'd leave it for early 2.7.

~Randy



