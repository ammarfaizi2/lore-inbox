Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUCTAPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 19:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUCTAPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 19:15:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59871 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263152AbUCTAPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 19:15:07 -0500
Message-ID: <405B8CFD.2030909@pobox.com>
Date: Fri, 19 Mar 2004 19:14:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <200403200059.22234.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403200059.22234.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> The fact that spec says "supported" not "enabled" in description of word86
> makes me wonder - can they be disabled? (FLUSH CACHE is mandatory for General
> feature set and FLUSH CACHE EXT is mandatory if 48-bit LBA is supported)

Yes, that's why there are separate 'supported' and 'enabled' bits for 
each feature.

Words 82-84 are 'supported' bits.  Words 85-87 are 'enabled' bits. 
These bits mirror each other, i.e. Word 83 and Word 86 have basically 
the same bits, except that Word 86 definitions change _slightly_ since 
the only bits that are relevant are the ones for features that can be 
disabled/enabled.

You use set-features command to enable and disable these features, and 
then the result shows up in subsequent identify-device command output.

If the driver is testing for a capability but does not enable it, then 
always use the 'enabled' set of bits, not the 'supported' set of bits.


> Jeff, please note that these bits were introduced by ATA-6 spec
> and take a look at ATA-5 spec:
> 
> ...
> FLUSH CACHE
> General feature set
> - Mandatory for all devices
> ...
> 
> and ATA-4 spec:
> 
> ...
> FLUSH CACHE
> General feature set
> - Optional for all devices
> ...
> 
> IMO to test if FLUSH CACHE works we should just issue it during disk setup
> and check result.  This way we can use FLUSH CACHE also on < ATA-6 devices
> (there is a lot of them).

I disagree.  "just issue it" is how those LG cdrom drives got cooked.

LG cdrom drives indicated in their identify-packet-device page that 
flush-cache was not supported...  and then re-used the flush-cache ATA 
opcode for their vendor-specific download-firmware command.  Combine 
that with a Linux patch that didn't properly check for flush-cache 
support.  Result: brick.

All drives that support flush-cache list the relevant bits in 
identify-device, even on pre-ATA-6 devices.  Whether the feature was 
optional or mandantory, we can check the feature bits.

	Jeff



