Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUCSQfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUCSQfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:35:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6594 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263092AbUCSQfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:35:01 -0500
Message-ID: <405B2127.8090705@pobox.com>
Date: Fri, 19 Mar 2004 11:34:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de>
In-Reply-To: <20040319153554.GC2933@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Cosmetic stuff that will get ironed out. You can find the patches here:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.5-rc1-mm2/
> 
> ide-barrier-2.6.5-rc1-mm2-1
> 	ide/core part


WRT ATA and flush-cache...  before the IDE pieces of this patch are 
merged, IMO it is a requirement that the entire flush-cache stuff gets a 
review.  ide_get_error_location() is one of the important pieces 
(great!).  Another important piece is to make sure that a drive's 
flush-cache capability is correctly deduced and set up from the 
identify-device.  The steps look like

- check identify-device word 83, bits 12 (flush cache) and 13 (flush 
cache ext)
- issue set-features command to get flush-cache into proper state 
(enabled or disabled, as the user desires), if identify-device word 86 
indicates it is not already in the state you seek.
- re-read identify [packet] device page from device, make sure 
flush-cache[-ext] is enabled.  A slacker could just make sure the 
set-features command completed successfully, but to be 100% correct you 
need to re-read the identify-device page.  :/

NOTE 1: these steps are specific to the flush-cache command, and are 
only vaguely related to write caching (which must be tested-for and 
enabled separately).  It is important to go through these steps 
separately for write-caching and flush-cache[-ext].

Write-caching and flush-cache-command state should always be considered 
separately, even though the two are often used together.  I want to 
avoid the LG cdrom debacle, where not properly checking for, and setting 
up, flush-cache resulted in turning cdroms into bricks.

NOTE 2: Don't forget to check for 0x0000 or 0xffff in word 86, of 
__only__ identify-packet-device.  These special case meanings do not 
appear for ATA devices, only ATAPI devices.

NOTE 3: flush-cache-ext should always be used on lba48 devices, even if 
the request was inside the lba28 limit.

NOTE 4: flush-cache-ext does not exist on ATAPI devices.

	Jeff



