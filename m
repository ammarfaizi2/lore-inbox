Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVDONDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVDONDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 09:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDONDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 09:03:34 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:18292 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261791AbVDONDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 09:03:30 -0400
Message-ID: <425FBB98.2000200@yahoo.com.au>
Date: Fri, 15 Apr 2005 23:03:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix sched domain degenerate
References: <20050413192616.A28163@unix-os.sc.intel.com>
In-Reply-To: <20050413192616.A28163@unix-os.sc.intel.com>
Content-Type: multipart/mixed;
 boundary="------------040708070705090000050803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708070705090000050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Siddha, Suresh B wrote:
> Appended patch makes sched domain degenerate really work.
> 
> For example, now NUMA domain really gets removed on a non-NUMA system.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> 
> --- linux-2.6.12-rc2-mm3/kernel/sched.c	2005-04-13 11:15:00.942609504 -0700
> +++ linux-mc/kernel/sched.c	2005-04-13 10:44:37.400829992 -0700
> @@ -4777,7 +4777,7 @@ static int __devinit sd_parent_degenerat
>  	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
>  	if (cflags & SD_WAKE_AFFINE)
>  		pflags &= ~SD_WAKE_BALANCE;
> -	if ((~sd->flags) & parent->flags)
> +	if (~cflags & pflags)
>  		return 0;
>  
>  	return 1;

Thanks, I need a brown paper bag.

I think instead of the other 2 hunks in your patch I would like
to do it the following way (I hope I get this right, finally).

-- 
SUSE Labs, Novell Inc.

--------------040708070705090000050803
Content-Type: text/plain;
 name="sched-degen-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-degen-fix.patch"

Make sched-remove-degenerate-domains.patch actually work.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


Catch more (hopefully all) cases.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-15 22:52:25.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-15 22:58:54.000000000 +1000
@@ -4844,7 +4844,14 @@ static int __devinit sd_parent_degenerat
 	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
 	if (cflags & SD_WAKE_AFFINE)
 		pflags &= ~SD_WAKE_BALANCE;
-	if ((~sd->flags) & parent->flags)
+	/* Flags needing groups don't count if only 1 group in parent */
+	if (parent->groups == parent->groups->next) {
+		pflags &= ~(SD_LOAD_BALANCE |
+				SD_BALANCE_NEWIDLE |
+				SD_BALANCE_FORK |
+				SD_BALANCE_EXEC);
+	}
+	if (~cflags & pflags)
 		return 0;
 
 	return 1;

--------------040708070705090000050803--

