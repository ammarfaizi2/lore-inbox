Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279606AbRJXVc5>; Wed, 24 Oct 2001 17:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279608AbRJXVcq>; Wed, 24 Oct 2001 17:32:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:52754 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279606AbRJXVc1>; Wed, 24 Oct 2001 17:32:27 -0400
Message-ID: <3BD73280.7FC6526D@zip.com.au>
Date: Wed, 24 Oct 2001 14:28:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Marinos J. Yannikos" <mjy@geizhals.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: gdth / SCSI read performance issues (2.2.19 and 2.4.10)
In-Reply-To: <3BD6B278.3070300@geizhals.at> <3BD6ECE6.8C9435C4@zip.com.au> <3BD729B6.6030902@geizhals.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marinos J. Yannikos" wrote:
> 
> Andrew Morton wrote:
> 
> > Well that's pretty bad, isn't it?
> 
> We could have bought a much cheaper controller and slower disks ;-)

It's Linux's way of saving you money :)

> > - Disable CONFIG_HIGHMEM
> 
> That seems to have no effect on performance. Btw., the 64GB support in
> 2.4.10 seemed to be buggy ("0-order allocation failed", then the DB
> crashed), so we were using the 4GB setting.

There have been many reports of this happening, but they
are tapering off now.

> > - Try linux-2.4.13
> 
> This helped - now performance is up to par with 2.2.19 (~ 85MB/s) - thanks!

It's surprising that 2.4.10->2.4.13 actually doubled throughput.
 
> > - Profile the kernel. [...]  With something like:
> >       ~/kern-prof.sh cp some_huge_file /dev/null
> 
> I tried this, but with
>   dd if=/dev/sda of=/dev/null bs=1024k count=3000
> 
> (the fs is too slow - so "cp" peaks out at 17MB/s!)

Really?  Are you saying that on a controller which can
do 85 megs/second, you can't read files through the filesystem
at greater than 17?  Which filesystem?

> The result (last 4 lines):
> c01388fc try_to_free_buffers                          55   0.1511
> c0128b10 file_read_actor                            1179  14.0357
> c01053b0 default_idle                               6784 130.4615
> 00000000 total                                      8695   0.0065

OK, that's normal and proper.  Almost all the kernel time
is spent copying data.
 
> Does this suggest that the kernel isn't the bottleneck?

Well...   We seem to have three issues here:

1: Why isn't the controller achieving the manufacturer's
   claimed throughput?

   Don't know.  Maybe it's the software copy.  Maybe it's the
   device driver.  Maybe they lied :).  It'd be interesting
   to test it on the same machine with the vendor's drivers
   and win2k.

2: 0-order allocation failures.

3: Poor `cp' throughput.  This one is strange.  Perhaps
   `cp' is using a small transfer-size and the kernel's
   readhead isn't working properly.  Could you experiment
   with this some more?  For example, what happens with

	dd if=large_file of=/dev/null bs=4096k

-
