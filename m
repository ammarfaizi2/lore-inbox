Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269169AbUINGrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbUINGrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbUINGrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:47:24 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:12678 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S269169AbUINGpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:45:09 -0400
Date: Tue, 14 Sep 2004 08:44:03 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914064403.GB20929@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094942212.1174.20.camel@cube>
X-Operating-System: Linux 2.6.9-rc1-mm4nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 18:36:53 -0400, Albert Cahalan wrote:
> > I forgot to mention that you can see the remnants of that approach in
> > <linux/nproc.h>: I used two bits of the field ID to define per-field
> > access restrictions (NPROC_PERM_USER, NPROC_PERM_ROOT).
> 
> Besides the low-security and high-security choices,
> I'd like to see a medium-security choice.
> 
> low: everybody sees everything
> medium: everybody sees something; privileged user sees all
> high: must be privileged
> 
> This might mean that asking for stuff like EIP and WCHAN
> causes you to see fewer processes.

I'm not sure I understand you correctly, but the combination of
NPROC_PERM_USER and NPROC_PERM_ROOT already seems to fit your
description:

- If the access control bits for a field are cleared, any process/user
  can get that field information for any process.

- If the access control bits are set to NPROC_PERM_USER, only root and
  the owner of a process can read the field for that process.

- For NPROC_PERM_ROOT, only root can ever read such a field.

I picked that design because it captures the essence of what /proc
does today.

> If partial info is returned for a process, I'd like to
> also get a bitmap of valid fields. Special "not valid"
> values are a pain to deal with.

If an app asks for a field it has no or partial permission for, the set
of processes returned is trimmed accordingly. Since an application will
expect this behavior based on the access control bits, no guessing is
involved here.

If an app asks for a non-existant field (not supported on this
architecture or obsolete), it will get an error back. No guessing
involved here, either. We could report the bad field ID back, but it's
easy for user-space to figure out and it's not in the fast path (for
user space).

The tricky case is if an app asks for an offered field without permission
problems, but the field is not available in that particular context. The
only instance of this that comes to mind are mm_struct related fields
and kernel threads. Neither returning an error nor skipping affected
processes seems a good solution. In this special case, the current
nproc code returns 0, but that's probably not optimal. Currently,
my preferred solution would be to return ~(0).

I'm not convinced yet that making message formats more complex (adding
bitmaps or lists of applicaple fields or something) for one special
case is a better idea.

Roger
