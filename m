Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292327AbSB0K0H>; Wed, 27 Feb 2002 05:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292324AbSB0KZs>; Wed, 27 Feb 2002 05:25:48 -0500
Received: from codepoet.org ([166.70.14.212]:45519 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S292315AbSB0KZp>;
	Wed, 27 Feb 2002 05:25:45 -0500
Date: Wed, 27 Feb 2002 03:25:44 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Simon Turvey <turveysp@ntlworld.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: IDE error on 2.4.17
Message-ID: <20020227102544.GA3226@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Simon Turvey <turveysp@ntlworld.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fmJt-0001Xi-00@the-village.bc.nu> <006e01c1bef6$6dd78e40$030ba8c0@mistral> <20020227104735.A29316@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020227104735.A29316@ucw.cz>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 27, 2002 at 10:47:35AM +0100, Vojtech Pavlik wrote:
> That won't help, this indeed is a media error. The drive is heading to
> hell. You have about another six months of life before it goes belly up
> completely.
> 
> Any chance it's one of those fast IBM 30 or 45 gig drives? They seem to
> be dying pretty fast ...

I expect a patch like this would help avoid these sort of
questions...

diff -urN linux/drivers/ide.orig/hd.c linux/drivers/ide/hd.c
--- linux/drivers/ide.orig/hd.c	Mon Oct 15 14:27:42 2001
+++ linux/drivers/ide/hd.c	Wed Feb 27 03:16:16 2002
@@ -201,6 +201,12 @@
 				printk(", sector=%ld", CURRENT->sector);
 		}
 		printk("\n");
+		/* Make sure people realize that very bad things are
+		 * happening, so they can do something about it before
+		 * it is too late... */
+		if (hd_error & ECC_ERR) {
+		    printk("hd%c: You should make a backup, this drive may fail soon!\n", devc);
+		}
 	}
 #else
 	printk("hd%c: %s: status=0x%02x.\n", devc, msg, stat & 0xff);
@@ -209,6 +215,9 @@
 	} else {
 		hd_error = inb(HD_ERROR);
 		printk("hd%c: %s: error=0x%02x.\n", devc, msg, hd_error & 0xff);
+		if (hd_error & ECC_ERR) {
+		    printk("hd%c: You should make a backup, this drive may fail soon!\n", devc);
+		}
 	}
 #endif	/* verbose errors */
 	restore_flags (flags);
diff -urN linux/drivers/ide.orig/ide.c linux/drivers/ide/ide.c
--- linux/drivers/ide.orig/ide.c	Fri Feb 22 16:20:13 2002
+++ linux/drivers/ide/ide.c	Wed Feb 27 03:20:12 2002
@@ -832,6 +832,13 @@
 				if (HWGROUP(drive) && HWGROUP(drive)->rq)
 					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
 			}
+			if (hd_error & ECC_ERR) {
+			    printk("\nhd%c: You should make a backup, this drive may fail soon!", devc);
+			}
+		}
+#else
+		if (drive->media == ide_disk && hd_error & ECC_ERR) {
+		    printk("\nhd%c: You should make a backup, this drive may fail soon!", devc);
 		}
 #endif	/* FANCY_STATUS_DUMPS */
 		printk("\n");
 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
