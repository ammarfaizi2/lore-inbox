Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVBYPnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVBYPnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVBYPmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:42:49 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34255 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262727AbVBYPmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:42:25 -0500
Subject: Re: [PATCH] audit: handle loginuid through proc
From: Albert Cahalan <albert@users.sf.net>
To: Chris Wright <chrisw@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, sds@epoch.ncsc.mil,
       Andrew Morton OSDL <akpm@osdl.org>, serue@us.ibm.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050225064909.GD28536@shell0.pdx.osdl.net>
References: <1109312092.5125.187.camel@cube>
	 <20050225064909.GD28536@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 10:15:47 -0500
Message-Id: <1109344547.5125.228.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 22:49 -0800, Chris Wright wrote:
> * Albert Cahalan (albert@users.sourceforge.net) wrote:

> > Assuming you'd like ps to print the LUID, how about
> > putting it with all the others? There are "Uid:"
> > lines in the /proc/*/status files.
> 
> It's also set (written) via /proc, so it should probably stay separate.

Gross. Please rip this out before it hits the streets.
(it's an interface change that might need eternal support)
Consider that:

1. Every other UID is handled by system calls:
   getuid, setuid, geteuid, setreuid,
   setresuid, getresuid, setfsuid

2. HP's Tru64 has getluid() and setluid() system calls
   that Linux should be compatible with. SecureWare has a
   version too, which looks more-or-less compatible with
   what HP is offering. (the descriptions do not conflict,
   but one has more details) It looks like ssh, apache,
   and sendmail (huh?) already knows to use these system
   calls even. 

The <prot.h> header is used. Prototypes are the obvious.
The setuid() call returns 0 on success.

Tru64 notes that the login UID is sometimes called the
audit UID (AUID) because it is recorded with most audit
events.

getluid() returns an error if the LUID (AUID) is unset.

SecureWare additionally notes that setuid() and setgid() will
also fail when the luid is unset, to ensure that the LUID
is set before any other identity changes. (probably Linux
should just disable setting LUID after that point)

------------

Just to be complete, here's what Sun did:

Sun has getauid() and setauid() syscalls which are
somewhat similar. They take pointers to the ID, and they
require privilege (PRIV_SYS_AUDIT and PRIV_PROC_AUDIT
for setauid, or just PRIV_PROC_AUDIT for getauid)
These calls have been superceded by getaudit_addr() and
setaudit_addr(), which use structs containing:

au_id_t       ai_auid;     // audit user ID
au_mask_t     ai_mask;     // preselection mask
au_tid_addr_t ai_termid;   // terminal ID
au_asid_t     ai_asid;     // audit session ID

(the terminal ID is variable length, containing a
network address and a length value for it)


