Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSKOBXr>; Thu, 14 Nov 2002 20:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSKOBXr>; Thu, 14 Nov 2002 20:23:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:55530 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265543AbSKOBXq>;
	Thu, 14 Nov 2002 20:23:46 -0500
Message-ID: <3DD44E39.4703C2DA@digeo.com>
Date: Thu, 14 Nov 2002 17:30:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com> <3DD443EC.2080504@sun.com> <3DD44742.2DFE4407@digeo.com> <3DD44CC0.40805@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 01:30:33.0915 (UTC) FILETIME=[979EA0B0:01C28C46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> Andrew Morton wrote:
> 
> > What are you actually using the search for?
> >
> >>From a quick look, it seems that it's purely to answer
> > the question "is this process a member of group X?".  Is
> > that correct?
> >
> > If so, test_bit() would work nicely.
> 
> This could work if we find the max gid, allocate an array of
> max_gid/CHAR_BITS + 1 bytes then test_bit, but given the non-contiguity
> (is that a word) of group memberships, we'll waste a lot of space on
> holes. Now, it could be argued that 10,000 groups are PROBABLY local
> enough.  Getting the groups back out will be nasty nastiness, though.
> 
> perhaps:
> 
> if (gidsetsize < (2 * EXEC_PAGESIZE)/sizeof(gid_t)) { /* or something */
>         /* use kmalloc() */
> else
>         /* use vmalloc() */
> 
> thoughts?
> 

10,000 bits isn't much.  Maybe:

- add `char groups[16]' to task_struct

- add `struct page *groups_page' to task_struct

- then
	if (getsetsize <= 256)
		use current->groups[]		/* 256 groups max */
	else
		use current->groups_page;	/* 32768 groups max */
