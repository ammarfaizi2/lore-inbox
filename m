Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318964AbSICWib>; Tue, 3 Sep 2002 18:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSICWiZ>; Tue, 3 Sep 2002 18:38:25 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:23307 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318964AbSICWiU>;
	Tue, 3 Sep 2002 18:38:20 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209032242.g83MglG21464@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <5.1.0.14.2.20020903230434.00ac6c50@pop.cus.cam.ac.uk> from Anton
 Altaparmakov at "Sep 3, 2002 11:19:21 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Wed, 4 Sep 2002 00:42:47 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, david.lang@digitalinsight.com,
       linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anton Altaparmakov wrote:"
[snip detailed description for which I am extremely grateful]
> Ok, so to do a 1 byte read, we just had to perform over 10-20 reads from 
> very different disk locations (we are talking several seconds _just_ in 
> seek times, never mind read times!), we had to allocate a lot of memory 
> buffers to store metadata which we have read from disk temporarily, as well 
> as a lot of memory in order to be able to decompress the mapping pair 
> arrays which tell us the logical to physical block mapping.
> 
> I am completely serious, we are talking at least hundreds of milliseconds 
> possibly even several seconds to read that single byte.
> 
> What was that about 50GiB/sec performance again...?

Let's maintain a single bit in the superblock that says whether  any
directory structure or whatever else we're worried about has been
altered (ecch, well, it has to be a timestamp, never mind ..). Before
every read we check this "bit" ondisk. If it's not set, we happily dive
for our data where we expect to find it. Otherwise we go through the
rigmarole you describe.

Maybe our programs aren't going to do unexpected things with the file
structures. Maybe our file systems satisfy assumptions like not
moving existing data ondisk to make room for other data. I'd be willing
to only consider such systems as sane enough to work with in a
distributed shared environment.

Can we improve the single-bit approach? Yes. The FS is a tree. When
we make a change in it we can set a bit everywhere above the change,
all the way to the root. When we observe the root bot changed, we
can begin to retrace the path to our data, but abandon the retrace
when the bit-trail we are following down towards our data turns cold.

No?

Peter
