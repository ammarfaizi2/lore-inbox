Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSHFUDu>; Tue, 6 Aug 2002 16:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSHFUDt>; Tue, 6 Aug 2002 16:03:49 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:34552 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315485AbSHFUDs>; Tue, 6 Aug 2002 16:03:48 -0400
Date: Tue, 6 Aug 2002 16:07:24 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: AIO together with SMPtimers-A0 oops and freezing
Message-ID: <20020806160724.A19564@redhat.com>
References: <200208051920.29018.mcp@linux-systeme.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208051920.29018.mcp@linux-systeme.de>; from mcp@linux-systeme.de on Mon, Aug 05, 2002 at 07:20:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 07:20:29PM +0200, Marc-Christian Petersen wrote:
> Hi Ben, Hi Ingo,

> Ben, I am using your AIO 20020619 patch + relevant fixes from the AIO 
> mailinglist together with your patch Ingo, SMPtimers-A0.

Hmmm, the only problem I can see in the aio code wrt timer usage is 
the following.  Does this patch make a difference?  If not, I'm guessing 
that the problem is something in SMPtimers-A0 that aio happens to 
trigger.  The only timer aio uses is for the timeout when waiting for an 
event, and the structure for that is put on the stack.

		-ben


Index: aio.c
===================================================================
RCS file: /bcrl/cvs/CVSROOT/net-aio/linux/fs/aio.c,v
retrieving revision 1.13
diff -u -u -r1.13 aio.c
--- aio.c	6 Aug 2002 20:02:23 -0000	1.13
+++ aio.c	6 Aug 2002 20:04:40 -0000
@@ -774,8 +774,10 @@
 			goto out;
 
 		set_timeout(&to, &ts);
-		if (to.timed_out)
+		if (to.timed_out) {
 			timeout = 0;
+			clear_timeout(&to);
+		}
 	}
 
 	while (likely(i < nr)) {
