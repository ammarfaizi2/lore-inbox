Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDDSog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDDSog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDDSof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:44:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31887 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750796AbWDDSoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:44:34 -0400
To: Zachary Amsden <zach@vmware.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de>
	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
	<4432B22F.6090803@vmware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 12:43:26 -0600
In-Reply-To: <4432B22F.6090803@vmware.com> (Zachary Amsden's message of
 "Tue, 04 Apr 2006 10:51:43 -0700")
Message-ID: <m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> No, this cleanup only eliminates the need to duplicate redundant code.   How
> does a machine vector make it any harder to break?  You still have a function
> with multiple definitions.  Duplicating code makes things really easy to break -
> twice.

Sharing functions is good, but if you don't share things carefully your code
becomes very brittle because it depends in non obvious ways on other
code.

A machine vector isn't exactly what is needed (although that allows building
all of the subarches at the same time).  What is needed are clear places
where the sub architectures get called.

The lack of visibility is what makes subarch code so easy to break right now.

I have had times where I have made a global change and fixed up the entire
kernel and all that broke was the i386 subarchitectures because there
was a dependency but it was totally invisible.  Despite testing on and
being most familiar with i386.

For example every other arch only has one implementation
of machine_restart, machine_halt, machine_power_off, and if they
have subarchitectures they have calls to subarch_restart, subarch_halt,
and subarch_power_off.  At which point it is trivial to see that
the code lives in a subarchitecture.

Even if that code turns right around and calls a common function on
all but one of the subarchitectures, at least the logic is visible when
you read the code.

If all you are doing is this one little clean up we can probably stop here.
But this looks like a start on getting a vmi or xen subarch working.

If this is really a prelude to introducing more subarchitectures we
need to fix the infrastructure, so it is obvious what is going on.
I would really like to see a machine vector, so we could compile in
multiple subarchitectures at the same time.  That makes building
a generic kernel easier, and the requirement that the we need
to build a generic kernel makes the structure of the subarchiteture
hooks hierarchical and you wind up with code whose dependencies
are visible.  Instead of the current linker and preprocessor magic.
Functions named hook are impossible to comprehend what they
are supposed to do while reading through the code.

Eric

