Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267621AbUHMWvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267621AbUHMWvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUHMWvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:51:45 -0400
Received: from 208-45-116-58.bois.qwest.net ([208.45.116.58]:24669 "EHLO
	torin.torford.com") by vger.kernel.org with ESMTP id S267621AbUHMWvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:51:42 -0400
Date: Fri, 13 Aug 2004 16:50:57 -0600 (MDT)
From: Torin Ford <torinf@qwest.net>
X-X-Sender: tford@torin.torford.com
Reply-To: Torin Ford <torinf@qwest.net>
To: Frank van Maarseveen <frankvm@xs4all.nl>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Torin Ford <code-monkey@qwest.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x Fork Problem?
In-Reply-To: <20040813200604.GA18862@janus>
Message-ID: <Pine.LNX.4.58.0408131649040.1914@torin.torford.com>
References: <006101c47fff$8feedac0$0200000a@torin> <04081209262700.19998@tabby>
 <20040813190958.GB18563@janus> <Pine.LNX.4.53.0408131521550.26183@chaos>
 <20040813200604.GA18862@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, Frank van Maarseveen wrote:

> On Fri, Aug 13, 2004 at 03:36:34PM -0400, Richard B. Johnson wrote:
> > 
> > In the above code there is something missing. in the code shown,
> > the child __will__ wait in exit() until somebody claims its status.
> > However, the child probably did a setsid(), becoming a process-leader
> > or the parent set up a SIGCHLD handler before the fork. In these
> > cases, the exit() will quickly exit because somebody will claim
> > the exit status.
> > 
> > So, by the time the parent gets the CPU, the child is long gone.
> > The solution is to use the default SIGCHLD handler if the parent
> > expects to get the child's status and for the child to not execute
> > setsid(), which will allow init to reap its status.
> 
> AFAIK a child doing setsid() has no effect whatsoever on any wait*()
> done by the parent. It just sets a new session leader.
> 
> But SIGCHLD set to SIG_IGN instead of SIG_DFL is a perfect explanation.
> Rereading alan's reply I suddenly got it: "random status" didn't refer
> to the &status arg but to the signal status. SIG_IGN is inherited I
> guess so a
> 
> 	signal(SIGCHLD, SIG_DFL);
> 
> once before the fork() should fix it. Hmm, so actually our parent should
> have reset SIGCHLD before exec'ing this code. This could cause more
> problems.
> 
> 

Thanks to everyone for their responses.  Alan and others were correct in 
that we needed to change the signal handler for SIGCHLD.  If I remember 
correctly, apache changes the signal handler for SIGCHLD, so we would have 
inherited those signal handlers from apache.  Adding a signal(SIGCHLD, 
SIG_DFL) before the fork fixed the problem for us.

Torin Ford
Venturi Technology Partners
