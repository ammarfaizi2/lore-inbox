Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUBQB0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUBQB0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:26:20 -0500
Received: from mho.net ([64.58.22.195]:43229 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S264477AbUBQBZ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:25:57 -0500
Date: Mon, 16 Feb 2004 18:24:09 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@sm1420.belits.com
To: Marc Lehmann <pcg@schmorp.de>
cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040216200321.GB17015@schmorp.de>
Message-ID: <Pine.LNX.4.58.0402161603420.10177@sm1420.belits.com>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Marc Lehmann wrote:

> > I have never claimed that the kernel really talk s UTF-8, and indeed, I
> > would say that such a kernel would be terminally and horribly broken.
>
> And I'd say such a kernel would be highly useful, as it would standardize
> the encoding of filenames, just as unix standardizes on "mostly ascii"
> (i.e. the SuS).
>
> However, just as POSIX is a nice but very limited base, (mostly) ASCII
> is a nice and very limited base. UTF-8 would also be a good base.

  UTF-8 is dependent on Unicode, that is cumbersome, not user-expandable,
not includes an ability to reliably implement subsets of it, poorly
supports language identification/language-dependent processing, and is
controlled by a single organization with extremely poor ability to
incorporate changes into the standard when it becomes necessary. This
means, it's quite possible that this standard will be replaced by
something better in the future when multilingual documents will become
widely used -- right now they certainly are not, and this is why poor
design of Unicode is tolerated by users, and this is also why many people
use non-Unicode-based charsets. Enforcing UTF-8 will burn the bridges to
any other language support infrastructure or encoding, right at the time
when such infrastructure is likely to be created.

> 8-bit bytes as filenames is not a good base, however, since they enforce
> a difefrent layer of interrpetation between the user and the kernel, and
> this interpretation cannot be based on the locale nor the filesystem
> itself, as there is no way to find out what encoding the filename is in.

  This is a matter of GUI implementation. If someone cared about this, he
would store language metadata with filename, too, however this is clearly
contrary to the Unix filesystem design.

> 8-bit bytes is convinient, but not useful for i18n environments. in the
> past, it was also convinient and nobody cared, since everything was
> either 8-bit or double-byte, and nobody exchanged files.

  I did, and it worked _fine_. Everyone who is willing to use UTF-8 is
free to do this right now, and everything will already work great for
them. Writing software to deliberately enforce UTF-8 is something
completely different from using UTF-8 for yourself.

> This, however, is going to change, and the current methodology of "just
> guess, you might be right" is a hindrance to this.

  This was "going to change" for more than a decade already, or,
alternatively, already happened if you listen to someone like Martin
Duerst. The reality is, everything can pass UTF-8 already, yet people use
other encodings for everything, too, and as long as they don't break,
things work. Breaking byte-value transparency in any place in the system
is counterproductive until the moment when everyone uses UTF-8. But I hope
before that day comes, UTF-8 and Unicode will be replaced with something
more sane.

> > The kernel is _agnostic_ in what it does.
>
> No, it's not. If at all, the kernel specifies a specially-interpreted
> (ascii sans / and \0) byte-stream, as you say yourself.
>
> However, just as with URLs (which are byte-streams, too), byte-streams are
> useless to store text. You need bytestreams + known encoding.

  MIME has a perfectly usable standard for declaring encodings, and huge
amounts of text (that may include filenames) are distributed by
MIME-compliant or MIME-like protocols (mail and HTTP, to name two). This
keeps the metadata in the userspace, and it also happens that everything
that displays multilingual text is entirely in userspace. Why kernel is
supposed to mess with this, is beyond me.

> If filenames were not names, but just binary id's I would agree, but
> this is not at all how filenames are used not how their use is applied.
>
> Filenames are composed of text, but the kernel gives no indication
> on how to interpret this text, and as a matter of fact, nothing else
> gives this indication. glib etc. uses G_BROKEN_FILENAMES to force
> locale-encoding. But as others have said, one mans locale is unlike other
> mens locale.

  And this is perfectly fine. Displaying and editing multilingual text is
a user interface issue, that kernel should not be involved in. Dealing
with locales is not limited to displaying but includes input methods, and
in many cases text processing, hyphenation rules, phonetic matching, etc.
that are specific to locale. Nothing in UTF-8 helps with those things,
they still have to be done based on metadata that is entirely in
userspace.

  I admit that some of my time would be better spent if I did a design of
an expandable pluggable language support modules library that would
understand "strings with metadata" and support some kind of stateful
language/encoding serialization for this purpose. It doesn't look like the
multilingual documents are common enough to justify designing such a thing
yet, however if such system was developed, it would be a good example of
how expandability is at best ortogonal, and at worst poorly compatible
with enforcing Unicode. Obviously, all this will have to be done entirely
in userspace, and all that it will require from kernel is byte-value
transparency. Singling out filenames as something that has to use a
particular encoding, just because current king of the i18n mess is
Unicode, is at least nearsighted, at most inconsistent.

> > really care AT ALL what you feed it, as long as it is a byte-stream.
> >
> > Now, that implies that if you want to have extended characters, then YOU
> > HAVE TO USE UTF-8.
>
> You say so, but there is no logical connection between these two
> statements. I can store latin1 easily in a bytestream, as I can store
> iso-2022-jp or euc-jp. But they are incompatible to UTF-8.

  Latin1 is most likely to be stored in iso8859-1, with a single currently
widely used exception of MS Word and similar programs. I hope, it is
pretty clear that what those programs operate on, is not plain text, and
can not replace plain text any soon.

> You are yelling at me for no good reason. "YOU HAVE TO USE UTF-8". Why
> should this be? The kernel certainly enforces this. Even you claim that
> I don't have to, as the kernel doesn't care.
>
> However, if you think so violently that it has to be UTF-8 that you even
> yell it, then why doesn't the kernel comply to this rule? Why should an
> applicaiton "HAVE TO" use utf-8 for input when the kernel doesn't even
> try to comply and hands out illegal output?

  If the program breaks on the malformed input, it's a bad program in the
first place. And if it makes assumptions about what is "malformed" based
on something that other users may disagree with, it's a problem of either
program's users or authors. OS kernel may be in a position where it can
step in and resolve this dispute in favor of either group, however it will
be highly inappropriate to do so based on some little discussion between
UTF-8 supporters and opponents that we can have here.

  I can point at the example of this "solution" that happened years ago
when UCS-2 was all the rage, and it got hardcoded and enforced by NTFS
and everything that handles it. Who is laughing about that decision now?

> This is just like mmap sometimes returning a page number and sometimes a
> byte address... this would also not be useful unless you know the unit
> that mmap returns (addreesses in multiples of 1).

  Huh? From the user's point of view mmap always returns a pointer.
Implementation enforces page boundaries, and all applications should be
aware that the address given to it can not be assumed to be used for
anything meaningful, however every application relies on the fact that it
gets a pointer to a mapped address. If someone jumped in and demanded that
given address must be used, and mmap() should assume MAP_FIXED to be
always set, it would be similar to the demand that kernel should only
allow UTF-8 -- just in that case the brokenness would be more obvious.

> > That's what I'm saying. I am _not_ saying that the kernel uses UTF-8.
>
> But you are saying that you have to feed UTF-8 into the kernel, which is
> not the case either. I certainly don't have to..., and, what's worse,
> you haven't given any indication of why one has to. Just because you say
> so? Or is there actually a reason? If there is a reason, why doesn't the
> kernel, in return, also follow this reasoning?
>
> > kernel doesn't care one way or the other. As far as the kernel is
>
> It doesn't. But the point is that it should. If the kernel would do
> everything we want it to do there would be no point in enhancing it.

  Kernel certainly CAN enforce an encoding. It also can disallow filenames
that contain "Pu-239" substring, and there may be people who would argue
that it should be a good thing.

> > concerened, you could uuencode all the stuff, and the kernel wouldn't
>
> (Yes, because uuencode has the peculiar property of neither generting \0
> nor /. It doesn't work in general with byte-streams).
>
> > think you're crazy. The kernel _only_ cares about byte streams.
>
> The kernel _interprets_ the byte-stream already. And some byte-streams are
> no valid filenames _already_.

  This only affects two byte values, that happen to be universally
understood, and arenever required by any charset to represent anything but
what they are in ASCII. UTF-8 is hardly unique in the way of handling
them, however it imposes huge number of restrictions that may conflict
with what people do or will likely do.

> > > There is no way for applications to handle UTF-8 and illegal-utf8 in
> > > a sane way, so most apps will either eat the illegal bytes, skip the
> > > filename, or crash (the latter case is clearly a bug in the app, thr
> > > former cases aren't).
> >
> > What you're complaining about are bad user applications. It has _zero_ to
> > do with the kernel.
>
> Could you elaborate on why these apps are bad? What I am interested in
> is to know how to fix them? since there is simply no way to interpret
> the names returned by the kernel as the corresponding meta-information
> is missing.

  "Be liberal in what you accept and strict in what you produce". Most of
applications don't even have user interface, and therefore should not be
concerned with how characters look like in the first place.

> Consider an OS that allows different characters for path-seperators (unix
> only allows '/'). Without the knowledge of the path seperator it would be
> impossible to interpret paths.

  Show me the person who uses file names and doesn't know how the path
separator looks like.

> And without knowledge about encoding it's
> impossible (but slightly less dramatic) to correctly interpret filenames.

  This is a userspace issue. Some kernel MAY support this metadata,
however Unix filesystem is not designed that way. If someone is eager to
embed the encoding information into a filename, MIME allows that already,
it's just impractical.

> > The kernel doesn't set policy. The kernel says "this is what I can do,
> > you set policy".
>
> Exactly. The kernel could specify the API to use UTF-8. This is not more
> policy than it currently enforces.

  Says who? How would this policy, if enforced, improve anything, other
than supporting UTF-8 proponents that were unsuccessful in their attempts
to eradicate all other charsets and encodings despite a decade-old
religious war? They may want to recruit Linux kernel to support their
efforts, however no matter how anyone feels about this issue, why would
kernel design mess with this? What's next, preventing C compilers from
reading goto from the source files? Correcting "teh" and "yuo", and
refusing to send SMTP when the message contais "Me, too"? Have a flag that
prevents running vi or emacs depending on which of those editors the
sysadmin, or distro maker, hates with a passion? Aren't all those things
way too far in the area of "activism"?

>
> Or do you suggest that the ability to change the source and replace all
> occurences of '/' by '\\' means that '/' is not enforced as policy on
> path seperators?
>
> We basically seem to disagree on what, exactly, policy is. Policy (to
> me) is something that differentiates between several incompatible
> alternatives. Chosing policy means to rule out other (useful)
> alternatives.

  But again, who should be able to choose the rules? UTF-8 is not
universally accepted. It is a fact. One may wish that it was accepted,
someone else may wish that it was less ugly so it could be accepted, and
vast majority of people don't care, use whatever they have, and will be
pissed if it will get broken just because someone is on a crusade to tell
everyone, how they are supposed to write text.

> One could argue that '/' is a policy because it precludes the '/'
> character from being used in filenames, sth. some filenames or operating
> systems support.

  This is a universally accepted policy. All Unix users know that, it is
written in standards (real ones, like POSIX), and no one uses path
separator for anything else. UTF-8 is a standard that some people use, and
some other people want everyone to use, however it's not universally
accepted, and deliberately breaking others' stuff to force them into using
UTF-8 is, again, unwarranted activism beyond the scope of what kernel is
supposed to do.

> I'd say (probably as much as you) that this policy is not a real policy,
> it's just idiotic.

  It is in a standard, that no one who uses Linux (or any other unixlike
system) ever broken because it was there from the very beginning. UTF-8 is
something that was designed by a bunch of people who wanted to make it a
great gift to the world (or to profit from making more convoluted software
-- hard to tell at this point), and it _competes_ with the status quo.
Linux is not a new system that defines the rules, plan9 is. Plan9 is
developed as something that was supposed to "cure" Unix inconsistency and
lack of rules, so it got stuffed with personal idiosyncrasies of its
author. And the result is hardly a confirmation that those idiosyncrasies
resulted in a superior, or even just more practical system.

> But enforcing other restrictions on filenames should magically be real
> policy? This is obviously bot idiotic at all, and should be carefully
> explored.
>
> > And UTF-8 just happens to be the only sane policy for encoding complex
> > characters into a byte stream. But it is not the only policy.
>
> Just as '/' is not the only possible path seperator. If that is your
> point, you should explain why enforcing this is ok while supporting utf-8
> (not enforcing, just supporting, meaning having the ability to rule out
> non-utf-8 sequences when the admin wants this) is not.

  '/' is not the only possible separator,  however it's pretty clear that
no other separator is superior to it. Only two other characters were ever
used for this purpose, and both are abandoned by pretty much everyone, so
it's unlikely that many people are going to suffer from the choice of a
slash. Ever.

   UTF-8 is one of the infinite number of possible solutions, and judging
by the rate of acceptance and by the rate at which Unicode representations
and charsets are being invented, it is very likely that not the last
encoding that will be used by humans.

> > Another sane policy is to say "byte streams are latin1". It's not an
> > acceptable policy for encoding _complex_ characters, but it is a policy.
> > And it's a perfectly sane one.
>
> I agree that it is sane. But it is not very useful for the future, as
> people who want russian filenames are plainly unable to use the other
> filenames in a sensible way. There is no way to know the encoding.

  Russians sometimes use filenames in koi8-r, sometimes even in
windows-1251, and mostly in ASCII. Never heard any Russian complaining
about this -- and certainly never in my life I have seen a Russian
filename in UTF-8, nor do I look forward to it. And I am Russian.

> > In short: filenames are byte streams. Nothing more.
>
> Right now, they aren't. Not all sequences of bytes are valid filenames
> already, and I think this is perfectly o.k.

  Slippery slope.

> > And when I say that you have to talk to the kernel using UTF-8, I'm only
> > claiming that it is the only sane way to encode extended characters in a
> > byte stream. Nothing more.
>
> And i fully agree.
>
>

  I disagree -- not with the point that UTF-8 is kinda sane but with the
idea that UTF-8 should be enforced to make it the last encoding that
people will be ever able to use. It may be "sanest" now for a limited
purpose of handling truly multilingual text, but certainly only a
practical use of multilingual documents (what is extremely rare now) may
answer the question, what encoding(s) should be used for this purpose. I
don't think, someone ten years from now would enjoy writing a wrapper that
will convert filenames from some "Expandable Multilingual Metacharset
2014" so they look like valid UTF-8 when they are written into some archaic
filesystem that doesn't even support Elvish and Klingon properly.

-- 
Alex
