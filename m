Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbVINU3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbVINU3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbVINU3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:29:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24775
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932765AbVINU3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:29:43 -0400
Date: Wed, 14 Sep 2005 13:29:36 -0700 (PDT)
Message-Id: <20050914.132936.105214487.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Brown paper bag in fs/file.c?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050914201550.GB6315@in.ibm.com>
References: <20050914191842.GA6315@in.ibm.com>
	<20050914.125750.05416211.davem@davemloft.net>
	<20050914201550.GB6315@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Thu, 15 Sep 2005 01:45:50 +0530

> Are you running with preemption enabled ? If so, fyi, I had sent
> out a patch earlier that fixes locking for preemption.
> Also, what triggers this in your machine ? I can try to reproduce
> this albeit on a non-sparc64 box.

No PREEMPT enabled.

I believe this bug has been around since before your RCU
changes, I've been seeing it for about half a year.

My test case is, on a uniprocessor with 1GB of ram, run the
following in parallel:

1) In one window, do a plain kernel build of 2.6.x

2) In another window, in a temporary directory, run this shell code:

	while [ 1 ]
        do
            rm -rf .git *
	    cp -a ../linux-2.6/.git .
	    git-checkout-cache -a
	    git-update-cache --refresh
	    echo "Finished one pass..."
	done

Adjust the path to a vanilla 2.6.x ".git" directory in #2 as needed.

Sometimes this can trigger in less than a minute.  Other times it
takes 5 or 6 minutes, but other than this variance it is rather
reliable.

I think the key is to make sure you don't have any more than 1GB of
ram for this on a 64-bit box, so that there is sufficient memory
pressure from all of the ext3 writebacks and other fs activity in
order to shrink the file table SLABs and thus liberate the pages.
