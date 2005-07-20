Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVGTOeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGTOeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVGTOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:34:24 -0400
Received: from gate.corvil.net ([213.94.219.177]:46085 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261240AbVGTOeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:34:21 -0400
Message-ID: <42DE60D8.2070101@draigBrady.com>
Date: Wed, 20 Jul 2005 15:34:00 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauricio Lin <mauriciolin@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
References: <42CC2923.2030709@draigBrady.com>	 <20050706181623.3729d208.akpm@osdl.org>	 <42CCE737.70802@draigBrady.com>	 <20050707014005.338ea657.akpm@osdl.org>	 <42D39102.5010503@draigBrady.com> <3f250c7105071913091c5b2858@mail.gmail.com>
In-Reply-To: <3f250c7105071913091c5b2858@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin wrote:
> Hi,
> 
> On 7/12/05, P@draigbrady.com <P@draigbrady.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>OK, please let us know how it goes.
>>
>>It went very well. I could find no problems at all.
>>I've updated my script to use the new method, so please merge smaps :)
>>http://www.pixelbeat.org/scripts/ps_mem.py
>>
>>Usually the shared mem reported by /proc/$$/statm
>>is the same as summing all the shared values in in /proc/$$/smaps
>>but there can be large discrepancies.
> 
> 
> Have you checked how the statm shared is calculated? I guess it does
> something like:
> shared = mm->rss - mm->anon_rss

yes

> But in smaps output you can have anonymous area like:
> 
> b6e0e000-b6e13000 rw-p
> Size:                20 KB
> Rss:                  4 KB
> Shared_Clean:         0 KB
> Shared_Dirty:         4 KB
> Private_Clean:        0 KB
> Private_Dirty:        0 KB
> 
> Look that it presents 4 KB of shared value in area considered anonymous.
> 
> ANDREW: anon_rss is the rss for anonymous area, right?

I see your point and I'm not sure.
The following shell gets the shared values for the
first httpd process:

FIRST_HTTPD=`ps -C httpd -o pid= | head -1 | tr -d ' '`
HTTPD_STATM_SHARED=$(expr 4 '*' `cut -f3 -d' ' /proc/$FIRST_HTTPD/statm`)
HTTPD_SMAPS_SHARED=$(grep Shared /proc/$FIRST_HTTPD/smaps | tr -s ' ' 
| cut -f2 -d' ' | ( tr '\n' +; echo 0 ) | bc)
 

This shows that "smaps" reports 3060 KB more shared mem than "statm".
However adding up all the anon sections in smaps only gives 2456 KB?

When doing this I also noticed that there are duplicate
entries in smaps. Any ideas why?

grep -F - /proc/$FIRST_HTTPD/smaps | sort | uniq -d -c

       2 b7f7d000-b7f7e000 r-xp 00000000 03:05 246646 
/usr/lib/httpd/modules/mod_auth_anon.so
       2 b7f7e000-b7f7f000 rwxp 00000000 03:05 246646 
/usr/lib/httpd/modules/mod_auth_anon.so
       2 b7f7f000-b7f81000 r-xp 00000000 03:05 246645 
/usr/lib/httpd/modules/mod_auth.so
       2 b7f81000-b7f82000 rwxp 00001000 03:05 246645 
/usr/lib/httpd/modules/mod_auth.so
       2 b7f82000-b7f84000 r-xp 00000000 03:05 246641 
/usr/lib/httpd/modules/mod_access.so
       2 b7f84000-b7f85000 rwxp 00001000 03:05 246641 
/usr/lib/httpd/modules/mod_access.so
       2 b7f85000-b7f9a000 r-xp 00000000 03:05 361234     /lib/ld-2.3.3.so
       2 b7f9a000-b7f9b000 r-xp 00014000 03:05 361234     /lib/ld-2.3.3.so
       2 b7f9b000-b7f9c000 rwxp 00015000 03:05 361234     /lib/ld-2.3.3.so
       2 bfb85000-bfb9a000 rw-p bfb85000 00:00 0          [stack]
       2 ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

If you factor that in, it means that smaps will report 156 KB
too much shared mem in this example.

>>In the real world you can see this with a newly started apache.
>>On my system statm reported that apache was using 35MB,
>>whereas smaps reported the correct amount of 11MB.
> 
> 
> How dou you know that 11MB is the correct shared value  and the 35MB
> is the wrong value?

Well I'm quite sure that COW pages ar not accounted for
in the statm shared value, which can be easily seen with
my previously posted test program. Also putting the machine
into swap, and then using httpd again causes the value reported
to be very close to 11MB (i.e. the unused pages are not swapped
back in).

-- 
Pádraig Brady - http://www.pixelbeat.org
--
