Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWJPQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWJPQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWJPQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:57:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16529 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422688AbWJPQ51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:57:27 -0400
Message-ID: <4533B9AB.8040403@redhat.com>
Date: Mon, 16 Oct 2006 11:56:11 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
References: <452CF523.5090708@sandeen.net> <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com> <20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org> <452EA06F.4060701@redhat.com> <452EB9C5.4000404@us.ibm.com> <20061013075613.GB29170@atrey.karlin.mff.cuni.cz> <452FB9EF.1050109@redhat.com> <20061016165411.GI6803@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20061016165411.GI6803@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>>>   I think Eric's patch may be a part of it. But we still need to check whether
>>> the buffer is not after EOF before submitting it (or better said just
>>> after we manage to lock the buffer). Because while we are waiting for
>>> the buffer lock, journal_unmap_buffer() can still come and steal the
>>> buffer - at least the write-out in journal_dirty_data() definitely needs
>>> the check if I haven't overlooked something.
>> Ok, let me think on that today.  My first reaction is that if we have
>> the bh state lock and pay attention to mapped in journal_dirty_data(),
>> then any blocks past EOF which have gotten unmapped by
>> journal_unmap_buffer will be recognized as such (because they are now
>> unmapped... without needing to check for past EOF...) and we'll be fine.
>   Hmm, yes, you're right. If we do the test in journal_dirty_data() we
> should not file unmapped buffer into transaction's list and hence we
> should be safe. Fine. In case we eventually hit the assertion, we can
> think further ;).

Awww no way that can possibly happen right?  :)

>> As a datapoint, davej's stresstest (several fsx's and fsstresses)
>> survived an overnight run on his box, which used to panic in < 2 hrs.
>> Survived about 6 hours on my box until I intentionally stopped it; my
>> box had added a write/truncate test in a loop, with a bunch of periodic
>> syncs as well....
>   Perfect :).

Ok, thanks Jan!

I'll send a patch for -mm as a new thread, this one has gotten buried
pretty deep.

-Eric
