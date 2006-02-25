Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWBYLM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWBYLM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWBYLM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:12:27 -0500
Received: from ms-smtp-03-lbl.southeast.rr.com ([24.25.9.102]:5030 "EHLO
	ms-smtp-03-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S1030212AbWBYLM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:12:27 -0500
Subject: Re: [patch 16/17] s390: multiple subchannel sets support.
From: Greg Smith <gsmith@nc.rr.com>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, cornelia.huck@de.ibm.com
Content-Type: text/plain
Date: Sat, 25 Feb 2006 06:12:02 -0500
Message-Id: <1140865922.3513.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running linux-2.6.16-rc4 on the hercules s390x emulator we noticed a
boatload of program checks on the stsch instruction, 192K to be exact.
Hercules does not support multiple subchannel sets at this time.
However, __init_channel_subsystem does not recognize the -EIO return
code from css_alloc_subchannel.

Further investigation shows that this would have been avoided if the
response code from the chsc instruction was properly handled.  In this
case chsc_enable_facility should have returned -EINVAL causing
init_channel_subsystem to set max_ssid to zero.  But the response code
0x0002 (invalid request) is not checked and chsc_enable_facility returns
0 causing max_ssid to be set to __MAX_SSID.

I have verified that on a real machine that does not support multiple
channel sets (a 9672) the CHSC_SDA_OC_MSS chsc request gets response
code 0x0002.  The emulator also sets the response code to 0x0002.

Users of the emulator can do `pgmtrace -15' to supress the 3.7 million
or so lines it spits out ;-)

Greg Smith

--- linux-2.6.16-rc4/drivers/s390/cio/css.c.orig	2006-02-23 17:59:08.000000000 -0500
+++ linux-2.6.16-rc4/drivers/s390/cio/css.c	2006-02-24 12:44:09.000000000 -0500
@@ -409,6 +409,9 @@
 		/* -ENXIO: no more subchannels. */
 		case -ENXIO:
 			return ret;
+		/* -EIO: this subchannel set not supported. */
+		case -EIO:
+			return ret;
 		default:
 			return 0;
 		}


--- linux-2.6.16-rc4/drivers/s390/cio/chsc.c.orig	2006-02-23 17:59:08.000000000 -0500
+++ linux-2.6.16-rc4/drivers/s390/cio/chsc.c	2006-02-25 05:43:24.000000000 -0500
@@ -1115,6 +1115,7 @@
 		goto out;
 	}
 	switch (sda_area->response.code) {
+	case 0x0002: /* invalid request */
 	case 0x0003: /* invalid request block */
 	case 0x0007:
 		ret = -EINVAL;


