Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272226AbTG3TqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTG3TqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:46:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:57277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272226AbTG3TqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:46:14 -0400
Date: Wed, 30 Jul 2003 12:34:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: aradorlinux@yahoo.es
Cc: kernel@kolivas.org, miller@techsource.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-Id: <20030730123427.50d128ea.akpm@osdl.org>
In-Reply-To: <20030730212832.22e065ad.aradorlinux@yahoo.es>
References: <200307280112.16043.kernel@kolivas.org>
	<200307300035.01354.kernel@kolivas.org>
	<20030730031616.3ed14362.diegocg@teleline.es>
	<200307301136.06396.kernel@kolivas.org>
	<20030730212832.22e065ad.aradorlinux@yahoo.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aradorlinux@yahoo.es wrote:
>
> [changing email address; several hosts block mail from *@teleline/terra.es;
> which is good if they're fighting against spam]
> El Wed, 30 Jul 2003 11:36:06 +1000 Con Kolivas <kernel@kolivas.org> escribió:
> 
> > The logic is in the difference between the dynamic and the static priority to 
> > determine if a task is interactive. 
> > current->static_prio - current->prio
> > will give you a number of -5 to +5, with +5 being a good bonus and vice versa.
> > however you need to ensure that the value you are fiddling with in the i/o 
> > scheduler is actually due to the current process[1]
> 
> I think current really is the process submitting the request; at least in the
> same function we've this:
> 
>         if (rq_data_dir(arq->request) == READ
>                         || current->flags&PF_SYNCWRITE)
> 
> Which would be wrong if current isn't the process submitting the request.

`current' is correct for reads and synchronous writes.  It is usually wrong
for normal pagecache writeback.

If we're going to do this sort of thing, the IO priority and any associated
state should be placeed into struct io_context, which is the structure with
which the IO scheduler tracks per-process stuff.

The io_context is constructed just once across teh lifetime of a process,
so we'd need to update it occasionally to pick up dynamic priority shifts,
changes in niceness, etc.  Probably do that inside a read.

I have a vague feeling that co-opting the scheduling priority information
for use as IO priority will end up being a mistake.  It may be best to
treat these things separately from the outset.

