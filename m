Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTFTL5c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTFTL5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:57:32 -0400
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:62204 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262955AbTFTL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:57:29 -0400
Date: Fri, 20 Jun 2003 15:11:29 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Bob Tracy <rct@gherkin.frus.com>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: 2.5.72: SCSI tape error handling
In-Reply-To: <20030619213635.AD2874F01@gherkin.frus.com>
Message-ID: <Pine.LNX.4.52.0306201505210.755@kai.makisara.local>
References: <20030619213635.AD2874F01@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003, Bob Tracy wrote:

> I was trying to do the responsible thing and back up my system today
> (for the first time in too many weeks :-)), and got the following
> errors in syslog about 15 minutes into the process:
>
> Jun 19 09:55:04 gherkin kernel: st0: Error with sense data: Info fld=0x3ba, Deferred stst0: sense key Medium Error
> Jun 19 09:55:04 gherkin kernel: Additional sense: Write append position error
> Jun 19 09:55:04 gherkin kernel: st0: Error with sense data: Current stst0: sense key Medium Error
> Jun 19 09:55:04 gherkin kernel: Additional sense: Write append position error
> Jun 19 09:55:04 gherkin kernel: st0: Error with sense data: Current stst0: sense key Medium Error
> Jun 19 09:55:04 gherkin kernel: Additional sense: Write append position error
> (... ad infinitum for the next three hours -- backup was unattended.
> There were no error messages of any kind on the console.)
>
st does not currently return error for any write problems except when at
EOT. The following one-liner fixes the bug (probably mangled by my mail
client):

--- linux-2.5.72-bk2/drivers/scsi/st.c	2003-06-19 20:43:38.000000000 +0300
+++ linux-2.5.72-bk2-km/drivers/scsi/st.c	2003-06-20 14:56:44.000000000 +0300
@@ -1555,6 +1555,7 @@
 				}
 			} else {
 				filp->f_pos -= do_count;
+				count += do_count;
 				STps->drv_block = (-1);		/* Too cautious? */
 				retval = (-EIO);
 			}

Thanks for the report.

-- 
Kai
