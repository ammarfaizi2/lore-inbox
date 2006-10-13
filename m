Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWJMQIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWJMQIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWJMQIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:08:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21925 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751596AbWJMQIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:08:39 -0400
Message-ID: <452FB9EF.1050109@redhat.com>
Date: Fri, 13 Oct 2006 11:08:15 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz> <452CF523.5090708@sandeen.net> <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com> <20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org> <452EA06F.4060701@redhat.com> <452EB9C5.4000404@us.ibm.com> <20061013075613.GB29170@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061013075613.GB29170@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>> This is exactly  the solution I proposed earlier (to check 
>> buffer_mapped() before calling submit_bh()).
>> But at that time, Jan pointed out that the whole handling is wrong.
>   Yes, and it was. However it turned out that there are more problems
> than I thought ;).
> 
>> But if this is the only case we need to handle, I am okay with this band 
>> aid :)
>   I think Eric's patch may be a part of it. But we still need to check whether
> the buffer is not after EOF before submitting it (or better said just
> after we manage to lock the buffer). Because while we are waiting for
> the buffer lock, journal_unmap_buffer() can still come and steal the
> buffer - at least the write-out in journal_dirty_data() definitely needs
> the check if I haven't overlooked something.

Ok, let me think on that today.  My first reaction is that if we have
the bh state lock and pay attention to mapped in journal_dirty_data(),
then any blocks past EOF which have gotten unmapped by
journal_unmap_buffer will be recognized as such (because they are now
unmapped... without needing to check for past EOF...) and we'll be fine.

As a datapoint, davej's stresstest (several fsx's and fsstresses)
survived an overnight run on his box, which used to panic in < 2 hrs.
Survived about 6 hours on my box until I intentionally stopped it; my
box had added a write/truncate test in a loop, with a bunch of periodic
syncs as well....

-Eric
