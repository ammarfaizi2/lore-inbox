Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267462AbUHMUMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267462AbUHMUMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUHMUIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:08:54 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:20201 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S267411AbUHMUGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:06:05 -0400
Date: Fri, 13 Aug 2004 22:06:04 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>, Torin Ford <code-monkey@qwest.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x Fork Problem?
Message-ID: <20040813200604.GA18862@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Jesse Pollard <jesse@cats-chateau.net>,
	Torin Ford <code-monkey@qwest.net>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <006101c47fff$8feedac0$0200000a@torin> <04081209262700.19998@tabby> <20040813190958.GB18563@janus> <Pine.LNX.4.53.0408131521550.26183@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408131521550.26183@chaos>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 03:36:34PM -0400, Richard B. Johnson wrote:
> 
> In the above code there is something missing. in the code shown,
> the child __will__ wait in exit() until somebody claims its status.
> However, the child probably did a setsid(), becoming a process-leader
> or the parent set up a SIGCHLD handler before the fork. In these
> cases, the exit() will quickly exit because somebody will claim
> the exit status.
> 
> So, by the time the parent gets the CPU, the child is long gone.
> The solution is to use the default SIGCHLD handler if the parent
> expects to get the child's status and for the child to not execute
> setsid(), which will allow init to reap its status.

AFAIK a child doing setsid() has no effect whatsoever on any wait*()
done by the parent. It just sets a new session leader.

But SIGCHLD set to SIG_IGN instead of SIG_DFL is a perfect explanation.
Rereading alan's reply I suddenly got it: "random status" didn't refer
to the &status arg but to the signal status. SIG_IGN is inherited I
guess so a

	signal(SIGCHLD, SIG_DFL);

once before the fork() should fix it. Hmm, so actually our parent should
have reset SIGCHLD before exec'ing this code. This could cause more
problems.

-- 
Frank
