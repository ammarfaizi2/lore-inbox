Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbUKCW2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUKCW2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUKCW04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:26:56 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:10661 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261883AbUKCWU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:20:26 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
Date: Wed, 3 Nov 2004 23:17:21 +0100
User-Agent: KMail/1.7.1
Cc: Gerd Knorr <kraxel@bytesex.org>, LKML <linux-kernel@vger.kernel.org>
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com> <200411031659.56887.blaisorblade_spam@yahoo.it> <20041103201001.GA29289@bytesex>
In-Reply-To: <20041103201001.GA29289@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032317.21886.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 21:10, Gerd Knorr wrote:
> On Wed, Nov 03, 2004 at 04:59:56PM +0100, Blaisorblade wrote:
> > On Wednesday 03 November 2004 09:32, Gerd Knorr wrote:
> > > Nuno Silva <nuno.silva@vgertech.com> writes:
> > > > Yes, maybe it was me and, FWIW, I never found a solution to make a
> > > > dynamic skas uml run under 2.6+libcNTPL.
> > >
> > > The usual workaround for any nptl issues works here as well:
> > > export LD_ASSUME_KERNEL=2.4.21
> >
> > You mean 2.4.1 IIRC, right?
>
> The exact version doesn't really matter I think.
More or less, it's true. The value is checked against 2.2.5 for base , 2.4.1 
and 2.6.0 for using NPTL.

On a RH 9, instead, IIRC 2.4.20 is the minimum for using NPTL. More details 
can be found at http://people.redhat.com/drepper/  (there is a 
LD_ASSUME_KERNEL link).

> > However, that does not work on LinuxFromScratch and Gentoo systems,
> > mostly, which miss a non-NPTL glibc version.

> Yes, you need a non-nptl glibc version for that, otherwise the dynamic
> linker can't use it obviously ...

And this means that we must fix UML for NPTL. Also, the problem is strange: 
the child and the father, when created linking with NPTL, get the same pid, 
so os_stop_process (i.e. kill(SIGSTOP, child_pid)) kills the whole process. 
In fact, replacing those with gettid() and tkill() appears to fix the 
problem.

But:

1) This should not happen, since clone() is not called with CLONE_THREAD (I 
verified that CLONE_THREAD is not used even with NPTL, so glibc is not doing 
anything strange here).

2) So, we get a host bug.

3) In fact, on my current Gentoo, Mplayer appears to experience a similar 
behaviour (it stops itself on entry and exit). It could be something 
unrelated, but it seems to me a host bug.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
