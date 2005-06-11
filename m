Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVFKQ4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVFKQ4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVFKQzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:55:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2245 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261743AbVFKQyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:54:52 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCH] filesystem auditing by location+name
Date: Sat, 11 Jun 2005 11:55:11 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Steve Grubb <sgrubb@redhat.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mounir Bsaibes <bsaibes@us.ibm.com>
References: <200506101728.25709.tinytim@us.ibm.com> <20050610223806.GA16506@infradead.org>
In-Reply-To: <20050610223806.GA16506@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506111155.12439.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 June 2005 17:38, Christoph Hellwig wrote:
> most of this looks like a copy & paste of the inotify code.  Could you
> please arrange with the inotify folks to merge the patches?
> 

Christoph,

Thank you for the response.

When we first started this project we had assessed whether or not inotify 
would be a feasible starting point, but ultimately rejected it.  What it came 
down to was that the objectives of inotify were distinctly different from the 
objectives of auditfs.  These distinctions were rooted in the very design of 
inotify.  Why?  Inotify is not a generic fs events notification subsystem.

Some of the cursory problems with using inotify which would need changing 
were:

1) Coverage

Inotify is only interested in a portion of the fs ops that we are interested 
in.  Most notably, we need the ability to generate records every time the 
[exec_]permission[_lite]() function is called.

2) Processing

The processing of events has to occur in the kernel, not in user space.  
Inotify collects events and tosses them back over the fence for processing.  
We cannot introduce any window of opportunity for audit subversion.

You see, auditfs is interested in the inode at location+name, whatever it may 
be when the auditable event occurs.  Thus, we've had to hook dcache to help 
us with this processing.  This is something Inotify does not care about nor 
should it.

Inotify will resolve a path to its inode and watch _that_ inode, we're saying 
"watch any inode at this path"

To build auditfs on top of inotify would require watching directories for 
events on its children and processing the events in the kernel (and not 
simply tossing them over the fence to user space).  This gets very... 
hackish ;)

3) Queue

Depending on the work, there may be a requirement that no audit record can be 
lost.  The message queue structure of inotify has the potential to overflow 
and drop events.  This is a no-go for us, but perfectly reasonable for 
inotify.

To make this work for us we'd have to hook the queueing functions to forward 
events on to the audit subsystem.  This would basically mean fitting a system 
that has been designed for interaction with userspace to also have 
interaction with other parts of the kernel... again, hackish.

4) Context

We require information regarding the process and system call associated with 
the fs event.  This is not necessarily evident from where the event occurred 
(ie: permission()).  Inotify would have to hook into the audit subsystem to 
get at this information. 


The only place that the two projects converge is in fs/namei.c where they both 
collect information about events.  One project notifies the audit subsystem 
and the other notifies user space.  I think it is here where a collaboration 
could take place without skewing the objectives of either project.

-tim
