Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQK1QTZ>; Tue, 28 Nov 2000 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129575AbQK1QTP>; Tue, 28 Nov 2000 11:19:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57255 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129514AbQK1QS7>;
        Tue, 28 Nov 2000 11:18:59 -0500
Date: Tue, 28 Nov 2000 10:48:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: tigran@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <200011281506.HAA02318@pizda.ninka.net>
Message-ID: <Pine.GSO.4.21.0011281045050.9313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, David S. Miller wrote:

>    Date:   Tue, 28 Nov 2000 15:13:44 +0000 (GMT)
>    From: Tigran Aivazian <tigran@veritas.com>
> 
>    I know that there is no problem due to the way it is called in
>    copy_files() -- it would only be above 32. But for what I want to
>    use it, I need the _correct_ number of open file descriptors and
>    not some "rounded up to 32" one.
> 
> That function is static for a reason :-)  It is not meant
> for external use.  What it gives you is the smallest multiple
> of (8 * sizeof(long)) which is larger than the largest file
> descriptor the task has open.
> 
> What you want is something like:
> 
> static int num_open_files(struct files_struct *files, int size)
> {
> 	total = 0;
> 	for (i = size / (8 * sizeof(long)); i > 0; )
> 		total += count_bits(files->open_fds->fds_bits[--i]);
> 
> 	return total;
> }

And you don't want even that - as soon as we release files->file_lock
the value becomes meaningless. So I'm rather suspicious about the
correctness of intended use.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
