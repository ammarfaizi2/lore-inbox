Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUINHLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUINHLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUINHLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:11:23 -0400
Received: from holomorphy.com ([207.189.100.168]:42897 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269181AbUINHLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:11:19 -0400
Date: Tue, 14 Sep 2004 00:10:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914071058.GH9106@holomorphy.com>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914064403.GB20929@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 18:36:53 -0400, Albert Cahalan wrote:
>> This might mean that asking for stuff like EIP and WCHAN
>> causes you to see fewer processes.

On Tue, Sep 14, 2004 at 08:44:03AM +0200, Roger Luethi wrote:
> I'm not sure I understand you correctly, but the combination of
> NPROC_PERM_USER and NPROC_PERM_ROOT already seems to fit your
> description:
> - If the access control bits for a field are cleared, any process/user
>   can get that field information for any process.
> - If the access control bits are set to NPROC_PERM_USER, only root and
>   the owner of a process can read the field for that process.
> - For NPROC_PERM_ROOT, only root can ever read such a field.
> I picked that design because it captures the essence of what /proc
> does today.

The concern appears to be that the tools might interpret failed
permission checks as indications of process nonexistence. I don't
regard this as particularly pressing, as properly-written apps should
check the specific value of errno (in particular to retry when EAGAIN
is received in numerous contexts).


On Sat, 11 Sep 2004 18:36:53 -0400, Albert Cahalan wrote:
>> If partial info is returned for a process, I'd like to
>> also get a bitmap of valid fields. Special "not valid"
>> values are a pain to deal with.

On Tue, Sep 14, 2004 at 08:44:03AM +0200, Roger Luethi wrote:
> If an app asks for a field it has no or partial permission for, the set
> of processes returned is trimmed accordingly. Since an application will
> expect this behavior based on the access control bits, no guessing is
> involved here.
> If an app asks for a non-existant field (not supported on this
> architecture or obsolete), it will get an error back. No guessing
> involved here, either. We could report the bad field ID back, but it's
> easy for user-space to figure out and it's not in the fast path (for
> user space).
> The tricky case is if an app asks for an offered field without permission
> problems, but the field is not available in that particular context. The
> only instance of this that comes to mind are mm_struct related fields
> and kernel threads. Neither returning an error nor skipping affected
> processes seems a good solution. In this special case, the current
> nproc code returns 0, but that's probably not optimal. Currently,
> my preferred solution would be to return ~(0).
> I'm not convinced yet that making message formats more complex (adding
> bitmaps or lists of applicaple fields or something) for one special
> case is a better idea.

Distinguishing between EPERM, ENOSYS, ENOENT, etc. could probably be
done if the fields are measured in units such that the top bit is never
set for any feasible value, then a fully qualified error return could
simply be returned as (unsigned long)(-err). I suspect VSZ may be
problematic wrt. overflows even for 32-bit, not just for 31-bit.


-- wli
