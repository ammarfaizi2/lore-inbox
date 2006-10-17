Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWJQPNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWJQPNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWJQPNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:13:52 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44979 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751124AbWJQPNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:13:51 -0400
Date: Tue, 17 Oct 2006 09:12:50 -0600
From: Ray Lehtiniemi <rayl@mail.com>
Subject: Bogus deps checking (was Re: [RFC] typechecking for
 get_unaligned/put_unaligned)
In-reply-to: <20061017043726.GG29920@ftp.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <200610170912.51273.rayl@mail.com>
Organization: Disorganized
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>
 <20061017043726.GG29920@ftp.linux.org.uk>
User-Agent: KMail/1.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 22:37, Al Viro wrote:
> FWIW, that reminds me - I ought to resurrect the
> patchset killing bogus dependencies; I modified sparse to collect stats
> on how many times each #include actually pulls a header during build,
> added those to data on dependencies (from .cmd.*) and got interesting
> results.

are these modifications publically available?  i would be interested to see 
them. i've been grovelling over the header files with perl...


> There are several #includes with very high impact; the worst happens
> to be module.h -> sched.h, followed by several includes of fs.h.  These
> turned out to be easy to kill (i.e. few places actually needed compensatory
> #include added) and that had seriously cut down on total dependencies.
> The patches will need to be redone due to bitrot, but they are not
> hard to reproduce.  The really interesting observation is that such
> high-impact includes exist and can be found by this technics...

i noticed another potential source of unneccessary dependencies: 
<linux/prefetch.h> includes <asm/processor.h> for a total of ~49 
dependencies.  it appears that the prefetch() concept could be moved into a 
separate <asm/prefetch.h> file with much smaller dependency footprint, for a 
pretty hefty reduction in total dependencies throughout the system.

another potential win:  a good chunk of <linux/kernel.h> (which has ~24 
dependencies) actually has nothing to do with the kernel per se.  i'm 
thinking of basic C language idioms (container_of(), typecheck(), etc) and 
constants (INT_MAX).  a fair number of files seem to include <linux/kernel.h> 
just for these items.  moving that stuff into a separate file (<linux/c.h>?) 
could eliminate 20 or more bogus deps from many locations.


ray
