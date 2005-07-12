Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVGLOwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVGLOwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGLOwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:52:18 -0400
Received: from THUNK.ORG ([69.25.196.29]:2991 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261495AbVGLOtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:49:39 -0400
Date: Tue, 12 Jul 2005 08:04:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050712120456.GA14032@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Paolo Ornati <ornati@fastwebnet.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050711123237.787dfcde@localhost> <20050711143427.GC14529@thunk.org> <20050712103811.0087a7e3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712103811.0087a7e3@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 10:38:11AM +0200, Paolo Ornati wrote:
> The particular case you analized (blocking connect interrupted by a
> SA_RESTART signal) is interesting... and since SUSV3 says
> 	"but the connection request shall not be aborted, and the connection
> 	shall be established asynchronously" (with select() or poll()...)
> both for EINPROGRESS and EINTR, I think it's quite stupit to
> automatically restart it and then return EALREADY.
> 
> The logically correct behaviur with blocking connect interrupted and
> then restarted should be to continue the blocking wait... IHMO.

I was looking at what happened with a *non-blocking* connect
interrupted by an SA_RESTART signal.  Since it is non-blocking, it
will never continue with the wait.  The only question is whether it
should return with an EINTR (which is what it currently does) or
return with whatever error code it would have returned if the signal
had not been delievered in the first place.  We currently do the
former; a close reading of the spec seems the require the latter.
Fortunately this is a pretty narrow race condition since the chances
of a signal being delivered right in the middle of a non-blocking
connect are small.  But, the paranoid application writer should check
for EINTR being returned from a non-blocking connect, since that is
the what the currently deployed Linux kernels will do right now in
this rare case.

						- Ted
