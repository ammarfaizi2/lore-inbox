Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129543AbQK1QY0>; Tue, 28 Nov 2000 11:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129492AbQK1QYR>; Tue, 28 Nov 2000 11:24:17 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:4871 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129548AbQK1QYK>;
        Tue, 28 Nov 2000 11:24:10 -0500
Date: Tue, 28 Nov 2000 15:55:13 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.GSO.4.21.0011281045050.9313-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011281552280.1254-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Alexander Viro wrote:
> 
> And you don't want even that - as soon as we release files->file_lock
> the value becomes meaningless. So I'm rather suspicious about the
> correctness of intended use.
> 

Hi Alexander,

I am well aware of the need to take the file_lock. So, I am putting a code
like this into set_user():

       /* switch the open fds from old_user to new_user */
        read_lock(&files->file_lock);
        nr_open = close_files(files, 0); /* 0 means don't close them */
        atomic_sub(nr_open, &old_user->files);
        atomic_add(nr_open, &new_user->files);
        read_unlock(&files->file_lock);

(haven't tested yet -- just an idea -- kernel is still compiling as we
speak). This assumes the close_files() semantics I described in the
previous email. I also put the corresponding code into
get/__put_unused_fd() and also into put_files_struct(). Btw, the latter
happens to call close_files() anyway so as a bonus it gets the nr_open_fd
return and atomic_subs the p->user->files accordingly. If all this works
and I didn't miss some descriptor accounting somewhere then we'll have a
valid p->user->files support which is what I wanted.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
