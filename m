Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271860AbRH1Ra2>; Tue, 28 Aug 2001 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271862AbRH1RaJ>; Tue, 28 Aug 2001 13:30:09 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:33811 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271860AbRH1RaE>; Tue, 28 Aug 2001 13:30:04 -0400
Message-ID: <3B8BD508.47CCA66D@zip.com.au>
Date: Tue, 28 Aug 2001 10:29:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Jannik Rasmussen <jannik@east.no>, linux-kernel@vger.kernel.org
Subject: Re: Error 3c900 driver in 2.2.19?
In-Reply-To: <3B8BD0F8.7308F0C9@zip.com.au> <Pine.LNX.4.30.0108281914220.2808-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> On Tue, 28 Aug 2001, Andrew Morton wrote:
> 
> > Possibly, VM system changes have taken you over some threshold.
> > Are you putting a lot of traffic through that machine?
> 
> There's <= 2500 messages (sendmail - usually <5 concurrently) going
> through per day, some 10.000 pop connections per day (mostly at working
> hours). The server's got some 256 megs of RAM, and is doing some small
> databases with postgresql and mysql in addition to the apache server. The
> server does not have any problems with swapping, as the text below should
> show.
> 
> As far as I can see from linux/mm/swap.c, it shouldn't have anything to do
> with freepages... Am I wrong?
> 
> roy
> 
> [root@server log]# free
>              total       used       free     shared    buffers     cached
> Mem:        257876     252976       4900      64120      65156     147368
> -/+ buffers/cache:      40452     217424
> Swap:       136512        268     136244
> 

Networking needs to allocate memory at interrupt time.  This is
referred to as "atomic allocation".  The only way in which this
can be successful is for the VM system to ensure that there is
a pool of immediately-allocatable memory lying around.

The 2.2 kernel uses the tunables in /proc/sys/vm/freepages to
decide how large that pool should be.  Machines which sustain
a high network load commonly require more memory than the
default freepages setting provides.  People who encounter network
Rx allocation failures with 2.2 kernels do report that increasing
the freepages tunables fixes the problem.

-
