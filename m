Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTD0MI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 08:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263958AbTD0MI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 08:08:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46787 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263954AbTD0MI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 08:08:57 -0400
Date: Sun, 27 Apr 2003 14:21:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Erik Andersen <andersen@codepoet.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
Message-ID: <20030427122104.GK10256@fs.tum.de>
References: <20030424093443.GA7180@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424093443.GA7180@codepoet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 03:34:43AM -0600, Erik Andersen wrote:
> The ide driver does not list whether drives support things like
> write cache, SMART, SECURITY ERASE UNIT.  But for some silly
> reason it tells us at boot whether each drive is capable of
> supporting the Host Protected Area feature set.  If people want
> to know the capabilites of their drive, they can run 'hdparm' 
> and find out.
> 
> This patch removes this pointless noise.  Please apply,
> 
> 
> --- linux/drivers/ide/ide-disk.c.orig	2003-04-24 03:23:53.000000000 -0600
> +++ linux/drivers/ide/ide-disk.c	2003-04-24 03:24:54.000000000 -0600
> @@ -1133,10 +1133,7 @@
>   */
>  static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
>  {
> -	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
> -	if (flag)
> -		printk("%s: host protected area => %d\n", drive->name, flag);
> -	return flag;
> +	return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
>  }
>  
>  /*


Looking at the only user of this function it seems we can completely 
remove it (patch below).

Alan:
Is the patch below OK or are there any future plans for more uses of
idedisk_supports_host_protected_area?

>  -Erik

cu
Adrian


--- linux-2.4.21-rc1-full/drivers/ide/ide-disk.c.old	2003-04-27 13:26:17.000000000 +0200
+++ linux-2.4.21-rc1-full/drivers/ide/ide-disk.c	2003-04-27 13:30:48.000000000 +0200
@@ -1128,18 +1128,6 @@
 #endif /* CONFIG_IDEDISK_STROKE */
 
 /*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
- */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
-{
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
-}
-
-/*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
  *
@@ -1165,8 +1153,6 @@
 	drive->capacity48 = 0;
 	drive->select.b.lba = 0;
 
-	(void) idedisk_supports_host_protected_area(drive);
-
 	if (id->cfs_enable_2 & 0x0400) {
 		capacity_2 = id->lba_capacity_2;
 		drive->head		= drive->bios_head = 255;
