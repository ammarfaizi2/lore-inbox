Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWD0XKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWD0XKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWD0XKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:10:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21172 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751763AbWD0XKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:10:40 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	 <1146105458.2885.37.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	 <1146107871.2885.60.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	 <20060427213754.GU3570@stusta.de>
	 <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 00:11:01 +0100
Message-Id: <1146179462.13540.131.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 15:00 -0700, Linus Torvalds wrote:
> This is one reason why we shouldn't even _plan_ on having header files 
> that can just be _directly_ used by the C libraries etc, even if it's just 
> a "small" kernel ABI header.
> 
> Selling it as that kind of idea will inevitably mean that we then get 
> blamed for not knowing magic rule #579 for SuS v2.1.6 subsection 8(a).
> 
> And if we say "you can use these headers unmodified", that _is_ what we're 
> going to get blamed for. I'm so _not_ interested in having to care or 
> worry. 

OK... I wasn't going to go here, because I don't want a potentially
contentious discussion to get in the way of the other cleanups which
I've been doing. We made that mistake at least year's Kernel Summit, and
we've made no progress since then despite having an almost unanimous
consensus on where we need to go.

But since Adrian's drawn you onto the topic, and since you've given me
an insight into what your objection is, I'll respond...

I don't think anyone imagines that a potential 'kabi' directory would be
used to specify anything like a _library_ interface, or that random
userspace programs would use stuff like 'struct stat' directly from it.
That would be like going back to the dark old days of libc5, and makes
me shudder as much as it does you.

Glibc has all that crap to define the interface between it and _its_
users. Its version of stuff like 'struct stat' may indeed vary according
to __USE_FILEOFFSET64 and the random standard of the day. We certainly
don't want to get involved with that kind of mess, I agree.

Our headers describe only _our_ interface to userspace, which often
bears no relation to glibc's interface to its users. We don't need to
care about our headers being usable in general by userspace
applications; only that they're useful for glibc. (With the exception of
stuff which defines ioctls, sockopts, etc.; obviously those are used by
system libraries and utilities rather than just glibc, but still -- it's
not just "random cross-platform POSIX userspace".)

Nobody _wants_ the hellish things you seem concerned about. All we want
to do is _think_ a little bit about avoiding gratuitous namespace
pollution in the headers -- for example, we should use only types like
__u32 instead of uint32_t and u32, we should refrain from exposing
private helper inlines, etc.

That's precisely what my cleanups have been fixing. It's not about
conforming to POSIX and other random standards so that our headers are
'clean' for direct inclusion as part of standard headers. This is _our_
interface, and our definition of it. It's just a case of being a little
bit disciplined about it rather than polluting it with internal crap.

Distinct from the cleanups, my existing 'make headers_install' takes the
limited set of headers which actually contain user-visible stuff, and
runs them through unifdef to get a consistent set of headers which all
distributions can use. The cleanups are just what was necessary to get
the resulting exported headers to the point where I can build glibc
against them on ppc, ppc64, i386, x86_64, s390, s390x and ia64. That's a
massive step forward, and it's all I really want to concentrate on right
now rather than talking about any potential 'next step'. What I'm doing
now stands on its own and is necessary.

However, there does seem to be a consensus that ifdefs are best avoided,
and that we should avoid them by splitting private stuff into one file,
public stuff into another, then including the latter from the former. I
haven't done that in the hdrcleanup-2.6.git tree; I've mostly just moved
stuff inside _existing_ '#ifdef __KERNEL__' guards within the same file.
But I _have_ done it in the past for include/linux/mtd/ (and put the
user-visible bits into linux/mtd/) and it's _much_ nicer that way.

_If_ we do that kind of thing, then it also makes some sense for the
user-visible files to be in one directory, and the private files to be
in another directory. That's just good practice.

That's all Adrian and others are talking about when they talk of a 'kabi
directory', I believe -- not your dystopian vision of trying to make our
headers conform to random standards-du-jour, but just treating them the
the same as we try to do in the actual C files through out the kernel --
avoiding ifdefs by splitting stuff into separate files, and grouping
those files into appropriate directories.

I think they're right, but I'm not arguing that point right now because
it's secondary to my task at hand, which is identifying the private vs.
public stuff in the first place and reducing the pollution so that our
headers are actually usable to build glibc again. In particular, I don't
want that discussion to get in the way of what I'm doing right now.

-- 
dwmw2

