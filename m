Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWHWP1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWHWP1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHWP1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:27:19 -0400
Received: from rtr.ca ([64.26.128.89]:10369 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964982AbWHWP1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:27:16 -0400
Message-ID: <44EC73D2.9090302@rtr.ca>
Date: Wed, 23 Aug 2006 11:27:14 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Johan Groth <johan.groth@linux-grotto.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk>
In-Reply-To: <44EB1875.3020403@linux-grotto.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Groth wrote:
> Hi,
> ever since I upgraded my server from a dual Opteron 244 (mobo Tyan 2885) 
> system to a dual dual-core Opteron 285 (mobo Tyan 2895) system, I'm 
> getting read errors that freezes the system which leads to my disk based 
> backup software stopped working (faubackup). I think it is faubackup 
> that triggers the bug.
> 
> I get these errors in the log:
> Aug 20 06:35:08 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 
> 0x40001
> Aug 20 06:35:56 jaguar kernel: end_request: I/O error, dev sda, sector 
> 616924530
> Aug 20 06:36:03 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 
> 0x40001
> Aug 20 06:36:03 jaguar kernel: end_request: I/O error, dev sda, sector 
> 616924538
..
> Aug 20 06:36:07 jaguar kernel: sd 2:1:0:0: SCSI error: return code = 
> 0x40001
> Aug 20 06:36:07 jaguar kernel: end_request: I/O error, dev sda, sector 
> 616924538
> 
> The last sector is repeated until I reboot the machine. The only 
> difference I've made to the raid configuration is that sdc is now 2x250 
> MB instead of 4x120MB, but that array is the target not the source (sda).
> The raid HW is an LSI Megaraid 300-8x with the following configuration:
..

That looks like the classic SCSI bad-sectory non-recovery bug.
The code in scsi_lib.c, scsi_error.c, and sd.c is currently a
bit of a mess here.  

Basically, given an I/O request for 200 sectors, with a bad sector
in the middle at number 100, what SCSI will often do is fail sectors
number 1 through 100, one at a time, retrying the entire remainder of
the request after each attempt.  This takes hours, and results in no
data for the first 99 good sectors.

What it needs to do *instead*, is retry each sector individually,
rather than the entire request.  This would result in sectors 1..99
and 101..200 succeeding, and retries/failure only for sector 100.

A slight optimization would be to fail the bio size around sector 100,
rather than just the one sector.

I've got patches that do exactly this, and they work quite well.
But they're probably not "pretty enough" for inclusion.

Cheers


