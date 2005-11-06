Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVKFWuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVKFWuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVKFWuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:50:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47580 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751270AbVKFWuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:50:11 -0500
Date: Sun, 6 Nov 2005 14:49:54 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 3/5] cpuset: change marker for relative numbering
Message-Id: <20051106144954.368713ad.pj@sgi.com>
In-Reply-To: <20051106125738.7e140f1c.akpm@osdl.org>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053132.549.16062.sendpatchset@jackhammer.engr.sgi.com>
	<20051104230827.16001781.akpm@osdl.org>
	<20051106020410.2c0c26e1.pj@sgi.com>
	<20051106125738.7e140f1c.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> If someone modifies a library-managed cpuset via the backdoor then the
> library (and its caller) are out of sync with reality _anyway_.

Yes, for system-wide operations.  No - for cpuset-relative operations.

For task migration (Christoph Lameter's patches) to work, I need to
provide a safe way for jobs to manage placement within their assigned
cpuset.  This means providing wrappers to sched_setaffinity, mbind and
set_mempolicy that take cpuset-relative cpu/mem numbers, and provide a
robust, cpuset-relative API to applications, that hides any migrations
from the application.

A year ago, Simon Derr pushed hard to get cpuset-relative numbering
support into the kernel, anticipating these sorts of problems.  I and
others pushed back, saying that this was the work of libraries, and
that the kernel-user API needed to use one simple, system-wide numbering.

Enforcing a system-wide synchronization of library code, using just
user code, is expensive, difficult and scales poorly on large systems.

A trivial, code-wise, hook in the kernel will enable each independent
library routine to efficiently detect any parallel changes and redo
their operation sequence.  It enables providing applications with a
cpuset-relative API for internal job memory and cpu placement that is
efficient and robustly safe in the face of migrations.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
