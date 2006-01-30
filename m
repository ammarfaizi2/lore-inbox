Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWA3PeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWA3PeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWA3PeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:34:01 -0500
Received: from smtpout.mac.com ([17.250.248.87]:9972 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932332AbWA3PeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:34:00 -0500
In-Reply-To: <43DDD359.8090000@symas.com>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43DDD1DA.6060507@aitel.hist.no> <43DDD359.8090000@symas.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <461FB690-4F18-409D-BC0A-6A3CC1F8312C@mac.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Mon, 30 Jan 2006 10:33:34 -0500
To: Howard Chu <hyc@symas.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2006, at 03:50, Howard Chu wrote:
> Helge Hafting wrote:
>> linux-os (Dick Johnson) wrote:
>>> To fix the current problem, you can substitute usleep(0); It will  
>>> give the CPU to somebody if it's computable, then give it back to  
>>> you. It seems to work in every case that sched_yield() has mucked  
>>> up (perhaps 20 to 30 here).
>>
>> Isn't that dangerous?  Someday, someone working on linux (or some  
>> other unixish os) might come up with an usleep implementation  
>> where usleep(0) just returns and becomes a no-op.  Which probably  
>> is ok with the usleep spec - it did sleep for zero time . . .
>
> We actually experimented with usleep(0) and select(...) with a  
> zeroed timeval. Both of these approaches performed worse than just  
> using sched_yield(), depending on the system and some other  
> conditions. Dual-core AMD64 vs single-CPU had quite different  
> behaviors. Also, if the slapd main event loop was using epoll()  
> instead of select(), the select's used for yields slowed down by a  
> couple orders of magnitude. (A test that normally took ~30 seconds  
> took as long as 45 minutes in one case, it was quite erratic.)
>
> It turned out that most of those yield's were leftovers inherited  
> from when we only supported non-preemptive threads, and simply  
> deleting them was the best approach.

I would argue that in a non realtime environment sched_yield() is not  
useful at all.  When you want to wait for another process, you wait  
explicitly for that process using one of the various POSIX-defined  
methods, such as mutexes, condition variables, etc.  There are very  
clearly and thoroughly defined ways to wait for other processes to  
complete work, why rely on usleep(0) giving CPU to some other task  
when you can explicitly tell the scheduler "I am waiting for task foo  
to release this mutex" or "I can't run until somebody signals this  
condition variable".

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that would also stop them from doing clever things.
   -- Doug Gwyn


