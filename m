Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVGUJHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVGUJHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVGUJHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:07:09 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:31170 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261702AbVGUJHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:07:07 -0400
Message-ID: <42DF671B.8020809@stesmi.com>
Date: Thu, 21 Jul 2005 11:12:59 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Bastiaan Naber <naber@inl.nl>, linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
References: <200507201416.36155.naber@inl.nl> <1121935332.21421.10.camel@tara.firmix.at>
In-Reply-To: <1121935332.21421.10.camel@tara.firmix.at>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bernd Petrovitsch wrote:
> On Wed, 2005-07-20 at 14:16 +0200, Bastiaan Naber wrote:
> [...]
> 
>>I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
>>this because I need to have this data accessible with a very low seek time.
> 
> 
> Apart fromn the 32-vs-64bit thing: Isn't it enough (and simpler and more
> flexible) to mmap(2) that file and mlock(2) it afterwards?
> 
> 	Bernd

On 32bit arches, a pointer is 32bit large.
On 64bit arches, a pointer is 64bit large.

You can't mmap() the whole file if it's larger than 32bit on a 32bit
arch.

 void *mmap(void *start, size_t length, int prot, int flags,
       int fd, off_t offset);

test.c:
#include <sys/mman.h>
int main(void)
{
  printf("sizeof(void *): %d\n", sizeof(void *));
  printf("sizeof(size_t): %d\n", sizeof(size_t));
}

On a 64bit machine:
$ gcc test.c -o test64 ; ./test64; file ./test64
sizeof(void *): 8
sizeof(size_t): 8
test64: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV), for
GNU/Linux 2.4.0, dynamically linked (uses shared libs), not stripped

On a 32bit machine (or in this case, 32bit userland on a 64bit machine):
$ gcc -m32 test.c -o test32 ; ./test32; file ./test32
sizeof(void *): 4
sizeof(size_t): 4
test32: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for
GNU/Linux 2.2.5, dynamically linked (uses shared libs), not stripped

Meaning both the pointer and the size argument are only 32bit (4byte)
on 32-bit arches and 64bit (8 byte) on 64bit arches.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD4DBQFC32caBrn2kJu9P78RAujmAJ9J3xYdbAwYdpGXuu8kiTwdcloaSQCY1TD1
SuJJ3Ylpsa+Cdo2uIQ/Prw==
=IFvd
-----END PGP SIGNATURE-----
