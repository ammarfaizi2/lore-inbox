Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbUKDVzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbUKDVzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUKDVzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:55:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:59338 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262449AbUKDVyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:54:15 -0500
Subject: [RFC] [PATCH] [0/6] LSM Stacking
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1099609471.2096.10.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:04:31 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches add support required to stack most
LSMs.  The most important patch is the first, which provides a
method for more than one LSM to annotate information to kernel
objects.  LSM's known to use the LSM fields include selinux, bsdjail,
seclvl, and digsig.  Without this patch (or something like it),
none of these modules can be used together.

The rest of the patches add stacking support to the existing LSMs.
Another set of three patches will be sent containing a stackable
version of bsdjail.

I have run some performance tests on a Fedora Core Devel system
under three configurations:

1. A 2.6.10-rc1-bk10 system with capabilities and SELinux compiled
into the kernel as it was in the default Fedora kernel.

2. A 2.6.10-rc1-bk10 system with the stacking patches, and capabilities
and SELinux compiled into the kernel under the stacker LSM.  Other
than stacker being compiled in and the size of the LSM void* array
being set to 4, the exact same .config was used.

3. The same kernel as in (2), but with bsdjail and seclvl also stacked.

On each of these configurations, I ran unixbench twice, and compiled
a kernel twice (with the same .config, and all files in the cached
each time).

The kernel compilation results are as follows:

         No stacking (1)           Stacking (2)      More Stacking (3)
Run 1    real 9m51.647s           real 9m48.045s      real 9m53.292s
         user 8m28.637s           user 8m29.108s      user 8m33.319s
          sys 1m13.900s            sys 1m14.993s       sys 1m15.377s

Run 2    real 9m48.154s           real 9m53.369s      real 9m53.292s
         user 8m28.983s           user 8m29.101s      user 8m34.407s
          sys 1m13.981s            sys 1m15.307s       sys 1m15.611s

Run 3    real 9m51.105s           real 9m51.840s      real 9m58.840s
         user 8m28.894s           user 8m29.192s      user 8m33.538s
          sys 1m14.183s            sys 1m15.345s       sys 1m16.146s

Unixbench summaries are as follows.  (I can send the full output if
anyone asks)

         No stacking (1)           Stacking (2)      More Stacking (3)
Run 1         651.5                    647.1                634.3
Run 2         648.2                    642.8                632.7

-serge


