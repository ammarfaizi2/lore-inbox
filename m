Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWAJNF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWAJNF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWAJNF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:05:57 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:21805 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750990AbWAJNF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:05:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=XyOez1TgPY7NiTI9huGg2wxVF5Iqw9KsM/2n7hxNXesScCoDdZpUeXgTW/YHzfkXhw0BkC7BSKhCRsXn4wIEnx3qJTtkJ91KmJaP6A89nrJSRq6QZhiE3yqP4Ys3rHBpVlcBB4427jt/+SQ2F03wlSdDDEpbUAyyXAuvUaixuZo=
Message-ID: <81083a450601100505m73f4580cvb6a4a0c6ceb9791d@mail.gmail.com>
Date: Tue, 10 Jan 2006 18:35:55 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi/arm/ecoscsi.c Handle scsi_add_host failure
In-Reply-To: <81083a450601100441s7675d584jd10db5a8e6ccaf58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_332_8608814.1136898355757"
References: <81083a450601100441s7675d584jd10db5a8e6ccaf58@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_332_8608814.1136898355757
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oops, Missed declaring the variable "retval". This one works for sure.
Please apply this patch and drop the previous one. Sorry about that.
-Ashutosh

Add scsi_add_host() failure handling for the ecoscsi driver.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_332_8608814.1136898355757
Content-Type: text/plain; name=ecoscsi.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ecoscsi.txt"

diff -Naurp linux-2.6.15-git5-vanilla/drivers/scsi/arm/ecoscsi.c linux-2.6.15-git5/drivers/scsi/arm/ecoscsi.c
--- linux-2.6.15-git5-vanilla/drivers/scsi/arm/ecoscsi.c	2006-01-03 08:51:10.000000000 +0530
+++ linux-2.6.15-git5/drivers/scsi/arm/ecoscsi.c	2006-01-10 18:23:12.000000000 +0530
@@ -174,7 +174,7 @@ static struct Scsi_Host *host;
 
 static int __init ecoscsi_init(void)
 {
-
+	int retval;
 	host = scsi_host_alloc(tpnt, sizeof(struct NCR5380_hostdata));
 	if (!host)
 		return 0;
@@ -203,7 +203,13 @@ static int __init ecoscsi_init(void)
 	NCR5380_print_options(host);
 	printk("\n");
 
-	scsi_add_host(host, NULL); /* XXX handle failure */
+	retval = scsi_add_host(host, NULL);
+	if (retval) {
+		printk(KERN_WARNING "ecoscsi: scsi_add_host failed\n");
+		scsi_host_put(host);
+		return retval;
+	}
+
 	scsi_scan_host(host);
 	return 0;
 

------=_Part_332_8608814.1136898355757--
