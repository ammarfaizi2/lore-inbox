Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289583AbSBJMfs>; Sun, 10 Feb 2002 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289594AbSBJMfj>; Sun, 10 Feb 2002 07:35:39 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:49426 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S289583AbSBJMfU>;
	Sun, 10 Feb 2002 07:35:20 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: <dledford@redhat.com>
Cc: "Dave Jones" <davej@suse.de>, "Lkml" <linux-kernel@vger.kernel.org>
Subject: [patch][2.5.4-dj4] cleanup, use strsep in aic7xxx_linux.c and aic7xxx_old.c
Date: Sun, 10 Feb 2002 13:35:18 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODMEMOCJAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch changes strtok() use to strsep().
Strtok() isn't SMP/thread safe. strsep is considered safer.


--
	Alex (alex@packetstorm.nu)


-------------------------- cut here -------------------------
diff -uN linux-2.5.3-dj4/drivers/scsi/aic7xxx/aic7xxx_linux.c linux/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- linux-2.5.3-dj4/drivers/scsi/aic7xxx/aic7xxx_linux.c        Thu Jan 17 22:59:33 2002
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c  Sat Feb  9 22:43:10 2002
@@ -445,7 +445,7 @@
                                                      struct ahc_linux_device*);
 static void ahc_linux_run_device_queue(struct ahc_softc*,
                                       struct ahc_linux_device*);
-static void ahc_linux_setup_tag_info(char *p, char *end);
+static void ahc_linux_setup_tag_info(char *p, char *end, char *s);
 static int ahc_linux_next_unit(void);
 static int ahc_linux_halt(struct notifier_block *nb, u_long event, void *buf);

@@ -906,7 +906,7 @@
 }

 static void
-ahc_linux_setup_tag_info(char *p, char *end)
+ahc_linux_setup_tag_info(char *p, char *end, char *s)
 {
        char    *base;
        char    *tok;
@@ -986,7 +986,7 @@
                }
        }
        while ((p != base) && (p != NULL))
-               p = strtok(NULL, ",.");
+               p = strsep(&s, ",.");
 }

 /*
@@ -1018,7 +1018,8 @@

        end = strchr(s, '\0');

-       for (p = strtok(s, ",."); p; p = strtok(NULL, ",.")) {
+       while ((p = strsep(&s, ",.")) != NULL) {
+               if (!*p) continue;
                for (i = 0; i < NUM_ELEMENTS(options); i++) {
                        n = strlen(options[i].name);

@@ -1026,7 +1027,7 @@
                                continue;

                        if (strncmp(p, "tag_info", n) == 0) {
-                               ahc_linux_setup_tag_info(p + n, end);
+                               ahc_linux_setup_tag_info(p + n, end, s);
                        } else if (p[n] == ':') {
                                *(options[i].flag) =
                                    simple_strtoul(p + n + 1, NULL, 0);
diff -Nru a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c        Sat Feb  9 21:03:01 2002
+++ b/drivers/scsi/aic7xxx_old.c        Sat Feb  9 21:03:01 2002
@@ -1443,7 +1443,7 @@

   end = strchr(s, '\0');

-  for (p = strtok(s, ",."); p; p = strtok(NULL, ",."))
+  while ((p = strsep(&s, ",.")) != NULL)
   {
     for (i = 0; i < NUMBER(options); i++)
     {
@@ -1525,7 +1525,7 @@
               }
             }
             while((p != base) && (p != NULL))
-              p = strtok(NULL, ",.");
+              p = strsep(&s, ",.");
           }
         }
         else if (p[n] == ':')


