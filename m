Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTDKB5r (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 21:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTDKB5r (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 21:57:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44791 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264253AbTDKB5q (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 21:57:46 -0400
Message-ID: <3E9623AE.6050509@us.ibm.com>
Date: Thu, 10 Apr 2003 19:08:46 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [Lockmeter 2.5] BKL with 51ms hold time, prove me wrong
References: <46950000.1050023701@w-hlinder>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> My original purpose was to verify my lockmeter port is producing 
> valid data so I was comparing to readprofile results. However, I saw 
> these high hold times and wanted to show them to you. Here is the 
> whole lockmeter output file: 
> http://prdownloads.sourceforge.net/lse/lockmeter.rmapm
> 
> Below is a snippet of lockmeter data from running Andrew Morton's
> rmap-test -m -i 10 -n 50 -s 600 -t 100 foo
> on a 2-way PIII 256MB RAM 500MHz System
> 
> If my port of the lockmeter tool is correct then this high hold
> time is a bad thing. If the lockmeter tool is incorrect please let 
> me know. Here is the link to a lockmeter patch (originally written 
> by John Hawkes, I simply ported it): 
> http://prdownloads.sourceforge.net/lse/lockmeter1.5-2.5.64-1.diff

This isn't much of a surprise, nor is is likely a problem in your
lockmeter port.  The offender is ext3_delete_inode.  The BKL was only
taken here twice out of the 126172 lock_kernel() which were profiled.
The 51ms happened once and the other time, the lock was released much
more quickly.

  SPINLOCKS     HOLD        WAIT
  UTIL  CON  MEAN( MAX ) MEAN( MAX)(% CPU) TOTAL NOWAIT SPIN RJECT
 0.02%    0% 26ms( 51ms)  0us                  2   100%    0%    0%

The odds are that the 22ms wait in ext3_writepage and the 20ms wait in
schedule were due to this single hold.  Actually, the schedule one could
very well be caused by the reacquisiton after ext3_delete_inode() hit
something that made it sleep with the BKL held.

I've thought that it would be helpful to have lockmeter special-case the
reacquire_kernel() in schedule, to properly attribute the time to the
original offender.
-- 
Dave Hansen
haveblue@us.ibm.com

