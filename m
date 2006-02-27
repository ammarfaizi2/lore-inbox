Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWB0IPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWB0IPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWB0IPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:15:48 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63259 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751678AbWB0IPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:15:48 -0500
Date: Mon, 27 Feb 2006 09:15:46 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg Smith <gsmith@nc.rr.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [patch 16/17] s390: multiple subchannel sets support.
Message-ID: <20060227091546.2d63209b@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1140865922.3513.87.camel@localhost.localdomain>
References: <1140865922.3513.87.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 06:12:02 -0500
Greg Smith <gsmith@nc.rr.com> wrote:

> However, __init_channel_subsystem does not recognize the -EIO return
> code from css_alloc_subchannel.

Good catch.

> I have verified that on a real machine that does not support multiple
> channel sets (a 9672) the CHSC_SDA_OC_MSS chsc request gets response
> code 0x0002.  The emulator also sets the response code to 0x0002.

The architecture seems to disagree somewhat :) (and I also got a
different response code on the non-MSS capable HW I tested on). On
further looking at the code, the check leaves room for improvement
anyway... I'd prefer the following patch:


s390: Improve response code handling in chsc_enable_facility().

Rather than checking for some known failures, check positively for the
success response code 0x0001 and return -EIO for unrecognized failure
response codes.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 chsc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 8cf9905..f4183d6 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1115,6 +1115,9 @@ chsc_enable_facility(int operation_code)
 		goto out;
 	}
 	switch (sda_area->response.code) {
+	case 0x0001: /* everything ok */
+		ret = 0;
+		break;
 	case 0x0003: /* invalid request block */
 	case 0x0007:
 		ret = -EINVAL;
@@ -1123,6 +1126,8 @@ chsc_enable_facility(int operation_code)
 	case 0x0101: /* facility not provided */
 		ret = -EOPNOTSUPP;
 		break;
+	default: /* something went wrong */
+		ret = -EIO;
 	}
  out:
 	free_page((unsigned long)sda_area);
