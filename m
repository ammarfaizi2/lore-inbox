Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVBQJ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVBQJ6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 04:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVBQJ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 04:58:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30897 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262285AbVBQJ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 04:57:57 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [PATCH] /proc/cpumem
References: <20050216170224.4C66.ODA@valinux.co.jp>
	<m1hdkcvc6v.fsf@ebiederm.dsl.xmission.com>
	<20050217084547.4C72.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Feb 2005 02:55:31 -0700
In-Reply-To: <20050217084547.4C72.ODA@valinux.co.jp>
Message-ID: <m1vf8rtsrw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi Eric,
> 
> > The lack of a type field looses a fair amount of functionality compared
> > to /proc/iomem.  In particular you can't see where the ACPI data is.
> 
> Hmm, restricting System RAM only may be too pessimistic.
> (One of motivations of this work is for using /dev/mem safely.
>  "dd if=/dev/mem of=xxx" causes panic on my amd64(8GB mem) machine
>  since reading from address around 0xfe000000 causes a machine
>  check. hmm, this area is marked as "reserved". not ACPI area.
>  ACPI area can be read.)
> 
> Ok, I will add a type field.

To be very clear.  I do not believe is necessary for x86.  The
is already sufficient information elsewhere to handle this.

> > The other direction something like this can go is to dump 
> > the data structures in linux/mmzone.h 
> 
> Do you mean defining a data structure in linux/mmzone.h ?
> 
> I used to think a particular struct is not necessary for this work,
> but now I think it is better to define a struct for this.
> Let me consider. 

To be clear there are two pieces of information that are needed.
1) The list of physical memory areas and what they are.
   /proc/iomem does a good job of this.
2) The list of which memory areas the kernel is using.
   It is the pgdat_t and related structures that define this.
   For the purposes of a core dump we want to capture this
   information before the kernel crashes and use it afterward.

> > I have written a first pass at a user space core dump generator,
> > using /dev/mem.  /sbin/kexec still needs some work to prepare
> > the ELF headers before a crash.
> 
> I am looking forward this :-)
> 
> And, you mentioned a couple of weeks ago:
> > Anyway one thing I want to do is actually drop the apic shutdown
> > code altogether in this code path.  I threw it in there to
> > ease the transition from the old code base to the new, but
> > if that code is causing issues....  So this is probably a good time
> > to start testing that.
> 
> How about this ?

My role in this is that of maintainer and architect.  On a practical
level I gain nothing from a working crash-dump/kexec-on-panic
implementation except it stops being a gating factor for the rest
of the kexec code.  So while many times I can see what needs to be
done it is hard for me to justify doing it.  So a lot of times
where I will weigh in with code is when I see a particular blind spot
on the part of the implementors.

The parties I see actively working on the crash dump implementation
are currently a group from IBM and you guys from valinux.co.jp.
One of the primaries at IBM has been on vacation which is likely
why we have not seen anything out of them for the last couple of
weeks.

But also this is open source software it will be done when it
is done.

Eric
