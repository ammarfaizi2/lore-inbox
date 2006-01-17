Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWAQWjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWAQWjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAQWjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:39:15 -0500
Received: from host233.omnispring.com ([69.44.168.233]:10335 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S932281AbWAQWjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:39:14 -0500
Message-ID: <43CD71FA.4090908@cfl.rr.com>
Date: Tue, 17 Jan 2006 17:38:50 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: sander@humilis.net, NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru> <20060117095019.GA27262@localhost.localdomain> <43CCD453.9070900@tls.msk.ru>
In-Reply-To: <43CCD453.9070900@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2006 22:39:20.0623 (UTC) FILETIME=[DB70ABF0:01C61BB6]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14212.000
X-TM-AS-Result: No--16.800000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
<snip>
> Compare this with my statement about "offline" "reshaper" above:
> separate userspace (easier to write/debug compared with kernel
> space) program which operates on an inactive array (no locking
> needed, no need to worry about other I/O operations going to the
> array at the time of reshaping etc), with an ability to plan it's
> I/O strategy in alot more efficient and safer way...  Yes this
> apprpach has one downside: the array has to be inactive.  But in
> my opinion it's worth it, compared to more possibilities to lose
> your data, even if you do NOT use that feature at all...
>
>   
I also like the idea of this kind of thing going in user space.  I was 
also under the impression that md was going to be phased out and 
replaced by the device mapper.  I've been kicking around the idea of a 
user space utility that manipulates the device mapper tables and 
performs block moves itself to reshape a raid array.  It doesn't seem 
like it would be that difficult and would not require modifying the 
kernel at all.  The basic idea is something like this:

/dev/mapper/raid is your raid array, which is mapped to a stripe between 
/dev/sda, /dev/sdb.  When you want to expand the stripe to add /dev/sdc 
to the array, you create three new devices:

/dev/mapper/raid-old:  copy of the old mapper table, striping sda and sdb
/dev/mapper/raid-progress: linear map with size = new stripe width, and 
pointing to raid-new
/dev/mapper/raid-new: what the raid will look like when done, i.e. 
stripe of sda, sdb, and sdc

Then you replace /dev/mapper/raid with a linear map to raid-new, 
raid-progress, and raid-old, in that order.  Initially the length of the 
chunks from raid-progress and raid-new are zero, so you will still be 
entirely accessing raid-old.  For each stripe in the array, you change 
raid-progress to point to the corresponding blocks in raid-new, but 
suspended, so IO to this stripe will block.  Then you update the raid 
map so raid-progress overlays the stripe you are working on to catch IO 
instead of allowing it to go to raid-old.  After you read that stripe 
from raid-old and write it to raid-new,  resume raid-progress to flush 
any blocked writes to the raid-new stripe.  Finally update raid so the 
previously in progress stripe now maps to raid-new. 

Repeat for each stripe in the array, and finally replace the raid table 
with raid-new's table, and delete the 3 temporary devices. 


Adding transaction logging to the user mode utility wouldn't be very 
hard either. 


