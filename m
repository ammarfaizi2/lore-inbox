Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVGWEkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVGWEkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 00:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVGWEkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 00:40:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:40865 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262327AbVGWEkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 00:40:41 -0400
X-Authenticated: #271361
Date: Sat, 23 Jul 2005 06:40:36 +0200
From: Edgar Toernig <froese@gmx.de>
To: Michael Harris <mharris@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Failure to deliver SIGCHLD
Message-Id: <20050723064036.67407a80.froese@gmx.de>
In-Reply-To: <42E120BF.6090504@torque.net>
References: <42E120BF.6090504@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Harris wrote:
>
> [2.] The problem occurs in a forking server similar in function to
> inetd.  The server employs a very simple SIGCHLD handler that loops on
> wait(2), until all zombie processes have been collected.  For no
> immediately apparent reason, the parent process behaves as if it no
> longer receives SIGCHLD.  Manually sending the signal has no effect.

Sounds like a blocked signal.

> [6.] This is the code for the signal handler in the server application. 
> 
>     void reaper_man (int signum)
>     {
>             int stat;
>             while ( waitpid(-1, &stat, WNOHANG) > 0 );
>     }
> 
>     signal (SIGCHLD, reaper_man);  /* from main() */
>
> I dare say it contains no bugs (famous last words)

It does - it clobbers errno :-)

My suggestions: use sigaction with defined restart/mask/etc behaviour
instead of signal.  Save and restore errno in the signal handler.
Make sure SIGCHLD isn't blocked.

But if your only interest is to get rid of the zombies, the most simple
solution would be to set SIGCHLD to ignore.

Ciao, ET.
