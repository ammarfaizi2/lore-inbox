Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315111AbSEST61>; Sun, 19 May 2002 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315115AbSEST60>; Sun, 19 May 2002 15:58:26 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:13576 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315111AbSEST6Z>; Sun, 19 May 2002 15:58:25 -0400
Date: Sun, 19 May 2002 21:57:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <Pine.LNX.4.44.0205191125120.3104-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205192118190.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 19 May 2002, Linus Torvalds wrote:

> A faulting write will fill some subsequent memory area with zeroes, but a
> subsequent write can complete the original one.
> 
> It has to _commit_ the whole area, because it uses the pre-fault size
> information to optimize away reads etc, ie if you do a
> 
> 	write(fd, buf, 4096);
> 
> at a page-aligned offset, the write code knows that it shouldn't read the
> old contents because they get overwritten.
> 
> Which is why we need to commit the whole 4096 bytes, even if we only
> actually were able to get a single byte from user space.

I basically agree, but I think there is a special case: writing at the end
of the file. Instead of writing zeros, we have to truncate the file,
otherwise you can't restart append writes. Currently we get this wrong.

bye, Roman

