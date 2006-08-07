Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWHGJxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWHGJxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWHGJxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 05:53:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37029 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750753AbWHGJxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 05:53:06 -0400
Message-ID: <44D70D79.1010106@in.ibm.com>
Date: Mon, 07 Aug 2006 15:22:57 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <6bffcb0e0608060409m2cd8fb4er6d7d2300915604c4@mail.gmail.com>
In-Reply-To: <6bffcb0e0608060409m2cd8fb4er6d7d2300915604c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
> 
> On 06/08/06, Andrew Morton <akpm@osdl.org> wrote:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/ 
>>
>>
> 
> I get this error during the build.
> 
> kernel/built-in.o: In function `bacct_add_tsk':
> /usr/src/linux-mm/kernel/tsacct.c:39: undefined reference to `__divdi3'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [_all] Error 2
> 
> I'll try with CONFIG_TASKSTATS disabled.
> 
> Regards,
> Michal
> 

Sounds likes we are trying to do a 64 bit division since timespec_to_ns() 
returns a 64 bit value.

Here's a compile tested patch to fix the problem

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

  kernel/tsacct.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/tsacct.c~tsacct-build-fix kernel/tsacct.c
--- linux-2.6.18-rc3/kernel/tsacct.c~tsacct-build-fix	2006-08-07 
14:20:58.000000000 +0530
+++ linux-2.6.18-rc3-balbir/kernel/tsacct.c	2006-08-07 14:51:44.000000000 +0530
@@ -36,7 +36,8 @@ void bacct_add_tsk(struct taskstats *sta
  	do_posix_clock_monotonic_gettime(&uptime);
  	ts = timespec_sub(uptime, current->group_leader->start_time);
  	/* rebase elapsed time to usec */
-	stats->ac_etime = (timespec_to_ns(&ts))/NSEC_PER_USEC;
+	stats->ac_etime = (ts.tv_sec * USEC_PER_SEC) +
+				(ts.tv_nsec / NSEC_PER_USEC);
  	stats->ac_btime = xtime.tv_sec - ts.tv_sec;
  	if (thread_group_leader(tsk)) {
  		stats->ac_exitcode = tsk->exit_code;
_



-- 
	Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
