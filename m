Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbTL3JqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbTL3JqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:46:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62390 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265714AbTL3JqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:46:18 -0500
Date: Tue, 30 Dec 2003 10:45:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Diego Calleja <grundig@teleline.es>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       ramon.rey@hispalinux.es, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
Message-ID: <20031230094547.GB7833@suse.de>
References: <20031229013223.75c531ed.akpm@osdl.org> <1072727943.1064.15.camel@debian> <1072731446.5170.4.camel@teapot.felipe-alfaro.com> <20031229233839.7f3b5666.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031229233839.7f3b5666.grundig@teleline.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29 2003, Diego Calleja wrote:
> El Mon, 29 Dec 2003 21:57:26 +0100 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> escribió:
> 
> > The same happens here. cdrecord is broken under -mm, but works fine with
> > plain 2.6.0.
> 
> 
> 
> I'm seeing the same here:
> 
> open("/dev/cd-rw", O_RDWR|O_NONBLOCK)   = -1 EROFS (Read-only file system)
> write(2, "cdrecord.mmap: Read-only file sy"..., 89cdrecord.mmap: Read-only file system. Cannot open '/dev/cd-rw'. Cannot open SCSI driver.) = 89

--- drivers/cdrom/cdrom.c~	2003-12-29 15:58:55.698005022 +0100
+++ drivers/cdrom/cdrom.c	2003-12-29 16:01:32.555918156 +0100
@@ -740,20 +740,21 @@
 
 	cdinfo(CD_OPEN, "entering cdrom_open\n"); 
 	cdi->use_count++;
-	ret = -EROFS;
-	if (fp->f_mode & FMODE_WRITE) {
-		if (!CDROM_CAN(CDC_RAM))
-			goto out;
-		if (cdrom_open_write(cdi))
-			goto out;
-	}
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
 	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS))
 		ret = cdi->ops->open(cdi, 1);
-	else
+	else {
+		if (fp->f_mode & FMODE_WRITE) {
+			ret = -EROFS;
+			if (!CDROM_CAN(CDC_RAM))
+				goto out;
+			if (cdrom_open_write(cdi))
+				goto out;
+		}
 		ret = open_for_data(cdi);
+	}
 
 	cdinfo(CD_OPEN, "Use count for \"/dev/%s\" now %d\n", cdi->name, cdi->use_count);
 	/* Do this on open.  Don't wait for mount, because they might

Fix is with andrew for -mm3

-- 
Jens Axboe

