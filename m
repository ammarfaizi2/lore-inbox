Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUFOIFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUFOIFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUFOIFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:05:47 -0400
Received: from elin.scali.no ([62.70.89.10]:15494 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S265362AbUFOIF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:05:29 -0400
Subject: Does exec-shield with -fpie  work?
From: Terje Eggestad <terje.eggestad@scali.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1087286723.3156.35.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Jun 2004 10:05:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I'm using FC2 with 2.6.5-1.358 and 2.6.6-1.435 kernels (same behavior)

exec-shield enables (If I understand correctly):

[root@pc-16 te]# cat /proc/sys/kernel/exec-shield
1
[root@pc-16 te]# cat /proc/sys/kernel/exec-shield-randomize 
1


Have a little test program that print out the addresses of a couple of
symbols:
#include <strings.h>
#include <stdlib.h>
#include <unistd.h>


main()
{
   char * a = "hei hei";
   char * b = "hei hei alle sammen";
   int rc;

   rc = strcmp(a, b);

   printf ("main %p strcmp %p\n", main, strcmp);
   printf ("getpid %p malloc %p\n", getpid, malloc);
   printf ("stack syms: a = %p  b = %p rc = %p\n", &a, &b, &rc);

};


Now I run it several times and while the stack addrs is randiomized,
libc only alternate between two addresses and main() is always at the
same place, I though part of the idea was to really randomize the shared
lib addrs as well as the main prog sym addrs? :


te pc-16 ~ 70> !gcc
gcc -fPIE -fpic -o ./testsc ./testsc.c



te pc-16 ~ 71> ./testsc
main 0x80483f8 strcmp 0x4b91e0
getpid 0x4d9ea0 malloc 0x4b3010
stack syms: a = 0xfef7eb20  b = 0xfef7eb1c rc = 0xfef7eb18
te pc-16 ~ 72> ./testsc
main 0x80483f8 strcmp 0x4b91e0
getpid 0x4d9ea0 malloc 0x4b3010
stack syms: a = 0xfee4dd80  b = 0xfee4dd7c rc = 0xfee4dd78
te pc-16 ~ 73> ./testsc
main 0x80483f8 strcmp 0x4b91e0
getpid 0x4d9ea0 malloc 0x4b3010
stack syms: a = 0xfee49dd0  b = 0xfee49dcc rc = 0xfee49dc8
te pc-16 ~ 74> ./testsc
main 0x80483f8 strcmp 0x1771e0
getpid 0x197ea0 malloc 0x171010
stack syms: a = 0xfef68540  b = 0xfef6853c rc = 0xfef68538
te pc-16 ~ 75> ./testsc
main 0x80483f8 strcmp 0x4b91e0
getpid 0x4d9ea0 malloc 0x4b3010
stack syms: a = 0xfef4c980  b = 0xfef4c97c rc = 0xfef4c978
te pc-16 ~ 76> ./testsc
main 0x80483f8 strcmp 0x4b91e0
getpid 0x4d9ea0 malloc 0x4b3010
stack syms: a = 0xfef4bd40  b = 0xfef4bd3c rc = 0xfef4bd38
te pc-16 ~ 77> ./testsc
main 0x80483f8 strcmp 0x1771e0
getpid 0x197ea0 malloc 0x171010
stack syms: a = 0xfef44620  b = 0xfef4461c rc = 0xfef44618
te pc-16 ~ 78> 




-- 

Terje Eggestad
Senior Software Engineer
dir. +47 22 62 89 61
mob. +47 975 31 57
fax. +47 22 62 89 51
terje.eggestad@scali.com

Scali - www.scali.com
High Performance Clustering

