Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUBKAjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUBKAjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 19:39:18 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26262 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263325AbUBKAjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 19:39:16 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Linux Kern <linux-kernel@vger.kernel.org>
Date: Wed, 11 Feb 2004 11:39:13 +1100
Cc: akpm@digeo.com
Subject: [TRIVIAL patch] 2.6.2-rc2 Remove compile warnings from timer.o
Message-ID: <20040211003913.GC15247@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To allow the ia64 simulator to run correctly on slower machines
the value of HZ has been defined as 32, this has introduced a compiler
warning (not that much of issue):
kernel/timer.c: In function `second_overflow':
kernel/timer.c:589: warning: right shift count is negative
kernel/timer.c:592: warning: right shift count is negative

I asked if the value of HZ could be increased for the simulator in 
include/asm-ia64/param.h, 
which was rejected for reasons below.

Is the patch below acceptable.

Darren


On Tue, 10 Feb 2004, David Mosberger wrote:


> 
>   Darren> -#  define HZ	  32
>   Darren> +#  define HZ	  96
> 
> Doesn't strike me as the correct fix: looking at timex.h, clearly HZ
> values as low as 12Hz are supposed to be supported.  Perhaps a better
> fix would be to change timer.c to verify that
> SHIFT_SCALE<=SHIFT_USEC+SHIFT_HZ before attempting to do the shifting
> (via a CPP #if, of course).
> 
> Also, I'm a bit reluctant to increase the HZ value for the simulator,
> because too large a value will cause the simulated kernel to fail to
> make forward progress on slow host machines.

I thouht that this might be the case, though the fisrt attempt modified
the smallest amount of source.

> 	--david

Hope the attached is suitable.

Darren

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--- linux-2.6.2-rc2.orig/kernel/timer.c	2004-02-11 10:45:02.000000000 +1100
+++ linux-2.6.2-rc2/kernel/timer.c	2004-02-11 10:01:26.000000000 +1100
@@ -584,12 +584,22 @@ static void second_overflow(void)
 			 STA_PPSWANDER | STA_PPSERROR);
     }
     ltemp = time_freq + pps_freq;
+    
+#if (SHIFT_SCALE <= (SHIFT_USEC + SHIFT_HZ))
     if (ltemp < 0)
 	time_adj -= -ltemp >>
 	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
     else
 	time_adj += ltemp >>
 	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
+	    
+#else	/* (SHIFT_SCALE > (SHIFT_USEC + SHIFT_HZ)) */
+    if (ltemp < 0)
+	time_adj -= -ltemp >> SHIFT_SCALE;
+    else
+	time_adj += ltemp >> SHIFT_SCALE;
+	    
+#endif /* (SHIFT_SCALE > (SHIFT_USEC + SHIFT_HZ)) */
 
 #if HZ == 100
     /* Compensate for (HZ==100) != (1 << SHIFT_HZ).


--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
