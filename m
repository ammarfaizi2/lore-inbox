Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422766AbWGJSyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422766AbWGJSyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbWGJSyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:54:36 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:31980 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1422766AbWGJSyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:54:35 -0400
Date: Mon, 10 Jul 2006 14:54:35 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
Message-ID: <20060710185435.GA5445@ccure.user-mode-linux.org>
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com> <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com> <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 10:00:37AM -0700, Joshua Hudson wrote:
> Yes, I use vfork. So far, the only way I have found for the parent to
> know whether or not the child's exec() failed is this way:

What I do in UML is make a pipe between the parent and child, set it
CLOEXEC, and write a byte down it if the exec fails.

The parent reads it - if it gets no bytes, the exec succeeded, if it
gets one byte, it failed.

child -
	execvp(argv[0], argv);
	errval = errno;
	write(data->fd, &errval, sizeof(errval));

parent -
	socketpair(AF_UNIX, SOCK_STREAM, 0, fds);
	fcntl(fds[1], F_SETFD, flag);
	pid = clone(child, NULL, SIGCHLD, NULL);
	if(pid < 0){
		...
	}

	close(fds[1]);

	/* Read the errno value from the child, if the exec failed, or get 0 if
	 * the exec succeeded because the pipe fd was set as close-on-exec.
	 */
	n = read(fds[0], &ret, sizeof(ret));
	if (n < 0) {
	} else if(n != 0){
		/* exec failed */
	} else {
		/* exec succeeded */
	}

				Jeff
