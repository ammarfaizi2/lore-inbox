Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSJYURq>; Fri, 25 Oct 2002 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSJYURq>; Fri, 25 Oct 2002 16:17:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:47535 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261585AbSJYURo>;
	Fri, 25 Oct 2002 16:17:44 -0400
Message-ID: <3DB9A84F.9040506@colorfullife.com>
Date: Fri, 25 Oct 2002 22:23:43 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cmm@us.ibm.com
CC: Paul Larson <plars@linuxtestproject.org>, Andrew Morton <akpm@digeo.com>,
       Hugh Dickins <hugh@veritas.com>, lkml <linux-kernel@vger.kernel.org>,
       dipankar@in.ibm.com, lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>		<3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com> 		<3DB880E8.747C7EEC@us.ibm.com> <1035555715.3447.150.camel@plars> 		<3DB97C90.2DF810E6@us.ibm.com> <1035570043.5646.191.camel@plars> <3DB992B7.E8919930@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080304000809090204080808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080304000809090204080808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

mingming cao wrote:

>Here is what I saw:
>
>[root@elm3b83 shmctl]# ./shmctl01
>shmctl01    1  PASS  :  pid, size, # of attaches and mode are correct -
>pass #1
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    0  INFO  :  shmdt() failed - 22
>
These failures are caused by a bug in the ltp test. See the attached patch.

>shmctl01    2  PASS  :  pid, size, # of attaches and mode are correct -
>pass #2
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    0  INFO  :  shmdt() failed - 22
>shmctl01    3  FAIL  :  # of attaches is incorrect - 0
>
This one is odd. The testcase contains races, but they can only increase 
# of attaches.
Could you strace shmctl01?
The testcase with shmat(), then fork() fails.

--
    Manfred

--------------080304000809090204080808
Content-Type: text/plain;
 name="patch-ltp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ltp"

diff -u ltp-orig/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c ltp-20021008/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
--- ltp-orig/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c	Tue May 21 15:55:56 2002
+++ ltp-20021008/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c	Fri Oct 25 22:14:23 2002
@@ -252,10 +252,12 @@
 
 			if (stat_time == FIRST) {
 				test = set_shmat();
+			} else {
+				test = set_shared;
 			}
 
 			/* do an assignement for fun */
-			(int *)test = i;
+			*(int *)test = i;
 
 			/* pause until we get a signal from stat_cleanup() */
 			rval = pause();
@@ -273,7 +275,7 @@
 		}
 	}
 	/* sleep briefly to ensure correct execution order */
-	usleep(25000);
+	usleep(250000);
 }
 
 /*

--------------080304000809090204080808--

