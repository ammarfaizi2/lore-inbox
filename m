Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSHHAPR>; Wed, 7 Aug 2002 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSHHAPR>; Wed, 7 Aug 2002 20:15:17 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:14774 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S317003AbSHHAO6>; Wed, 7 Aug 2002 20:14:58 -0400
Date: Wed, 7 Aug 2002 17:18:29 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org, Rob Radez <rob@osinvestor.com>,
       Matt Domsch <Matt_Domsch@dell.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       marcelo@conectiva.com.br
Subject: [PATCH] [2.4.20-pre1] Watchdog Stuff (3/4)
Message-ID: <20020808001829.GD1038@nic1-pc.us.oracle.com>
References: <20020808001238.GB1038@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808001238.GB1038@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The third patch, fixing drivers that don't use get_user in their
magicclose code.

Joel

diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/advantechwdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/advantechwdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/advantechwdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/advantechwdt.c	Wed Aug  7 15:40:06 2002
@@ -125,7 +125,10 @@
 			adv_expect_close = 0;
 
 			for (i = 0; i != count; i++) {
-				if (buf[i] == 'V')
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
 					adv_expect_close = 42;
 			}
 		}
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/alim7101_wdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/alim7101_wdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/alim7101_wdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/alim7101_wdt.c	Wed Aug  7 15:40:06 2002
@@ -174,9 +174,13 @@
 			wdt_expect_close = 0;
 
 			/* now scan */
-			for(ofs = 0; ofs != count; ofs++)
-				if(buf[ofs] == 'V')
+			for(ofs = 0; ofs != count; ofs++) {
+				char c;
+				if(get_user(c, buf + ofs))
+					return -EFAULT;
+				if(c == 'V')
 					wdt_expect_close = 1;
+			}
 		}
 
 		/* someone wrote to us, we should restart timer */
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/eurotechwdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/eurotechwdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/eurotechwdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/eurotechwdt.c	Wed Aug  7 15:40:06 2002
@@ -237,7 +237,10 @@
          eur_expect_close = 0;
 
          for (i = 0; i != count; i++) {
-            if (buf[i] == 'V')
+            char c;
+            if (get_user(c, buf + i))
+		    return -EFAULT;
+            if (c == 'V')
                eur_expect_close = 42;
          }
       }
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/machzwd.c linux-2.4.20-pre1-magicclose-fix/drivers/char/machzwd.c
--- linux-2.4.20-pre1-nowayout/drivers/char/machzwd.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/machzwd.c	Wed Aug  7 15:40:06 2002
@@ -329,7 +329,10 @@
 	
 			/* now scan */
 			for(ofs = 0; ofs != count; ofs++){
-				if(buf[ofs] == 'V'){
+				char c;
+				if(get_user(c, buf + ofs))
+					return -EFAULT;
+				if(c == 'V'){
 					zf_expect_close = 1;
 					dprintk("zf_expect_close 1\n");
 				}
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/sc1200wdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/sc1200wdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/sc1200wdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/sc1200wdt.c	Wed Aug  7 15:40:06 2002
@@ -263,7 +263,10 @@
 
 			for (i = 0; i != len; i++)
 			{
-				if (data[i] == 'V')
+				char c;
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
 					expect_close = 42;
 			}
 		}
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/sc520_wdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/sc520_wdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/sc520_wdt.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/sc520_wdt.c	Wed Aug  7 15:40:06 2002
@@ -210,9 +210,13 @@
 		wdt_expect_close = 0;
 
 		/* now scan */
-		for(ofs = 0; ofs != count; ofs++) 
-			if(buf[ofs] == 'V')
+		for(ofs = 0; ofs != count; ofs++) {
+			char c;
+			if (get_user(c, buf + ofs))
+				return -EFAULT;
+			if(c == 'V')
 				wdt_expect_close = 1;
+		}
 
 		/* Well, anyhow someone wrote to us, we should return that favour */
 		next_heartbeat = jiffies + WDT_HEARTBEAT;
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/shwdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/shwdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/shwdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/shwdt.c	Wed Aug  7 15:40:06 2002
@@ -237,7 +237,10 @@
 		shwdt_expect_close = 0;
 
 		for (i = 0; i != count; i++) {
-			if (buf[i] == 'V')
+			char c;
+			if (get_user(c, buf + i))
+				return -EFAULT;
+			if (c == 'V')
 				shwdt_expect_close = 42;
 		}
 		next_heartbeat = jiffies + (sh_heartbeat * HZ);
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/w83877f_wdt.c linux-2.4.20-pre1-magicclose-fix/drivers/char/w83877f_wdt.c
--- linux-2.4.20-pre1-nowayout/drivers/char/w83877f_wdt.c	Fri Aug  2 17:39:43 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/w83877f_wdt.c	Wed Aug  7 15:40:06 2002
@@ -192,8 +192,13 @@
 
 		/* now scan */
 		for(ofs = 0; ofs != count; ofs++)
-			if(buf[ofs] == 'V')
+		{
+			char c;
+			if(get_user(c, buf + ofs))
+				return -EFAULT;
+			if(c == 'V')
 				wdt_expect_close = 1;
+		}
 
 		/* someone wrote to us, we should restart timer */
 		next_heartbeat = jiffies + WDT_HEARTBEAT;
diff -uNr linux-2.4.20-pre1-nowayout/drivers/char/wdt_pci.c linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt_pci.c
--- linux-2.4.20-pre1-nowayout/drivers/char/wdt_pci.c	Wed Aug  7 15:30:18 2002
+++ linux-2.4.20-pre1-magicclose-fix/drivers/char/wdt_pci.c	Wed Aug  7 15:40:06 2002
@@ -247,7 +247,10 @@
 			expect_close = 0;
 
 			for (i = 0; i != count; i++) {
-				if (buf[i] == 'V')
+				char c;
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
 					expect_close = 1;
 			}
 		}

-- 

Life's Little Instruction Book #20

	"Be forgiving of yourself and others."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
