Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbRFGTUE>; Thu, 7 Jun 2001 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262998AbRFGTTy>; Thu, 7 Jun 2001 15:19:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41738 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262915AbRFGTTe>; Thu, 7 Jun 2001 15:19:34 -0400
Date: Thu, 7 Jun 2001 14:43:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Please test: workaround to help swapoff behaviour 
In-Reply-To: <Pine.LNX.4.21.0106071410090.1156-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0106071441270.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Marcelo Tosatti wrote:

> 
> On Thu, 7 Jun 2001, Mike Galbraith wrote:
> 
> > On 6 Jun 2001, Eric W. Biederman wrote:
> > 
> > > Mike Galbraith <mikeg@wen-online.de> writes:
> > >
> > > > > If you could confirm this by calling swapoff sometime other than at
> > > > > reboot time.  That might help.  Say by running top on the console.
> > > >
> > > > The thing goes comatose here too. SCHED_RR vmstat doesn't run, console
> > > > switch is nogo...
> > > >
> > > > After running his memory hog, swapoff took 18 seconds.  I hacked a
> > > > bleeder valve for dead swap pages, and it dropped to 4 seconds.. still
> > > > utterly comatose for those 4 seconds though.
> > >
> > > At the top of the while(1) loop in try_to_unuse what happens if you put in.
> > > if (need_resched) schedule();
> > > It should be outside all of the locks.  It might just be a matter of everything
> > > serializing on the SMP locks, and the kernel refusing to preempt itself.
> > 
> > That did it.
> 
> What about including this workaround in the kernel ? 

Well, 

This is for the people who has been experiencing the lockups while running
swapoff.

Please test. (against 2.4.6-pre1)

Thanks for the suggestion, Eric. 


--- linux.orig/mm/swapfile.c	Wed Jun  6 18:16:45 2001
+++ linux/mm/swapfile.c	Thu Jun  7 16:06:11 2001
@@ -345,6 +345,8 @@
 		/*
 		 * Find a swap page in use and read it in.
 		 */
+		if (current->need_resched)
+			schedule();
 		swap_device_lock(si);
 		for (i = 1; i < si->max ; i++) {
 			if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD) {

