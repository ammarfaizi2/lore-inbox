Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSEQj>; Sat, 18 Nov 2000 23:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbQKSEQ3>; Sat, 18 Nov 2000 23:16:29 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:2827 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129152AbQKSEQ1>;
	Sat, 18 Nov 2000 23:16:27 -0500
Date: Sat, 18 Nov 2000 19:46:24 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek/llseek allows the negative offset
Message-ID: <20001118194624.A27451@valinux.com>
In-Reply-To: <20001117155913.A26622@valinux.com> <20001117160900.A27010@valinux.com> <20001118192542.B24555@athlon.random> <20001119014512.G26779@athlon.random> <20001118172034.A22523@valinux.com> <20001119040704.A31148@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001119040704.A31148@athlon.random>; from andrea@suse.de on Sun, Nov 19, 2000 at 04:07:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 04:07:04AM +0100, Andrea Arcangeli wrote:
> On Sat, Nov 18, 2000 at 05:20:34PM -0800, H . J . Lu wrote:
> > Try this again 2.2.18pre21. It works for me.
> > 
> > 
> > -- 
> > H.J. Lu (hjl@valinux.com)
> > ---
> > --- linux/fs/ext2/file.c.lseek	Sat Nov 18 17:18:49 2000
> > +++ linux/fs/ext2/file.c	Sat Nov 18 17:19:28 2000
> > @@ -120,6 +120,8 @@ static long long ext2_file_lseek(
> >  		case 1:
> >  			offset += file->f_pos;
> >  	}
> > +	if (offset < 0)
> > +		return -EINVAL;
> >  	if (((unsigned long long) offset >> 32) != 0) {
> >  #if BITS_PER_LONG < 64
> >  		return -EINVAL;
> 
> It's not enough for 2.2.x (and you left the `>> 32' nosense check).
> 

It works for me on ia32. offset is a long long in 2.2.18pre21 on ia32.
I don't see anything wrong for

	if (offset < 0)
		return -EINVAL;

I got:

lseek(3, 4294967295, SEEK_SET)          = -1 EINVAL (Invalid argument)
lseek(3, 4294967294, SEEK_SET)          = -1 EINVAL (Invalid argument)
lseek(3, 4294967293, SEEK_SET)          = -1 EINVAL (Invalid argument)
lseek(3, 4294967292, SEEK_SET)          = -1 EINVAL (Invalid argument)
lseek(3, 4294967291, SEEK_SET)          = -1 EINVAL (Invalid argument)
lseek(3, 2147483647, SEEK_CUR)          = -1 EOVERFLOW (Value too large for defined data type)
lseek(3, 2147483647, SEEK_CUR)          = -1 EOVERFLOW (Value too large for defined data type)
_llseek(3, 18446744073709551614, 0xbffff980, SEEK_SET) = -1 EINVAL (Invalid argument)
lseek(3, 4294867296, SEEK_SET)          = -1 EINVAL (Invalid argument)

My kernel has LFS patch.

H.J.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
