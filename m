Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130347AbQKNCAi>; Mon, 13 Nov 2000 21:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbQKNCAa>; Mon, 13 Nov 2000 21:00:30 -0500
Received: from ha2.rdc2.tx.home.com ([24.14.77.21]:13038 "EHLO
	mail.rdc2.tx.home.com") by vger.kernel.org with ESMTP
	id <S130347AbQKNCAX>; Mon, 13 Nov 2000 21:00:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem autonegotiation with tulip driver?
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 13 Nov 2000 18:30:39 -0600
Message-ID: <m2bsvjwg28.fsf@c469597-a.grlnd1.tx.home.com>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current version (and may previous versions) of the tulip driver
in media.c in the function tulip_select_media() with mleaf->type being
2 or 4, we have the following code:

  if (p[1] & 0x40) {      /* SIA (CSR13-15) setup values are provided. */
      csr13val = setup[0];
      csr14val = setup[1];
      csr15dir = (setup[3]<<16) | setup[2];
      csr15val = (setup[4]<<16) | setup[2];
      outl(0, ioaddr + CSR13);
      outl(csr14val, ioaddr + CSR14);
      outl(csr15dir, ioaddr + CSR15); /* Direction */
      outl(csr15val, ioaddr + CSR15); /* Data */
      outl(csr13val, ioaddr + CSR13);
  } else {
      csr13val = 1;
      csr14val = 0x0003FF7F;
	         ^^^^^^^^^^
      csr15dir = (setup[0]<<16) | 0x0008;
      csr15val = (setup[1]<<16) | 0x0008;

In the value underscored above, autonegotiation of the media is turned
off if the eeprom doesn't provide the CSR14 value.  This doesn't seem
right (and doesn't work on our Ramix cards), it seems like you would
want to leave autonegotiation on here (the value would be 0x0003FFFF).
Without this, our Ramix cards will not autonegotiate.  With the
change, they work great.

Corey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
