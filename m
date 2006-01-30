Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWA3Iun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWA3Iun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWA3Iun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:50:43 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:61452 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932133AbWA3Ium (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:50:42 -0500
Message-ID: <43DDD359.8090000@symas.com>
Date: Mon, 30 Jan 2006 00:50:33 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43DDD1DA.6060507@aitel.hist.no>
In-Reply-To: <43DDD1DA.6060507@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> linux-os (Dick Johnson) wrote:
>
>> To fix the current problem, you can substitute usleep(0); It will
>> give the CPU to somebody if it's computable, then give it back to
>> you. It seems to work in every case that sched_yield() has
>> mucked up (perhaps 20 to 30 here).
>>  
>>
> Isn't that dangerous?  Someday, someone working on linux (or some
> other unixish os) might come up with an usleep implementation where
> usleep(0) just returns and becomes a no-op.  Which probably is ok
> with the usleep spec - it did sleep for zero time . . .
>
We actually experimented with usleep(0) and select(...) with a zeroed 
timeval. Both of these approaches performed worse than just using 
sched_yield(), depending on the system and some other conditions. 
Dual-core AMD64 vs single-CPU had quite different behaviors. Also, if 
the slapd main event loop was using epoll() instead of select(), the 
select's used for yields slowed down by a couple orders of magnitude. (A 
test that normally took ~30 seconds took as long as 45 minutes in one 
case, it was quite erratic.)

It turned out that most of those yield's were leftovers inherited from 
when we only supported non-preemptive threads, and simply deleting them 
was the best approach.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

