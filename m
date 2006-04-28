Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWD1Azn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWD1Azn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWD1Azn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:55:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751720AbWD1Azm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:55:42 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	 <1146105458.2885.37.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	 <1146107871.2885.60.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	 <20060427213754.GU3570@stusta.de>
	 <Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
	 <20060427231200.GW3570@stusta.de>
	 <Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 01:55:59 +0100
Message-Id: <1146185760.13540.199.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 17:01 -0700, Linus Torvalds wrote:
> As long as people realize that any kabi headers would only ever be used by 
> system libraries _internally_ to build themselves (or strange system 
> tools, of course), then I'm happy. I just get the feeling that people 
> don't always realize that, and they really want to see it as some kind of 
> "/usr/include/bits" kind of thing.

Absolutely. There's no justification for kernel headers being treated
like that -- and one of my goals is to _reduce_ the amount they get
abused in that fashion. Certainly nobody wants to allow the abuse to
increase.

And of _course_ there are people who don't fully grasp the situation.
We've been entirely inconsistent about it with the "Never use kernel
headers" mantra, when we _know_ it actually has to be done in certain
special circumstances.

That's _why_ I want a 'make headers_install' which copies out (and
unifdefs) a strict subset of headers which were chosen by hand -- it
makes it very clear what is permitted, and what is not. Traditionally,
distributions have been far too liberal about what they've exposed, and
it's led to people doing insanely broken things like using
<asm/atomic.h> even though it isn't even actually atomic on i386 in
userspace. That needs to stop.

There is a small set of headers which we _need_ to export, for the
benefit of glibc, gdb and some Linux-specific tools which use ioctls and
sockopts. Nothing else should be exposed; random userspace apps
shouldn't _want_ to include kernel headers.

The point of what I'm doing is to be strict about what we export, to
_discourage_ the abuse of stuff which shouldn't really have been visible
in the first place. And to be _consistent_ across Linux distributions
about what is available and what is not. (With the vast majority being
'NOT', because that's just sane.)

That's what git://git.infradead.org/hdrinstall-2.6.git is about.


As a separate quality of implementation issue, those headers which we
_do_ need to export should be exported in a form which is actually
useful, and which doesn't require each distributor to maintain their own
fork by hand or use evil sed tricks like this one the Gentoo maintainer
showed me...

headers___fix() {
	# Voodoo to partially fix broken upstream headers.
	# Issues with this function should go to plasmaroo.
	sed -i \
		-e "s/\([ "$'\t'"]\)\(u\|s\)\(8\|16\|32\|64\)\([ "$'\t'"]\)/\1__\2\3\4/g;" \
		-e 's/ \(u\|s\)\(8\|16\|32\|64\)$/ __\1\2/g' \
		-e 's/\([(, ]\)\(u\|s\)64\([, )]\)/\1__\264\3/g' \
		-e "s/^\(u\|s\)\(8\|16\|32\|64\)\([ "$'\t'"]\)/__\1\2\3/g;" \
		-e "s/ inline / __inline__ /g" \
		"$@"

That's what git://git.infradead.org/hdrcleanup-2.6.git is about. It's
just simple fixes.


What Adrian brings up is a _third_ issue, one which is fairly
uncontentious in the context of C files: that ifdefs are generally bad
and should be avoided. Instead of using ifdefs, it's nicer to split
stuff into separate files. Also, files should be grouped together into
directories as appropriate for their purpose. 

In the specific case of kernel headers, the consensus seems to be that
we should tend to avoid __KERNEL__ by making separate 'public' files for
those bits which _have_ to be public -- we can include those public
files from other, entirely-private, files. And there also seems to be
agreement that those 'public' files should live in a directory together
where we can immediately see when we're changing the ABI, etc. For want
of a better name, people have referred to this as a 'kabi directory'.

I've been avoiding this third issue since it seems to cause you a lot of
concern -- perhaps because we'd managed to miscommunicate the intent,
and we shouldn't have said "public" when we do really mean it's only for
Linux-specific libraries and tools, not 'public' for general
applications. I've also been avoiding it because with my new 'make
headers_install' it isn't _quite_ so much of an issue as it once was --
although I do still agree with the general consensus that it's probably
a good idea anyway.

-- 
dwmw2

