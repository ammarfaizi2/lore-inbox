Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316989AbSFAHGO>; Sat, 1 Jun 2002 03:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSFAHGN>; Sat, 1 Jun 2002 03:06:13 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:5013 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S316989AbSFAHGI>; Sat, 1 Jun 2002 03:06:08 -0400
Date: Sat, 1 Jun 2002 00:05:56 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Radez <rob@osinvestor.com>,
        Matt Domsch <Matt_Domsch@dell.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Watchdog Stuff (3/4)
Message-ID: <20020601070554.GB10159@insight.us.oracle.com>
In-Reply-To: <20020601064309.GA10222@insight.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch number three, fixing the watchdogs that access userspace
without get_user().

Joel

diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/advantechwdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/advantechwdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/advantechwdt.c	Thu May 30 17:15:25 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/advantechwdt.c	Fri May 31 13:24:10 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/alim7101_wdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/alim7101_wdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/alim7101_wdt.c	Thu May 30 18:23:19 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/alim7101_wdt.c	Fri May 31 13:23:52 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/eurotechwdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/eurotechwdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/eurotechwdt.c	Thu May 30 17:24:50 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/eurotechwdt.c	Fri May 31 13:23:38 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/machzwd.c linux-2.4.19-pre9-magicclose-fix/drivers/char/machzwd.c
--- linux-2.4.19-pre9-nowayout/drivers/char/machzwd.c	Thu May 30 17:30:24 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/machzwd.c	Fri May 31 13:24:22 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/sc1200wdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/sc1200wdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/sc1200wdt.c	Thu May 30 17:43:56 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/sc1200wdt.c	Fri May 31 14:08:20 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/sc520_wdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/sc520_wdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/sc520_wdt.c	Fri May 31 14:32:54 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/sc520_wdt.c	Fri May 31 14:33:47 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/shwdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/shwdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/shwdt.c	Tue May 28 18:51:38 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/shwdt.c	Fri May 31 13:26:05 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/w83877f_wdt.c linux-2.4.19-pre9-magicclose-fix/drivers/char/w83877f_wdt.c
--- linux-2.4.19-pre9-nowayout/drivers/char/w83877f_wdt.c	Tue May 28 18:51:38 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/w83877f_wdt.c	Fri May 31 13:26:53 2002
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
diff -uNr linux-2.4.19-pre9-nowayout/drivers/char/wdt_pci.c linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt_pci.c
--- linux-2.4.19-pre9-nowayout/drivers/char/wdt_pci.c	Fri May 31 14:32:40 2002
+++ linux-2.4.19-pre9-magicclose-fix/drivers/char/wdt_pci.c	Fri May 31 14:33:39 2002
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

"Always give your best, never get discouraged, never be petty; always
 remember, others may hate you.  Those who hate you don't win unless
 you hate them.  And then you destroy yourself."
	- Richard M. Nixon

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
