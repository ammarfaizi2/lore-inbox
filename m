Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTJATXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTJATXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:23:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:12423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262446AbTJATXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:23:37 -0400
Date: Wed, 1 Oct 2003 12:22:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Hockin <thockin@hockin.org>
cc: Pete Zaitcev <zaitcev@redhat.com>, <braam@clusterfs.com>,
       <rusty@rustcorp.com.au>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
In-Reply-To: <20031001184610.GA25716@hockin.org>
Message-ID: <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Oct 2003, Tim Hockin wrote:
> 
> This patch touches all the compat code in the 64-bit architectures.
> These files have a LOT of duplicated code from uid16.c.  I did not try to
> reduce duplicated code, and instead followed suit.

Augh. It also makes code even uglier than it used to be:

	...

	+               u16 group;
	+               if (copy_from_user(&group, grouplist+i, sizeof(group)))
	+                       return  -EFAULT;

which is really a memcpy() of two bytes at a time. That's disgusting. It
really should be

	u16 group;

	if (nr > TASK_SIZE / sizeof(group))
		return -EFAULT;
	if (!access_ok(grouplist, nr*sizeof(group))
		return -EFAULT;
	...

		if (__get_user(group, grouplist + i))
			return -EFAULT;
	...

which really is so common that it _really_ should be in kernel/uid16.c
(or, actually create a new kernel/gid16.c file) rather than copied 
(incorrectly) to a lot of architectures. Then things like the above can be 
done right once, rather than merging this that does the nasty thing over 
and over.

Sorry to just complain all the time,

			Linus

