Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWHOLtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWHOLtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWHOLtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:49:50 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:34707 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030268AbWHOLtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:49:49 -0400
Date: Tue, 15 Aug 2006 06:49:47 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Nicholas Miell <nmiell@comcast.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060815114946.GA7267@vino.hallyn.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155615736.2468.12.camel@entropy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Miell (nmiell@comcast.net):
> On Mon, 2006-08-14 at 21:29 -0600, Eric W. Biederman wrote:
> > "Serge E. Hallyn" <serue@us.ibm.com> writes:
> > 
> > > In fact my version knowingly ignores CAP_AUDIT_WRITE and
> > > CAP_AUDIT_CONTROL (because on my little test .iso they didn't exist).
> > > So a version number may make sense.
> > >
> > >> So we need some for of
> > >> forward/backward compatibility.  Maybe in the cap name?
> > >
> > > You mean as in use 'security.capability_v32" for the xattr name?
> > > Or do you really mean add a cap name to the structure?
> > 
> > I was thinking the xattr name.  But mostly I was looking
> > for a place where you had possibly stashed a version.
> > 
> > Thinking about it possibly the most portable thing to do
> > is to assign each cap a well known name.  Say
> > "security.cap.dac_override" and have a value in there like +1  
> > add the cap -1 clear the cap.  That at least seems to provide
> > granularity and some measure of future proofing and some measure of
> > portability.  The space it would take with those names looks ugly
> > though.

On the one hand, there shouldn't be many executables with capabilities
so even a horrendous abuse of disk space isn't so bad, but on the other
hand, yes, it'd be a horrendous abuse of disk space :)

> > The practical question is what do you do with a program that
> > was give a set of capabilities you no longer support? 
> > Do you run it without any capabilities at all?
> > Do you give it as many capabilities of what it asked for
> >    as you can?
> > Do you complain loudly and refuse to execute it at all?
> > 
> > What is the secure choice that least violates the principle of least surprise?
> 
> Make it an arbitrary length bitfield with a defined byte order (little
> endian, probably). Bits at offsets greater than the length of the
> bitfield are defined to be zero. If the kernel encounters a set bit that
> it doesn't recognizes, fail with EPERM. If userspace attempts to set a
> bit that the kernel doesn't recognize, fail with EINVAL.
> 
> It's extensible (as new capability bits are added, the length of the
> bitfield grows), backward compatible (as long as there are no unknown
> bits set, it'll still work) and secure (if an unknown bit is set, the
> kernel fails immediately, so there's no chance of a "secure" app running
> with less privileges than it expects and opening up a security hole).

Sounds good.

The version number will imply the bitfield length, or do we feel warm
fuzzies if the length is redundantly encoded in the structure?

> OTOH, everybody seems to have moved from capability-based security
> models on to TE/RBAC-based security models, so maybe this isn't worth
> the effort?

One day perhaps, but that day isn't here yet.  People are still using
setuid (see /sbin/passwd), so obviously they're not sufficiently
comfortable using *only* TE/RBAC.

-serge
