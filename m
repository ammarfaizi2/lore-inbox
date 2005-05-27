Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVE0Hmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVE0Hmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVE0HmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:42:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:47069 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261941AbVE0Hhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:37:40 -0400
Message-ID: <4296CE3B.3040504@pobox.com>
Date: Fri, 27 May 2005 03:37:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de>
In-Reply-To: <20050527073016.GO1435@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> That is the typical case, ata_qc_new() succeeds but we cannot issue the
> command yet. So where do you want this logic placed? You cannot drop the
> host_lock in-between, as that could potentially change the situation.

ata_scsi_translate() in libata-scsi.c, in between the call to 
ata_scsi_qc_new() and ata_qc_issue().

something like:

	if (ata_scsi_qc_new() fails ||
	    (depth > 0 && ata_check_non_ncq_cmd()))
		complete SCSI command with 'queue full'

NOTE!

I just noticed a bug -- When ata_scsi_qc_new() fails, the code should 
complete the command with queue-full, but does not.

         qc = ata_scsi_qc_new(ap, dev, cmd, done);
         if (!qc)
                 return;

