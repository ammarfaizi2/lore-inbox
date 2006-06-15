Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031078AbWFOSoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031078AbWFOSoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031079AbWFOSoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:44:32 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:28171 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1031078AbWFOSoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:44:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lLJQMbHmMDBdnIY7gAulBv8yXoUV0kmvF6ThV1MYQbi7H3+aNFsqxhPReOtDspNQBQ8d13/gfVUdhfpv6Gsql8izoi5phg71LzxOAZTslwPDCvB25AJoXYASk7Ld6DQqEtytpvzAhFHQHm7gYCOygD9VTdOxM4KQy1StAi6mkaM=
Message-ID: <12c511ca0606151144i140c21e5w90dd948af9b536a4@mail.gmail.com>
Date: Thu, 15 Jun 2006 11:44:31 -0700
From: "Tony Luck" <tony.luck@intel.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz
In-Reply-To: <200606140942.31150.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606140942.31150.ak@suse.de>
X-Google-Sender-Auth: 5e49c35778c3b749
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/06, Andi Kleen <ak@suse.de> wrote:
> But at a closer look it really makes sense:
> - The kernel has strong thread affinity and usually keeps a process on the
> same CPU. So switching CPUs is rare. This makes it an useful optimization.

Alternatively it means that this will almost always do the right thing, but
once in a while it won't, your application will happen to have been migrated
to a different cpu/node at the point it makes the call, and from then on
this instance will behave oddly (running slowly because it allocates most
of its memory on the wrong node).  When you try to reproduce the problem,
the application will work normally.

> The alternative is usually to bind the process to a specific CPU - then it
> "know" where it is - but the problem is that this is nasty to use and
> requires user configuration. The kernel often can make better decisions on
> where to schedule. And doing it automatically makes it just work.

Another alternative would be to provide a mechanism for a process
to bind to the current cpu (whatever cpu that happens to be).  Then
the kernel gets to make the smart placement decisions, and processes
that want to be bound somewhere (but don't really care exactly where)
have a way to meet their need.  Perhaps a cpumask of all zeroes to a
sched_setaffinity call could be overloaded for this?

Or we can dig up some of the old virtual cpu/virtual node suggestions (we
will eventually need to do something like this, but most systems now don't
have enough cpus for this to make much sense yet).

-Tony
