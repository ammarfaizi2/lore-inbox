Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSH1BCW>; Tue, 27 Aug 2002 21:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318472AbSH1BCW>; Tue, 27 Aug 2002 21:02:22 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:21190 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318458AbSH1BCU>; Tue, 27 Aug 2002 21:02:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 27 Aug 2002 18:06:32 -0700
Message-Id: <200208280106.SAA05492@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: Loop devices under NTFS
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002 at 00:59:55AM +0100, Christoph Hellwig wrote:
>On Tue, Aug 27, 2002 at 04:42:56PM -0700, Adam J. Richter wrote:
>> >On Tue, Aug 27, 2002 at 06:53:19AM -0700, Adam J. Richter wrote:
>> >> 	Why?
>> >> 
>> >> 	According to linux-2.5.31/Documentation/Locking,
>> >> "->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
>> >> may be called from the request handler (/dev/loop)."
>> 
>> >Just because it's present in current code it doesn't mean it's right.
>> >Calling aops directly from generic code is a layering violation and
>> >it will not survive 2.5.
>> 
>> 	Only according your own proclamation.  You are arguing
>> circular logic, and I am aruging a concrete benefit: we can avoid an
>> extra copying of all data in the input and output paths going through
>> an encrypted device.

>I tell you that the address_spaces are an _optional_ abstraction.
>Thus using the directly from generic code is a layering violation.

	That does not follow from your previous sentence.  It is
perfectly legitimate to check for the existence of an optional feature
and use it if it is there, which is what the stock 2.5.31 loop.c and
my version do.

>This layer
>of indirection was added intentionally in 2.3, and if you want to get rid
>of it again please submit a patch to Al to merge the aops back into the
>inode_operations vector.

	Regardless of whether aops and inode_operations are merged,
you haven't shown a problem with using aops when they are present.  It
is not necessary to remerge these data structures in order to use an
optional feature if it is present.

>Otherwise I will cleanup the last remaining
>violation of that layering rule in 2.5.

	You've failed to show real end user benefits against the
disadvantage of slower encrypted devices and you're going to go ahead
anyway?  I am trying to keep an open mind here, but if you can't
provide real reasons against performance benefits and nobody else
convinces me otherwise, and you insist on trying to put through these
changes, then I think Linux will be better off if I ask Linus to
reject your loop.c patches and encourage others to do likewise.


>> While I don't have a benchmark to show you (and
>> the burden of proof is upon you since you want a change), an extra
>> copying of all data going through a potentially high throughput
>> service (like, say, all of your file systems if you're running an
>> encryptd disk), is likely to have a substantial performance impact.
>> There is a real world benefit at stake here of making strong
>> encryption as "cheap" to use as as possible.

>I am currently reviewing a patch from Jari Ruusu that does not only
>get rid of the layering violation but also provides certain advantags
>for the loop-AES crypto addon he wrote/maintains.

	Why don't you list those advantages or at least some of them?

	I have nothing against Jari, and I adapted his file_operations
change in my loop.c cleanup, but I should tell you that the last time
I looked at his changes, they created a much bigger loop.c.  In
comparison, my version fixes the serious bug of loop.c allocating
n*(n+1)/2 pages for an n page bio, cleans up the locking dramatically,
eliminats the need to preallocate a fixed number of loop devices,
exports the DMA parameters of each underlying loop devices to enable
handling of bigger bio's, eliminates unnecessary data copying (via
bio_copy, not just the aops stuff we have been talkign about), a
generally makes it a lot more readable.  Before I put in the
file_ops->{read,write} stuff, my changes actually shrunk loop.c.

>I doubt he would do
>so it it kills performance for his application.

	There is a difference between killing performance and making
enough of a difference to warrant an engineering decision.
Differences that warrant such changes can be small enough that you
need to do benchmarks to be sure of them.  People present lots of
papers on measurement results in Linux at conferences because of this.
In general, and extra copy of all data on the input and output data
paths is a big deal.

>Neverless I must say
>I don't care at all for performace of encrypted loop:  It's not merged,
>and mainline correctness has a _much_ higher priority for me than
>performance of external code.

	Again, your only definition of "correctness" is by your own
proclamation.  Linux isn't just for your personal interests.  Anyone
who filters patches on that basis is abusing the trust placed in him
or her.  If you care that little about a major use of loop.c, then
Linux will be better off if you stay out of the patch approval path
for it.

>You argue for performace at the cost of correctness.

	Again, your definition of "correct" is only your own proclamation
against my real world benefits.

>> >Separating a stackalbe encryption block device from the loop driver is
>> >a good idea.  The current loop code is a horrible mess because it tries
>> >to do the job of three drivers in one.
>> 
>> 	Just saying "good idea" is no substitute for an argument about
>> real world benefits, like performance, code footprint, etc.

>Correctness and cleanness.

	If we discount circular proclamation ("correct is what I
say"), I think my loop.c patch is by far the cleanest implementation
(granted, I still need to submit a patch to deal with bio_copy
failing, but that is not very rare occurance now that I have fixed the
n**2 pages bug, and the infrastructure for it is in my latest patch).

[...]
>If you think that the guarantee that every filesystem should be pagecache
>backed is worth documenting (and adopting everything to it), feel free to
>submit a patch for review.

	In the meantime, it is not a layering violation to check for
an optional feature and use it if availalbe.

	Actually, if someone implements
tmpfs->aops->{prepare,commit}_write, then I would be happy to have
writable /dev/loop work only on file systems that provide
{prepare,commit}_write, as I think the only remaining one would be
intermezzo (which perhaps could also be fixed, but I believe has few
users and is likely to be replaced by Lustre).


>I have stated above why it's not a good idea.

	No, you haven't.  I have asked you repeatedly.  Please provide
a narrative that shows where there can be a behavior that users will
dislike more than the performance penalty of your approach.  Walk me
through the call graph.  If the facts are on your side, why can't you
explain such a scenario clearly?

	If I wanted to argue circular proclamations like you are
doing, I could complain about the kernel code basically pretending to
be a user process with set_fs(), make hokey claims it is a "layering
violation" to call blk_run_queues, etc., but I don't, because I know
that benefits to the user are the purpose that discliplines are
supposed to serve, and that it is sometimes delivers more benefits to
question and adjust such practices accordingly.  In this particular
case, by the way, the documentation (Documentation/Locking) is even on
my side, so it's really you who are arguing for a change in practice,
and all you can cite is a circular proclamation that boils down to
"because I say so."

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
