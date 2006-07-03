Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWGCJ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWGCJ2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWGCJ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:28:07 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38635 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751042AbWGCJ2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:28:06 -0400
Date: Mon, 3 Jul 2006 11:26:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>,
       perex@suse.cz, Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
In-Reply-To: <1151874979.25802.31.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0607031123350.22261@yvahk01.tjqt.qr>
References: <20060629192128.GE19712@stusta.de>  <44A54D8E.3000002@superbug.co.uk>
 <20060630163114.GA12874@dspnet.fr.eu.org>  <1151702966.32444.57.camel@mindpipe>
  <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>
  <44A76DDF.4020307@superbug.co.uk>  <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr>
  <1151854092.12026.39.camel@mindpipe>  <Pine.LNX.4.61.0607022304230.5218@yvahk01.tjqt.qr>
 <1151874979.25802.31.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> We do not reverse engineer the .text section, but change the .dynstr 
>> section that is specific to the ELF format. I doubt any app out there md5s 
>> itself.
>
>It's possible.  They certainly try very hard to thwart reverse
>engineers.
>
>http://www.secdev.org/conf/skype_BHEU06.handout.pdf
>

Here is your POC for the manipulation of dynstr (and therefore, interception of
library calls without interfering with redefining/overriden libc names like
memory debuggers and AOSS do).

skype-1.2.0.18.tar.bz2

.dynsym table (0x2f80), as printed per "HT"
0130 global   func     00000000 0000007c *undefined  writ
05b9 global   func     00000000 0000007c *undefined  open
074d global   func     00000000 0000007c *undefined  read

.dynsym table (absaddr 0x2f80):
ofs     absaddr stringptr
+0x0130 0x4280  0xe0c0
+0x05b9 0x8b10  0xddbc
+0x074d 0xa450  0xdff0

.dynstr table (absaddr 0xa750):
ofs     absaddr name
+0xe0c0 0x18810 write
+0xddbc 0x1850c open  (note it is part of "fdopen")
+0xdff0 0x18740 read

Change to w2ite, o2en, r2en. Implement w2ite(), o2en(), r2()en and fdo2en() in
an extra library. Load that via LD_PRELOAD.

---extra.c---
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int o2en(const char *path, int flags, mode_t mode) {
    int ret = open(path, flags, mode);
    printf("open(\"%s\", %x, %04o) = %d\n", path, flags, (int)mode, ret);
    return ret;
}

FILE *fdo2en(int fd, const char *mode) {
    FILE *ret = fdopen(fd, mode);
    printf("fdopen(%d, \"%s\") = %#p\n", fd, mode, ret);
    return ret;
}

ssize_t r2ad(int fd, void *buf, size_t count) {
    ssize_t ret = read(fd, buf, count);
    printf("read(%d, %#p, %zu) = %zd\n", fd, buf, count, ret);
    return ret;
}

ssize_t w2ite(int fd, const void *buf, size_t count) {
    ssize_t ret = write(fd, buf, count);
    printf("write(%d, %#p, %zu) = %zd\n", fd, buf, count, ret);
    return ret;
}

---eof---
11:21 linux01:~ > cc extra.c -Wall -o extra.so -shared
11:21 linux01:~ > export LD_PRELOAD=$PWD/extra.so
write(4, 0xbfffe82b, 1) = 1
write(4, 0x8a211d0, 26) = 26
read(4, 0x8a27620, 2048) = 4
write(4, 0x8a211d0, 7) = 7
read(4, 0x8a31750, 2048) = 260
read(4, 0x8a31f60, 2048) = -1
read(4, 0x8a31f60, 2048) = 82
read(4, 0x8a32770, 2048) = -1
read(4, 0x8a32770, 2048) = 256
read(4, 0x8a31f60, 2048) = -1
open("/home/jengelh/.Skype/shared.lck", 8041, 0777) = 8
open("/home/jengelh/.Skype/shared.xml", 8000, 0777) = 9
read(9, 0x8a3c900, 168) = 168
open("/dev/urandom", 0, 0004) = 8
read(8, 0xbfffe760, 8) = 8
open("/dev/urandom", 0, 0004) = 8
read(8, 0xbfffe760, 8) = 8
open("/dev/urandom", 0, 1051125610) = 8
read(8, 0xbfffe7a0, 8) = 8
open("/dev/urandom", 0, 1051131340) = 8
read(8, 0xbfffe7a0, 8) = 8


W.W.W.W.W.


Jan Engelhardt
-- 
