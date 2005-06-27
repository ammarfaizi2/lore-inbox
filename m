Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVF0US7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVF0US7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVF0US7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:18:59 -0400
Received: from [63.81.117.10] ([63.81.117.10]:30408 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261612AbVF0USg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:18:36 -0400
Message-ID: <42C05F16.5000804@xfs.org>
Date: Mon, 27 Jun 2005 15:18:30 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com>
In-Reply-To: <42C0578F.7030608@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jun 2005 20:18:33.0908 (UTC) FILETIME=[64893F40:01C57B55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Steve, there is a remark about XFS below which you are going to be more
> expert on.
> 
> Theodore Ts'o wrote:
> 

>>
>>XFS has similar issues where it assumes that hardware has powerfail
>>interrupts, and that the OS can use said powerfail interrupt to stop
>>DMA's in its tracks on an power failure, so that you don't have
>>garbage written to key filesystem data structures when the memory
>>starts suffering from the dropping voltage on the power bus faster
>>than the DMA engine or the disk drives.  So XFS is a great filesystem
>>--- but you'd better be running it on a UPS, or on a system which has
>>power fail interrupts and an OS that knows what to do.  Ext3, because
>>it does physical block journalling, does not suffer from this problem.
>>(Yes, Resierfs uses logical journalling as well, so it suffers from
>>the same problem.)
>>

I presume Ted is referring to problems guaranteeing the integrity of
the journal at recovery time. I am coming into this without all the
available context, so I may be barking up the wrong tree.... In
particular, I am not sure how journaling whole blocks protects
you from this.

The xfs journal protects itself against partial writes, to a certain
degree. The header of a journal write (inside a 512 byte sector)
contains an array of words which are swapped out from the start of
each following 512 byte sector of the journal write. The following
sectors then each have the log sequence number (LSN) of the write inserted
in place of that data.

During recovery, we find the most recent LSN via a binary chop
search, this gives us an associated tail LSN. A scan backwards
from the head LSN is then done - this covers the total possible
amount of in flight data (maximum log buffers x maximum log buffer
size). If any of the sectors has the wrong LSN in the first word,
then it an all following data is discarded from replay. Of course,
we will also not replay any journal entry for which we do not find
the transaction commit record.

Now, this protects against some failure cases, it assumes that
sector writes are atomic, they either happen or they do not
happen. If sector writes are not atomic and one end can be
good with the other is bad, then a partial sector is possibly
going to get replayed. There have been discussions about doing
this with the head and tail of each sector, or using a checksum
instead.

XFS on linux has had power cycle crash testing, but there is no
way you can cover all possible hardware configurations, and I
seem to recall some hardware never recovered from this testing,
by that I mean the PC did not survive the continual power cycling
and went up in smoke.

Steve

