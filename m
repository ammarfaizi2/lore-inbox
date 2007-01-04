Return-Path: <linux-kernel-owner+w=401wt.eu-S932121AbXADFCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbXADFCg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbXADFCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:02:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:19717 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbXADFCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:02:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type;
        b=gq1SouQcfgZXtDVOo87PmCsBsuIYszOZ18Z6c28U9bnam8wYQpTNdkDUazOwlFqyrGc5XDacsc7s0F6z3dbr1aTGMKpM0ahnBYim8Pfh5dnCfVygym7u5gu5DYxwGTBbH1UcAbBqGv5at1l38zK9hr4rehVSQq+K1woSmz+vKN8=
Message-ID: <459C8A5E.5010206@gmail.com>
Date: Thu, 04 Jan 2007 14:02:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar> <459B9F91.9070908@gmail.com> <459BC703.9000207@fliagreco.com.ar>
In-Reply-To: <459BC703.9000207@fliagreco.com.ar>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------080909090305090104090408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909090305090104090408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pablo Sebastian Greco wrote:
> By crash I mean the whole system going down, having to reset the entire
> machine.
> I'm sending you 4 files:
> dmesg: current boot dmesg, just a boot, because no errors appeared after
> last crash, since the server is out of production right now (errors
> usually appear under heavy load, and this primarily a transparent proxy
> for about 1000 simultaneous users)
> lspci: the way you asked for it
> messages and messages.1: files where you can see old boots and crashes
> (even a soft lockup).
> If there is anything else I can do, let me know. If you need direct
> access to the server, I can arrange that too.

Can you try 2.6.20-rc3 and see if 'CLO not available' message goes away
(please post boot dmesg)?

The crash/lock is because filesystem code does not cope with IO errors
very well.  I can't tell why timeouts are occurring in the first place.
 It seems that only samsung drives are affected (sda2, 3, 4).  Hmmm...
Please apply the attached patch to 2.6.20-rc3 and test it.

Thanks.

-- 
tejun

--------------080909090305090104090408
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0d51d13..f8cf349 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3327,6 +3327,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* NCQ is slow */
         { "WDC WD740ADFD-00",   NULL,		ATA_HORKAGE_NONCQ },
 
+	{ "SAMSUNG SP2504C",	NULL,		ATA_HORKAGE_NONCQ },
+
 	/* Devices with NCQ limits */
 
 	/* End Marker */

--------------080909090305090104090408--
