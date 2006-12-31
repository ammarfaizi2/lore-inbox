Return-Path: <linux-kernel-owner+w=401wt.eu-S932764AbWLaTqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWLaTqD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 14:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWLaTqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 14:46:01 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31011 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbWLaTqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 14:46:00 -0500
Subject: Re: [BUG 2.6.20-rc2-mm1] init segfaults when
	CONFIG_PROFILE_LIKELY=y
From: Daniel Walker <dwalker@mvista.com>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: Hua Zhong <hzhong@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu, johnstul@us.ibm.com
In-Reply-To: <20061231150422.GA5285@mail.ustc.edu.cn>
References: <20061231150422.GA5285@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Sun, 31 Dec 2006 11:45:09 -0800
Message-Id: <1167594309.14081.79.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 23:04 +0800, Fengguang Wu wrote:
> Hi,
> 
> The following messages keeps popping up when CONFIG_PROFILE_LIKELY=y:
> 
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> 


Does this seem like an appropriate solution? This just reconstitutes
Ingo's patch by removing the unlikely calls that got added recently. 

Maybe a comment into vsyscall.c that says to stay away from all macro's
and possible debug code that could be added might be helpful ?

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 arch/x86_64/kernel/vsyscall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux-2.6.19.orig/arch/x86_64/kernel/vsyscall.c
+++ linux-2.6.19/arch/x86_64/kernel/vsyscall.c
@@ -111,7 +111,7 @@ static __always_inline void do_vgettimeo
 		seq = read_seqbegin(&__vsyscall_gtod_data.lock);
 
 		vread = __vsyscall_gtod_data.clock.vread;
-		if (unlikely(!__vsyscall_gtod_data.sysctl_enabled || !vread)) {
+		if (!__vsyscall_gtod_data.sysctl_enabled || !vread) {
 			gettimeofday(tv,0);
 			return;
 		}
@@ -151,7 +151,7 @@ int __vsyscall(0) vgettimeofday(struct t
  * unlikely */
 time_t __vsyscall(1) vtime(time_t *t)
 {
-	if (unlikely(!__vsyscall_gtod_data.sysctl_enabled))
+	if (!__vsyscall_gtod_data.sysctl_enabled)
 		return time_syscall(t);
 	else if (t)
 		*t = __vsyscall_gtod_data.wall_time_tv.tv_sec;


