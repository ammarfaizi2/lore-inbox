Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVE2W5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVE2W5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVE2W5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 18:57:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:50618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261463AbVE2W5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 18:57:41 -0400
Date: Sun, 29 May 2005 15:59:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
In-Reply-To: <1117399764.9619.12.camel@localhost>
Message-ID: <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>  <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
  <84144f0205052911202863ecd5@mail.gmail.com>  <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
 <1117399764.9619.12.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 May 2005, Pekka Enberg wrote:
> 
> The mouse cursor does not move and the screen does not refresh. The
> machine locks up completely for few seconds (actually more like 5-10 s)
> and then the system comes back up (after which it can be used normally).
> I cannot even switch virtual consoles. Please note that I can
> immediately reproduce the problem again as many times as I want by doing
> the test scenario.

The thing is, your sysrq-P output clearly shows that it's all in wine, and 
I'd be very surprised if this is not a codeweavers/wine bug. The pipe poll 
code is literally a couple of lines long, and it's hard to introduce a bug 
there. Especially a transient bug that goes away.

However, I don't understand how wine can block the X server from doing 
even cursor updates. It might be a scheduler bug, of course. The one thing 
a bigger pipe buffer does is end up changing scheduling behaviour. 

(On the other hand, I would not be surprised if Wine does something that 
makes X pause, like use DGA or whatever and tells X not to update the 
screen, including cursors).

> Is it possible that your changes for pipes to fill up to 64 KB confuses
> pipe_poll and friends?

pipe_poll shouldn't get confused, but apps certainly could. If an app 
"knows" that a pipe read can only return 4kB of data, it would obviously 
get confused when that's no longer true.

> The funny thing is that when I am stracing (and
> thus not hitting the problem), I do not see _any_ calls to sys_poll but
> when I _do_ hit the bug, pipe_poll clearly shows up in oprofile.

Are you sure your oprofile PC map is correct? 

		Linus
