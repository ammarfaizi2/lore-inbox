Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIBOAa>; Sun, 2 Sep 2001 10:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271628AbRIBOAU>; Sun, 2 Sep 2001 10:00:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8459 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S271627AbRIBOAF>;
	Sun, 2 Sep 2001 10:00:05 -0400
Date: Sun, 2 Sep 2001 15:00:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: thunder7@xs4all.nl
Cc: parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010902105538.A15344@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010902105538.A15344@middle.of.nowhere>; from thunder7@xs4all.nl on Sun, Sep 02, 2001 at 10:55:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 10:55:38AM +0200, thunder7@xs4all.nl wrote:
> ReiserFS version 3.6.25
> bonnie[163]: Unaligned data reference 28

As it says, an unaligned data reference.

> r0-3     00000000 102ec550 10197d0c 26f24838

> IASQ: 00000000 00000000 IAOQ: 10197d10 10197d14

In kernel mode.

> 10197d10:       0c 7c 10 93     ldw  e(sr0,r3),r19

r3 is 26f24838, and offset `e' from that is unaligned.

> which makes the error somewhere around here in 
> fs/reiserfs/namei.c, function reiserfs_add_entry, after call to
> padd_item, before call to reiserfs_find_entry:
> 
>     /* copy name */
>     memcpy ((char *)(deh + 1), name, namelen);
>     /* padd by 0s to the 4 byte boundary */
>     padd_item ((char *)(deh + 1), ROUND_UP (namelen), namelen);
> 
>     /* entry is ready to be pasted into tree, set 'visibility' and 'stat data in entry' attributes */
>     mark_de_without_sd (deh);
>     visible ? mark_de_visible (deh) : mark_de_hidden (deh);
> 
>     /* find the proper place for the new entry */
>     memset (bit_string, 0, sizeof (bit_string));
>     de.de_gen_number_bit_string = (char *)bit_string;
>     retval = reiserfs_find_entry (dir, name, namelen, &path, &de);

I suspect mark_de_without_sd is an inlined function/macro and this will
be where the unaligned data reference is happening.

-- 
Revolutions do not require corporate support.
