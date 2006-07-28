Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWG1R41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWG1R41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWG1R41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:56:27 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:63248 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1161207AbWG1R40 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:56:26 -0400
To: =?utf-8?Q?Pawe=C5=82?= Sikora <pluto@agmk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
X-URL: <http://www.mandrivalinux.com/
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	<1154102627.6416.13.camel@laptopd505.fenrus.org>
	<1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	<200607281913.37889.pluto@agmk.net>
From: Thierry Vignaud <tvignaud@mandriva.com>
Organization: Mandriva
Date: Fri, 28 Jul 2006 19:56:20 +0200
In-Reply-To: <200607281913.37889.pluto@agmk.net> (=?utf-8?Q?Pawe=C5=82?=
 Sikora's message of "Fri, 28 Jul 2006 19:13:37 +0200")
Message-ID: <m2psfpy5ob.fsf@vador2.mandriva.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paweł Sikora <pluto@agmk.net> writes:

> gcc supports stack protection at so called tree-level (it means it's
> architecture-independent). i've just tested a simple userland-code:
> 
> #include <stdlib.h>
> #include <string.h>
> int main()
> {
> 	char c;
> 	memset( &c, 0, 512 );
> 	return 0;
> }
> 
> and stack protection works fine on {ix86,x86-64,powerpc}-linux.
> i can test it on {alpha,sparc}-linux later but i'm pretty sure
> it'll work too on these archs.

$ gcc -v
Using built-in specs.
Target: x86_64-mandriva-linux-gnu
Configured with: ../configure --prefix=/usr --libexecdir=/usr/lib --with-slibdir=/lib64 --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --enable-languages=c,c++,ada,fortran,objc,obj-c++,java --host=x86_64-mandriva-linux-gnu --with-cpu=generic --with-system-zlib --enable-long-long --enable-__cxa_atexit --enable-clocale=gnu --disable-libunwind-exceptions --enable-java-awt=gtk --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --enable-gtk-cairo --enable-ssp --disable-libssp
Thread model: posix
gcc version 4.1.1 20060724 (prerelease) (4.1.1-3mdk)
$ gcc  -fstack-protector t.c
$ ./a.out                   
zsh: segmentation fault  ./a.out

it segfaults if using "return 0" instead of "exit(0)" and only if
memset overwrote the stack

why? because, according to gcc man page, "This includes functions that
call alloca, and functions with buffers larger than 8 bytes."
once the stack is bigger, it does abort with "*** stack smashing
detected ***: <unknown> terminated" however.

thus this won't protect stacks of small functions... such as your
example...
