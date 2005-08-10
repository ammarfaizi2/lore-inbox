Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbVHJRys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbVHJRys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVHJRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:54:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:59287 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965239AbVHJRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:54:46 -0400
Subject: Re: [PATCH] remove name length check in a workqueue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050810103733.42170f27.akpm@osdl.org>
References: <1123683544.5093.4.camel@mulgrave>
	 <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
	 <20050810100523.0075d4e8.akpm@osdl.org> <1123694672.5134.11.camel@mulgrave>
	 <20050810103733.42170f27.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 12:54:26 -0500
Message-Id: <1123696466.5134.23.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 10:37 -0700, Andrew Morton wrote:
> > and anyway, it doesn't have to be unique;
> > set_task_comm just does a strlcpy from the name, so it will be truncated
> > (same as for a binary with > 15 character name).
> 
> Yup.  But it'd be fairly silly to go adding the /%d, only to have it
> truncated off again.

Well, but the other alternative is that we hit arbitrary BUG_ON() limits
in systems that create numbered workqueues which is rather contrary to
our scaleability objectives, isn't it?

I think I'd rather the name truncation than have to respond to kernel
BUG()'s.  If someone really has a problem with the appearance of ps,
they can always increase TASK_COMM_LEN.

> We could truncate the name before adding the CPU number, but it sounds
> saner to just prevent anyone passing in excessively long names.  Via
> BUG_ON, say ;)
> 
> What's the actual problem?

What I posted originally; the current SCSI format for a workqueue:
scsi_wq_%d hits the bug after the host number rises to 100, which has
been seen by some enterprise person with > 100 HBAs.

The reason for this name is that the error handler thread is called
scsi_eh_%d; so we could rename all our threads to avoid this, but one
day someone will come along with a huge enough machine to hit whatever
limit we squeeze it down to.

James


