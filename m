Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314205AbSDSBfT>; Thu, 18 Apr 2002 21:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314232AbSDSBfS>; Thu, 18 Apr 2002 21:35:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314205AbSDSBfS>;
	Thu, 18 Apr 2002 21:35:18 -0400
Message-ID: <3CBF743E.9CA419BB@zip.com.au>
Date: Thu, 18 Apr 2002 18:34:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: disk throughput down in 2.5.8
In-Reply-To: <200204182336.BAA22417@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> Is it just me or is disk I/O throughput way down in 2.5.8?
> 
> I was preparing to build 2.4.19-pre7 on a box running 2.5.8,
> when I noticed that 'tar zxvf' on the kernel tarball seemed
> slow and jerky. So I ran
> 
>         cd /tmp; time tar zxf /path/to/linux-2.5.8.tar.gz
> 
> on several boxes(*), comparing 2.4.19-pre7 with 2.5.8.
> 
> On the older boxes (2 PentiumIIs and one K6-III), 2.5.8 was slower
> by factors of 2.3-4.5. A P4 with an IBM 60GXP "only" suffered a
> 40% slowdown.
> 

I can't say that it's happening here.  The time to untar
and sync a kernel tarball from /dev/sdb6 to /dev/sdb5:

2.4.19-pre4:
~/doit  6.55s user 3.69s system 53% cpu 19.225 total
2.4.19-pre7
~/doit  6.82s user 3.29s system 53% cpu 18.811 total
2.5.8:
~/doit  6.32s user 3.52s system 56% cpu 17.401 total

So 2.5.8 is a little quicker.  Note that this time includes
"sync".  2.4.19-recent has more intelligent write-behind
than other kernels, and if you don't include the /bin/sync
time, you actually miss out on timing a lot of the I/O.
Which is a good feature in 2.4, but it only goes so far.

dbench throughput is down the tubes in 2.5.8 - partly because
the kernel is starting too many pdflush threads, and partly
because I (had to) take out the bit of code where bdflush
waits on I/O completion before looking for another wakeup.
That would be a waste of pdflush resources.  It needs to
be addressed by other means, but not with the buffer LRUs.

-
