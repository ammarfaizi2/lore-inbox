Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVJDWRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVJDWRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVJDWRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:17:13 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:63138 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965013AbVJDWRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:17:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gfvZMv46rBTjFswH4sXOE3KGSMcjHG0JHfjusK4EIj1vu/vbWIbkbHs5+6kWUhKgd5Hhfcw69ry7F12l6SuNLEbMFdMOb5SkEGNdN3PgH+baWM3X93w0bGLNSJk++VJihjvfz5GWNxOLl7VymypvRbwHzSzxc2R55FCc3XRALPQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: [PATCH] ide-cd mini cleanup of casts (mainly)
Date: Wed, 5 Oct 2005 00:19:43 +0200
User-Agent: KMail/1.8.2
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, andersen@codepoet.org
References: <200510040017.57168.jesper.juhl@gmail.com> <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com> <20051004062146.GD3511@suse.de>
In-Reply-To: <20051004062146.GD3511@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510050019.44256.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 08:21, Jens Axboe wrote:
[snip]
> This is a mess. So NACK on this patch. And why are you changing the
[snip]

Hi Jens,

Sorry about the messy previous patch.  Would you consider something like the
one below instead?  It only makes a few changes, not lots of different ones in
the same patch and it also only makes changes that I hope you'll agree are 
useful. :)


Remove some unneeded casts.
Avoid an assignment in the case of kmalloc failure.
Break a few instances of  if (foo) whatever;  into two lines.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/ide/ide-cd.c |   54 +++++++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

--- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c	2005-10-05 00:04:01.000000000 +0200
@@ -2211,13 +2211,12 @@ static int cdrom_read_toc(ide_drive_t *d
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
-		toc = (struct atapi_toc *) kmalloc (sizeof (struct atapi_toc),
-						    GFP_KERNEL);
-		info->toc = toc;
+		toc = kmalloc(sizeof(struct atapi_toc), GFP_KERNEL);
 		if (toc == NULL) {
 			printk (KERN_ERR "%s: No cdrom TOC buffer!\n", drive->name);
 			return -ENOMEM;
 		}
+		info->toc = toc;
 	}
 
 	/* Check to see if the existing data is still valid.
@@ -2240,7 +2239,8 @@ static int cdrom_read_toc(ide_drive_t *d
 	/* First read just the header, so we know how long the TOC is. */
 	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
 				    sizeof(struct atapi_toc_header), sense);
-	if (stat) return stat;
+	if (stat)
+		return stat;
 
 #if ! STANDARD_ATAPI
 	if (CDROM_CONFIG_FLAGS(drive)->toctracks_as_bcd) {
@@ -2324,7 +2324,8 @@ static int cdrom_read_toc(ide_drive_t *d
 		/* Read the multisession information. */
 		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp), sense);
-		if (stat) return stat;
+		if (stat)
+			return stat;
 
 		toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);
 	} else {
@@ -2460,7 +2461,7 @@ static int ide_cdrom_packet(struct cdrom
 			    struct packet_command *cgc)
 {
 	struct request req;
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 
 	if (cgc->timeout <= 0)
 		cgc->timeout = ATAPI_WAIT_PC;
@@ -2537,7 +2538,7 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 			   unsigned int cmd, void *arg)
 			   
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *info = drive->driver_data;
 	int stat;
 
@@ -2548,7 +2549,7 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 	 */
 	case CDROMPLAYTRKIND: {
 		unsigned long lba_start, lba_end;
-		struct cdrom_ti *ti = (struct cdrom_ti *)arg;
+		struct cdrom_ti *ti = arg;
 		struct atapi_toc_entry *first_toc, *last_toc;
 
 		stat = cdrom_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
@@ -2571,12 +2572,13 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 	}
 
 	case CDROMREADTOCHDR: {
-		struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
+		struct cdrom_tochdr *tochdr = arg;
 		struct atapi_toc *toc;
 
 		/* Make sure our saved TOC is valid. */
 		stat = cdrom_read_toc(drive, NULL);
-		if (stat) return stat;
+		if (stat)
+			return stat;
 
 		toc = info->toc;
 		tochdr->cdth_trk0 = toc->hdr.first_track;
@@ -2586,11 +2588,12 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 	}
 
 	case CDROMREADTOCENTRY: {
-		struct cdrom_tocentry *tocentry = (struct cdrom_tocentry*) arg;
+		struct cdrom_tocentry *tocentry = arg;
 		struct atapi_toc_entry *toce;
 
 		stat = cdrom_get_toc_entry(drive, tocentry->cdte_track, &toce);
-		if (stat) return stat;
+		if (stat)
+			return stat;
 
 		tocentry->cdte_ctrl = toce->control;
 		tocentry->cdte_adr  = toce->adr;
@@ -2613,7 +2616,7 @@ int ide_cdrom_audio_ioctl (struct cdrom_
 static
 int ide_cdrom_reset (struct cdrom_device_info *cdi)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
 	struct request req;
 	int ret;
@@ -2636,12 +2639,13 @@ int ide_cdrom_reset (struct cdrom_device
 static
 int ide_cdrom_tray_move (struct cdrom_device_info *cdi, int position)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
 
 	if (position) {
 		int stat = cdrom_lockdoor(drive, 0, &sense);
-		if (stat) return stat;
+		if (stat)
+			return stat;
 	}
 
 	return cdrom_eject(drive, !position, &sense);
@@ -2650,7 +2654,7 @@ int ide_cdrom_tray_move (struct cdrom_de
 static
 int ide_cdrom_lock_door (struct cdrom_device_info *cdi, int lock)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	return cdrom_lockdoor(drive, lock, NULL);
 }
 
@@ -2700,7 +2704,7 @@ void ide_cdrom_update_speed (ide_drive_t
 static
 int ide_cdrom_select_speed (struct cdrom_device_info *cdi, int speed)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct request_sense sense;
 	struct atapi_capabilities_page cap;
 	int stat;
@@ -2723,7 +2727,7 @@ int ide_cdrom_select_speed (struct cdrom
 static
 int ide_cdrom_drive_status (struct cdrom_device_info *cdi, int slot_nr)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct media_event_desc med;
 	struct request_sense sense;
 	int stat;
@@ -2769,7 +2773,7 @@ int ide_cdrom_get_last_session (struct c
 				struct cdrom_multisession *ms_info)
 {
 	struct atapi_toc *toc;
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *info = drive->driver_data;
 	struct request_sense sense;
 	int ret;
@@ -2791,7 +2795,7 @@ int ide_cdrom_get_mcn (struct cdrom_devi
 {
 	int stat;
 	char mcnbuf[24];
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 
 /* get MCN */
 	if ((stat = cdrom_read_subchannel(drive, 2, mcnbuf, sizeof (mcnbuf), NULL)))
@@ -2815,7 +2819,7 @@ static
 int ide_cdrom_check_media_change_real (struct cdrom_device_info *cdi,
 				       int slot_nr)
 {
-	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
+	ide_drive_t *drive = cdi->handle;
 	int retval;
 	
 	if (slot_nr == CDSL_CURRENT) {
@@ -2886,7 +2890,7 @@ static int ide_cdrom_register (ide_drive
 	devinfo->mask = 0;
 	devinfo->speed = CDROM_STATE_FLAGS(drive)->current_speed;
 	devinfo->capacity = nslots;
-	devinfo->handle = (void *) drive;
+	devinfo->handle = drive;
 	strcpy(devinfo->name, drive->name);
 	
 	/* set capability mask to match the probe. */
@@ -2942,7 +2946,7 @@ int ide_cdrom_probe_capabilities (ide_dr
 	 * registered with the Uniform layer yet, it can't do this.
 	 * Same goes for cdi->ops.
 	 */
-	cdi->handle = (ide_drive_t *) drive;
+	cdi->handle = drive;
 	cdi->ops = &ide_cdrom_dops;
 
 	if (ide_cdrom_get_capabilities(drive, &cap))
@@ -3309,7 +3313,7 @@ static int ide_cd_probe(struct device *)
 static int proc_idecd_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t*drive = (ide_drive_t *)data;
+	ide_drive_t *drive = data;
 	int len;
 
 	len = sprintf(page,"%llu\n", (long long)ide_cdrom_capacity(drive));
@@ -3449,7 +3453,7 @@ static int ide_cd_probe(struct device *d
 		printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
 		goto failed;
 	}
-	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
+	info = kmalloc(sizeof(struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
 		goto failed;


