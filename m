Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbTGURQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbTGUROC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:14:02 -0400
Received: from [128.2.206.88] ([128.2.206.88]:54985 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S270655AbTGURMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:12:45 -0400
Date: Mon, 21 Jul 2003 13:27:06 -0400
To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes.)
Message-ID: <20030721172656.GA32597@delft.aura.cs.cmu.edu>
Mail-Followup-To: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>,
	linux-kernel@vger.kernel.org
References: <5df3060bad.60bad5df30@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df3060bad.60bad5df30@teleline.es>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 07:04:29PM +0200, RAMON_GARCIA_F wrote:
> And that is exactly the reason why I like the interface that I designed.
> As opposed to transfer of handles through unix domain sockets, that is
> tied to unix sockets, my interface is more primitive. It is not tied to
> anything. You get a representation of a file handle, and then you can
> transfer it through a regular file, a pipe, ...

There are many arguments against it.

- Cookies are only useful on the local system, files, pipes, tcpsockets
  etc. are cross-platform.

- Refcounting issues, a rogue application can quickle use up kernel
  resources by requesting thousands of cookies, he isn't even limited by
  per-process resource limits, as it is possible to open a file, grab a
  cookie, and close the file. The only 'solution' you have is a timeout
  on the cookie, possibly this could be extended by some scheme where
  cookies are dropped more agressivly. But any such solution will either
  not be sufficient to protect the system from resource exhaustion or
  provide the opportunity for denial of service attacks.

- Technically the SCM_RIGHTS message that is passed across the
  socketpair(2) or Unix domain socket contains pretty much the cookie
  you are talking about, but it has several useful properties. The
  process is required to keep the filehandle open until the message is
  passed, so it has to obey per-process resource limits. There is strict
  refcounting and no workarounds required to expire handles, the
  SCM_RIGHTS method is portable across pretty much all Unix systems.

- It is trivial to implement your proposal in userspace based on the
  existing primitives (simple library + daemon solution). But it is not
  possible to implement the exact semantics of the existing primitives
  in userspace if they are replaced by your proposed cookies in the
  kernel.

Jan
