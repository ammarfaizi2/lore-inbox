Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbSLSW6I>; Thu, 19 Dec 2002 17:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbSLSW6I>; Thu, 19 Dec 2002 17:58:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:17357 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267716AbSLSW6F>; Thu, 19 Dec 2002 17:58:05 -0500
Date: Thu, 19 Dec 2002 18:08:15 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
In-Reply-To: <200212162327.AAA06228@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.50L.0212191806090.1711-100000@freak.distro.conectiva>
References: <200212162327.AAA06228@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Mikael Pettersson wrote:

> I wrote:
> >On Sun, 15 Dec 2002 02:23:34 +0100, Marc-Christian Petersen wrote:
> >>> Kernel 2.4.21-pre1 broke the ide-tape driver: the driver
> >>> now hangs during initialisation. 2.2 kernels (with Andre's
> >>> IDE patch) and 2.4 up to 2.4.20 do not have this problem.
> >>> My box has a Seagate STT8000A ATAPI tape drive as hdd;
> >>> hdc is a Philips CD-RW, and the controller is ICH2 (i850 chipset).
> >>http://linux.bkbits.net:8080/linux-2.4/patch@1.828?nav=index.html|ChangeSet@-7d|cset@1.828
> >
> >Addendum: this patch fixes the init-time hang, and ide-tape does
> >seem to work fine, but 'rmmod ide-tape' oopses -- 2.4.20-ac2 also
> >oopses on 'rmmod ide-tape'.
>
> Solved, I think. Observe ide-tape's module_exit() procedure idetape_exit():
>
> >static void __exit idetape_exit (void)
> >{
> >	ide_drive_t *drive;
> >	int minor;
> >
> >	for (minor = 0; minor < MAX_HWIFS * MAX_DRIVES; minor++) {
> >		drive = idetape_chrdevs[minor].drive;
> >		if (drive != NULL && idetape_cleanup(drive))
> >			printk(KERN_ERR "ide-tape: %s: cleanup_module() "
> >				"called while still busy\n", drive->name);
> >	}
> >#ifdef CONFIG_PROC_FS
> >	if (drive->proc)
> >		ide_remove_proc_entries(drive->proc, idetape_proc);
> >#endif
> >
> >	ide_unregister_module(&idetape_module);
> >}
>
> In the "if (drive->proc)" line, drive==NULL when I rmmod ide-tape,
> causing the oops.
>
> I'm not sure if ide_remove_proc_entries() is needed or not,
> but the current code is obviously broken.
>
> - ide_unregister_module() removes ide-tape's proc entry
>   (/proc/ide/ideX/hdY/name) for us, at least that's what happens
>   on my box after I commented out the entire "if (drive->proc) ..."
>   statement to prevent the oops. So possibly the call should be deleted.
>
> - ide-disk/ide-floppy do the test&call inside the loop rather than after,
>   so possibly the call should be moved into the loop, and augmented
>   to be "if (drive && drive->proc) ide_remove_proc_entries(...)".

Yes... here is a patch which moves the ide_remove_proc_entries inside the
detection loop. Without ide_remove_proc_entries inside the loop we would
also not unregister more than one device /proc entries, too.

Please test it, works for me.

--- linux-bk/drivers/ide/ide-tape.c	2002-12-19 18:05:07.000000000 -0200
+++ linux-2.4.21/drivers/ide/ide-tape.c	2002-12-19 17:59:39.000000000 -0200
@@ -6597,14 +6597,16 @@

 	for (minor = 0; minor < MAX_HWIFS * MAX_DRIVES; minor++) {
 		drive = idetape_chrdevs[minor].drive;
-		if (drive != NULL && idetape_cleanup(drive))
-			printk(KERN_ERR "ide-tape: %s: cleanup_module() "
-				"called while still busy\n", drive->name);
-	}
+		if (drive) {
+			if (idetape_cleanup(drive))
+				printk(KERN_ERR "ide-tape: %s: cleanup_module() "
+					"called while still busy\n", drive->name);
 #ifdef CONFIG_PROC_FS
-	if (drive->proc)
-		ide_remove_proc_entries(drive->proc, idetape_proc);
+			if (drive->proc)
+				ide_remove_proc_entries(drive->proc, idetape_proc);
 #endif
+		}
+	}

 	ide_unregister_module(&idetape_module);
 }
