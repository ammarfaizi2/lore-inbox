Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUDPAoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 20:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUDPAoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 20:44:55 -0400
Received: from mail.cyclades.com ([64.186.161.6]:47292 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261161AbUDPAov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 20:44:51 -0400
Date: Thu, 15 Apr 2004 21:10:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-ID: <20040416001028.GA1373@logos.cnet>
References: <407A2DAC.3080802@redhat.com> <20040415145350.GF2085@logos.cnet> <20040415122411.0bcb9195.akpm@osdl.org> <20040415195430.GB3568@logos.cnet> <20040415214632.GA4402@logos.cnet> <20040415155408.0902a0c0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20040415155408.0902a0c0.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Andrew!

On Thu, Apr 15, 2004 at 03:54:08PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > This adds a new "RLIMIT_SIGPENDING" limit, which is used to limit
> > per-uid pending signals. Currently an unpriviledged user can queue 
> > more than maximum of allowed signals and cause overall system 
> > malfunction.
> 
> So now it takes two users to gang up and do the same thing.  

Decrease rlim_cur then. Usually people dont have several accounts 
on the same box.

> We should either exempt root from the global check or simply remove the global > limit
> altogether.

Then allow for unlimited pending signals? Are you sure?

> Is it possible for a process to do setuid() with outstanding signals?  If
> so, they may end up with a negative current->user->signal_pending?

Nice catch, root can do that and I think current->user->signal_pending can get
negative. Not completly sure though.

> You need to initialise ->signal_pending in alloc_uid().

--- signal.c.orig	2004-04-15 20:44:17.458438104 -0300
+++ signal.c	2004-04-15 20:45:36.850368696 -0300
@@ -288,7 +288,8 @@
 		return;
 	kmem_cache_free(sigqueue_cachep, q);
 	atomic_dec(&nr_queued_signals);
-	atomic_dec(&current->user->signal_pending);
+	if (atomic_read(&current->user->signal_pending) > 0)
+		atomic_dec(&current->user->signal_pending);
 }
 
 static void flush_sigqueue(struct sigpending *queue)
--- user.c.orig	2004-04-15 20:44:20.395991528 -0300
+++ user.c	2004-04-15 20:44:37.069456776 -0300
@@ -98,6 +98,7 @@
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		atomic_set(&new->signal_pending, 0);
 
 		/*
 		 * Before adding this, check whether we raced

> What are you doing for testing of this?

Simple app posted by Nikita (attached) together with MySQL and 
sql-bench for creating mysql threads.
The setuid() was added by me now.


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="signal.c"

#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
                                                                                                                                                                                    
int main()
{
        sigset_t set;
        int i;
        pid_t pid;
                                                                                                                                                                                    
        sigemptyset(&set);
        sigaddset(&set, 40);
        sigprocmask(SIG_BLOCK, &set, 0);
                                                                                                                                                                                    
        pid = getpid();
        for (i = 0; i < 1024; i++)
                kill(pid, 40);

	setuid(500);

        while (1)
                sleep(1);
}

--ReaqsoxgOBHFXBhH--
