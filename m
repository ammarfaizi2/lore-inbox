Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVGLP7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVGLP7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGLP7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:59:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23033 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261489AbVGLP7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:59:04 -0400
Message-ID: <42D3E852.5060704@mvista.com>
Date: Tue, 12 Jul 2005 08:57:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org, torvalds@osdl.org,
       christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050712121008.GA7804@ucw.cz> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org>
In-Reply-To: <200507122253.03212.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 12 Jul 2005 22:39, Con Kolivas wrote:
> 
>>On Tue, 12 Jul 2005 22:10, Vojtech Pavlik wrote:
>>
>>>The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
>>>and is divided by 12 to get PIT tick rate
>>>
>>>	14.3181818 MHz / 12 = 1193182 Hz

Yes, but the current code uses 1193180.  Wonder why that is...

>>>
>>>The reality is that the crystal is usually off by 50-100 ppm from the
>>>standard value, depending on temperature.
>>>
>>>    HZ   ticks/jiffie  1 second      error (ppm)
>>>---------------------------------------------------
>>>   100      11932      1.000015238      15.2
>>>   200       5966      1.000015238      15.2
>>>   250       4773      1.000057143      57.1
>>>   300       3977      0.999931429     -68.6
>>>   333       3583      0.999964114     -35.9
>>>   500       2386      0.999847619    -152.4
>>>  1000       1193      0.999847619    -152.4

If we are following the standard and trying to set up a timer, the 1 second time 
MUST be >= 1 second.  Thus the values for 300 and above in this table don't fly. 
  If we are trying to keep system time, well we do just fine at that by using 
the actual value of the jiffie (NOT 1/HZ) when we update time (one of the 
reasons for going to nanoseconds in xtime).  The observable thing the user sees 
is best seen by setting up an itimer to repeat every second.  Then you will see 
the drift AND it will be against the system clock which itself is quite accurate 
(the 50-100ppm you mention), even without ntp.  And the error really is in the 
range of 848ppm for HZ=1000 BECAUSE we need to follow the standard.  You can 
easily see this with the current 2.6 kernel.  We even have a bug report on it:

http://bugzilla.kernel.org/show_bug.cgi?id=3289
~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
