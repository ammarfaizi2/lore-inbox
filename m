Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129716AbQK1Q0Q>; Tue, 28 Nov 2000 11:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129492AbQK1Q0G>; Tue, 28 Nov 2000 11:26:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1202 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129724AbQK1QZ4>;
        Tue, 28 Nov 2000 11:25:56 -0500
Date: Tue, 28 Nov 2000 10:55:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.4.21.0011281539000.1254-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011281049400.9313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Tigran Aivazian wrote:

> On Tue, 28 Nov 2000, David S. Miller wrote:
> > What you want is something like:
> > 
> > static int num_open_files(struct files_struct *files, int size)
> > {
> > 	total = 0;
> > 	for (i = size / (8 * sizeof(long)); i > 0; )
> > 		total += count_bits(files->open_fds->fds_bits[--i]);
> > 
> > 	return total;
> > }
> 
> Ok, since we have to walk the sets and test the bits anyway, I propose to
> make close_files() to return 'nr_open_fds' and accept an extra argument
> 'doclose=0 or 1' which will specify whether we want to close the 'fd' or
> whether we just want to count them.

What for? I smell a bunch of races here - as soon as you release ->files_lock
the value of the function (it can be called only with that lock held) becomes
meaningless.

Besides, locking rules like that (you must hold the files->files_lock if
doclose is 0 and you must NOT hold it is doclose is 1) are sick. We could
make the function itself grab the spinlock, but then the return value
becomes junk before the thing returns it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
