Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUC1UwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUC1Uuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:50:39 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:30129 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262208AbUC1UuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:50:09 -0500
Date: Sun, 28 Mar 2004 13:50:42 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328205042.GD6405@bounceswoosh.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Jamie Lokier <jamie@shareable.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328173623.GA1087@mail.shareable.org> <4067114D.7050606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4067114D.7050606@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 at 12:54, Jeff Garzik wrote:
>Jamie Lokier wrote:
>>This is what I mean: turn off write cacheing, and performance on PATA
>>drops because of the serialisation and lost inter-command time.
>>
>>With TCQ-on-write, you can turn off write cacheing and in theory
>>performance doesn't have to drop, is that right?
>
>hmmm, that's a good point.  I honestly don't know.  Something to be 
>tested, I suppose...
>
>My premature guess would be that you would need a queue depth larger 
>than 2 or 4 before performance starts to not-suck.

Write-cache off + queueing means that the drive can't "finish" the
command until it is on the media.  This means that until the block is
written, you won't get a 0x50 status or a SetBits FIS.

In theory, write-cache-off queueing will be slightly slower than
random reads+queueing, since most drives have slightly stricter
guidelines for write-settle versus read-settle.  (read settle you can
let your ECC hardware tell you that you pooched a seek and went
offtrack because you were still vibrating, for writes that is liable
to corrupt good data on adjacent tracks which you may not have in
buffer and therefore might not be able to repair.)

However, cached writes (queued or unqueued), especially small ones,
will have WAY higher ops/sec.  ATA TCQ is limited to 32 choices for
the next best operation, but an 8MB buffer doing 4K random-ops could
potentially have ~2000 choices for the next thing to do. (assuming
perfect cache granularity, etc, etc)

At 32 choices, the seek and rotate are still somewhat significant,
though way better than unqueued.  With 2000 things to choose from, the
drive is never, ever idle.  Seek, land just-in-time, read/write,
rinse/repeat.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

