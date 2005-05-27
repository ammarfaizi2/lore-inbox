Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVE0AYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVE0AYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 20:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVE0AYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 20:24:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:183 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261616AbVE0AYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 20:24:33 -0400
Date: Thu, 26 May 2005 17:24:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, akpm@osdl.org, dino@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-Id: <20050526172414.473f9013.pj@sgi.com>
In-Reply-To: <20050526130713.2be9bed8.pj@sgi.com>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
	<Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
	<20050526130713.2be9bed8.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On rereading my post above, I realize that it is confusingly presented.

Let me try again ...

Issue (1) is that we might need parts of the cpuset to process
notify_on_release after we have released the cpuset by decrementing its
reference count to zero.  Unless we hold the global cpuset_sem
semaphore, if we try to access that released cpuset to get what we need,
we can crash the kernel.  This is the issue that prompted this patch.

Issue (2) is that we have two ways of tracking users of a cpuset, with
both a reference count of tasks linked to the cpuset, and also a linked
list of child cpusets.  Unless we hold the global cpuset_sem semaphore,
there is no atomicly safe way to answer the question "is this cpuset
free now?"

The solution to Issue (1) is to make local variable copies of the
information we need from the cpuset, before we let go of it (before we
decrement its reference count).

The solution to Issue (2) is to have child cpusets also manipulate the
cpuset reference count, so that the cpuset reference count provides an
atomic way to detect all uses of a cpuset.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
