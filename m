Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRKLQGi>; Mon, 12 Nov 2001 11:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280827AbRKLQG2>; Mon, 12 Nov 2001 11:06:28 -0500
Received: from 200-171-244-84.customer.telesp.net.br ([200.171.244.84]:29062
	"EHLO socrates.dnsalias.org") by vger.kernel.org with ESMTP
	id <S280825AbRKLQGR>; Mon, 12 Nov 2001 11:06:17 -0500
Date: Mon, 12 Nov 2001 14:05:30 -0200
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] VIA timer fix was removed?
Message-ID: <20011112140530.A23866@socrates>
In-Reply-To: <20011112111409.A2617@socrates> <200111121448.PAA01060@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111121448.PAA01060@green.mif.pg.gda.pl>
User-Agent: Mutt/1.3.23i
From: Jeronimo Pellegrini <pellegrini@mpcnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 03:48:24PM +0100, Andrzej Krzysztofowicz wrote:
> > The following patch (introduced by Vojtech Pavlik some time ago) was
> > removed somewhere between 2.4.14 and 2.4.15-pre3.
> > Without it, the timer counter is reset to a wrong value and
> > gettimeofday() starts to return strange values
> > 
> > Nothing aboutit is mentioned in the changelog, so I suppose it wasn't
> > supposed to be removed?
> 
> Maybe, it happens because somebody forgot to comment why this code is
> necessary here ?
> Just a guess...

Then perhaps this would be a good idea?

J.

--- linux-2.4.15-pre3/arch/i386/kernel/time.c	Sun Nov 11 21:33:31 2001
+++ linux-2.4.15-pre3-new/arch/i386/kernel/time.c	Mon Nov 12 14:04:20 2001
@@ -501,6 +501,19 @@
 
 		count = inb_p(0x40);    /* read the latched count */
 		count |= inb(0x40) << 8;
+
+	        /*
+		 * When using some via chipsets (as the vt82c686a, for example)
+		 * the system timer counter (i8253) should be reprogrammed in
+		 * this case, otherwise it may be reset to a wrong value.
+		 */
+		if (count > LATCH-1) {
+			outb_p(0x34, 0x43);
+		        outb_p(LATCH & 0xff, 0x40);
+			outb(LATCH >> 8, 0x40);
+			count = LATCH - 1;
+		}
+
 		spin_unlock(&i8253_lock);
 
 		count = ((LATCH-1) - count) * TICK_SIZE;

