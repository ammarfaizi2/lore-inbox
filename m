Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275254AbRIZPQu>; Wed, 26 Sep 2001 11:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275258AbRIZPQl>; Wed, 26 Sep 2001 11:16:41 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:55039 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S275254AbRIZPQc>; Wed, 26 Sep 2001 11:16:32 -0400
Message-ID: <3BB1F0FB.2554ED93@de.ibm.com>
Date: Wed, 26 Sep 2001 17:15:07 +0200
From: Juergen Doelle <jdoelle@de.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Tweedie <sct@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Mark Hemment <markhe@veritas.com>, lse-tech@lists.sourceforge.net,
        "Steve Fox" <stevefx@us.ibm.com>
Subject: Re: [PATCH] Align VM locks, new spinlock patch
X-MIMETrack: Itemize by SMTP Server on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 26/09/2001 17:16:00,
	Serialize by Router on D12ML008/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 26/09/2001 17:16:28,
	Serialize complete at 26/09/2001 17:16:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen C. Tweedie wrote
> Do you have CPU utilisation differences for these cases, as well as
> pure IO bandwidth differences?  It would be interesting to see just
> how much the IO code's internal latency impacts on the final dbench
> numbers.

I created vmstat traces for dbench 22

+-----------------------------------+------------------------------+
| 2.4.10                            | 2.4.10 + spinlock patch      |                                  
+----+----------+-------+-----------+----------+-------+-----------+                       
|time|procs     |  IO   | cpu       |procs     |  IO   | cpu       |      
+    +----------+-------+-----------+----------+-------+-----------+ 
|[s] | r  b   w |  bo/s | us  sy id | r  b   w |  bo/s | us  sy id |    
+----+----------+-------+-----------+----------+-------+-----------+ 
|  1 | 23  0  0 |     0 |  0  14 85 | 22  0  0 |     0 |  1  47 52 |    
|  2 | 22  0  0 |     0 |  2  98  0 | 22  0  0 |     0 |  2  99  0 |     
|  3 | 22  0  0 |     0 |  2  98  0 | 22  0  0 |     0 |  4  97  0 |     
|  4 |  8 14  2 | 11052 | 12  89  0 |  5 17  1 | 20465 | 11  84  5 |     
|  5 |  3 19  1 |  1616 |  1   4 94 | 20  2  6 |  1788 | 16  83  0 |    
|  6 |  1 21  1 |  1760 |  2   4 94 | 22  0  4 |     0 | 18  82  0 |    
|  7 | 23  0  3 |  2852 | 12  46 42 | 22  0  1 |     0 | 19  80  0 |    
|  8 | 22  0  3 |     0 | 15  85  0 | 22  0  0 |     0 | 19  82  0 |     
|  9 | 22  0  2 |     0 | 17  83  0 | 23  0  0 |     0 | 18  82  0 |     
| 10 | 23  0  1 |     0 | 16  84  0 | 22  0  0 |     0 | 17  82  1 |     
| 11 | 22  0  0 |     0 | 14  86  0 | 22  0  0 |     0 | 18  83    |     
| 12 | 22  0  0 |     0 | 16  84  0 | 19  0  0 |     0 | 18  82  0 |     
| 13 | 22  0  0 |     0 | 19  81  1 |  9  0  0 |     0 |  7  94    |     
| 14 | 20  0  0 |     0 | 17  84  0 |  0  0  0 |     0 |  0  30 70 |     
| 15 | 17  0  0 |     0 | 15  85  0 |----------+-------+-----------+     
| 16 | 13  0  0 |     0 |  4  97  0 |      
| 17 | 12  0  0 |     0 |  0 100  0 |      
| 18 |  7  0  0 |     0 |  0  99  0 |      
| 19 |  0  0  0 |     0 |  0  15 85 |     
+----+----------+-------+-----------+
*the empty idle columns originally containing 5315553, treat as '0'

The patch 
o reduces significantly the idle times, the user process wait time
  is much shorter
o reduces the I/O phase to the  half of the time, by much higher rates
o increases the user and decreases the system CPU utilization 

I prior posted lockmeter results on 2.4.5, where this patch reduced 
for 8 CPUs the average spin hold time by about 47% and the total CPU 
utilization spent for spinning by 45%. 
I think it does not influence the device layer directly. It speeds up 
the time spent in critical phases protected with spin locks, when the
number of competitors increases. In case of high competitions caused by
many parallel working processors, the buffer cache and pagecache 
handling gets faster and this increases the number of changed pages per 
second.

Therefore the mechanism used here can also be used to improve 
competitive scenarios for other spin locks.


Juergen

______________________________________________________________
Juergen Doelle
IBM Linux Technology Center - kernel performance
jdoelle@de.ibm.com
