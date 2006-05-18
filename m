Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWEREOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWEREOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWEREOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:14:03 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:45186 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1751052AbWEREOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:14:02 -0400
Date: Wed, 17 May 2006 21:13:59 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some interrelated
 stability and cleanliness fixes
In-Reply-To: <ada4pzo5xti.fsf@cisco.com>
Message-ID: <Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
 <fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no> <Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
 <ada4pzo5xti.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Roland Dreier wrote:

|     Dave> We are seeing a bug (with both our driver native MPI
|     Dave> processes and mthca mvapic), where when 8 processes using
|     Dave> "simultaneously exit", we get watchdogs and/or hangs in the
|     Dave> close routines.  Moving the freeing outside the mutex was an
|     Dave> attempt to see if we were running into some VM issues by
|     Dave> doing lots of page unlocking and freeing with the mutex
|     Dave> held.  It seemed to help somewhat, but not to solve the
|     Dave> problem.
| 
| Am I understanding correctly that you see a hang or watchdog timeout
| even with the mthca driver?

Yes.   That is, the symptoms are the same, although the cause
may be different.

| Is there any possibility of posting the test case to reproduce this?

It's the MPI job mpi_multibw (based on the OSU osu_bw, but changed
to do messaging rate), running 8 copies per dual-core 4-socket opteron,
both on InfiniPath MPI, and MVAPICH (built for gen2).

We ship the source with our upcoming release, and will probably make
it available outside our release.

We did discover one possible problem today, which is shared between
our device code and the core openib code, and that's doing some 
memory freeing and accounting from a work thread (updating mm->locked_vm
and cleaning up from earlier get_user_pages); the code in our driver
was copied from the openib core code, it's not literally shared.

I have a strong suspicion that at least sometimes, it's executing after
the current->mm has gone away.   I'm looking at that more right now.

| It doesn't seem likely that ipath changes are going to fix a generic
| bug like this...

It wasn't an attempt to fix it, so much as to work around it, while
I worked on other higher priority stuff.   As I mentioned, it also helps
a bit in allowing multiple processes to be in the open and close code
simultaneously, when you have multiple cpus, so even on that basis,
I'd probably leave it as it now is.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
