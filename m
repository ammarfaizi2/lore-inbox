Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVJDWqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVJDWqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVJDWqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:46:42 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:52871 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964955AbVJDWqm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:46:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Date: Wed, 5 Oct 2005 00:47:45 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
References: <20051002231332.GA2769@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz>
In-Reply-To: <20051004205334.GC18481@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200510050047.45697.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 4 of October 2005 22:53, Pavel Machek wrote:
> Hi!
> 
]-- snip --[
> > > That does not belong to snaphost. The rest is notthat clear, but I have it
> > > working in userspace.
> > 
> > Of course it is doable in the userland, but this does not mean it should be
> > done in the userland.  Personally I don't think so (please see
> > below).
> 
> Even if you don't agree with putting it to userland (and that's
> neccessary -- if we want some features from suspend2), split still
> makes sense.

I do agree with that and yes the split makes sense.  The only problem is
I don't think the line of splitting, so to speak, is not very well defined.
I mean there are some functions that belong to the "grey zone"
and there really shouldn't be any.

> > > Image creation is still done in kernel space, but I think that kernel
> > > <-> user interface is going to be cleaner that way, and I do not think
> > > pushing it to user is so huge win.
> > > 
> > > Yes, names are not ideal, but that will be followup patch.
> > 
> > Having considered it for a while I think it's too early for the splitting,
> > because:
> > 1) we have bug fixes pending (viz. the x86-64 resume problem),
> 
> It is in arch-dependend code, only. It does not even conflict with split.

Well, that depends on which solution we'll end up with.  I hope the last one,
ie. allocation of the resume page tables in the init code, in which case
it won't conflict with the split, indeed.

> > 2) we can simplify swsusp quite a bit thanks to the rework-memory-freeing
> > patch (eg. we can get rid of eat_page(), free_eaten_memory() and
> > some complicated error paths in the resume code), which I'd prefer to do
> > before the code is split,
> 
> Well, same cleanup can be done after the split, just as easily.
> 
> > 3) some cleanups are due before the splitting (eg. function names, the removal
> > of prepare_suspend_image() etc.),
> 
> Split does not prevent you from doing the cleanups.

No, it doesn't, but the flow of changes would be easier to follow if the
cleanups were made first (ie. cleanup -> smaller and simpler code -> split).

> > 4) we could make swsusp consist of two functionally independent parts (ie. such
> > that they use different data structures etc.) while it is in the single file
> > and _then_ split.
> 
> The order of cleanups does not matter.

>From the final code point of view, it doesn't, but by applying the cleanups
after the split we would make the whole thing practically irreversible.
I mean if we find out at some point that the split is not so great idea,
whatever the reason, we'll have to undo the cleanups to revert it and
apply the cleanups again.  By applying the cleanups _first_ we won't have
to undo them in either case.

> > IMHO there could be the snapshot-handling part and the storage-handling
> > part interfacing via some functions (called by the snapshot-handling part)
> > like:
> 
> No. It needs to be controlled by storage-handling parts, so that
> snapshot-handling parts become nice library.

You are right, I have confused the sides.  I should have said like that:
The snapshot-handling part makes some functions available to the
storage-handling part.  The storage-handling part initializes suspend
or resume by calling specific function from the snapshot-handling part.
Then, it sends pages of data to the the snapshot-handling part or
receives pages of data from it (as many pages as needed).  Finally,
it callls a function to finalize the process.

The whole point is that the storage-handling part need not care for
what data are contained in these pages as long as it is able to send or
receive them is a specific order.  On the other hand, the snapshot-handling
part need not care for what happens to the pages of data send to the
storage-handling parts as long as it can receive them back in the same
order in which they have been sent.

]-- snip --[
> 
> That is ugly. snapshot needs to be called from storage handling parts,
> and then interface can become much simpler:
> 
> struct pbe *sys_snapshot();
> 
> snapshots a system, then you can save it in any way you want. And
> 
> void sys_restore(struct pbe *);
> 
> . Simple, eh?

Well, aren't there any problems with handling kernel addresses from the user
space and vice versa?

Anyway, I think on resume we should send data from the user space to the
kernel and let the kernel arrange them in memory instead of placing them in
memory directly from the used space.  By symmetry, on suspend we should send
data from the kernel to the user space instead of allowing the users space
to read memory at will.  IMO the arrangement of the data in memory should
not be visible to the user space at all.

]-- snip --[ 
> Lets do it different way. Give me two weeks to do my cleanups. The
> initial code move is big, but things get pretty easy from then on. I
> break nothing, your cleanups will still be possible. Preview of some
> cleanups follows...

OK

Still I'm afraid in the future we'll be moving some functions between
snapshot.c and swsusp.c back and forth ...

> Cleanup comments, remove unneccessary includes.

Sure all of this should be applied.

Greetings,
Rafael
