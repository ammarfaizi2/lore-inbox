Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVBYRJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVBYRJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVBYRJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:09:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:28850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262750AbVBYRIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:08:49 -0500
Date: Fri, 25 Feb 2005 09:08:32 -0800
From: Chris Wright <chrisw@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Chris Wright <chrisw@osdl.org>, sds@epoch.ncsc.mil,
       Andrew Morton OSDL <akpm@osdl.org>, serue@us.ibm.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-audit@redhat.com
Subject: Re: [PATCH] audit: handle loginuid through proc
Message-ID: <20050225170832.GX15867@shell0.pdx.osdl.net>
References: <1109312092.5125.187.camel@cube> <20050225064909.GD28536@shell0.pdx.osdl.net> <1109344547.5125.228.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109344547.5125.228.camel@cube>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Albert Cahalan (albert@users.sourceforge.net) wrote:
> On Thu, 2005-02-24 at 22:49 -0800, Chris Wright wrote:
> > * Albert Cahalan (albert@users.sourceforge.net) wrote:
> 
> > > Assuming you'd like ps to print the LUID, how about
> > > putting it with all the others? There are "Uid:"
> > > lines in the /proc/*/status files.
> > 
> > It's also set (written) via /proc, so it should probably stay separate.
> 
> Gross. Please rip this out before it hits the streets.
> (it's an interface change that might need eternal support)

It's already supported via the new pam_loginuid module.  Also the
loginuid is not a part of the task proper, rather the audit context.
It's treated in a manner similar to security contexts which are handled
via /proc interfaces.  Having said that, I wouldn't be opposed to a
patch that promotes it to compatible syscall as you mentioned below
(thanks for the details) if it turns out to be useful.  Got a patch?

[details left for linux-audit folks]

> Consider that:
> 
> 1. Every other UID is handled by system calls:
>    getuid, setuid, geteuid, setreuid,
>    setresuid, getresuid, setfsuid
> 
> 2. HP's Tru64 has getluid() and setluid() system calls
>    that Linux should be compatible with. SecureWare has a
>    version too, which looks more-or-less compatible with
>    what HP is offering. (the descriptions do not conflict,
>    but one has more details) It looks like ssh, apache,
>    and sendmail (huh?) already knows to use these system
>    calls even. 
> 
> The <prot.h> header is used. Prototypes are the obvious.
> The setuid() call returns 0 on success.
> 
> Tru64 notes that the login UID is sometimes called the
> audit UID (AUID) because it is recorded with most audit
> events.
> 
> getluid() returns an error if the LUID (AUID) is unset.
> 
> SecureWare additionally notes that setuid() and setgid() will
> also fail when the luid is unset, to ensure that the LUID
> is set before any other identity changes. (probably Linux
> should just disable setting LUID after that point)
> 
> ------------
> 
> Just to be complete, here's what Sun did:
> 
> Sun has getauid() and setauid() syscalls which are
> somewhat similar. They take pointers to the ID, and they
> require privilege (PRIV_SYS_AUDIT and PRIV_PROC_AUDIT
> for setauid, or just PRIV_PROC_AUDIT for getauid)
> These calls have been superceded by getaudit_addr() and
> setaudit_addr(), which use structs containing:
> 
> au_id_t       ai_auid;     // audit user ID
> au_mask_t     ai_mask;     // preselection mask
> au_tid_addr_t ai_termid;   // terminal ID
> au_asid_t     ai_asid;     // audit session ID
> 
> (the terminal ID is variable length, containing a
> network address and a length value for it)
