Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTIWBQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 21:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTIWBQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 21:16:33 -0400
Received: from fmr06.intel.com ([134.134.136.7]:6881 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261156AbTIWBQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 21:16:30 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH 2.6.x] additional kernel event notifications
Date: Mon, 22 Sep 2003 18:16:14 -0700
Message-ID: <7F740D512C7C1046AB53446D372001732DEC9E@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.x] additional kernel event notifications
Thread-Index: AcOA+bUdpg4q64tQQ8yy3o4lkBtbWgAc7ksA
From: "Villacis, Juan" <juan.villacis@intel.com>
To: "John Levon" <levon@movementarian.org>
Cc: "Andi Kleen" <ak@muc.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Sep 2003 01:16:15.0132 (UTC) FILETIME=[48A0BDC0:01C38170]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"John Levon" <levon@movementarian.org> writes:
> > In some cases, a profiler can figure out information regarding
> > Dynamically Generate Code (DGC) with help from the generator of the
> > code, but in other cases it cannot.
> > 
> > In the case of Java jitted code, our userspace tools obtain
sufficient
> > information through JVMPI, when it is implemented by the JVM.
> 
> I would argue that any JVM that doesn't yet implement
> JVMPI_EVENT_COMPILED_METHOD_LOAD is broken - JVMPI has been around for
> a long time now.
> 
> I don't see why the kernel is the correct place to fix such lacking
> functionality.

There are several languages and tools besides Java which can jit code.
Perl6 (using interpreters like Parrot) and Python (using interpreters
like Psycho) are examples of this and it is not yet clear what
interfaces they will provide to allow for JVMPI like functionality.  We
would like to be able to profile applications using these interpreters
(as well as others).  If userspace interpreters, for whatever reason, do
not provide functionality for tracking jitted code, would it not be
useful to provide help in the kernel to allow profilers to be able to
track this? 

Although we understand your belief that a DGC generator that doesn't
provide hooks for determining the DGC information may not be optimal, we
would still like to be able to provide something useful to the users of
those environments.  Perhaps this philosophical discussion is better
handled offline per an earlier suggestion.

> > for DGC which does not have such userspace support, it is important
to
> > be able to spot and accurately attribute samples to DGC.  The 4
> > additional profiling hooks we proposed can be used for such
purposes.
> 
> Please be specific about which *actual* cases you're worried about,
and
> why they shouldn't be fixed in userspace.

>From what we can see in the Oprofile driver code, if there is no dcookie
for a corresponding EIP, the EIP information is discarded and the
"oprofile_stats.sample_lost_no_mapping" count is incremented (see
add_us_sample() in drivers/oprofile/buffer_sync.c).  Did we
misunderstand something?  Is a DENTRY (and a corresponding dcookie)
being created somewhere for DGC?

> > If the generator of DGC frees memory used for DGC that subsequently
gets
> > a loaded image (or reuses memory that may have once had an
executable
> > image), you can mis-attribute samples so that instead of attributing
the
> > samples to the DGC, you will attribute the samples to an image. The
> > dcookie mechanism will indicate information about an image, but
doesn't
> > help prevent mis-attribution of samples if DGC is intermixed with
images
> > that are loaded/unloaded in the same memory region.
> 
> Simply flush the sample buffer by echo 1 >/dev/oprofile/dump when you
> receive a COMPILED_METHOD_LOAD/UNLOAD that conflicts with a previous
> mapping.

As long as there exists a userspace API similar to the JVMPI for a
particular DGC generator, and as long as the profiling tool is using
that API, then yes, it seems like this method would work.  But this
isn't the case we are worried about.

-juan
