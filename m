Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbUKQW7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbUKQW7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKQW7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:59:02 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:7371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262620AbUKQWyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:54:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gosUIWTOw5vIKGT7h7uCUPNSwIZa/hjcDsVWUPCGex282EB2xqCC2io2c8t/3ZKJM3+BNwEDiPD+vs1uFbl7Uve9OsaU4eo7HwBR5u2zyXRqei4Yp9UnbJOqMwHuWeuyUD7d7aJ8AmQw7JK7SPKTlFEs4y7R0Bek57HOvNRNyWk=
Message-ID: <58cb370e04111714541a0aebc@mail.gmail.com>
Date: Wed, 17 Nov 2004 23:54:20 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Nasty log spamming problem in ide proc changes
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20041111161021.GB9129@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411012006.iA1K6HR7010518@hera.kernel.org>
	 <1100184927.22254.22.camel@localhost.localdomain>
	 <20041111161021.GB9129@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2004 17:10:21 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Nov 11 2004, Alan Cox wrote:
> > > +   printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
> > > +                       "obsolete, and will be removed soon!\n");
> > > +
> >
> > The above should be rate limited or on the write case moved to after
> > the capable() check. A program polling these settings now makes a nasty
> > noise and wipes the logs. A user can also do it intentionally.
> 
> Or just print it once...

I'm about to add this to ide-2.6...

[ide] fix /proc/ide/hd?/settings to not spam logs

On Thu, 11 Nov 2004 17:10:21 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Nov 11 2004, Alan Cox wrote:
> > > +   printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
> > > +                       "obsolete, and will be removed soon!\n");
> > > +
> >
> > The above should be rate limited or on the write case moved to after
> > the capable() check. A program polling these settings now makes a nasty
> > noise and wipes the logs. A user can also do it intentionally.
> 
> Or just print it once...

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2004-11-17 23:56:13 +01:00
+++ b/drivers/ide/ide-proc.c	2004-11-17 23:56:13 +01:00
@@ -124,6 +124,18 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+static void proc_ide_settings_warn(void)
+{
+	static int warned = 0;
+
+	if (warned)
+		return;
+
+	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
+			    "obsolete, and will be removed soon!\n");
+	warned = 1;
+}
+
 static int proc_ide_read_settings
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -132,8 +144,7 @@
 	char		*out = page;
 	int		len, rc, mul_factor, div_factor;
 
-	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
-			    "obsolete, and will be removed soon!\n");
+	proc_ide_settings_warn();
 
 	down(&ide_setting_sem);
 	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
@@ -171,11 +182,10 @@
 	ide_settings_t	*setting;
 	char *buf, *s;
 
-	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
-			    "obsolete, and will be removed soon!\n");
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+
+	proc_ide_settings_warn();
 
 	if (count >= PAGE_SIZE)
 		return -EINVAL;
