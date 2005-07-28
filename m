Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVG1Tne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVG1Tne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVG1Tnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:43:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261174AbVG1TnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:43:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <42B02004.6020306@xfs.org> 
References: <42B02004.6020306@xfs.org>  <42AAE5C8.9060609@xfs.org> <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <20050614205933.GC7082@ojjektum.uhulinux.hu> <42B010C0.90707@sgi.com> 
To: Stephen Lord <lord@xfs.org>
Cc: Prarit Bhargava <prarit@sgi.com>,
       =?ISO-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>,
       linux-kernel@vger.kernel.org, davej@redhat.com, ak@suse.de
Subject: Re: Race condition in module load causing undefined symbols 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 28 Jul 2005 20:42:48 +0100
Message-ID: <28920.1122579768@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Someone's finally waved this discussion in my direction.

> Still puzzled about what could have been fixed in user space since this
> appears to affect more than one shell. Module loading appears to be
> very synchronous, so unless the shell was not waiting for exit status
> on children correctly, it seems hard to explain in user space.

The problem with nash is very simple, and may be duplicated in other shells:

 (1) The patch to the module wangling patch that I made makes use of
     stop_machine_run() to insert a module into the module list or remove it
     from the module list.

     This is done because certain things that look at the list have to run
     without locks, so the only way to be certain they aren't going to run is
     to ensure that _nothing_ else is going to run.

 (2) stop_machine_run() creates a bunch of kernel threads to hog the other
     CPUs with interrupts disabled whilst one CPU does the actual work.

 (3) These kernel threads are reparented to the init process (PID 1).

 (4) When "parentless" threads exit, whatever process is running as PID 1 gets
     to deal with the zombies and will get a wait() event for each.

 (5) nash runs as PID 1 during boot.

 (6) nash was NOT checking the pid returned by its calls to wait(); in
     especial, when it forked off an insmod process, it would then simply wait
     for the first wait event to happen and continue on, without checking that
     the process it was waiting for had actually finished.

That is the basic problem being seen. It's just that it rarely happens without
this patch, but the problem is still there in nash, and could be triggered due
to other parentless processes exiting or dying.

I got nash patched, but it seems to be taking awhile to percolate.

David
