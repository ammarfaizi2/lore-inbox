Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWBVUoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWBVUoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWBVUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:44:05 -0500
Received: from spirit.analogic.com ([204.178.40.4]:31243 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751423AbWBVUoE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:44:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1140635265.26079.16.camel@lycan.lan>
x-originalarrivaltime: 22 Feb 2006 20:43:55.0907 (UTC) FILETIME=[B2DBDD30:01C637F0]
Content-class: urn:content-classes:message
Subject: Re: Problems with read() on /proc/devices with x86_64 system
Date: Wed, 22 Feb 2006 15:43:55 -0500
Message-ID: <Pine.LNX.4.61.0602221520080.11376@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with read() on /proc/devices with x86_64 system
Thread-Index: AcY38LLjjV60+l5fSJarpio3uKsYPg==
References: <1140635265.26079.16.camel@lycan.lan>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Schlemmer" <azarah@nosferatu.za.org>
Cc: "Linux Kernel Mailing Lists" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Feb 2006, Martin Schlemmer wrote:

> Hi,
>
> Not sure when it started, but 2.6.16-rc[1234] at least have problems
> with unbuffered read() and /proc/devices on my x86_64 box.  I first
> picked it up with dmsetup that did not want to work properly built
> against klibc (glibc with fread() worked fine though, as it mmap()'d the
> file).
>
> Following code (from HPA and klibc mailing lists), when compiled and run
> with /proc/devices only reads the first two lines and then exits
> normally, where with any other file works as expected.
>
> -----
> #include <stdlib.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <sys/stat.h>
>
> int main(int argc, char *argv[])
> {
>  char c;
>  int i, fd, rv;
>
>  for ( i = 1 ; i < argc ; i++ ) {
>    fd = open(argv[i], O_RDONLY);
>    if ( fd < 0 ) {
>      perror(argv[i]);
>      exit(1);
>    }
>
>    while ( (rv = read(fd, &c, 1)) ) {
>      if ( rv == -1 ) {
>        if ( errno == EINTR || errno == EAGAIN )
>          continue;
>
>        perror(argv[i]);
>        exit(1);
>      }
>      putchar(c);
>    }
>
>    close(fd);
>  }
>  return 0;
> }
> -----
>
> Output over here:
>
> -----
> # ./readbychar.klibc /proc/devices
> Character devices:
>  1 mem
> #
> -----
> Thanks,
> Martin Schlemmer

If your code ever worked, it's probably because of some
fortuitous buffering in the 'C' runtime library. Most
of the 'read' code in drivers that have a /proc interface
is not designed for 1-character-at-a-time I/O. It's expected
that it will be accessed like `cat` or `more` or other
such tools access it, -- one read with 4096-byte buffer --

read(3, "MemTotal:       773860 kB\nMemFre"..., 4096) = 670
write(1, "MemTotal:       773860 kB\nMemFre"..., 670) = 670

The read code uses sprintf to write all the parameters to
a buffer, then it copies the parameters to the user. The
next read will return 0 for EOF and reset the interface
for the next access.

If your code read /proc without any help from the 'C' runtime
library, you would read the same first character, every time
you attempted to read a character. Don't do that! Your code
should do (with some error-checking):

         fd = open(argv[1], O_RDONLY);
 	buffer = malloc(LEN);
         read(fd, buffer, len);
         puts(buffer);

Also, something seems somewhat strange because it is not
commonplace to provide a mmap() interface to /proc file-system
capability in drivers and the /proc base code doesn't
provide memory-map capability at least on 2.6.15.4. So,
your reference to memory-mapping the file seems to be
incorrect.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
