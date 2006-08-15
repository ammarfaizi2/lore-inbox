Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWHOEWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWHOEWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 00:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbWHOEWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 00:22:20 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:16102 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1752102AbWHOEWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 00:22:19 -0400
Subject: Re: [RFC] [PATCH] file posix capabilities
From: Nicholas Miell <nmiell@comcast.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
In-Reply-To: <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
	 <20060814220651.GA7726@sergelap.austin.ibm.com>
	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
	 <20060815020647.GB16220@sergelap.austin.ibm.com>
	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 21:22:16 -0700
Message-Id: <1155615736.2468.12.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 21:29 -0600, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > In fact my version knowingly ignores CAP_AUDIT_WRITE and
> > CAP_AUDIT_CONTROL (because on my little test .iso they didn't exist).
> > So a version number may make sense.
> >
> >> So we need some for of
> >> forward/backward compatibility.  Maybe in the cap name?
> >
> > You mean as in use 'security.capability_v32" for the xattr name?
> > Or do you really mean add a cap name to the structure?
> 
> I was thinking the xattr name.  But mostly I was looking
> for a place where you had possibly stashed a version.
> 
> Thinking about it possibly the most portable thing to do
> is to assign each cap a well known name.  Say
> "security.cap.dac_override" and have a value in there like +1  
> add the cap -1 clear the cap.  That at least seems to provide
> granularity and some measure of future proofing and some measure of
> portability.  The space it would take with those names looks ugly
> though.
> 
> The practical question is what do you do with a program that
> was give a set of capabilities you no longer support? 
> Do you run it without any capabilities at all?
> Do you give it as many capabilities of what it asked for
>    as you can?
> Do you complain loudly and refuse to execute it at all?
> 
> What is the secure choice that least violates the principle of least surprise?

Make it an arbitrary length bitfield with a defined byte order (little
endian, probably). Bits at offsets greater than the length of the
bitfield are defined to be zero. If the kernel encounters a set bit that
it doesn't recognizes, fail with EPERM. If userspace attempts to set a
bit that the kernel doesn't recognize, fail with EINVAL.

It's extensible (as new capability bits are added, the length of the
bitfield grows), backward compatible (as long as there are no unknown
bits set, it'll still work) and secure (if an unknown bit is set, the
kernel fails immediately, so there's no chance of a "secure" app running
with less privileges than it expects and opening up a security hole).

OTOH, everybody seems to have moved from capability-based security
models on to TE/RBAC-based security models, so maybe this isn't worth
the effort?

-- 
Nicholas Miell <nmiell@comcast.net>

