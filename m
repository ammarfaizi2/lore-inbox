Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278642AbRJXQf5>; Wed, 24 Oct 2001 12:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRJXQfr>; Wed, 24 Oct 2001 12:35:47 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:51216 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278642AbRJXQfd>; Wed, 24 Oct 2001 12:35:33 -0400
Message-ID: <3BD6ECE6.8C9435C4@zip.com.au>
Date: Wed, 24 Oct 2001 09:31:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marinos Yannikos <mjy@geizhals.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: gdth / SCSI read performance issues (2.2.19 and 2.4.10)
In-Reply-To: <3BD6B278.3070300@geizhals.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marinos Yannikos wrote:
> 
> Hi,
> 
> our brand-new ICP GDT8523RZ controller with 6 disks peaks out at
> 45MB/s under 2.4.10, while with 2.2.19 it reaches 85MB/s (seq.
> read performance). It should realistically be able to reach
> at least 150-200MB/s in this configuration

Well that's pretty bad, isn't it?

Some things which it would be interesting to try out:

- Disable CONFIG_HIGHMEM in your kernel config, see
  what that does.

- Try linux-2.4.13 -- 2.4.10 was a bit of a dog (this may make
  a difference if the driver uese the new PCI DMA API,
  but it doesn't explain why 2.2.x does so much better).

- Profile the kernel.  You may enable profiling by booting
  the kernel with the LILO option `profile=1'.

  Then, making sure that /boot/System.map reflects the
  running kernel, run this little script

#!/bin/sh
TIMEFILE=/tmp/$(basename $1).time
sudo readprofile -r
time "$@"
readprofile -v -m /boot/System.map | sort -n +2 | tail -40 | tee $TIMEFILE
echo created $TIMEFILE

  With something like:

	~/kern-prof.sh cp some_huge_file /dev/null
