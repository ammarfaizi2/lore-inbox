Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbULIRia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbULIRia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 12:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULIRia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 12:38:30 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29607 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261558AbULIRiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 12:38:20 -0500
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200412091724.iB9HOEf26056@dbear.engr.sgi.com>
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job kernel/user
To: jeffrey.hundstad@mnsu.edu (Jeffrey E. Hundstad)
Date: Thu, 9 Dec 2004 09:24:14 -0800 (PST)
Cc: holt@sgi.com (Robin Holt), linux-kernel@vger.kernel.org,
       limin@dbear.engr.sgi.com (Limin Gu)
In-Reply-To: <41B88319.9070207@mnsu.edu> from "Jeffrey E. Hundstad" at Dec 09, 2004 10:53:45 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'd have to second Robin's sentiments.  IMHO there should be a very 
> strong reason to have this type of information in a new filesystem as 
> this type of proliferation is counterproductive.
> 
> -- 
> jeffrey hundstad
> 
> Robin Holt wrote:
> 
> >On Wed, Dec 08, 2004 at 02:03:21PM -0800, Limin Gu wrote:
> >  
> >
> >>Hello,
> >>
> >>I am looking for your comments on the attached draft, it is the job patch 
> >>for 2.6.9. I have posted job patch for older kernel before, but in this patch
> >>I have replaced the /proc/job binary ioctl calls with a new small virtual 
> >>filesystem (jobfs).
> >>
> >>Job uses the hook provided by PAGG (Process Aggregates). A job is a group
> >>related processes all descended from a point of entry process and identified
> >>by a unique job identifier (jid). You can find the general information
> >>about PAGG and Job at http://oss.sgi.com/projects/pagg/
> >>
> >>I will very much appreciate your comments, suggestions and criticisms
> >>on this new filesystem design and implementation as the job kernel/user
> >>communication interface. The patch is still a draft.
> >>
> >>Thank you!
> >>    
> >>
> >
> >I maintain my position that this belongs in /proc.

This is a question I try to find an answer. If the community agrees
the /proc is the right place for it, I would be very happy to move it
to /proc and implement it with procfs.

> >
> >Why not have a structure something like:
> >
> >/proc/<pid>/job -> ../jobs/<jid>

SGI is providing job to our customers as a kernel module. 
But adding /proc/<pid>/job needs to patch fs/proc/base.c, we can not
do that in a module. Of course if job gets accepted, this won't be a problem.

> >/proc/jobs/<jid>/<pid> -> ../../<pid>
> >
> >What other information is really necessary from userland?

We want to keep the same userland libraries and commands we have been
providing to our customers. Here is the library interface.

jid_t
job_create( jid_t jid_requested, uid_t uid, int options );

jid_t
job_getjid( pid_t pid );

jid_t
job_waitjid( jid_t jid, int *status, int options );

int
job_killjid( jid_t jid, int sig );

int
job_getjidcnt( void );

int
job_getjidlist( jid_t *jid, int bufsize );	/* buffer size in bytes*/

int
job_getpidcnt( jid_t jid );

int
job_getpidlist( jid_t jid, pid_t *pid, int bufsize ); /* buffer size in bytes*/

uid_t
job_getuid( jid_t jid );

pid_t
job_getprimepid( jid_t jid );

int
job_sethid( unsigned int hid );

int
job_detachjid( jid_t jid );

jid_t
job_detachpid( pid_t pid );

We will need more than those two entries in /proc as you listed above.
Would it be considered abusing /proc to have too much job stuff there?

Thanks,
--Limin
