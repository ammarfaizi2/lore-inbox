Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWJMMDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWJMMDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWJMMDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:03:13 -0400
Received: from rbox6.erasmusmc.nl ([156.83.10.16]:30193 "EHLO
	rbox6.erasmusmc.nl") by vger.kernel.org with ESMTP id S1751632AbWJMMDM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:03:12 -0400
From: "Jerome Borsboom" <j.borsboom@erasmusmc.nl>
To: linux-kernel@vger.kernel.org
Date: Fri, 13 Oct 2006 14:02:58 +0200
MIME-Version: 1.0
Subject: 2.6.18 bug in gdth.c [solved]
Message-ID: <452F9C92.29502.13A9459@j.borsboom.erasmusmc.nl>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes in the gdth.c driver introduced an 'unable to handle 
kernel paging request' bug. The offending change seems to be 
following change in 'gdth_fill_raw_cmd':

@@ -3022,7 +3148,7 @@ #ifdef GDTH_STATISTICS
             }
#endif
-        } else {
+        } else if (scp->request_bufflen) {
             scp->SCp.Status = GDTH_MAP_SINGLE;
             scp->SCp.Message = PCI_DMA_BIDIRECTIONAL;
             page = virt_to_page(scp->request_buffer);

Reverting this line, make the driver stable again. My hypothesis is 
that when scp->request_bufflen is 0, then cmdp->u.raw.sg_ranz will 
not be assigned which makes the subsequent ha->cmd_len calculation 
misbehave. When you compare gdth_fill_raw_cmd with 
gdth_fill_cache_cmd, then in the latter function cmdp- 
>u.cache.sg_canz IS assigned before the conditional 'if (scp- 
>use_sg)...'


Jerome Borsboom
-----------------------------
Dr.ir. Jerome Borsboom, Ph.D.
Biomedical Engineering
Erasmus MC
Room Ee2302
Dr. Molewaterplein 50
3015 GE Rotterdam
the Netherlands
Tel:  +31 10 408 7474
Fax: + 31 10 408 9445


