Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263376AbVBDCK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbVBDCK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVBDCBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:01:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48260 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261629AbVBDB5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:57:41 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <20050202161108.18D7.ODA@valinux.co.jp>
	<m1fz0f9g20.fsf@ebiederm.dsl.xmission.com>
	<20050204090151.18F0.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 18:55:30 -0700
In-Reply-To: <20050204090151.18F0.ODA@valinux.co.jp>
Message-ID: <m1brb19jhp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> On 02 Feb 2005 07:45:11 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > 
> > And the feedback begins :)
> > 
> > Itsuro Oda <oda@valinux.co.jp> writes:
> > 
> > > Hi,
> > > 
> > > I don't like calling crash_kexec() directly in (ex.) panic().
> > > It should be call_dump_hook() (or something like this).
> > > 
> > > I think the necessary modifications of the kernel is only:
> > > - insert the hooks that calls a dump function when crash occur
> > crash_kexec()
> > > - binding interface that binds a dump function to the hook
> > >   (like register_dump_hook())
> > sys_kexec_load(...);
> 
> For example there are pepole who want to execute a built in kernel
> debugger when the system is crashed. or there are pepole who
> believe the diskdump is the best dump tool :-)
> 
> So I think a sort of hook is better than calling crash_kexec 
> directly. (May I make a patch ?)

The prevalent feeling I have heard from kernel developers and 
and my personal feeling as well is that after a kernel has called
panic you can't trust it.  Which means anything running in the kernel
itself is suspect.

The crash_kexec() hooks enables everything that does not get linked into
the kernel.   So I don't feel a hook in the panic path is necessary
nor do I feel that it is wise, especially with no in-kernel users.

Plus the worst part about a hook in the panic path is that it is
inherently racy.  Keeping the crash_kexec() code from blocking or
being racy has been a challenge.  And I still think that entire code
path needs a review and some more code tweaks to remove races.

If someone else wants a hook in the panic path they can add their own
hook, and make their own case for why it is needed.

Eric
