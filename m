Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUBQX6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUBQX6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:58:19 -0500
Received: from dp.samba.org ([66.70.73.150]:54713 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266720AbUBQX5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:57:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.43626.191682.882729@samba.org>
Date: Wed, 18 Feb 2004 10:57:30 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
	<16433.47753.192288.493315@samba.org>
	<Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
	<Pine.LNX.4.58.0402170833110.2154@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > It's also hard to know what to do when there are two filenames that
 > literally _are_ the same when not comparing cases. Which can obviously
 > happen under Linux - you'd have a case-sensitive app that creates a both
 > "makefile" and "Makefile", and now you have a case-insensitive app that
 > looks it up (or worse, removes it), and what the *heck* is the dcache now
 > supposed to really do?

This is really not as bad as it first seems. Just think what the
absolutely obvious thing to do is and do that. It's like all those
things in POSIX where it says "if you do XXX then the behaviour is
undefined" and the implementations end up doing whatever the heck they
find easiest to do. It's the same here.

In the example you give then you just give whatever file you come
across first or happen to have in the dcache. You can't do better than
that, as the problem is fundamentally insoluble in a sane fashion, so
just don't try. We've been doing exactly that in Samba for 12 years
(picking the first file we come across) and I can't recall a *single*
complaint about that behaviour. Users *expect* the server to just pick
one, and have no pre-conceived idea of which one it will pick.

Of course, some samba-tuned filesystem could have a mount option to
refuse to allow the creation of filenames that conflict in this way,
but don't even try to enforce this in the kernel core.

 > This is why I'd hate for the generic Linux dcache to know about case
 > sensitivity, and I'd be a lot happier having a separate path (which isn't
 > as speed-critical) that can be used to help implement helper functions for
 > doing case-insensitive things.

The problem is that if that separate path doesn't go via the dcache
then we won't get the invalidation of our negative dentries so we
won't be able to do any better than scanning the whole directory every
time to prove files don't exist. The dcache has to know about this as
its the only place where all the information that is needed comes
together (I'm sure you'll correct me if I'm wrong about this).

 > That way the bugs and strange behaviour would be all be limited to the 
 > case-insensitive special code, and not pollute the "sane" side.

except when something like a file create happens on the "sane" side of
things and we then have no way of knowing that our name space has just
changed. I suppose we could create a completely new dcache in parallel
with the current one and have some sort of notify between the "sane"
and "insane" worlds, but I suspect the glue code between them would be
worse than just adding that context bit to the main dcache.

 > For example, I fundamentally can't easily do an atomic exclusive
 > case-insensitive "create" or "rename", but we _could_ expose things like
 > directory generation counts to the special interfaces, and thus allow at
 > least "local-atomic" operations (but they would _not_ be atomic over a
 > network, to give you an idea of the kinds of _fundamental_ limitations
 > there are here).

yes, doing atomic network file operations sucks, but please don't let
that stop us doing it in a reasonable fashion for local filesystems.

Doing a nice atomic case-insensitive create or rename is really *no*
different from what we do now in Linux, it just means that we need to
have case-insensitive dentries that mean "this is a negative dentry
that covers all possible case combinations of the name it
contains". It is up to the filesystem to provide you with that -ve
dentry (just like the filesystem provides the case-sensitive -ve
dentries now) and the dcache just has to use it in the same way that
it uses the existing ones.

If you really don't want to do this then fine, in which case I'll ask
again in a year or twos time and see if I can convince you then. I
know this would make the code messier, and making code messier for the
sake of interoperability with windows is perhaps reason enough not to
do it. But please don't tell me it *can't* be done or that it is just
too hard. That's just not true.

 >  - regular atomic create of random case-_sensitive_ name using something 
 >    tempnam()-like (use a prefix that is invalid on windows or something: 
 >    make the first character be 0xff or whatever).
 >  - "read directory local sequence count"
 >  - readdir to make sure that the new name is still unique even in the
 >    case-insensitive sense
 >  - "atomic move conditionally on the local sequence count still being X"

that could make things atomic, but it won't make it fast. Think about
the fact that modern filesystems are now using better than linear
lists for directories. So in most cases lookups in large directories
can be done in much better than O(n) time (for reasonable values of
n). The above solution means Samba will never be better than O(n), so
for large directories we will always suck performance wise. It doesn't
have to be that way.

 > We can even allow that case-insensitive module to set some flags in the 
 > dentries (so that you can create negative dentries that have a flag set 
 > "this is negative for all cases").

ahh! yipee!

yes, if we have that dentry bit then we have a hope. Without that I
think it won't help much.

 > See where I'm going? Would this be acceptable to you? Are there any samba 
 > people who are knowledgeable about the VFS-layer and have the time/energy 
 > to try something like this?

I'll discuss this with some of the people here in OzLabs and see if we
can come up with a plan. I suspect most of OzLabs will be avoiding me
for a day or two in an attempt to not be the one to do this :-)

Cheers, Tridge
