Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSLTR4E>; Fri, 20 Dec 2002 12:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSLTR4E>; Fri, 20 Dec 2002 12:56:04 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:52352 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263228AbSLTR4D>;
	Fri, 20 Dec 2002 12:56:03 -0500
Date: Fri, 20 Dec 2002 19:04:01 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212201804.TAA12661@harpo.it.uu.se>
To: marcelo@conectiva.com.br
Subject: Re: 2.4.21-pre1 broke the ide-tape driver
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002 18:08:15 -0200 (BRST), Marcelo Tosatti wrote:
>> - ide-disk/ide-floppy do the test&call inside the loop rather than after,
>>   so possibly the call should be moved into the loop, and augmented
>>   to be "if (drive && drive->proc) ide_remove_proc_entries(...)".
>
>Yes... here is a patch which moves the ide_remove_proc_entries inside the
>detection loop. Without ide_remove_proc_entries inside the loop we would
>also not unregister more than one device /proc entries, too.
>
>Please test it, works for me.

Tested. Works for me too.

/Mikael

>
>--- linux-bk/drivers/ide/ide-tape.c	2002-12-19 18:05:07.000000000 -0200
>+++ linux-2.4.21/drivers/ide/ide-tape.c	2002-12-19 17:59:39.000000000 -0200
>@@ -6597,14 +6597,16 @@
>
> 	for (minor = 0; minor < MAX_HWIFS * MAX_DRIVES; minor++) {
> 		drive = idetape_chrdevs[minor].drive;
>-		if (drive != NULL && idetape_cleanup(drive))
>-			printk(KERN_ERR "ide-tape: %s: cleanup_module() "
>-				"called while still busy\n", drive->name);
>-	}
>+		if (drive) {
>+			if (idetape_cleanup(drive))
>+				printk(KERN_ERR "ide-tape: %s: cleanup_module() "
>+					"called while still busy\n", drive->name);
> #ifdef CONFIG_PROC_FS
>-	if (drive->proc)
>-		ide_remove_proc_entries(drive->proc, idetape_proc);
>+			if (drive->proc)
>+				ide_remove_proc_entries(drive->proc, idetape_proc);
> #endif
>+		}
>+	}
>
> 	ide_unregister_module(&idetape_module);
> }
>
