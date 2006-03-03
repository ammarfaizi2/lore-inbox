Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWCCOzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWCCOzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWCCOzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:55:05 -0500
Received: from mail.phnxsoft.com ([195.227.45.4]:62988 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1751462AbWCCOzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:55:04 -0500
Message-ID: <4408589B.2040305@imap.cc>
Date: Fri, 03 Mar 2006 15:54:19 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>	 <1141032577.2992.83.camel@laptopd505.fenrus.org> <440779AF.5060202@imap.cc> <1141368808.2883.16.camel@laptopd505.fenrus.org>
In-Reply-To: <1141368808.2883.16.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig97EA9B411286E34F6E1B6B24"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97EA9B411286E34F6E1B6B24
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 03 Mar 2006 07:53:28 +0100, Arjan van de Ven wrote:

> On Fri, 2006-03-03 at 00:03 +0100, Tilman Schmidt wrote:

>> So you are saying that, for example
>>
>> 	spin_lock_irqsave(&cs->ev_lock, flags);
>> 	head = cs->ev_head;
>> 	tail = cs->ev_tail;
>> 	spin_unlock_irqrestore(&cs->ev_lock, flags);
>>
>> is (mutatis mutandis) actually cheaper than
>>
>> 	head = atomic_read(&cs->ev_head);
>> 	tail = atomic_read(&cs->ev_tail);
>
> atomic_read is special since it's not actually an atomic operation ;)
> but.. think about it: you do 2 atomic reads, however there is ZERO
> guarantee that the reads are atomic with respect to eachother; eg your
> head and tail are not an atomic "snapshot" of these 2 variables!

That's not a problem. It's a ringbuffer. It doesn't need an atomic
snapshot of the reading and writing pointers together. Nothing breaks
if a reader advances the read pointer while a writer is holding a
local copy of it, or vice versa. The only thing we have to guard
against is the result of an individual read operation being corrupted
by a parallel write.

So what's better in that case? Should we change these from atomic to
spinlocked or not?

[#define IFNULL*]
>> Ok, these were mainly debugging aids. We'll just drop them and let the
>> oops mechanism catch the (hopefully non-existent) remaining cases of
>> pointers being unexpectedly NULL.
>
> you can also use WARN_ON() and BUG_ON() for that, you then get a more
> readable oops message (with filename and line information)

Actually, we won't. The IFNULL* macros were not only printing a message,
but also taking evasive action in order to avoid dereferencing the NULL
pointer. To achieve the same with WARN_ON() would require four lines of
code for each occurrence, which IMHO is too much code clutter for a class
of bugs which should be largely eradicated by now anyway.

>> >> +void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
>> >> +			size_t len, const unsigned char *buf, int from_user)
>> >
>> > such "from_user" parameter is highly evil, and also breaks sparse and
>> > friends.. (btw please run sparse on the code and fix all warnings)
>>
>> Are you referring to anything in particular? We do run sparse regularly,
>> and it did not emit any warnings for the submitted version, not even for
>> this function. (But heaps of them for other parts of the kernel, if you
>> pardon the remark.)
>
> msg should have the __user atribute here since it can be in userspace...
> sometimes. It is the "sometimes" that is the bad idea!

That's understood and will be fixed. I was just wondering whether your
remark in parentheses was prompted by any particular sparse warnings you
wanted us to fix and which for some reason we hadn't seen?

> (GFP_ATOMIC is like borrowing from the VM, the VM will be in slight
> imbalance afterwards. With GFP_KERNEL you allow the kernel to fix this
> imbalance. A slight imbalance is fine and not a problem. Especially if
> you give it the memory back soon. But if the imbalance can accumulate,
> for example because you keep allocating and free the memory much later,
> it can become a problem)

Thanks muchly for that very lucid explanation. I see much clearer now
in that area! :-)

Regards
Tilman

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)

--------------enig97EA9B411286E34F6E1B6B24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFECFimMdB4Whm86/kRAmWNAJ995N7rKbV7r+rOxQSAc0Nn+b480ACfU3Ts
i5tq/OsohHvH43u7v9fS0Xo=
=7YcF
-----END PGP SIGNATURE-----

--------------enig97EA9B411286E34F6E1B6B24--
