Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131128AbQKACdv>; Tue, 31 Oct 2000 21:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbQKACdl>; Tue, 31 Oct 2000 21:33:41 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:7181 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131128AbQKACd3>; Tue, 31 Oct 2000 21:33:29 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14847.32981.849578.490063@wire.cadcamlab.org>
Date: Tue, 31 Oct 2000 20:32:53 -0600 (CST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Keith Owens <kaos@ocs.com.au>, Christoph Hellwig <hch@ns.caldera.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <20001031075506.B1041@wire.cadcamlab.org>
	<Pine.LNX.4.10.10010310912050.6866-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Linus]
> But it doesn't even WORK.
> 
> You need to have 
> 
> 	LINK_FIRST1
> 	LINK_FIRST2
> 	LINK_FIRST3
> 	...
> 
> etc to get the proper ordering.

???  No you don't.  Perhaps you mean something else.  Here's how
LINK_FIRST works:

Say you have foo.o, bar.o, baz.o and lots of other objects.  foo.o must
come before bar.o which must come before baz.o which must come before
some other object.  But of course all of the above are conditional:
they can be configured as modules, or not at all.

  LINK_FIRST := foo.o bar.o baz.o

  obj-$(CONFIG_BAR) += bar.o
  obj-$(CONFIG_BAZ) += baz.o
  obj-$(CONFIG_BLURFL) += blurfl.o
  obj-$(CONFIG_FOO) += foo.o
  obj-$(CONFIG_...).....

Problem solved.  If CONFIG_FOO=y CONFIG_BAR=n CONFIG_BAZ=y etc, link
order is

  foo.o baz.o {everything else}

In short, LINK_FIRST/LINK_LAST take care of any case I can think of in
the kernel.  Including things like "buslogic and aha174x must come
before aha1520, but the two parallel zip drivers must come last in
drivers/scsi because you don't want to renumber scsi drives more than
you have to" or "certain ISA cards must come after ne.c because of
autoprobe lockups on cheap ne clones, but ne2kpci should come *before*
ne so ne won't get the pci cards".

> In many other cases, like SCSI, we need almost _total_ ordering. For such
> a case, theer is no "first" or "last" - there is a well-specific ORDER.

I don't understand why we need *total* ordering -- I am only aware of a
few specific requirements.

Anyway, we still need to remove duplicates.  NCR53c9x.o appears a lot.
If we can make all those cases go away by use of CONFIG_SCSI_53C9X or
something, I will be a lot happier.  Your proposed method,

  obj-53C9X-$(CONFIG_SCSI_MCA_53C9X) := y
  obj-53C9X-$(CONFIG_SCSI_OKTAGON) := y
  obj-$(obj-53C9X-y) := y
  obj-$(obj-53C9X-m) := m

is definitely less ugly than a lot of what we do now ... but I still
don't like it.  Mostly because each shared object file creates
special-case code in the makefile.

> The only way it would work is to make LINK_FIRST maintain the order,
> but once you do that LINK_FIRST is completely superfluous, as it ends
> up being exactly the same as $(obj-y).

The theory behind LINK_FIRST is that most drivers do not care about
their order: the ones that do are the exception, not the rule.  If in
fact you *do* care about the order of every last driver in the kernel,
then I agree that LINK_FIRST is a bad idea.

> So trust me, LINK_FIRST/LINK_LAST is not going to happen. 

> And if you really want to remove duplicates, at worst we can even use
> an external program for it - which would solve all these things once
> and for all.

This is true.  Mainly what we disagree on is which method is the bigger
kludge. (:

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
