Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTEPW4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTEPW4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:56:20 -0400
Received: from corky.net ([212.150.53.130]:12755 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S264434AbTEPW4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:56:18 -0400
Date: Sat, 17 May 2003 02:09:04 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Ahmed Masud <masud@googgun.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.] 
In-Reply-To: <Pine.LNX.4.33.0305160354500.23288-100000@marauder.googgun.com>
Message-ID: <Pine.LNX.4.44.0305170140520.32047-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Yoav,
>
> After sort of thinking about it at this early friday hour (well late
> thursday for me), it occurs to me that we may want to maintain keys
> either in the vm_area_struct (vma) or for a vma group.
>
> We want to decrypt mostlikely after a page-fault, which triggers a vma
> nopage (code here?), has loaded the page so vma key, and swapping out of
> course is still in vma domain.
>
> Since we can always go from process to vma to page and back again i think
> it is not going to cause any tracking issues.

Right.  The only drawback is that we have another level of indirection for
some operations, but its negligible because it'll only be used on swap
operations or core dumps, both of which rely on disk access times anyway.

I guess a refcount and a key can be added to vm_area_struct, to provide
that.  As long as this vma is in use, key remains valid.

There's still something I'm unsure of.  I'm not familiar with the mm
subsystem.  Do you know whether vma structs are shared among processes
with shared mapping ?  I'd think the answer is yes, in which case the
above is the right way, but if it works that way, how come vm_area_struct
doesn't have a refcount yet ?  Who keeps track of it ?  Who frees it when
the last mapper unmaps it ?  Is the vma->shared in charge of all that ?
If so, what lock protects it ?

>
> Further, we have different vma's for shared and other interesting pages
> so various optimizations are also doable on a case to case basis.
>

Yes, I seems so, but we need to dig into mm and find some answers to be
sure about all cases.

> Does this make any sense? or am I off the cuckoo train at this hour :)

It does, unless I'm also off the cuckoo train at this hour.  Time to get
some sleep, I guess :)

	Yoav

