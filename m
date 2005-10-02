Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVJBOQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVJBOQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 10:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVJBOQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 10:16:57 -0400
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:33506 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S1751099AbVJBOQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 10:16:56 -0400
Date: Sun, 2 Oct 2005 22:16:37 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Ed Tomlinson <tomlins@cam.org>
Cc: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051002141637.GC5211@blackham.com.au>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl> <20051002045315.GA20946@ucc.gu.uwa.edu.au> <200510020857.27065.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510020857.27065.tomlins@cam.org>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 08:57:26AM -0400, Ed Tomlinson wrote:
> Is there any kernel api that adding would make cryopid more
> dependable/cleaner?

Currently a fair bit of information is obtained by injecting code
into the process's memory space, executing it, and reaping out the
results (eg, termcaps, file offsets, fcntl states, locks, signal
actions, etc).  Can't think of ways to make it cleaner off the top
of my head, but I'm open to ideas.

Seeing as you asked though, here's my wishlist :) I don't expect all
of these to be implemented, but every bit would help. Issues I
haven't been able to address so far:

 - Processes that cache their PID and need it, or rely on PIDs of
   their children.

   Some way to request a given PID when cloning/forking (or on the
   fly even) would make life easier.

 - UNIX sockets aren't currently supported but figuring out what is
   connected to what seems a little shaky. Some old code used to
   take a guess that socketpairs had inodes k and k+1 with k odd,
   which seemed to work in all cases I saw. It certainly didn't feel
   reliable though.
   
   An extra field in /proc/net/unix saying what inode socket was on
   the other end (only needed for the connect() end) would be great.

 - Setting cmdline as appears in /proc/$pid/cmdline. argv and
   environ point somewhere into the process's stack determined by
   the size of argv and environ at exec time. Without va space
   randomisation in the picture, it's not too difficult to reproduce
   this and get it back where it should be (it's a hack though), but
   with va space randomisation it's pretty much impossible.

   An API to change the actual memory location of this (task's
   mm->arg_start) would be handy (prctl maybe?)

 - Merging tcpcp for TCP connection saving support.

 - I haven't put a great deal of thought into the multithreading
   side of things, but a non-intrusive way to determine which
   threads share filesystem contexts, FDs, namespaces, VMAs, and so
   on would be infinitely useful. My current plan of attack was to
   tinker with one and see if I could observe it from the others.

That's all I can think of for now. If any of these look even
remotely plausible to incorporate, I'd be quite happy to prepare
patches (2 and 3 seem trivial enough :)

Kind regards,

Bernard.
