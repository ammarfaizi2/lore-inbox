Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbRGZOcj>; Thu, 26 Jul 2001 10:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbRGZOc3>; Thu, 26 Jul 2001 10:32:29 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:15749 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267992AbRGZOcS>; Thu, 26 Jul 2001 10:32:18 -0400
Date: Thu, 26 Jul 2001 16:32:23 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726163223.Q17244@emma1.emma.line.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> <E15PlYr-0003mr-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15PlYr-0003mr-00@the-village.bc.nu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Alan Cox wrote:

> Rik is right. It isnt just about premature notification - its about 
> atomicity. At the point you are notified the data has been queued for disk
> I/O. Even on traditional BSD ufs with synchronous metadata you still had
> points where a crash left the rename partially complete and nothing but a
> log or an atomic update system is going to fix that.

No. Atomic update systems and logs can by no means fix premature
acknowledgements:

Proof:

Assume the OS has a phase tree kind of thing or log that requires
just a single-block write for an atomic rename.

Assume an MTA calls rename(), and the OS by whatever means notifies it of
completion, but actually, the data is only queued, not written.

Assume The MTA receives the acknowledgement (e. g. rename call
returned), sends a "250 mail action complete" packet across the network.

Assume the machine sends the network packed, but not the queued disk
block and then crashes.

--> The single block is lost, the rename operation is lost, but the
operation had been acknowledged. Consequence: the mail is lost. q. e. d.

All this boils down to: 

1. The OS _MUST_ know when a write operation has been physically
committed to non-volatile storage.

2. The OS _MUST_ _NOT_ acknowledge the (assumedly synchronous operation)
any earlier. (This may well include switching off drive write
buffering.)

If the OS cannot fulfill these two basic requirements, I can save all
the log or FS atomicity efforts because they don't get me anywhere.

The problem is not that the operation can fail, the problem IS premature
acknowledgement. Even with atomic updates, as shown above.

Note, of course there is no premature acknowledgement for the
Linux-default asynchronous directory update. There IS for -o sync or
chattr +S -- and that's what MTAs to to guarantee data integrity, and
that's why I'm still suggesting dirsync or something to remedy the
negative data write performance of full-sync.

If the OS tell me "write completed" when it means "I queued your data
for writing", it is BROKEN.

That's my point.

And since the common POSIX OS lacks a dedicated notification feature for
e. g. rename, MTAs have no other choice than to rely on "has completed
when the syscall returns".

BTW, my Linux rename(2) man page doesn't document EIO condition, FreeBSD
4.3-STABLE and SUS v2 do.

-- 
Matthias Andree
