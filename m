Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUINH5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUINH5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbUINH5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:57:23 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:65419 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S269193AbUINH4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:56:20 -0400
Date: Tue, 14 Sep 2004 09:55:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914075508.GA10880@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914071058.GH9106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 00:10:58 -0700, William Lee Irwin III wrote:
> > - If the access control bits for a field are cleared, any process/user
> >   can get that field information for any process.
> > - If the access control bits are set to NPROC_PERM_USER, only root and
> >   the owner of a process can read the field for that process.
> > - For NPROC_PERM_ROOT, only root can ever read such a field.
> > I picked that design because it captures the essence of what /proc
> > does today.
> 
> The concern appears to be that the tools might interpret failed
> permission checks as indications of process nonexistence. I don't
> regard this as particularly pressing, as properly-written apps should
> check the specific value of errno (in particular to retry when EAGAIN
> is received in numerous contexts).

I would expect a tool to refrain from asking for fields with restricted
access if it needs a complete overview over existing processes. It can
always ask for restricted fields in a second request (the vast majority
of fields are world-readable anyway).

> > processes seems a good solution. In this special case, the current
> > nproc code returns 0, but that's probably not optimal. Currently,
> > my preferred solution would be to return ~(0).
> > I'm not convinced yet that making message formats more complex (adding
> > bitmaps or lists of applicaple fields or something) for one special
> > case is a better idea.
> 
> Distinguishing between EPERM, ENOSYS, ENOENT, etc. could probably be
> done if the fields are measured in units such that the top bit is never
> set for any feasible value, then a fully qualified error return could
> simply be returned as (unsigned long)(-err). I suspect VSZ may be
> problematic wrt. overflows even for 32-bit, not just for 31-bit.

Yeah, that makes me nervous. There are just too many ways this can go
wrong or be misinterpreted in user space. Currently, nproc does not
indicate the type of error at all, because a properly written user-space
app will either not hit an error or be able to figure out what the
problem was based on the available information. I suppose if we wanted
to change that (which doesn't sound unreasonable), the proper way would
be to return error flags with an error message (delivered via netlink).

Roger
