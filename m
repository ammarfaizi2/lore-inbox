Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVATKpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVATKpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 05:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVATKpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 05:45:54 -0500
Received: from mx1.elte.hu ([157.181.1.137]:44509 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262110AbVATKpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 05:45:38 -0500
Date: Thu, 20 Jan 2005 11:44:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050120104451.GE12665@elte.hu>
References: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEA86D.7020108@comcast.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Richard Moser <nigelenki@comcast.net> wrote:

> I respect you as a kernel developer as long as you're doing preemption
> and schedulers; [...]

actually, 'preemption and schedulers' ignores 80% of my contributions to
Linux so i'm not sure what to make of your comment :-| Here's a list of
bigger stuff i worked on in the past 3-4 years:

  http://redhat.com/~mingo/

as you can readily notice from the directory names alone, 'preemption
and schedulers' is pretty much in the minority :-|

and that list i think sums up the main difference in mindset: to me,
exec-shield is 'just' another kernel feature (amongst dozens), which
solves a problem. I'm not attached to the concept/patch emotionally, i
only want to see a solution for a problem in a pragmatic way. Playing
with lowlevel segment details is not nice and not always fun and results
in tradeoffs i dont like, but it's pretty much the only technique that
works on older x86 CPUs (as PaX has proven it too). If something better
comes along, then more power to it.

> [...] but I honestly think PaX is the better technology, and I think
> it's important that the best security technology be in place. [...]

i like PaX's completeness, and it has different tradeoffs. There is one
major and two medium tradeoffs that PaX has, from a distributor's POV:

1) the halving of the per-process VM space from 3GB to 1.5GB.

[ 2) the technique PaX uses (mirrored vmas) is pretty complex in terms
     of MM code. ]

[ 3) requires manual tagging of applications. ]

The technique exec-shield uses (to track the per-process 'highest
executable address') is pretty simple and non-intrusive on the
implementational level, but it also results in exec-shield's main
tradeoff:

   certain VM allocation patterns (e.g. doing mprotect() on an area that
   was allocated not via PROT_EXEC and was thus mapped high) can reduce
   exec-shield to 'only protects the stack against execution', or if
   the application needs an executable stack then reduces exec-shield to
   'no protection'.

it turns out these cases where exec-shield gets reduced are quite rare
and dont happen in critical applications. (partly because we fixed
affected critical applications - such fixes made sense even when not
considering the exec-shield impact.)

If a 'generic' distribution (i.e. one that has a significant userbase,
has thousands of packages that do get used) deviates from mainline it
wants to do it as simply as possible. (otherwise it would have the
overhead of porting/testing those deviations all the time.) In fact,
most of the extra patches that distribution kernels apply are patches
that they think will go mainline soon. If they apply any patch they know
wont be merged anytime soon they only do it if it is really needed, and
even then they try chose the variant that is smaller and easier to
maintain. Another important aspect is that extra patches should
obviously _widen_ the utility of the system, not narrow it.

On x86, VM space is scarce so PaX's halving of the VM space is a
'reduced utility' problem. (yes, you can turn it off per application and
get processes that have 3GB of address space, but that removes security
for those processes. Also, you cannot know in advance whether an
application will use more than 1.5GB of VM - different systems have
different usage patterns.)

[ PaX's #2 tradeoff is a maintainance overhead issue. Not an
  insurmountable issue because it is well-written kernel code, but
  combined with #1 it can tip the scale. PaX's #3 tradeoff is fixable -
  it could very well use the PT_GNU_STACK code now upstream. ]

you seem to be arguing for a 'no prisoners taken' approach to security,
and that is a perfectly fine approach if you maintain your own variant
of a distribution.

the other approach to security (which Fedora follows) is to 'make it as
seemless and automatic as possible, so that people actually end up using
our stuff.'

so while exec-shield is not "complete" in the sense of PaX, in practice
it is like 99% complete. E.g. on my Fedora desktop box:

  $ lsexec --all | grep 'execshield enabled' | wc -l
  86
  $ lsexec --all | grep 'execshield disabled' | wc -l
  0

and that's what really matters at the end of the day. (Anyway, you dont
have to believe and/or follow any of this, you are free to run your own
distribution, and if it's good then people will inevitably end up using
it.)

	Ingo
