Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTKRGzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 01:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTKRGzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 01:55:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:22467 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262356AbTKRGzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 01:55:20 -0500
Date: Mon, 17 Nov 2003 23:00:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: patelamitv@yahoo.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: scsi_report_lun_scan bug?
Message-Id: <20031117230033.59f1ef5c.akpm@osdl.org>
In-Reply-To: <20031117215252.A25366@beaverton.ibm.com>
References: <20031118024833.7619.qmail@web13006.mail.yahoo.com>
	<20031117215252.A25366@beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patmans@us.ibm.com> wrote:
>
> On Mon, Nov 17, 2003 at 06:48:33PM -0800, Amit Patel wrote:
> > Hi,
> > 
> > I am using 2.6-test9-mm3. I noticed while doing
> > scsi_report_lun_scan(scsi_scan.c:891) the data
> > returned is assigned(scsi_scan.c:993) to signed char
> > array which causes the reported number of luns to be
> > huge while calculating num_luns to scan. Is there any
> > particular reason to be data is signed or just a bug?
> > 
> > I changed it to unsigned char and it seems to work
> > fine. I have attached a diff of scsi_scan.c. Let me
> > know if I am missing something.
> 
> I don't see why making it signed or unsigned would make any difference.


 	length = ((data[0] << 24) | (data[1] << 16) |
 		  (data[2] << 8) | (data[3] << 0));

If data[3] is 0xff, this expression will always evaluate to
0xffffffff.  etcetera.

> It should really be a u8, since it is a pointer to an array of bytes.
> 
> (And all the scsi_cmd[]'s should be u8.)

Yup.

diff -puN drivers/scsi/scsi_scan.c~scsi_report_lun-fix drivers/scsi/scsi_scan.c
--- 25/drivers/scsi/scsi_scan.c~scsi_report_lun-fix	2003-11-17 20:22:49.000000000 -0800
+++ 25-akpm/drivers/scsi/scsi_scan.c	2003-11-17 20:22:49.000000000 -0800
@@ -899,7 +899,7 @@ static int scsi_report_lun_scan(struct s
 	unsigned int retries;
 	struct scsi_lun *lunp, *lun_data;
 	struct scsi_request *sreq;
-	char *data;
+	u8 *data;
 
 	/*
 	 * Only support SCSI-3 and up devices.
@@ -990,7 +990,7 @@ static int scsi_report_lun_scan(struct s
 	/*
 	 * Get the length from the first four bytes of lun_data.
 	 */
-	data = (char *) lun_data->scsi_lun;
+	data = (u8 *) lun_data->scsi_lun;
 	length = ((data[0] << 24) | (data[1] << 16) |
 		  (data[2] << 8) | (data[3] << 0));
 

_

