Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289639AbSBJO21>; Sun, 10 Feb 2002 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289645AbSBJO2I>; Sun, 10 Feb 2002 09:28:08 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:51474 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S289639AbSBJO1z>;
	Sun, 10 Feb 2002 09:27:55 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: <l.s.r@web.de>
Cc: "Dave Jones" <davej@suse.de>, "Lkml" <linux-kernel@vger.kernel.org>
Subject: RE: [patch][2.5.4-dj4] cleanup to use strsep for fs/fat/inode.c
Date: Sun, 10 Feb 2002 15:27:47 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODKENACJAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020210141918.3552d0fc.l.s.r@web.de>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch changes all use of strtok() to strsep().
> > Strtok() isn't SMP/thread safe. strsep is considered safer.
> 
> OK, but ...
> 
> > -       for (this_char = strtok(options,","); this_char;
> > -            this_char = strtok(NULL,",")) {
> 
> This _does not_ change the value of 'options'.
> 
> > +       while ((this_char = strsep(&options,",")) != NULL) {
> 
> This _does_ change the value of 'options'. Problem is, it's
> used later. Same is true for your patch to fs/vfat/namei.c.

Ok, sorry seems i overlooked that. Patches, for both files, below 
should fix it.

Cheers,
--
	Alex (alex@packetstorm.nu)


diff -uN linux-2.5.3-dj4/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux-2.5.3-dj4/fs/vfat/namei.c     Mon Jan 28 22:20:44 2002
+++ linux/fs/vfat/namei.c       Sun Feb 10 15:28:26 2002
@@ -97,6 +97,7 @@
 static int parse_options(char *options,        struct fat_mount_options *opts)
 {
        char *this_char,*value,save,*savep;
+       char *optptr = options;
        int ret, val;

        opts->unicode_xlate = opts->posixfs = 0;
@@ -114,7 +115,9 @@
        save = 0;
        savep = NULL;
        ret = 1;
-       for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+       while ((this_char = strsep(&optptr,",")) != NULL) {
+               if (!*this_char)
+                       continue;
                if ((value = strchr(this_char,'=')) != NULL) {
                        save = *value;
                        savep = value;
diff -uN linux-2.5.3-dj4/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.5.3-dj4/fs/fat/inode.c      Sat Feb  9 21:57:39 2002
+++ linux/fs/fat/inode.c        Sun Feb 10 15:51:42 2002
@@ -203,7 +203,7 @@
                         char *cvf_format, char *cvf_options)
 {
        char *this_char,*value,save,*savep;
-       char *p;
+       char *p, *optptr = options;
        int ret = 1, len;

        opts->name_check = 'n';
@@ -223,8 +223,9 @@
                goto out;
        save = 0;
        savep = NULL;
-       for (this_char = strtok(options,","); this_char;
-            this_char = strtok(NULL,",")) {
+       while ((this_char = strsep(&optptr,",")) != NULL) {
+               if (!*this_char)
+                       continue;
                if ((value = strchr(this_char,'=')) != NULL) {
                        save = *value;
                        savep = value;



