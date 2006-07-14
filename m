Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161283AbWGNSsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWGNSsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWGNSsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:48:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:45962 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161284AbWGNSsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:48:53 -0400
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
In-Reply-To: <1152745664.22943.115.camel@localhost.localdomain>
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>
	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	 <1152739766.3217.83.camel@laptopd505.fenrus.org>
	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
	 <1152741665.3217.85.camel@laptopd505.fenrus.org>
	 <44B57191.5000802@zytor.com>  <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
	 <1152745664.22943.115.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 04:45:45 +1000
Message-Id: <1152902745.23037.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 00:07 +0100, Alan Cox wrote:
> Ar Mer, 2006-07-12 am 16:26 -0600, ysgrifennodd Eric W. Biederman:
> > If the lock is not short lived then the release is like to be a long
> > ways off.  If the lock is not highly contended then you are not likely
> > to hit the window when someone else as the contended lock.
> > 
> > How frequent are highly contended short lived locks in user space?
> 
> I'm not sure it matters.
> 
> If you want to do the job right then do this
> 
> - Stick an indicator of how much else wants to run on this CPU in the
> vsyscall page or similar location

Except that "this cpu" doesn't really mean anything in userspace, and
while I think Andi has some tricks to get some sort of CPU number to
userspace (though it's really only valid during the execution of the
instruction that reads it :) I haven't yet found an equivalent for
powerpc (and possibly other architectures will have the same problem).

> In your locks you can now do
> 
>               while(try_and_grab_lock() == FAILED) {
>                        if (kernelpage->waiting > 0)
>                               sys_somelockwaitthing()
>               }
> 
> Furthermore the kernel can be intelligent about the waiting indicator
> for power or other global scheduling reasons
> 
> [Disclaimer: There is a patent issue around this technique but its not
> one that will impact GPL code as permissions are given for GPL use.]
> 
> Alan

