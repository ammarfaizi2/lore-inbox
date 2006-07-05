Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWGEQIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWGEQIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWGEQIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:08:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964844AbWGEQIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:08:04 -0400
Subject: Re: [RESEND][PATCH] Let even non-dumpable tasks access
	/proc/self/fd
From: Jeff Layton <jlayton@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Petr Baudis <pasky@suse.cz>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <m1veqwfiox.fsf@ebiederm.dsl.xmission.com>
References: <20060616124157.GB24203@pasky.or.cz>
	 <20060619204851.84467440.akpm@osdl.org>
	 <m1veqwfiox.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 12:07:26 -0400
Message-Id: <1152115646.29174.29.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 00:24 -0600, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Fri, 16 Jun 2006 14:41:57 +0200
> > Petr Baudis <pasky@suse.cz> wrote:
> >
> >> All tasks calling setuid() from root to non-root during their lifetime
> >> will not be able to access their /proc/self/fd.  This is troublesome
> >> because the fstatat() and other *at() routines are emulated by accessing
> >> /proc/self/fd/*/path and that will break with setuid()ing programs,
> >> leading to various weird consequences (e.g. with the latest glibc,
> >> nftw() does not work with setuid()ing programs on ppc and furthermore
> >> causes the LSB testsuite to fail because of this).
> >
> > Odd. Did something actually change in glibc to make this start happening?
> >
> >> This kernel patch fixes the problem by letting the process access its
> >> own /proc/self/fd - as far as I can see, this should be reasonably safe
> >> since for the process, this does not reveal "anything new". Feel free to
> >> comment on this.
> >> 
> >
> > Eric, Chris - any thought on this one?
> 
> This can't fix the glibc emulation problem.  As the kernel
> this patch would apply to doesn't need emulation.
> 
> The basic goal of allowing the current process to access it's
> own proc directories is reasonable.
> 
> I don't like the implementation. It is not obvious that this case
> applies just to the current process.
> 
> I admit that any permission checking in /proc that happens at
> open time instead of at access time is buggy but that is
> the best we have right now.
> 
> Anything more requires a very close review.
> 
> 
> Eric

This might be a stupid question, but can someone explain to me why all
of this whole thing is keyed off of the dumpable flag? With the current
scheme setting suid_dumpable to true works around this problem, but that
doesn't seem like it's an intended behavior.

Also, I recently had someone report a problem where a program that
dropped its privileges was not able access /proc/self/maps. So making so
that we can access /proc/self/fd might not be sufficient.

Perhaps we should consider making this use a blacklist instead of a
whitelist approach? That is to make pid_revalidate to change the
ownership of anything under /proc/self to the euid irrespective of the
dumpable flag, except for things that we know need to retain the
previous ownership?

-- Jeff


