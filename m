Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbULBVsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbULBVsC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbULBVsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:48:02 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11443 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261768AbULBVrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:47:51 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@gmail.com>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0412020727370.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>
	 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
	 <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
	 <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org>
	 <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org>
	 <84144f020412020129e5d0566@mail.gmail.com>
	 <Pine.LNX.4.58.0412020727370.22796@ppc970.osdl.org>
Date: Thu, 02 Dec 2004 23:46:11 +0200
Message-Id: <1102023971.10250.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004, Pekka Enberg wrote:
> > How is a class interface different from an external API?

On Thu, 2004-12-02 at 07:35 -0800, Linus Torvalds wrote:
> It's different from an external API exactly because it's not "external". 
> 
> I dunno about you, but the (admittedly few) explicitly object-oriented 
> projects I've seen from the inside, the class interface is something that 
> you consider internal to your project, and are willing to change.
> 
> In Linux, the VFS layer comes pretty close: it's really very much about
> object-oriented programming, except the implementation is explicit rather
> than left up to the programmer. And we have very explicit rules on how
> you're supposed to do things: some are even _documented_ (oh, horrors) in
> Documentation/filesystems/vfs.txt.
> 
> And yes, in this kind of environment I actually think "contract" makes 
> some kind of sense, because it is an internal thing that _has_ come out of 
> agreement on both sides, and where changes need to be agreed upon by both 
> user and definition. It's not an a-priori interface, it's something where 
> both sides are intimately involved.

I tend to think the other way around actually. For published (external)
APIs, contracts are far more important because you cannot review or test
the callers. For internal APIs, contracts can be more relaxed as you
usually have full control over the codebase. So no, I don't think
contracts are for internal use only.

On Thu, 2 Dec 2004, Pekka Enberg wrote:
> > I think Alexandre's definition has in fact originated from the "Design
> > by Contract" cult. And it's all pretty simple stuff:
> > 
> >   - You need to call a function in a certain way (precondition). The
> >     caller fills this part
> >     of the contract. Now the caller can _expect_ something from the
> >     function (see below).
> >   - The function does what it has promised to do and optionally
> >     returns some values
> >     (postcondition). The callee fills this part of the contract.
> >   - The function expects some parts of the system state to remain stable during
> >     execution (invariants). In the kernel, you use BUG_ON for these btw.
> > 
> > So there's nothing new here really. However, if your _tools_ support
> > Design by Contract, you can be explicit about this and enforce the
> > 'contract' during compile-time or run-time.
> > 
> > And I think you're already doing this with your "require spinlock to
> > be taken" sparse thingy...

On Thu, 2004-12-02 at 07:35 -0800, Linus Torvalds wrote:
> Yes. And I think it makes sense _internally_ for a project. 
> 
> But pretty much by definition, that's not an ABI. That's an "internal 
> interfaces" kind of thing.

And why not externally too? There are elements of a contract, I think.
The kernel, for example, dictates that you must invoke syscall A with a
pointer X pointing to an memory region of size E. Now, if the userland
follows that contract, it gets service; otherwise it won't. And as soon
as the userland _agrees_ with the contract, the kernel _must_ deliver
the service as specified by the contract.

Please note that the kernel may change the contract on its part any time
it wishes to do so. The userland can either accept the fact or reject it
and live without the service. And this is what you're essentially doing
right now. The only thing you're missing is actually _enforcing_ those
contracts.

But anyway, I think I'm twisting the original definition of Design by
Contract here for my own purposes and the only thing I violently
disagreed with you was the fact that you claimed Alexandre was making up
terms. ;)

On Thu, 2 Dec 2004, Pekka Enberg wrote:
> > I don't think it's an US thing. At the university you did your CS
> > stuff, we (well at least I) use the term 'contract' pretty much the
> > same way Alexandre does...

On Thu, 2004-12-02 at 07:35 -0800, Linus Torvalds wrote:
> It may also be a new thing. Dammit, when I started, we had USCD Pascal,
> and we were happy. None of this OO stuff ;)

Yeah, they've ruined it completely now. They're pushing Java right from
day one to youngsters :-)

			Pekka

