Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWJNAKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWJNAKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 20:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJNAKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 20:10:51 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:49452 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932082AbWJNAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 20:10:50 -0400
Date: Fri, 13 Oct 2006 17:09:51 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061014000951.GC2747@ca-server1.us.oracle.com>
Mail-Followup-To: Matt Helsley <matthltc@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@suse.de>,
	"Chandra S. Seetharaman" <sekharan@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	CKRM-Tech <ckrm-tech@lists.sourceforge.net>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011220619.GB7911@ca-server1.us.oracle.com> <1160619516.18766.209.camel@localhost.localdomain> <20061012070826.GO7911@ca-server1.us.oracle.com> <1160782659.18766.549.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160782659.18766.549.camel@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 04:37:38PM -0700, Matt Helsley wrote:
> > 	Sure it works.  You have one per resource group.  In
> > resource_group_make_object(), you sysfs_mkdir() the sysfs file.  There
> 
> 	That's the easy part. Next we need to make the pid attribute whenever a
> new task is created. And delete it when the task dies. And move it
> around whenever it changes groups. Is there rename() support in /sys? If
> not, would changes to allow rename() be acceptable (I'm worried it would
> impact alot of assumptions made in the existing code)?

	No, you don't create a pid attribute per task.  The sysfs file
is literally your large attribute.  So, instead of echoing a new pid to
"/sys/kernel/config/ckrm/group1/pids", you echo to
"/sys/ckrm/group1/pids".  To display them all, you just cat
"/sys/ckrm/group1/pids".  It's exactly like the file you want in
configfs, just located in a place where it is allowed.

> 	Consider that having two very similar (but not symlinked!) trees in
> both /sys/ ... /res_group and /sys/kernel/config/res_group could be
> rather confusing to userspace programmers and users alike.

	Not really.  It's not identical (tons of attributes live in the
configfs part but not the sysfs part), and it has a clear deliniation of
what each does.

> 	It would be strange because when you rmdir a group
> in /sys/kernel/config/res_group... a directory in /sys would also
> disappear. Yet you can't mkdir or rmdir the /sys dirs. And to edit the

	This is no different than tons of sysfs and procfs functionality
today.

> Hmm, that suggests a good point. While some one *can* do that or:
> 
> ATTR=( $(cat /sys/kernel/config/ckrm/myresource/attr) )
> 
> the space available for environment variables is limited. So attempting
> to store a large (What's "large"?) attribute in an environment variable
> is a potentially buggy practice. This is a significant problem affecting
> large attributes in general.

	If you can't do it in sh, it's pretty much out of scope.  This
is a taste rule I use, because like to shell program.  Sure, not the end
of the world (not a hard rule, I guess), but worth thinking about.

> 	There are two parts to the complexity: code complexity and the number
> of userspace pieces to deal with. I think that in both of these
> categories the OVPA approach is more complex. Here's how I see it:

	By your definition, sysfs, configfs, and other fs-style control
mechanisms are too complex.  We should all just be using ioctl() so that
coders and users have only one namespace :-)

> > 	You're effectively suggesting that a specific attribute type of
> > "repeated value of type X".  No mixed types, no exploded structures,
> > just a "list of this attr" sort of thing.  This does fit my personal
> > requirement of avoiding a generic, abusable system.
> 
> Exactly.

	How do you implement it?  Full on seq_file with restrictions
(ops->start,stop,next,show)?  Some sort of array (how do I placehold
where the last read(2) was)?  Some sort of linked list (again with the
placeholding and locking)?  Anything short of seq_file+restrictions
would be perhaps binding that traversal, no?

Joel

-- 

"When I am working on a problem I never think about beauty. I
 only think about how to solve the problem. But when I have finished, if
 the solution is not beautiful, I know it is wrong."
         - Buckminster Fuller

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
