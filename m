Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbTH0Nkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTH0Nkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:40:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262398AbTH0Nka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:40:30 -0400
Date: Wed, 27 Aug 2003 09:40:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timo Sirainen <tss@iki.fi>
cc: Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
In-Reply-To: <1061988729.1457.115.camel@hurina>
Message-ID: <Pine.LNX.4.53.0308270925550.278@chaos>
References: <1061987837.1455.107.camel@hurina>  <200308271442.48672.martin.konold@erfrakon.de>
 <1061988729.1457.115.camel@hurina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Timo Sirainen wrote:

> On Wed, 2003-08-27 at 15:42, Martin Konold wrote:
> > > The question is what can happen if I read() a file that's being
> > > simultaneously updated by a write() in another process?
> >
> > The behaviour is undefined.
>
> So it's not such a good idea then? Hmh.. That'd solve a lot of problems
> for me.
>
> > > 123 over XXX, is it possible that read() returns 1X3 in some conditions?
> >
> > Yes. The actual order stuff is written to the disk is not guaranteed.
>
> It doesn't matter when it's actually written to disk, if it's only seen
> by read().
>


> 123 over XXX, is it possible that read() returns 1X3 in some conditions?

I'm going to take this question literly. You are asking
if the middle-byte of a 3-byte sequence can be residual,
not yet updated.

Let's see if it is possible for the middle byte of
a 3-byte sequence to not be written when both
other bytes are written:

In the first place, everything within a buffer or
sector will be written in-order, i.e., if you have
the two end bytes, you must have the middle byte.
It's only the end-bytes that can stop anywhere.

So we look at the end of a buffer condition.

             |End of buffer
XXXXXXXXXXXXXXXXXXXXXXXXXXX <-- original data
             123            <-- new data
              |____ Write a byte
              ||___ Write a word
              ||||_ Write a long

Clearly, regardless of how the bytes are written, if you
get a '3', but not a two, the next write must have started
at offset 1, not offset 0. So, whatever write sequence
is done internally must subsequently seek backwards to offset
zero. This is highly unlikely (although possible).

Even in machines that do load/store operations where individual
components of those stores happen in groups, access to/from
a buffer of such data is controlled (by hardware) so a write
will complete before a read occurs. So if a data element that
is at a higher address has been modified as well as a data element
at a lower address, either the hardware is capable of byte access
or the center element must also have been modified. With hardware
that can perform byte-access (ix86), the only byte-access that
is going to happen is at the end(s) of buffers.

Given the 'famous' byte-sequence 0x12345678, the following incomplete
updates are possible (big endian):

0x123456xx   Byte access
0x1234xxxx   Word access
0xxx345678   Byte access
0xxxxx5678   Word access

Given the 'famous' byte-sequence 0x12345678, the following incomplete
updates are possible (little endian):

0x875634xx	Byte access
0x8756xxxx	Word access
0xxx563412	Byte access
0xxxxx3412	Word access

So I don't see how you could ever have a sequence of 123 written,
with both '1' and '3' written, but not '2'. It is only the stuff
on the 'ends' that can be incomplete.

Anyway, if you want two (or more) processes to access the file,
you should mmap it. You can configure a mmap'ed file so that
updates appear to all readers. However, just like any shared-memory
access, you need some kind of synchronization, perhaps a semaphore,
so that you always read valid data. Usually one only needs
__valid__ data, not necessarily __current__ data. For instance,
I have one task writing incremental numbers to a specific offset
in a file (shared memory). If it's okay for the reader to get
a non-garbage number, even though it's not the latest instantaneous
number, then if you stay away from multi-part numbers (like long long),
your data will always be "good" with no locking at all. That's because
the write will complete before the CPU gets taken away and given to a
reader. What is not guaranteed is that the data are current. You need a
semaphore for that.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


