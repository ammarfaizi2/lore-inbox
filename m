Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAHU2f>; Mon, 8 Jan 2001 15:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAHU20>; Mon, 8 Jan 2001 15:28:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40212 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129387AbRAHU2T>; Mon, 8 Jan 2001 15:28:19 -0500
Date: Mon, 8 Jan 2001 21:28:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108212833.S27646@athlon.random>
In-Reply-To: <20010108180857.A26776@athlon.random> <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 12:58:20PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:58:20PM -0500, Alexander Viro wrote:
> It's a hell of a pain wrt locking. You need to lock the parent, but it can

This is a no-brainer and bad implementation, but shows it's obviously right
wrt locking. (pseudocode, I ignored the uaccess details and all the other not
relevant things)

	sys_rmdir(path)
	{
		char buf[PAGE_SIZE]

		err = sys_getcwd(buf, PAGE_SIZE)
		if (err)
			goto out
		
		if (!memcmp(path, ".", 2))
			path = buf
		err = 2_4_0_sys_rmdir(path)

	out:
		return err
	}

Optimizing things just a little more as _worse_ the overhead of supporting
`rmdir .` can be reduced to a memcmp(name, ".") plus and out of line jump and I
don't see a performance problem with that.

Could you enlight me on where's the locking pain?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
