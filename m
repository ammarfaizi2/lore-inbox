Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUBPU6p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUBPU6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:58:45 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:12215 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S265879AbUBPU6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:58:38 -0500
Date: Mon, 16 Feb 2004 21:58:35 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040216205835.GG17015@schmorp.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 12:23:25PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > And I am saying that this is not good, which is my sole point.
> 
> Fair enough. 

Thank you (honestly), for acknowledging it.

> However, that's where the unix philosophy comes in. The unix philosophy 
> has always been to not try to understand the data that the user passes 
> around - and that "everything is a bytestream" is very much encoded in the 
> basic principles of how unix should work.

This never really applied to paths or filenames, although I admit that
this was the intention indeed, hindred by the need of having _some_
out-of-band data like '/'.

So yes, that's the principle.

> That agnosticism has a lot of advantages. It literally means that the
> basic operating system doesn't set arbitrary limitations, which means that
> you can do things that you couldn't necessarily otherwise easily do.

I think '/' is arbitrary, but of course there is a difference between
ruling out 2 bytes out of 256 as opposed to ruling out hundreds of
thousands of combinations.

However, UTF-8 was invented to transform unicode _text_ to filenames by
the inventors of unix.

Yes, this does not mean that they intended your typical kernel to
enforce this, but still this is what plan9 does, and it's a very useful
"limitation" because it removes the need for difficult-to-get-by-with
out-of-band data stating the interpretation of filenames.

Unlike file contents, filenames are always meant to represent text, not
binary data, which I hope you agree with.

> It does mean that you can do "strange" things too, and it does mean that 
> user space basically has a lot of choice in how to interpret those byte 
> streams.

Windows, for example, allows a lot more strange things like "x.y." to
mean the same as "x.y", or even worse things playing with "illegal
UTF-8".

Most, if not all, of these strange exceptions in windows resulted in
exploitable security flaws.

While this certainly is workable (in the sense that these all were
applicaiton bugs), I think it would be highly useful to be able to enforce
this by saying: "you can put whatever you like into filenames, as long as
it is encoded using UTF-8".

Just like the kernel currently enforces "it must be encoded using
octects", which is trivial, of course, but consider that UCS-2, while also
being a bytestream, is NOT a valid encoding for filenames in linux.

So the kernel is certainly not agnostic versus encodings.

It is, however, agnostic to multibyte encodings as used in e.g. ISO-C.
It does not support wide character encodings.

This is not bad at all, but I claim that the kernel simply isn't as
agnostic as we all might wish, and if there is a specification on
well-formed encodings, it could just as well be "UTF-8".

(Right now it is "most 8-bit encodings, all multibyte encodings but no
multiword encodings with embedded nulls or '/'", which is simply too
unsharp for me to be acceptable. For me, this is clearly a subjective
opinion).

> And yes, it can cause confusion. You don't like the confusion, so you 
> argue that it shouldn't be allowed. It's a valid argument, but it's an 
> argument that assumes that choice is bad.

Actually, I called for an optional way of enforcing a very promising
encoding over a lot of other encodings.

The kernel simply supports only a subset of possible encodings, and I said
that being able to limit this choice to the only encoding that even _you_
call the only sane one, as an option.

> If you want to _force_ everybody to use UTF-8, then yes, the kernel could 

I don't want to do that. I sitll happen to find the rare iso-8859-1
filename on my disk, and almost puke everytime because it breaks bash
etc. I even modified my terminal emulator (rxvt) to support the
occasional german umlaut because it's so convinient.

But all in all, it would be very much easier if this simply couldn't
happen. Especially because it's easy to get from "illegal utf-8 allowed"
to "security issue in formerly secure code".

> enforce that readdir() would never pass through a broken UTF-8 string, and 
> all the path lookup functions also would never accept a broken string. It' 
> snot technically impossible to to, although it would add a certain amount 
> of pain and overhead.

I can certainly yield to arguments like "if you want it, send a patch good
enough to be accepted" :)

> But the thing is, not everyone uses UTF-8.

I don't want to enforce it, exactly because, as you say, it'll
take years. I do think that a way to enforce this as local (or
distribution-wise) policy, would be very helpful indeed.

I don't mind if some embedded system doesn't want the overhead of having a
UTF-8 environment that simply isn't useful for it.

> people from doing clever things. Encoding other information in filenames 
> might be proper for a number of applications.

But it will simplify a lot of applications that otherwise have no idea on
filename encoding (it's a pain in the ass in perl, which has generally
good (unicode-)text support, but still filenames, which are text, simply
come out garbled most of the time).

It's rather similar to the discussion about extended attributes (ok, it's
hornets nest, or at leats was one :). Having a clear API definition would
certainly help.

It's no policy either, as applicaitons wanting to encode e.g. binary
information can certainly do so using UTF-8, just as they currently can do
so by other means, e.g. escaping \0 and /.

> It would also be very painful, since it would mean that when you mount an 
> old disk, you may be totally unable to read the files, because they have 
> filenames that such a kernel would never accept.

That's why I asked for a mount option. I might be too extreme for your
taste in my opinions, but I am still living on earth. I, too, have these
disks.

However, I also have some windows disks, and umlauts or japanese
characters on these often result in chaos, which is not really a bug in
linux either, but highly annoying to people trying to use linux.

> You don't "need" a known encoding. The kernel clearly doesn't need one. 
> It's a container, and the encoding comes from the outside. 

Right now the kernel does need encoding for _some_ byte values. I can't
use UCS-2, it simply isn't agnostic.

Please, I don't want to use UCS2, UTF-16, or other such atrocities :) I
am just trying to make the point that the kernel already enforces some
encodings.

> And that's what I mean by agnostic - you can make your own encoding. 

Given the limitations of the kernel in interpreting byte streams, I can.
However, only under the existing constraints.

I'd like to have a more forcing constraint - UTF-8. It might never be
implemented (especially not against your will), but I think it isn't more
idiotic than what the kernel currently does.

Again, I find the "restrictions" unix has with respect to filenames
very sane and useful, and if at all, it's usually a problem that
filenames can contain unusual characters like \n.

> Choice is _inherently_ good. Trying to force a world-view is bad. You 

Yes! I want the choice of having a kernel supporting UTF-8 (again, meaning
active support, i.e. not accepting malformed utf-8) :)

> UTF-8"), but you should not _force_ them to that if they have good reasons 
> not to (and "backwards compatibility" is a better reason than just about 
> anything else).

Well, being able (having the choice) to force is good. Just like having
nosuid mount options is good, because it allows admins the choice.

> No. I'm saying that
>  (a) "if you want to use complex character sets"
> then 
>  (b) "you really have to use UTF-8"
> to talk to the kernel.
> 
> Note the two parts. You're hung up on (b), while I have tried to make it 
> clear that (a) is a prerequisite for (b).

Ok, this is true.

> (In all fairness, some people will disagree with (b) even when (a) is true
> and like things like UCS-2. Those people are crazy, but I guess I'd just
> mention that possibility anyway).

You have to admit, however, that apart from UCS-2 being obvious insanity
as opposed to UTF-16 or some 32 encoding, that some people have a point
in asking for these.

It IMHO not useful to support this simply because the posix API cannot be
made to deal with it. But I wouldn't rule out encodings like UTF-32 as
simply being crazy.

> This may change, btw. I'm nothing if not pragmatic. In another twenty
> years, maybe everybody _literally_ uses complex character sets, and this
> whole discussion is totally silly, and the kernel may enforce UTF-8 or
> Klingon or whatever. At some point assumptions become _so_ ingrained that
> they are no longer policy any more, they are just "fact".

True. Thanks a lot for explaining your arguments in this detail. In
fact, I can accept most if not all of your arguments, but I sitll think
it would be nice to have this extra functionality.

Arguments like "it's a pain to implement" (which I don't think it is, but
you are clearly better in judging that!), weigh even more to me.

So even if I think it's a good idea, it might never be implemneted for
purely practical reasons.

(end of discussion, I think, for me at last)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
