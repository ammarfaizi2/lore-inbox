Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282360AbRK2Gb5>; Thu, 29 Nov 2001 01:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282357AbRK2Gbr>; Thu, 29 Nov 2001 01:31:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30985 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282290AbRK2Gbc>; Thu, 29 Nov 2001 01:31:32 -0500
Message-ID: <3C05D608.6D06190D@zip.com.au>
Date: Wed, 28 Nov 2001 22:30:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16 revisited
In-Reply-To: <1006928344.2613.2.camel@cygnusx-1.okcforum.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nathan G. Grennan" wrote:
> 
> Well I tried your patch Andrew. It seemed to have absolutely no effect
> on my problem. I used the am-response.patch someone posted the url to
> eariler in the first thread, which was just a file of your patch. I
> really suggest you try a mozilla source rpm. Not only does it do the
> unarchiving, but also patches and rm -rf. I often see a second pause
> during the patching after the unarchving. I use
> 
> rpm --rebuild mozilla-2001112602_trunk-0_rh7.src.rpm
> 
> I also tried Redhat's latest rawhide kernel, 2.4.16-0.1 and it had to
> had time same problem. So it isn't fixed by one of their patchs. It is
> most likely just a difference between Linus's 2.4.9 and 2.4.16.

Nathan,

I can reproduce the 30 second stall on ext3.  It is due to
ext3's journalling of atime updates.  Even though everything
is in cache, running an application requires a write to the
inode.  If there's a lot of write activity going on, this can
occasionally cause the seemingly-read-only caller to get stuck
on the queue behind a huge amount of writes.  So of course the
read-latency improvements don't help.

The 2.2 kernel's version of ext3 didn't journal atime updates,
and this may be a reason for going back to that scheme.  Needs
thought and more testing.

However I can't reproduce the stalls on ext2, and I would expect
the 2.4.9 kernel's ext3 to be demonstrating the same stalls.

Could you please confirm that the stalls happen with ext2 as well,
and could you please test ext2 and ext3 with the `noatime' mount
option?

Thanks.
