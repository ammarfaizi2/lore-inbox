Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHVPzR>; Thu, 22 Aug 2002 11:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSHVPzR>; Thu, 22 Aug 2002 11:55:17 -0400
Received: from ida.rowland.org ([192.131.102.52]:2564 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id <S312558AbSHVPzC>;
	Thu, 22 Aug 2002 11:55:02 -0400
Date: Thu, 22 Aug 2002 11:59:08 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: <stern@ida.rowland.org>
To: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@transvirtual.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Patch for PC keyboard driver's autorepeat-rate handling
Message-ID: <Pine.LNX.4.33L2.0208221153210.672-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes several mistakes in the PC keyboard driver's
autorepeat-rate handling.  It applies as-is to both the current 2.4.x
and 2.5.x Linux kernels.

I don't know why nobody has addressed this problem earlier.  Hasn't
anyone noticed that Rik Faith's kbdrate program no longer works
properly?  The error is not in the program; it's in the kernel's
handling of the KDKBDREP ioctl.  This patch fixes the following three
mistakes:

	The .rate member of struct kbd_repeat is actually a repeat
	_period_ measured in msec; the driver interprets it as a
	repeat _rate_ in characters per second.

	The driver returns the _prior_ values of the rate and delay
	settings rather than the _current_ values.

	The driver looks for an exact match for the rate and delay
	values rather than using the closest match.

Note that the first two issues above are mentioned explicitly in
include/linux/kd.h, in the region defining the KDKBDREP ioctl.

Not all the repeat rates supported by the PC hardware are recognized
by the driver.  I decided not to change that, since many of the rates
are only imperceptibly different.  If anybody thinks that implementing
the full set would be worthwhile, it will be easy enough to do so.

Incidentally, does anybody know why drivers/char/pc_keyb.c hasn't been
moved to the arch/i386 part of the directory tree?

Alan Stern


--- drivers/char/pc_keyb.c.orig	Wed Aug 21 15:36:13 2002
+++ drivers/char/pc_keyb.c	Thu Aug 22 11:12:05 2002
@@ -13,6 +13,9 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Fix the keyboard autorepeat rate handling.
+ * Alan Stern <stern@rowland.org> 2002-08-21.
+ *
  */

 #include <linux/config.h>
@@ -578,7 +581,7 @@
 }

 #define DEFAULT_KEYB_REP_DELAY	250
-#define DEFAULT_KEYB_REP_RATE	30	/* cps */
+#define DEFAULT_KEYB_REP_RATE	33	/* msec: = 30 cps */

 static struct kbd_repeat kbdrate={
 	DEFAULT_KEYB_REP_DELAY,
@@ -587,48 +590,48 @@

 static unsigned char parse_kbd_rate(struct kbd_repeat *r)
 {
-	static struct r2v{
-		int rate;
-		unsigned char val;
-	} kbd_rates[]={	{5,0x14},
-			{7,0x10},
-			{10,0x0c},
-			{15,0x08},
-			{20,0x04},
-			{25,0x02},
-			{30,0x00}
-	};
-	static struct d2v{
-		int delay;
-		unsigned char val;
-	} kbd_delays[]={{250,0},
-			{500,1},
-			{750,2},
-			{1000,3}
+#if 0	/* Here is the complete list of repeat periods in msec. */
+		{	 33,  38,  42,  46,  50,  54,  58,  63,
+			 67,  75,  83,  92, 100, 108, 117, 125,
+			133, 150, 167, 183, 200, 217, 234, 250,
+			267, 300, 334, 367, 400, 434, 467, 500};
+#endif
+	static struct r2v {
+		int period;
+		int val;
+	} kbd_rates[] = {	{33,0},		/* 30 cps */
+				{42,2},		/* 24 */
+				{50,4},		/* 20 */
+				{67,8},		/* 15 */
+				{100,12},	/* 10 */
+				{133,16},	/* 7.5 */
+				{200,20},	/* 5 */
+				{500,31},	/* 2 */
 	};
-	int rate=0,delay=0;
+	static int kbd_delays[4] = {250, 500, 750, 1000};
+	int rval=0, dval=0, i;
+
 	if (r != NULL){
-		int i,new_rate=30,new_delay=250;
 		if (r->rate <= 0)
 			r->rate=kbdrate.rate;
 		if (r->delay <= 0)
 			r->delay=kbdrate.delay;
-		for (i=0; i < sizeof(kbd_rates)/sizeof(struct r2v); i++)
-			if (kbd_rates[i].rate == r->rate){
-				new_rate=kbd_rates[i].rate;
-				rate=kbd_rates[i].val;
+
+		/* Find the closest matches */
+
+		for (i = 0; i < sizeof(kbd_rates)/sizeof(struct r2v)-1; i++) {
+			if ((kbd_rates[i].period+kbd_rates[i+1].period)/2 >= r->rate)
 				break;
-			}
-		for (i=0; i < sizeof(kbd_delays)/sizeof(struct d2v); i++)
-			if (kbd_delays[i].delay == r->delay){
-				new_delay=kbd_delays[i].delay;
-				delay=kbd_delays[i].val;
+		}
+		r->rate = kbd_rates[i].period;
+		rval = kbd_rates[i].val;
+		for (dval=0; dval < sizeof(kbd_delays)/sizeof(int)-1; dval++) {
+			if ((kbd_delays[dval]+kbd_delays[dval+1])/2 >= r->delay)
 				break;
-			}
-		r->rate=new_rate;
-		r->delay=new_delay;
+		}
+		r->delay = kbd_delays[dval];
 	}
-	return (delay << 5) | rate;
+	return (dval << 5) | rval;
 }

 static int write_kbd_rate(unsigned char r)
@@ -644,13 +647,13 @@
 {
 	if (rep == NULL)
 		return -EINVAL;
-	else{
+	if (rep->rate < 0 && rep->delay < 0) {
+		*rep = kbdrate;
+		return 0;
+	} else {
 		unsigned char r=parse_kbd_rate(rep);
-		struct kbd_repeat old_rep;
-		memcpy(&old_rep,&kbdrate,sizeof(struct kbd_repeat));
-		if (write_kbd_rate(r)){
-			memcpy(&kbdrate,rep,sizeof(struct kbd_repeat));
-			memcpy(rep,&old_rep,sizeof(struct kbd_repeat));
+		if (write_kbd_rate(r)) {
+			kbdrate = *rep;
 			return 0;
 		}
 	}


