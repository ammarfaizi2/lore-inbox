Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280683AbRKLNOj>; Mon, 12 Nov 2001 08:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280691AbRKLNOa>; Mon, 12 Nov 2001 08:14:30 -0500
Received: from 200-171-244-84.customer.telesp.net.br ([200.171.244.84]:16001
	"EHLO socrates.dnsalias.org") by vger.kernel.org with ESMTP
	id <S280683AbRKLNOQ>; Mon, 12 Nov 2001 08:14:16 -0500
Date: Mon, 12 Nov 2001 11:14:09 -0200
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: [PATCH] VIA timer fix was removed?
Message-ID: <20011112111409.A2617@socrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The following patch (introduced by Vojtech Pavlik some time ago) was
removed somewhere between 2.4.14 and 2.4.15-pre3.
Without it, the timer counter is reset to a wrong value and
gettimeofday() starts to return strange values.

Nothing aboutit is mentioned in the changelog, so I suppose it wasn't
supposed to be removed?

J.

--- linux-2.4.15-pre3/arch/i386/kernel/time.c	Sun Nov 11 21:33:31 2001
+++ linux-2.4.15-pre3-new/arch/i386/kernel/time.c	Mon Nov 12 10:45:57 2001
@@ -501,6 +501,14 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+
+		if (count > LATCH-1) {
+			outb_p(0x34, 0x43);
+		        outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+			count = LATCH - 1;
+		}
+
 		spin_unlock(&i8253_lock);
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
