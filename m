Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVE0SE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVE0SE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVE0SE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:04:58 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:62901 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261949AbVE0SEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:04:55 -0400
Subject: Re: disowning a process
From: Steven Rostedt <rostedt@goodmis.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42975945.7040208@davyandbeth.com>
References: <42975945.7040208@davyandbeth.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 14:04:48 -0400
Message-Id: <1117217088.4957.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 12:30 -0500, Davy Durham wrote:
> Hi,  I'm not sure if there's a posix way of doing this, but wanted to 
> check if there is a way in linux.
> 
> I want to have a daemon that fork/execs a new process, but don't want 
> (for various reasons) the responsibility for cleaning up those process 
> with the wait() function family.   I'm assuming that if the init process 
> became the parent of one of these forked processes, then it would clean 
> them up for me (is this assumption true?).    Besides the daemon process 
> exiting, is there a way to disown the process on purpose so that init 
> inherits it?

Try man daemon.

The way I use to do it was simply do a double fork. That is
(simplified)...

if ((pid = fork()) < 0) {
	perror("fork");
} else if (!pid) {
	/* child */
	if ((pid = fork()) < 0) {
		perror("child fork");
		exit(-1);
	} if (pid) {
		/* child parent */
		/* Here we detach from the child */
		exit(0);
	}
	/* Now this code is a child running almost as a daemon
		with init as the parent. */
	setsid();
	/* Now the child is completely detached from the original
	   parent */
	/* ... daemon code here ... */
	exit(0);
}

/* parent code here */

-- Steve


