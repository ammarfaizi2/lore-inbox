Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUHPP2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUHPP2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUHPPZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:25:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:62690 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267695AbUHPPYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:24:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Mon, 16 Aug 2004 17:24:09 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815150414.GA12181@devserv.devel.redhat.com>
In-Reply-To: <20040815150414.GA12181@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161724.09880.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes write access to /proc/ide/hd?/driver without even
mentioning this - IMHO we should deprecate it first.  Such changes should
be described (with rationale for them) at least in the changelog
(or even better in Documentation/ide.txt).

On Sunday 15 August 2004 17:04, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc3/drivers/ide/ide-proc.c
> linux-2.6.8-rc3/drivers/ide/ide-proc.c ---
> linux.vanilla-2.6.8-rc3/drivers/ide/ide-proc.c	2004-08-09
> 15:51:00.000000000 +0100 +++
> linux-2.6.8-rc3/drivers/ide/ide-proc.c	2004-08-12 17:26:00.000000000 +0100
> @@ -355,7 +355,7 @@
>  static int proc_ide_read_identify
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *)data;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
>  	int		len = 0, i = 0;
>  	int		err = 0;
>
> @@ -397,11 +397,15 @@
>  static int proc_ide_read_settings
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> -	ide_settings_t	*setting = (ide_settings_t *) drive->settings;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
> +	ide_settings_t	*setting;
>  	char		*out = page;
>  	int		len, rc, mul_factor, div_factor;
> +
> +	if(drive == NULL)
> +		return -EIO;
>
> +	setting = (ide_settings_t *) drive->settings;
>  	down(&ide_setting_sem);
>  	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
>  	out += sprintf(out, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
> @@ -431,7 +435,7 @@
>  static int proc_ide_write_settings(struct file *file, const char __user
> *buffer, unsigned long count, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
>  	char		name[MAX_LEN + 1];
>  	int		for_real = 0;
>  	unsigned long	n;
> @@ -440,6 +444,9 @@
>
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> +
> +	if (drive == NULL)
> +		return -EIO;
>
>  	if (count >= PAGE_SIZE)
>  		return -EINVAL;
> @@ -523,9 +530,12 @@
>  int proc_ide_read_capacity
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
>  	int		len;
>
> +	if(drive == NULL)
> +		return -EIO;
> +
>  	len = sprintf(page,"%llu\n",
>  		      (long long) (DRIVER(drive)->capacity(drive)));
>  	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
> @@ -534,9 +544,12 @@
>  int proc_ide_read_geometry
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
>  	char		*out = page;
>  	int		len;
> +
> +	if(drive == NULL)
> +		return -EIO;
>
>  	out += sprintf(out,"physical     %d/%d/%d\n",
>  			drive->cyl, drive->head, drive->sect);
> @@ -552,10 +565,14 @@
>  static int proc_ide_read_dmodel
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> -	struct hd_driveid *id = drive->id;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
> +	struct hd_driveid *id;
>  	int		len;
>
> +	if(drive == NULL)
> +		return -EIO;
> +
> +	id = drive->id;
>  	len = sprintf(page, "%.40s\n",
>  		(id && id->model[0]) ? (char *)id->model : "(none)");
>  	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
> @@ -564,40 +581,30 @@
>  static int proc_ide_read_driver
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> -	ide_driver_t	*driver = drive->driver;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
> +	ide_driver_t	*driver;
>  	int		len;
>
> +	if(drive == NULL)
> +		return -EIO;
> +
> +	driver = drive->driver;
> +
>  	len = sprintf(page, "%s version %s\n",
>  			driver->name, driver->version);
>  	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
>  }
>
> -static int proc_ide_write_driver
> -	(struct file *file, const char __user *buffer, unsigned long count, void
> *data) -{
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> -	char name[32];
> -
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -	if (count > 31)
> -		count = 31;
> -	if (copy_from_user(name, buffer, count))
> -		return -EFAULT;
> -	name[count] = '\0';
> -	if (ide_replace_subdriver(drive, name))
> -		return -EINVAL;
> -	return count;
> -}
> -
>  static int proc_ide_read_media
>  	(char *page, char **start, off_t off, int count, int *eof, void *data)
>  {
> -	ide_drive_t	*drive = (ide_drive_t *) data;
> +	ide_drive_t	*drive = ide_drive_from_key(data);
>  	const char	*media;
>  	int		len;
>
> +	if(drive == NULL)
> +		return -EINVAL;
> +
>  	switch (drive->media) {
>  		case ide_disk:	media = "disk\n";
>  				break;
> @@ -616,7 +623,7 @@
>  }
>
>  static ide_proc_entry_t generic_drive_entries[] = {
> -	{ "driver",	S_IFREG|S_IRUGO,	proc_ide_read_driver,	proc_ide_write_driver
> }, +	{ "driver",	S_IFREG|S_IRUGO,	proc_ide_read_driver,	NULL },
>  	{ "identify",	S_IFREG|S_IRUSR,	proc_ide_read_identify,	NULL },
>  	{ "media",	S_IFREG|S_IRUGO,	proc_ide_read_media,	NULL },
>  	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_dmodel,	NULL },
> @@ -668,7 +675,7 @@
>
>  		drive->proc = proc_mkdir(drive->name, parent);
>  		if (drive->proc)
> -			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
> +			ide_add_proc_entries(drive->proc, generic_drive_entries,
> ide_drive_to_key(drive)); sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2,
> drive->name);
>  		ent = proc_symlink(drive->name, proc_ide_root, name);
>  		if (!ent) return;
