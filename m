Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWG0S7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWG0S7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWG0S7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:59:49 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:63402 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751954AbWG0S7s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:59:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cciss: removes uneeded 'pos' and 'size' variables
Date: Thu, 27 Jul 2006 13:59:44 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE553C75C8@cceexc23.americas.cpqcorp.net>
In-Reply-To: <44C7A78B.8000208@nevola.be>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss: removes uneeded 'pos' and 'size' variables
Thread-Index: Acaw2cQL+i4BEzlgTTWoF9n9BxnrVQA1It0w
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Laura Garcia" <laura@nevola.be>, "ISS StorageDev" <iss_storagedev@hp.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 18:59:45.0191 (UTC) FILETIME=[D32B8B70:01C6B1AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Laura Garcia [mailto:laura@nevola.be] 
> Sent: Wednesday, July 26, 2006 12:34 PM
> To: ISS StorageDev; Andrew Morton
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] cciss: removes uneeded 'pos' and 'size' variables
> 
> 
> Signed-off-by: Laura Garcia Liebana <laura@nevola.be>

Acked-by: Mike Miller <mike.miller@hp.com>

> 
> diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
> --- a/drivers/block/cciss.c	2006-07-26 10:25:16.000000000 +0200
> +++ b/drivers/block/cciss.c	2006-07-26 11:27:34.000000000 +0200
> @@ -238,9 +238,8 @@
>   static int cciss_proc_get_info(char *buffer, char **start, 
> off_t offset,
>   			       int length, int *eof, void *data)
>   {
> -	off_t pos = 0;
>   	off_t len = 0;
> -	int size, i, ctlr;
> +	int i, ctlr;
>   	ctlr_info_t *h = (ctlr_info_t *) data;
>   	drive_info_struct *drv;
>   	unsigned long flags;
> @@ -259,7 +258,7 @@
>   	h->busy_configuring = 1;
>   	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
> 
> -	size = sprintf(buffer, "%s: HP %s Controller\n"
> +	len += sprintf(buffer, "%s: HP %s Controller\n"
>   		       "Board ID: 0x%08lx\n"
>   		       "Firmware Version: %c%c%c%c\n"
>   		       "IRQ: %d\n"
> @@ -277,9 +276,7 @@
>   		       h->num_luns, h->Qdepth, h->commands_outstanding,
>   		       h->maxQsinceinit, h->max_outstanding, h->maxSG);
> 
> -	pos += size;
> -	len += size;
> -	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
> +	cciss_proc_tape_report(ctlr, buffer, &len);
>   	for (i = 0; i <= h->highest_lun; i++) {
> 
>   		drv = &h->drv[i];
> @@ -293,12 +290,10 @@
> 
>   		if (drv->raid_level > 5)
>   			drv->raid_level = RAID_UNKNOWN;
> -		size = sprintf(buffer + len, "cciss/c%dd%d:"
> +		len += sprintf(buffer + len, "cciss/c%dd%d:"
>   			       "\t%4u.%02uGB\tRAID %s\n",
>   			       ctlr, i, (int)vol_sz, (int)vol_sz_frac,
>   			       raid_label[drv->raid_level]);
> -		pos += size;
> -		len += size;
>   	}
> 
>   	*eof = 1;
> diff -Nru a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
> --- a/drivers/block/cciss_scsi.c	2006-07-15 
> 23:53:08.000000000 +0200
> +++ b/drivers/block/cciss_scsi.c	2006-07-26 
> 11:27:43.000000000 +0200
> @@ -1440,19 +1440,17 @@
>   }
> 
>   static void
> -cciss_proc_tape_report(int ctlr, unsigned char *buffer, 
> off_t *pos, off_t *len)
> +cciss_proc_tape_report(int ctlr, unsigned char *buffer, off_t *len)
>   {
>   	unsigned long flags;
> -	int size;
> 
> -	*pos = *pos -1; *len = *len - 1; // cut off the last 
> trailing newline
> +	*len = *len - 1; // cut off the last trailing newline
> 
>   	CPQ_TAPE_LOCK(ctlr, flags);
> -	size = sprintf(buffer + *len,
> +	*len += sprintf(buffer + *len,
>   		"Sequential access devices: %d\n\n",
>   			ccissscsi[ctlr].ndevices);
>   	CPQ_TAPE_UNLOCK(ctlr, flags);
> -	*pos += size; *len += size;
>   }
> 
>   /* Need at least one of these error handlers to keep 
> ../scsi/hosts.c from @@ -1534,6 +1532,6 @@
>   #define cciss_scsi_setup(cntl_num)
>   #define cciss_unregister_scsi(ctlr)
>   #define cciss_register_scsi(ctlr)
> -#define cciss_proc_tape_report(ctlr, buffer, pos, len)
> +#define cciss_proc_tape_report(ctlr, buffer, len)
> 
>   #endif /* CONFIG_CISS_SCSI_TAPE */
> 
> 
> 
