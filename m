Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318156AbSHDLaj>; Sun, 4 Aug 2002 07:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSHDLaj>; Sun, 4 Aug 2002 07:30:39 -0400
Received: from pD9E43AA4.dip.t-dialin.net ([217.228.58.164]:37321 "EHLO
	linux-buechse.de") by vger.kernel.org with ESMTP id <S318156AbSHDLai>;
	Sun, 4 Aug 2002 07:30:38 -0400
Date: Sun, 4 Aug 2002 13:33:50 +0200
From: "Juergen E. Fischer" <fischer@linux-buechse.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Problem with AHA152X driver in 2.4.19
Message-ID: <20020804113350.GA11061@linux-buechse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <p6r65yrlvt1.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p6r65yrlvt1.fsf@free.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sat, Aug 03, 2002 at 19:02:50 +0200, Marc Lefranc wrote:
> I just built 2.4.19 and checked that the problem that had been
> introduced in the aha152x driver between 2.4.19-pre8 and pre10 (bad
> initialization due to lost interrupt) had been corrected. However, I
> have experienced another problem related to blocking factor.

I posted another patch a while ago. Obviously it didn't make it into
2.4.19.  So this is the same thing against 2.4.19.

It fixes your problem and another one related to longtaking tape
operations.


Juergen


--- orig/linux/drivers/scsi/aha152x.c	2002-08-04 13:26:14.000000000 +0200
+++ linux-2.4/drivers/scsi/aha152x.c	2002-07-19 00:10:35.000000000 +0200
@@ -602,7 +602,11 @@
 #define SCDONE(SCpnt)		SCDATA(SCpnt)->done
 #define SCSEM(SCpnt)		SCDATA(SCpnt)->sem
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#define SG_ADDRESS(buffer)	((buffer)->address)
+#else
 #define SG_ADDRESS(buffer)	((char *) (page_address((buffer)->page)+(buffer)->offset))
+#endif
 
 /* state handling */
 static void seldi_run(struct Scsi_Host *shpnt);
@@ -2657,7 +2661,7 @@
 		 * STCNT to trigger ENSWRAP interrupt, instead of
 		 * polling for DFIFOFULL
 		 */
-		the_time=jiffies + 10*HZ;
+		the_time=jiffies + 100*HZ;
 		while(TESTLO(DMASTAT, DFIFOFULL|INTSTAT) && time_before(jiffies,the_time))
 			barrier();
 
@@ -2670,7 +2674,7 @@
 		if(TESTHI(DMASTAT, DFIFOFULL)) {
 			fifodata = 128;
 		} else {
-			the_time=jiffies + 10*HZ;
+			the_time=jiffies + 100*HZ;
 			while(TESTLO(SSTAT2, SEMPTY) && time_before(jiffies,the_time))
 				barrier();
 
@@ -2826,7 +2830,7 @@
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 		}
 
-		the_time=jiffies + 10*HZ;
+		the_time=jiffies + 100*HZ;
 		while(TESTLO(DMASTAT, DFIFOEMP|INTSTAT) && time_before(jiffies,the_time))
 			barrier();
 
