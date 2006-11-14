Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965939AbWKNRYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965939AbWKNRYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965873AbWKNRYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:24:49 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:42133 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933462AbWKNRYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=RvZBSurKdycF57FRzPzyFSri+VeVBvgv102QSwlXgpBzBsrwg3tHA62aU61rRBTc8sCiCo/vqEcSnzP6QfkffWblmmLN7xCup7hKzWJeHGSBsuCCu5b/Jmg0wPnKWP/38pqKzfSMGpZVf2i8wElM2NHOA/Sy7Mr0p1wy0+T+/UQ=
Message-ID: <4559FBCF.9050203@gmail.com>
Date: Wed, 15 Nov 2006 02:24:31 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Mathieu Fluhr <mfluhr@nero.com>
CC: Arjan van de Ven <arjan@infradead.org>, Phillip Susi <psusi@cfl.rr.com>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>	 <4558BE57.4020700@cfl.rr.com>	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>	 <1163446372.15249.190.camel@laptopd505.fenrus.org> <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
In-Reply-To: <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>
Content-Type: multipart/mixed;
 boundary="------------060503030804010707040602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060503030804010707040602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mathieu Fluhr wrote:
> On Mon, 2006-11-13 at 20:32 +0100, Arjan van de Ven wrote:
>> On Mon, 2006-11-13 at 19:56 +0100, Mathieu Fluhr wrote:
>>> On Mon, 2006-11-13 at 13:49 -0500, Phillip Susi wrote:
>>>> Mathieu Fluhr wrote:
>>>>> Hello,
>>>>>
>>>>> I recently tried to burn some datas on CDs and DVD using a SATA burner
>>>>> and the latest 2.6.18.2 kernel... using NeroLINUX. (It is controlling
>>>>> the device by sending SCSI commands over the 'sg' driver)
>>>>>
>>>> Please note that the sg interface is depreciated.  It is now recommended 
>>>> that you send the CCBs directly to the normal device, i.e. /dev/hdc.
>>> Of course for native IDE devices, we are using the /dev/hdXX device, but
>>> for SATA devices controlled by the libata, this is not possible ;)
>> for those there is /dev/scd0 etc...
>> (usually nicely symlinked to /dev/cdrom)
> 
> Hummm as we are _writing_ to devices, I think that using /dev/sgXX with
> SG_IO is better no?

The recommended way is using SG_IO to /dev/srX (or /dev/scdX).

> ... and the problem is not in accessing the device itself (this is
> working like a charm) but understanding why a SCSI READ(10) cmd
> sometimes fails as a ATA-padded READ(10) cmd - as discribed in the Annex
> A of the MMC-5 spec - ALWAYS works.
> -> I would suspect somehow a synchronisation problem somehow in the
> translation of SCSI to ATA command...

Can you try the attached patch and see if anything changes?

-- 
tejun

--------------060503030804010707040602
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 2dc3264..fa82151 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -286,6 +286,7 @@ static int sg_io(struct file *file, requ
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr->cmd_len;
+	memset(rq->cmd, 0, BLK_MAX_CDB);
 	memcpy(rq->cmd, cmd, hdr->cmd_len);
 	if (sizeof(rq->cmd) != hdr->cmd_len)
 		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d2c02df..080c2ed 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -410,6 +410,7 @@ int scsi_execute_async(struct scsi_devic
 		goto free_req;
 
 	req->cmd_len = cmd_len;
+	memset(req->cmd, 0, BLK_MAX_CDB);
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sioc->sense;
 	req->sense_len = 0;

--------------060503030804010707040602--
