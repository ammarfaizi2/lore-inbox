Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTFYDFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 23:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTFYDFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 23:05:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16406 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263676AbTFYDFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 23:05:36 -0400
Date: Tue, 24 Jun 2003 20:19:30 -0700
Message-Id: <200306250319.h5P3JUw27438@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
Subject: Re: common name for the kernel DSO
In-Reply-To: David Mosberger's message of  Wednesday, 18 June 2003 16:56:45 -0700 <16112.64573.582305.388014@napali.hpl.hp.com>
X-Windows: the first fully modular software disaster.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Andrew> What happens if one architecture decides to take this up to
>   Andrew> linux-gate.so.2?  If that is even a legit thing to do.
> 
> Beats me.  Roland?

As I said in my original posting of the i386 vsyscall DSO changes, nothing
as yet makes any use of the soname, version set name, or symbol names.  So
at the moment you can change them to linux-mergatroid.so.23, LIGNUX_7.9,
and _StUdLy_KeRnEl_vSyScAlL et al, and Nothing Happens (well, with the
middle of those three I have a feeling *something* would happen to
*somebody* ;->).  

My expectation is that if and when anything makes use of any of these
names, they will be used in the same way a normal userland DSO is used.
The namespace for sonames is considered machine-specific, though usually
kept in synch across machines when the source APIs are the same or nearly so.
The namespace for version sets is local to the soname of the containing DSO,
though likewise usually assigned in a machine-independent fashion.

sonames should be something it's reasonable to use as a file name in /lib.
Version set names are just arbitrary symbols compared for identity, and can
encode kernel version numbers or dates if you like, or not if you don't.
People see them and will want to know what set of kernels supplies a DSO
containing that set, so kernel version numbers make sense.  But you can do
whatever floats your boat.

If a machine changes its kernel DSO's ABI it has two options.  It can keep
the same soname, and provide compatibility entry points for the previous
ABI using the same version set name, and provide newly-flavored entry
points with a new version set name.  Or it can change the soname, start
over with whatever version set name floats its boat, and not worry about
compatibility.  In that case, compatibility for existing dependencies can
be provided by a normal user-level DSO stored in a regular file by the name
of the old soname.  e.g., linux-mergatroid.so.22 can be a user-level
wrapper DSO that works by linking against the new linux-mergatroid.so.23
provided by the new kernel and calling its entry points after whatever
appropriate calling convention fixup is required.  

If these DSO ABIs evolve independently for each machine, it doesn't make
particular sense to coordinate the soname changes between them.  I mean,
using a common name prefix is wise just so people understand they are all
being used in the same way, but having the trailing number correlate across
machines only makes sense if there is some correlation with the DSO's API
changes across machines.

You'll note I haven't really told you what to do.  If there is anything
else I can make more clear about how best to decide what to do, please ask.

Btw, I still don't care what names are used for anything, but
"linux-gate.so.1" sounds particularly stupid to me.  (What is that, the big
scandal about that time the President hired some hamfisted goons with
taxpayer's money to violate the GPL for personal gain and sexual favors?)
"linux-kernel.so.1" is the least stupid name I have thought of (and that
still seems kind of stupid).


Enjoy,
Roland
