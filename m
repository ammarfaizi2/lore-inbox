Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSAFTR1>; Sun, 6 Jan 2002 14:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSAFTRR>; Sun, 6 Jan 2002 14:17:17 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:48394 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S289009AbSAFTRD>; Sun, 6 Jan 2002 14:17:03 -0500
Date: Sun, 6 Jan 2002 11:16:59 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: "vda@port.imtp.ilyichevsk.odessa.ua" 
	<vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201061151.g06BpvE04632@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0201061101370.5442-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, vda@port.imtp.ilyichevsk.odessa.ua wrote:

> Like dd if=/dev/zero of=/tmp/file bs=... count=... ?
>
That would do it, but I was trying to give a real-world example from
image processing, like copying a large image file.

> > # perform a 2D in-place FFT of total size at least "MemTotal/2" but less
> > # than "MemTotal"
>
> I'm willing to try. What program can I use for FFT?

I use FFTW from http://www.fftw.org.

> Can you describe FFT memory access pattern in more detail?
> I'd like to write a simple testcase with similar 'bad' pattern.


Imagine a 16384 by 16384 array of double complex values. That's a 4
GByte image. Scale down to fit your machine, of course :). The first
pass will do an FFT on every row (column) if your language is C
(FORTRAN). The "stride" is 16 bytes (one complex value) in the inner
loop. Each row (column) is 16384*16 = 262144 bytes long, which works out
to 64 pages if the page size is 4096 bytes.

Then the second pass will do an FFT on every column (row). The stride is
16384*16 = 262144 bytes. This is a new page for each 16-byte complex
value you process :-). That is, all 16384 pages have to be in memory, or
swapped into memory if you've run out of real memory and the kernel has
swapped them out.

Please ... *don't* try to do this on a 512 MB machine and think that an
efficient VM is gonna make it work :),
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

What phrase will you *never* hear Miss Piggy use?
"You can't make a silk purse out of a sow's ear!"

