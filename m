Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUB1VYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbUB1VYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:24:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42664 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261920AbUB1VXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:23:51 -0500
Message-ID: <404106D7.8050809@pobox.com>
Date: Sat, 28 Feb 2004 16:23:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH/RFT] libata "DMA timeout" fix
References: <4040E7B5.4020709@pobox.com> <1078001357.2020.90.camel@mulgrave>
In-Reply-To: <1078001357.2020.90.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sat, 2004-02-28 at 13:10, Jeff Garzik wrote:
> 
>>===== drivers/scsi/libata-core.c 1.19 vs edited =====
>>--- 1.19/drivers/scsi/libata-core.c	Wed Feb 25 22:41:13 2004
>>+++ edited/drivers/scsi/libata-core.c	Sat Feb 28 14:03:18 2004
>>@@ -2130,6 +2130,14 @@
>> 				cmd->result = SAM_STAT_CHECK_CONDITION;
>> 			else
>> 				ata_to_sense_error(qc);
>>+
>>+			/* hack alert! we need this to get past the
>>+			 * first check in scsi_done().  libata is the
>>+			 * -only- user of ->eh_strategy_handler() in
>>+			 * any kernel tree, which exposes some incorrect
>>+			 * assumptions in the SCSI layer.
>>+			 */
>>+			scsi_add_timer(cmd, 2000 * HZ, NULL);
>> 		} else {
>> 			cmd->result = SAM_STAT_GOOD;
>> 		}
> 
> 
> You can't do this.  Supposing there command's delayed, the timer fires
> and then the command returns with a sense error?  The done will go
> through automatically completing the command, but your strategy handler
> will still think it has a failed command to handle.

hmmm, yeah that will be a problem iff we are not already in the strategy 
handler.


> The correct fix is this, I think (uncompiled, but you get the idea):

Yeah, that's much better.  That function is not exported though ;-)

	Jeff



