Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUF2Bjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUF2Bjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 21:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbUF2Bjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 21:39:49 -0400
Received: from mail.inter-page.com ([12.5.23.93]:57871 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265331AbUF2Bjq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 21:39:46 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'David S. Miller'" <davem@redhat.com>,
       "'Oliver Neukum'" <oliver@neukum.org>
Cc: <zaitcev@redhat.com>, <greg@kroah.com>, <arjanv@redhat.com>,
       <jgarzik@redhat.com>, <tburke@redhat.com>,
       <linux-kernel@vger.kernel.org>, <stern@rowland.harvard.edu>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>
Subject: RE: drivers/block/ub.c
Date: Mon, 28 Jun 2004 18:39:26 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAlc1GA9iXSku+9YJ/moYgVQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040627142628.34b60c82.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller Wrote:

> Oliver Neukum <oliver@neukum.org> wrote:

> > OK, then it shouldn't be used in this case. However, shouldn't we have
> > an attribute like __nopadding__ which does exactly that?


> It would have the same effect.  CPU structure layout rules don't pack
> (or using other words, add padding) exactly in cases where it is
> needed to obtain the necessary alignment.

It "seems" that having an attribute on a structure that says "pack my internals, but
my base will be normally aligned" would be reasonable, if not easy to manage.

In such a case, the compiler would be able to recognize the poorly aligned internal
members for which the ugly code needs to be generated, and still generate the optimal
instructions for the coincidentally well-aligned accesses.

struct whatever {
u8  thing;
u16 thing2;
u8  thing3[5];
u32 thing4[10];
} attribute ((__packed__));

Has no rationally evident reason to generate ugly code for thing4 access.  Most
programmers will not expect thing4[x] to suffer any degradation whatsoever even as
they understand that thing2 is unhappiness personified.  There is nothing to even
remotely suggest that an instance of whatever is going to be based on a poorly
aligned pointer (etc). 

That is, it is easy to imagine a programmer being able to know that the guts are
packed, but the overall placement and access is normal.  As a matter of fact, that is
the "normal" way packed structures are used in the first place, since such structures
are just about always created normally (allocated, automatic, etc) and only get
__packed__ when they have to meet some exterior qualification like writing to a
device.

My presumption (and Oliver's apparently), would be that __packed__ and __unaligned__
are completely different assertions with no predicate relationship between them.
Least astonishment kind-of then dictates that __packed__ isn't going to
__ruin_access__ (8-) structures who's innards happen to be the same on a platform
where the not-__packed__ representation has the same map.

In fact, "structures are packed, instances are aligned" approaches aphorism.  One
could just as easily expect have an normal, unpacked structure mapped into/over
memory at an unaligned address to meet the requirement of some particular custom
hardware or for fast-encoding into/out-of a text buffer.

Rob.


