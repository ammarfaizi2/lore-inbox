Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRCHRmz>; Thu, 8 Mar 2001 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRCHRmq>; Thu, 8 Mar 2001 12:42:46 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:5400 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129344AbRCHRmf>; Thu, 8 Mar 2001 12:42:35 -0500
Message-ID: <3AA7C616.3922B744@sgi.com>
Date: Thu, 08 Mar 2001 09:49:10 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Elevator algorithm parameters
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few comments/questions on the elv. alg. as it is now.  Some
of them may be based on a flawed understanding, but please be patient
anyway :-).

1) read-ahead is given the same 'latency' [max-wait priority] as 'read'
   I can see r-a as being less important than 'read' -- 'read' means
   some app is blocked waiting for input *now*.  'ra' -- means the
   kernel is being clever in hopes it is predicting a usage pattern where
   reading ahead will be useful.  I'd be tempted to give read-ahead
   a higher acceptable latency than reads and possibly higher than
   writes.  By definition, 'ra' i/o is i/o that no one currently has
   requested be done.
   a) the code may be there, but if a read request comes in for a
      sector marked for ra, then the latency should be set to 
      min(r-latency,remaining ra latency)

2) I seem to notice a performance boost for my laptop setting the
   read latency down to 1/8th of the write (2048/16384) instead of
   the current 1:2 ratio.  

   I am running my machine as a nfs server as well as doing local tasks
   and compiles.  I got better overall performance because nfs requests
   got serviced more quickly to feed a data-hungry dual-processor
   "compiler-server".  Also, my interactive processes which need
   lots of random reads perform better because they got 'fed' faster
   while some background data transfers (read and writes) of large
   streams of data were going on.

3) It seems that the balance of optimal latency figures would vary
   based on how many cpu-processes are blocked on data-reads, how many
   cpu's are reading from the same disk, the disk speed, the cpu speed
   and available memory for buffering.  Maybe there is a neat wiz-bang
   self-adjusting algorithm that can adapt dynamically to different
   loads (like say detects -- hmmm, we have 100 non mergable read 
   requests plugged, should I wait for more?...well only 1 active write
   request is running....maybe I should lower the read latency...etc).
   However, in the interim, it seems having the values at least be
   tunable via /proc (rather than the current ioctl) would be useful --
   just able to echo some values into there @ runtime.  I couldn't
   seem to find such a beast in /proc.

Comments/cares?

If you ask for code from me, it'll be a while -- My read and write 
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
