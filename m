Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUB2Wca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUB2Wc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 17:32:29 -0500
Received: from holomorphy.com ([199.26.172.102]:3084 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262182AbUB2Wb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 17:31:59 -0500
Date: Sun, 29 Feb 2004 14:31:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jochen Roemling <jochen@roemling.net>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040229223153.GJ655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@osdl.org>
References: <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net> <403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com> <403E9E54.6030404@roemling.net> <20040227021101.GV693@holomorphy.com> <40425BA2.6030905@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40425BA2.6030905@roemling.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It's capable(CAP_IPC_LOCK) || in_group_p(0), not current->uid == 0.
>> It will barf if you ask for more than either one of those limits. It
>> will also barf if you ask for an amount not a multiple of the hugepage
>> size. Please show the test program's code and strace the test program
>> to determine what response it's getting.

On Sun, Feb 29, 2004 at 10:37:38PM +0100, Jochen Roemling wrote:
> What do I have to do to make this pgm run as an ordinary user with a 
> stock kernel?

Locked memory is a privileged resource, so you do have to do something
to authenticate lest any user be able to consume all memory on your
system with no possibility of paging it. Examples of what to do to
acquire locked memory specifically for hugetlb shm segments in mainline:

(a) give the user gid 0 as a primary or supplementary group
(b) grant the capability -- yes, it can be done (and is being done in
	practice elsewhere), something is going wrong on your end I
	haven't been able to diagnose.
(c) make requests from a shmget() proxy daemon where you make requests
	over a socket and it hands back shm segment ID's that have had
	their uid's/perms set to the end user. Once shmget() is done,
	shmat() uses normal shm permissions checks.
(d) use a setuid root shmget() helper app.
(e) launch as root, then retain capabilities
(f) launch as root and shmget before dropping privs

(e) and (f) are probably not options in your case. I can't predict
what's going to be desirable on your end in general. You will have to
jump through a hoop of some kind, though, and be glad you do, since
otherwise unbounded amounts of locked memory requested by arbitrary
users could cripple the system's performance or worse.


-- wli
