Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUJSP6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUJSP6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269476AbUJSP45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:56:57 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6050
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269477AbUJSP4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:56:35 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041019144642.GA6512@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019144642.GA6512@elte.hu>
Content-Type: multipart/mixed; boundary="=-larDdpj4IlAJPRLC46ck"
Organization: linutronix
Message-Id: <1098200916.12223.929.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 17:48:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-larDdpj4IlAJPRLC46ck
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-10-19 at 16:46, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> i've re-released the patch because shortly after releasing it i found a
> false-positive in the deadlock-detector that was triggering in oowriter. 

Hit and converted another one. There are more, but they need more
modifications as they don't have a condition to wait for and therefor
must be converted to use the completion API, which must be extended to
provide completion_timemout() first.

tglx




--=-larDdpj4IlAJPRLC46ck
Content-Disposition: attachment; filename=clnt.c.diff
Content-Type: text/x-patch; name=clnt.c.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U6/net/sunrpc/clnt.c 2.6.9-rc4-mm1-VP-U4-LRT1/net/sunrpc/clnt.c
--- 2.6.9-rc4-mm1-RT-U6/net/sunrpc/clnt.c	2004-10-12 09:32:23.000000000 +0200
+++ 2.6.9-rc4-mm1-VP-U4-LRT1/net/sunrpc/clnt.c	2004-10-19 16:16:29.000000000 +0200
@@ -231,7 +231,8 @@
 		clnt->cl_oneshot = 0;
 		clnt->cl_dead = 0;
 		rpc_killall_tasks(clnt);
-		sleep_on_timeout(&destroy_wait, 1*HZ);
+		wait_event_timeout(destroy_wait, 
+			atomic_read(&clnt->cl_users) > 0, 1*HZ);
 	}
 
 	if (atomic_read(&clnt->cl_users) < 0) {

--=-larDdpj4IlAJPRLC46ck--

