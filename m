Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWGDFbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWGDFbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWGDFbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:31:19 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:62911 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751050AbWGDFbS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:31:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] pcmcia: update alloc_io_space for conflict checking for multifunction PC card for Linux kernel 2.6.15.4.
Date: Tue, 4 Jul 2006 11:01:13 +0530
Message-ID: <B99D5530D32CC043B5C2221C775FE2F3029ABF8B@PNE-HJN-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] pcmcia: update alloc_io_space for conflict checking for multifunction PC card for Linux kernel 2.6.15.4.
Thread-Index: AcaeCw8zG8s+x1X3TU6IKcGsqT7aCABG3aYA
From: <kaustav.majumdar@wipro.com>
To: <linux@dominikbrodowski.net>
Cc: <linux-pcmcia@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2006 05:31:14.0595 (UTC) FILETIME=[1119C730:01C69F2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some PCMCIA cards do not mention specific IO addresses in the CIS.
In that case, inside the alloc_io_space function, conflicts are detected
(the function returns 1) for the second function of a multifunction card
unless the length of IO address range required is greater than 0x100.
The following patch will remove this conflict checking for a PCMCIA
function which had not mentioned any specific IO address to be mapped
from. 
The patch is tested for Linux kernel 2.6.15.4 and works fine in the
above case and is as suggested by Dave Hinds.


Signed-off-by: Kaustav Majumdar <kaustav.majumdar@wipro.com>

--- linux-2.6.15.4/drivers/pcmcia/pcmcia_resource.c.orig
2006-07-03 15:02:31.000000000 +0530
+++ linux-2.6.15.4/drivers/pcmcia/pcmcia_resource.c	2006-07-03
15:03:01.000000000 +0530
@@ -97,7 +97,7 @@ static int alloc_io_space(struct pcmcia_
 	 * potential conflicts, just the most obvious ones.
 	 */
 	for (i = 0; i < MAX_IO_WIN; i++)
-		if ((s->io[i].NumPorts != 0) &&
+		if ((s->io[i].NumPorts != 0) && (*base != 0) &&
 		    ((s->io[i].BasePort & (align-1)) == *base))
 			return 1;
 	for (i = 0; i < MAX_IO_WIN; i++) {


Regards,
Kaustav Majumdar 
