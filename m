Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbUK3VXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUK3VXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbUK3VXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:23:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262321AbUK3VWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:22:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	<oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 30 Nov 2004 19:22:22 -0200
In-Reply-To: <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
Message-ID: <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 29 Nov 2004, Alexandre Oliva wrote:
>> 
>> I don't see it as obvious at all.  The need for an agreement between
>> two parties on an ABI doesn't imply that one party gets to define it
>> and the other gets to follow it. 

> Sorry, but that's not how it works.

Then maybe this is the fundamental problem.  As long as the kernel
doesn't recognize that an ABI is a contract, rather than an
imposition, kernel developers won't care.

But guess what?  Kernel developers *do* care about maintaining the
userland ABI.  They don't just go wild changing data types,
structures, renumbering system calls and all that sort of nasty stuff
because there's a contract with userland that they don't want to
break.  Because breaking this contract would be a stupid thing, that
would require all affected userland to be modified to cope with the
change, even if that's just a recompile using the new kernel
headers...  erhm...  using the result of applying the kernel ABI
change in the copy/extract/whatever of kernel headers that userland is
entitled to use.


As long as we recognize that the notion that the kernel<->userland ABI
is a separate entity, that enables kernel and userland to exchange
information, rather than something that the kernel defines and
userland must follow, we give strength to the argument that userland
is not a derived work from the kernel.  If this argument proves to be
false, then only works released under the GNU GPL or a compatible
license will be allowed to run atop of Linux, because libc would be a
derived work, its license would become full GPL, and any program
linked with it could only be distributed under the full GPL.  Oh, and
just in case, IANAL :-)

Again, I wouldn't mind that at all, but I'm sure others feel
otherwise.  Besides, as I wrote before, if this is the intent, I'd
rather have it exposed in clear, rather than seeing people being
misled to believe it's fair game to run non-GPLed software on
Linux-based operating systems.

> He who writes the code decides what it is.

I've been in projects in which I wrote ABI headers before the
corresponding kernel port had even started.  Sometimes, quite
unfortunately, the kernel engineer went ahead and wrote headers with
slightly different assumptions, and then we had to get together to
define what the ABI was going to be.

In fact, the way you seem to want things to be, you want both kernel
and userland to write the code, and somehow hope they magically match
each other.  That's not how things work.  The way things work is that
either you get agreement first, or each end goes on its way and then
at some point they figure out where they diverged and fix things up,
or one end goes first and the other takes the definitions and uses
them.  It's in no way a kernel->userland one-way street.  It's a
language (for lack of a better word) that kernel and userland choose
to exchange information, not one that the kernel invents and then
requires others interested in talking to it to learn (you know, that
``Do you speak English/my language?´´ phrase so common in Hollywood
movies in which an American character needs to talk to someone abroad
:-)

Sometimes you'll even find formal ABI specifications, written down
before either userland or kernel start being developed.  Claiming that
the kernel gets to set the ABI as it wishes, without worrying about
userland because it never calls userland is a very narrow view, and in
some cases it's even a lie.  Think signal handling and process
start-up, for example: if you don't follow the userland ABI to call
the function pointer given to the signal function, or if you don't
follow the userland ABI to start the program's entry point, it's not
userland that is broken, it's the kernel.

> In this case, if the kernel 
> does a new extension, it's the kernel that gets to decide what it is. 

As in, say, NPTL?  As if a number of userland considerations hadn't
driven most of the design decisions behind the then-defined ABI
extensions?

> If glibc wants to do something new, go wild. The kernel won't care.

This is not about glibc.  That's not the only userland component.
There are several different alternatives one can use.

And then, the kernel will care, because it has to.  A kernel without
userland is nothing.  A kernel that kept introducing incompatible ABI
changes would die a very quick death.  A kernel has to be very careful
about complying with the ABI it shares with userland, and you know
that, because you do care about it.

> And that's really the fundamental issue. The kernel does not care what
> user land does. The kernel exports functionality, the kernel does _not_
> ask user land to help.

I'm not so much talking about the hundreds of syscalls, the syscall
conventions and the number and type of arguments given to each
syscall.  This is not even well defined in kernel headers.  All that's
exported regarding syscalls is a mapping from syscall names to
numbers.

What I'm talking about is the data structures.  Sure, the kernel can
define these however it likes.  So can userland.  The point is that,
if they don't match, when you get userland and kernel together, in the
hopes of getting something useful done, it doesn't work.

Both ends can come up with extensions, and do things the old way until
the other end picks up the extension.  I'll give you that many
extensions make to the kernel before say glibc, but that's mostly just
like, when we create a new toolchain port, assembler and linker are
generally implemented before the compiler.  I guess it just makes more
sense.  It wastes less effort to make sure you got something right in
a lower layer before you build something atop of it.  It's unlikely
that a change would make to glibc if it used a feature that isn't
available in the kernel, just because most often features undergo
(minor or sometimes major) changes when they're integrated, and it's
easier to fix things up if you haven't committed to the way that
didn't make it there yet.

> That _does_ make it a one-way street. Sorry.

Good, we're getting somewhere.  This is surely better than a zero-way
street, i.e., one in which headers that specify the ABI don't flow in
any direction.  If we're agreeing to make it one way, let's make it
so: have headers that are maintained as part of the kernel, and that
are imposed, if you like, on userland.  Saying it's a one-way street
but denying others from taking what comes their way through this
one-way street hasn't been very effective :-)

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
