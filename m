Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129414AbQK1PwH>; Tue, 28 Nov 2000 10:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129410AbQK1Pv5>; Tue, 28 Nov 2000 10:51:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46979 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S129226AbQK1Pvo>;
        Tue, 28 Nov 2000 10:51:44 -0500
Date: Tue, 28 Nov 2000 07:06:27 -0800
Message-Id: <200011281506.HAA02318@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: tigran@veritas.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011281459080.1254-100000@penguin.homenet>
        (message from Tigran Aivazian on Tue, 28 Nov 2000 15:13:44 +0000
        (GMT))
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.4.21.0011281459080.1254-100000@penguin.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Tue, 28 Nov 2000 15:13:44 +0000 (GMT)
   From: Tigran Aivazian <tigran@veritas.com>

   I know that there is no problem due to the way it is called in
   copy_files() -- it would only be above 32. But for what I want to
   use it, I need the _correct_ number of open file descriptors and
   not some "rounded up to 32" one.

That function is static for a reason :-)  It is not meant
for external use.  What it gives you is the smallest multiple
of (8 * sizeof(long)) which is larger than the largest file
descriptor the task has open.

What you want is something like:

static int num_open_files(struct files_struct *files, int size)
{
	total = 0;
	for (i = size / (8 * sizeof(long)); i > 0; )
		total += count_bits(files->open_fds->fds_bits[--i]);

	return total;
}

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
