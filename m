Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTDHJAh (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDHJAh (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:00:37 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9890 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262674AbTDHJAb (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:00:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 8 Apr 2003 11:12:05 +0200 (MEST)
Message-Id: <UTC200304080912.h389C5902360.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] paride fix: make timeouts unsigned long
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Tue Mar 25 04:54:31 2003
+++ b/drivers/block/paride/pg.c	Tue Mar 25 04:59:59 2003
@@ -233,14 +233,14 @@
 	int busy;        	  /* write done, read expected */
 	int start;		  /* jiffies at command start */
 	int dlen;		  /* transfer size requested */
-	int timeout;		  /* timeout requested */
+	unsigned long timeout;	  /* timeout requested */
 	int status;		  /* last sense key */
 	int drive;		  /* drive */
 	unsigned long access;     /* count of active opens ... */
 	int present;		  /* device present ? */
 	char *bufptr;
 	char name[PG_NAMELEN];	  /* pg0, pg1, ... */
-	};
+};
 
 struct pg_unit pg[PG_UNITS];
 
@@ -292,43 +292,47 @@
 	schedule_timeout(cs);
 }
 
-static int pg_wait( int unit, int go, int stop, int tmo, char * msg )
-
-{       int j, r, e, s, p;
+static int pg_wait(int unit, int go, int stop, unsigned long tmo, char *msg)
+{
+	int j, r, e, s, p, to;
 
 	PG.status = 0;
 
 	j = 0;
-	while ((((r=RR(1,6))&go)||(stop&&(!(r&stop))))&&(time_before(jiffies,tmo))) {
-		if (j++ < PG_SPIN) udelay(PG_SPIN_DEL);
-		else pg_sleep(1);
-	}
-
-	if ((r&(STAT_ERR&stop))||time_after_eq(jiffies, tmo)) {
-	   s = RR(0,7);
-	   e = RR(0,1);
-	   p = RR(0,2);
-	   if (verbose > 1)
-	     printk("%s: %s: stat=0x%x err=0x%x phase=%d%s\n",
-		   PG.name,msg,s,e,p,time_after_eq(jiffies, tmo)?" timeout":"");
-
-
-	   if (time_after_eq(jiffies, tmo)) e |= 0x100;
-	   PG.status = (e >> 4) & 0xff;
-	   return -1;
+	while ((((r=RR(1,6))&go) || (stop&&(!(r&stop))))
+	       && time_before(jiffies,tmo)) {
+		if (j++ < PG_SPIN)
+			udelay(PG_SPIN_DEL);
+		else
+			pg_sleep(1);
+	}
+
+	to = time_after_eq(jiffies, tmo);
+
+	if ((r&(STAT_ERR&stop)) || to) {
+		s = RR(0,7);
+		e = RR(0,1);
+		p = RR(0,2);
+		if (verbose > 1)
+			printk("%s: %s: stat=0x%x err=0x%x phase=%d%s\n",
+			       PG.name, msg, s, e, p, to ? " timeout" : "");
+		if (to)
+			e |= 0x100;
+		PG.status = (e >> 4) & 0xff;
+		return -1;
 	}
 	return 0;
 }
 
-static int pg_command( int unit, char * cmd, int dlen, int tmo )
-
-{       int k;
+static int pg_command(int unit, char *cmd, int dlen, unsigned long tmo)
+{
+	int k;
 
 	pi_connect(PI);
 
 	WR(0,6,DRIVE);
 
-	if (pg_wait(unit,STAT_BUSY|STAT_DRQ,0,tmo,"before command")) {
+	if (pg_wait(unit, STAT_BUSY|STAT_DRQ, 0, tmo, "before command")) {
 		pi_disconnect(PI);
 		return -1;
 	}
@@ -337,15 +341,15 @@
 	WR(0,5,dlen / 256);
 	WR(0,7,0xa0);          /* ATAPI packet command */
 
-	if (pg_wait(unit,STAT_BUSY,STAT_DRQ,tmo,"command DRQ")) {
+	if (pg_wait(unit, STAT_BUSY, STAT_DRQ, tmo, "command DRQ")) {
 		pi_disconnect(PI);
 		return -1;
 	}
 
 	if (RR(0,2) != 1) {
-	   printk("%s: command phase error\n",PG.name);
-	   pi_disconnect(PI);
-	   return -1;
+		printk("%s: command phase error\n",PG.name);
+		pi_disconnect(PI);
+		return -1;
 	}
 
 	pi_write_block(PI,cmd,12);
@@ -358,27 +362,30 @@
 	return 0;
 }
 
-static int pg_completion( int unit, char * buf, int tmo)
-
-{       int r, d, n, p;
+static int pg_completion(int unit, char *buf, unsigned long tmo)
+{
+	int r, d, n, p;
 
-	r = pg_wait(unit,STAT_BUSY,STAT_DRQ|STAT_READY|STAT_ERR,
-			tmo,"completion");
+	r = pg_wait(unit, STAT_BUSY, STAT_DRQ|STAT_READY|STAT_ERR,
+		    tmo, "completion");
 
 	PG.dlen = 0;
 
 	while (RR(0,7)&STAT_DRQ) {
-	   d = (RR(0,4)+256*RR(0,5));
-	   n = ((d+3)&0xfffc);
-	   p = RR(0,2)&3;
-	   if (p == 0) pi_write_block(PI,buf,n);
-	   if (p == 2) pi_read_block(PI,buf,n);
-	   if (verbose > 1) printk("%s: %s %d bytes\n",PG.name,
-				    p?"Read":"Write",n);
-	   PG.dlen += (1-p)*d;
-	   buf += d;
-	   r = pg_wait(unit,STAT_BUSY,STAT_DRQ|STAT_READY|STAT_ERR,
-			tmo,"completion");
+		d = (RR(0,4)+256*RR(0,5));
+		n = ((d+3)&0xfffc);
+		p = RR(0,2)&3;
+		if (p == 0)
+			pi_write_block(PI,buf,n);
+		if (p == 2)
+			pi_read_block(PI,buf,n);
+		if (verbose > 1)
+			printk("%s: %s %d bytes\n", PG.name,
+			       p?"Read":"Write", n);
+		PG.dlen += (1-p)*d;
+		buf += d;
+		r = pg_wait(unit, STAT_BUSY, STAT_DRQ|STAT_READY|STAT_ERR,
+			    tmo, "completion");
 	}
 
 	pi_disconnect(PI); 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/paride/pseudo.h b/drivers/block/paride/pseudo.h
--- a/drivers/block/paride/pseudo.h	Fri Nov 22 22:40:27 2002
+++ b/drivers/block/paride/pseudo.h	Tue Mar 18 14:50:10 2003
@@ -39,7 +39,7 @@
 
 static void (* ps_continuation)(void);
 static int (* ps_ready)(void);
-static int ps_timeout;
+static unsigned long ps_timeout;
 static int ps_tq_active = 0;
 static int ps_nice = 0;
 
@@ -70,7 +70,7 @@
 	spin_unlock_irqrestore(&ps_spinlock,flags);
 }
 
-static void ps_tq_int( void *data )
+static void ps_tq_int(void *data)
 {
 	void (*con)(void);
 	unsigned long flags;
