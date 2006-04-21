Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWDUTd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWDUTd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDUTd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:33:28 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33408 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932353AbWDUTd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:33:27 -0400
Date: Fri, 21 Apr 2006 12:27:43 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: David Wilk <davidwilk@gmail.com>
Cc: Hugh Dickins <hugh@veritas.com>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
Message-ID: <20060421192743.GH3061@sorel.sous-sol.org>
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com> <20060419192803.GA19852@kroah.com> <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com> <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com> <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Wilk (davidwilk@gmail.com) wrote:
> Ok, on my first test system (lowest amount of ram) a 2.6.16.9 kernel
> patched with the patch you provided works fine.  I'll throw it on some
> other systems and we'll see how it does.

Was that same (lowest amount of ram) system failing before Hugh's patch
with vanilla 2.6.16.9?  What we're looking for is to see if the app
was doing:

1) shmget(0444) [RDONLY], shmat(SHM_RDONLY), mprotect(PROT_WRITE)
or
2) shmget(0666) [RDWR], shmat(SHM_RDONLY), mprotect(PROT_WRITE)

The first is definitely a bug, and that's what the original patch
was closing.  The second is technically (as in POSIX) undefined, and
the original patch treated it as a bug as well.  Hugh's additional
patch allows this behaviour, as it's vaguely similar to open(RDWR),
mmap(PROT_READ), mprotect(PROT_WRITE), which is legitimate.  So we're
trying to determine if that's what your app is doing.  strace output
may be unwieldy, but that (or using syscall audit) would be helpful
to clarify.

thanks,
-chris
