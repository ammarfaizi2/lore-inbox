Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSKDVoz>; Mon, 4 Nov 2002 16:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSKDVoz>; Mon, 4 Nov 2002 16:44:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13835 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262806AbSKDVoy>; Mon, 4 Nov 2002 16:44:54 -0500
Date: Mon, 4 Nov 2002 13:50:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <3DC6DA2B.8060903@redhat.com>
Message-ID: <Pine.LNX.4.44.0211041344040.12273-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Nov 2002, Ulrich Drepper wrote:
> int
> main()
> {
>   system ("cp -f u1 uu");
>   int fd = open ("./uu", 0);
>   char buf[100];
>   sprintf (buf, "/proc/self/fd/%d", fd);
>   char buf2[100];
>   int n = readlink (buf, buf2, sizeof (buf2));
>   buf2[n] = '\0';
>   system ("cp -f u2 uu");
>   execl (buf, buf2, "hallo", 0);
>   return 0;
> }
> $ gcc -c o u u.c
> $ ./u
> 
> 
> You should see 'u2' as the result.  But this is exactly what the fexecve
> call is supposed to prevent.  The file, once opened, should be reused.
> The expected result is 'u1'.

No, you're wrong.

Your "cp -f" will _overwrite_ the already existing "uu" file. So the "cp"  
is actually overwriting the old binary, and it prints out "u2" as a
result: which is exactly the expected behaviour of "fexecve()". If you
change the file itself, there's no way to execve() the old contents,
because the old contents simply do not exist. That's true of fexecve()  
too.

To show what you want to show, you need to use "cp -fb" or something else
that actually _switches_ the file around from under you. Or make the
system() call do a "rm uu; cp uX uu". And if you do that, then you will
see "u1". Try it and see.

In other words, "execve(/proc/self/fd/xxx)" does work and is exactly the
same as fexecve().

		Linus


