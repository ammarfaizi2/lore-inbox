Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316185AbSFUD3Y>; Thu, 20 Jun 2002 23:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSFUD3X>; Thu, 20 Jun 2002 23:29:23 -0400
Received: from dsl-213-023-043-172.arcor-ip.net ([213.23.43.172]:56485 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316185AbSFUD3X>;
	Thu, 20 Jun 2002 23:29:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Fri, 21 Jun 2002 05:28:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christopher Li <chrisl@gnuchina.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <20020619113734.D2658@redhat.com> <20020619234340.A24016@redhat.com> <20020620005452.M5119@redhat.com>
In-Reply-To: <20020620005452.M5119@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17LF65-0001K4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 01:54, Stephen C. Tweedie wrote:
> > I'm checking out a proper hash function at the moment.
> 
> Done, checked into ext3 cvs (features-branch again.)
> 
> Deleting and recreating 100,000 files with this kernel:
> 
> [root@spock test0]# time xargs rm -f < /root/flist.100000 
> 
> real    0m14.305s
> user    0m0.750s
> sys     0m5.430s
> [root@spock test0]# time xargs touch < /root/flist.100000 
> 
> real    0m16.244s
> user    0m0.530s
> sys     0m6.660s
> 
> that's an average of 160usec per create, 140usec per delete elapsed
> time, and 66/54usec respectively system time.  
> 
> I assume the elapsed time is greater only because we're starting to
> wrap the journal due to the large amount of metadata being touched
> (we're touching a lot of inodes doing the above, which I could avoid
> by making hard links instead of new files.)  Certainly, limiting the
> test to 10,000 files lets it run at 100% cpu.

I ran a bakeoff between your new half-md4 and dx_hack_hash on Ext2.  As 
predicted, half-md4 does produce very even bucket distributions.  For 200,000 
creates:

   half-md4:        2872 avg bytes filled per 4k block (70%)
   dx_hack_hash:    2853 avg bytes filled per 4k block (69%)

but guess which was faster overall?

   half-md4:        user 0.43 system 6.88 real 0:07.33 CPU 99%
   dx_hack_hash:    user 0.43 system 6.40 real 0:06.82 CPU 100%

This is quite reproducible: dx_hack_hash is always faster by about 6%.  This 
must be due entirely to the difference in hashing cost, since half-md4 
produces measurably better distributions.  Now what do we do?

By the way, I'm running about 37 usec per create here, on a 1GHz/1GB PIII, 
with Ext2.  I think most of the difference vs your timings is that your test 
code is eating a lot of cpu.

-- 
Daniel
