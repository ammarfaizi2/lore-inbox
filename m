Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314616AbSD0UtE>; Sat, 27 Apr 2002 16:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314615AbSD0UtD>; Sat, 27 Apr 2002 16:49:03 -0400
Received: from vestibule.its.caltech.edu ([131.215.48.17]:53389 "EHLO
	vestibule.its.caltech.edu") by vger.kernel.org with ESMTP
	id <S314616AbSD0UtB>; Sat, 27 Apr 2002 16:49:01 -0400
Message-ID: <3CCB0EAB.9050602@ixiacom.com>
Date: Sat, 27 Apr 2002 13:48:43 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Warchild <warchild@spoofed.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: remote memory reading using arp?
In-Reply-To: <20020427202756.GC6240@spoofed.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warchild wrote:
 > [oh my god, i see userspace text strings in ARP packets]
 >
> I couldn't find anything in the archives about this, and also didn't see
> any changes in the arp implementation of the 2.4 kernel between 2.4.16 and
> 2.4.18.  I also browsed rfc826 to see if there was any mention of 'padding
> data', but nothing caught my eye.
> 
> Any ideas what is causing this?

It's not the ARP layer that's causing the padding... Ethernet has a
minimum transmit size of 64 bytes (everything below that is disgarded
by hardware as a fragment), so the network device driver or
the hardware itself will pad any Linux skb smaller than 60 bytes up to
that size (so that it's 64 bytes after appending CRC32). Apparently, in
some cases that's done by just transmitting whatever uninitialized
memory follows skb->data, which, after the system has been running
for a while, may be inside a page previously used by userspace.

This is NOT a "remote memory reading" exploit, since there is no way to
remotely control what address in memory gets used as padding. I guess
you could packet blast a machine and hope to find something
interesting, but that'd be a denial of service attack long before you
got a complete view of system memory. In any case, it's arguably
userspace's responsibility to clear any sensitive memory contents
before exiting. I would be more concerned if you can find data
from currently in use, userspace-allocated pages flying out as packet
padding (i.e. if reading past skb->data pushes you into somebody else's
page, which seems unlikely since new skb's tend to get allocated near
the beginning of a page).

If you are really concerned you could probably patch the network driver
to zero out memory that will be used as padding, though I don't think
the security risk justifies that performance hit.

-Bryan

