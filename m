Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTDKSB4 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTDKSBz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:01:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14775 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261364AbTDKSBl (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:01:41 -0400
Date: Fri, 11 Apr 2003 11:15:14 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lockmeter 2.5] BKL with 51ms hold time, prove me wrong
Message-ID: <34680000.1050084914@w-hlinder>
In-Reply-To: <20030410185006.5fd88c30.akpm@digeo.com>
References: <46950000.1050023701@w-hlinder> <20030410185006.5fd88c30.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 10, 2003 06:50:06 PM -0700 Andrew Morton <akpm@digeo.com> wrote:

> I'm a bit surprised that even slow machine like that would take 50
> milliseconds to truncate 128MB of file, but it's not impossible I guess. 
> Truncate is not really a fastpath.  ext3 in -mm doesn't have any lock_kernels
> in it.

Sure enough. I ported lockmeter to 2.5.67-mm1 and ran the same rmap-test
and lo and behold all the ext3 issues went away. However, the one remaining
long hold time moved to the top (unmap_vmas):
___________________________________________________________________________________________
System: Linux w-hlinder2 2.5.67-mm1 #1 SMP Fri Apr 11 12:31:38 PDT 2003 i686

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

       19.2%  2.0us(  49ms)  1.1us(9767us)(0.58%)   5506902 80.8% 16.6%  2.5%  *TOTAL*

 0.30% 0.00%  0.4us(9728us) 2598us(3751us)(0.01%)    672210  100% 0.00%    0%  journal_datalist_lock 

 0.26% 0.01%  1.1us(9759us) 4116us(9767us)(0.04%)    211510  100% 0.01%    0%  kernel_flag

 0.00% 10.9%  2.2us(  14us)  1.0us( 1.9us)(0.00%)       137 89.1% 10.9%    0%  runqueues
 0.00% 42.9%  1.6us(  14us)  1.0us( 1.9us)(0.00%)        35 57.1% 42.9%    0%    load_balance+0x138
 0.00%    0%  2.3us( 3.9us)    0us                      102  100%    0%    0%    wake_up_forked_process+0x3c

  3.1%    0%   11ms(  49ms)    0us                      245  100%    0%    0%  unmap_vmas+0x1c0

------------

Here is the port of lockmeter to the 2.5.67-mm1 kernel. If you would consider
putting it in your tree that would be great and I would work on porting the
rest of the architectures. 

http://prdownloads.sourceforge.net/lse/lockmeter1.5-2.5.67-mm1.patch?download

Here is also the whole locmeter output of this run if 
you are interested.

http://prdownloads.sourceforge.net/lse/lockstat-mm1.rmapm?download

Thanks a lot!

Hanna Linder
IBM Linux Technology Center
hannal@us.ibm.com




