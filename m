Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318780AbSICXjw>; Tue, 3 Sep 2002 19:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSICXjw>; Tue, 3 Sep 2002 19:39:52 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:23054 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318780AbSICXjw>;
	Tue, 3 Sep 2002 19:39:52 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209032344.g83NiEc29471@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <1031093579.1073.6.camel@bip> from Xavier Bestel at "Sep 4, 2002
 00:52:58 am"
To: Xavier Bestel <xavier.bestel@free.fr>
Date: Wed, 4 Sep 2002 01:44:14 +0200 (MET DST)
Cc: ptb@it.uc3m.es, Anton Altaparmakov <aia21@cantab.net>,
       david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Xavier Bestel wrote:"
[Charset ISO-8859-15 unsupported, filtering to ASCII...]
> Le mer 04/09/2002 _ 00:42, Peter T. Breuer a _crit :
> 
> > Let's maintain a single bit in the superblock that says whether  any
> > directory structure or whatever else we're worried about has been
> > altered (ecch, well, it has to be a timestamp, never mind ..). Before
> > every read we check this "bit" ondisk. If it's not set, we happily dive
> > for our data where we expect to find it. Otherwise we go through the
> > rigmarole you describe.
> 
> Won't work. You would need an atomic read-and-write operation for that

I'm proposing (elsewhere) that I be allowed to generate special block-layer
requests from VFS, which act as "tags" to impose order on other requests
at the shared disk resource. But ...

> (read previous timestamp and write a special timestamp meaning
> "currently writing this block"), and you don't have that.

I believe we only have to write it when we change metadata, and
read it when we are about to use cached metadata. Racing to write it
doesn't matter, since the most recent wins, which is what we want.

Umm .. there is a bad race to read. We can read, think nothing has
changed, then read and find things shifted out from under. We need
to take a FS global lock when reading! Umm. No. We need to take
a global lock against changing metadata when reading, not against
arbitrary changes. And that can be done by issuing a tag request.

It's late.

Peter
