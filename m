Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWJCRB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWJCRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWJCRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:01:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030329AbWJCRB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:01:58 -0400
Date: Tue, 3 Oct 2006 10:01:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: linux/compat.h includes asm/signal.h causing problems
Message-Id: <20061003100136.e38553ff.akpm@osdl.org>
In-Reply-To: <12989.1159878079@warthog.cambridge.redhat.com>
References: <20061003105435.GG29920@ftp.linux.org.uk>
	<20061002.141850.18280315.davem@davemloft.net>
	<20061002.131414.74728780.davem@davemloft.net>
	<20061002135036.7bd1f76b.akpm@osdl.org>
	<20061002.140437.78732307.davem@davemloft.net>
	<9802.1159868725@warthog.cambridge.redhat.com>
	<12989.1159878079@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 13:21:19 +0100
David Howells <dhowells@redhat.com> wrote:

> Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> > I do, it's not a problem...
> 
> Actually, I was asking for myself.  Can I grab a copy?
> 

x86 binaries:

http://userweb.kernel.org/~akpm/sparc-cross.tar.bz2
http://userweb.kernel.org/~akpm/sparc64-cross.tar.bz2

script to run them:



#!/bin/sh

if [ x$ARCH == x ]
then
	echo '$ARCH' unset
	exit 1
fi

if [ x$J == x ]
then
	J=256
fi

if [ x"$DISTCC_HOSTS" != x ]
then
	DISTCC="distcc"
fi

XARCH="$ARCH-unknown-linux-gnu"
I=vmlinux

[ $ARCH = alpha ] &&	CT=gcc-4.1.0-glibc-2.3.6
[ $ARCH = arm ] &&	CT=gcc-3.4.5-glibc-2.3.6
[ $ARCH = i386 ] &&	CT=gcc-4.1.0-glibc-2.3.6 && XARCH=i686-unknown-linux-gnu && I=bzImage
[ $ARCH = ia64 ] &&	CT=gcc-3.4.5-glibc-2.3.6
[ $ARCH = m68k ] &&	CT=gcc-4.1.0-glibc-2.3.6
[ $ARCH = mips ] &&	CT=gcc-3.4.5-glibc-2.3.6
[ $ARCH = powerpc ] &&	CT=gcc-4.1.0-glibc-2.3.6 && XARCH=powerpc-405-linux-gnu
[ $ARCH = s390 ] &&	CT=gcc-4.1.0-glibc-2.3.6
[ $ARCH = sh ] &&	CT=gcc-3.4.5-glibc-2.3.6 && XARCH=sh4-unknown-linux-gnu
[ $ARCH = sparc ] &&	CT=gcc-4.1.0-glibc-2.3.6
[ $ARCH = sparc64 ] &&	CT=gcc-3.4.5-glibc-2.3.6
[ $ARCH = x86_64 ] &&	CT=gcc-4.0.2-glibc-2.3.6 && I=bzImage
[ $ARCH = parisc ] &&	CT=gcc-4.0.2-glibc-2.3.6 && I=bzImage

if [ $# -eq 0 ]
then
	WHAT="$I modules"
else
	WHAT="$*"
fi

PATH=$PATH:/opt/crosstool/$CT/$XARCH/bin export PATH

export CROSS_COMPILE=/opt/crosstool/$CT/$XARCH/bin/$XARCH-

export CC="$DISTCC /opt/crosstool/$CT/$XARCH/bin/$XARCH-gcc"

if [ "$ECHO" != "" ]
then
	echo CROSS_COMPILE=$CROSS_COMPILE CC=\"$CC\" make -j$J $* CC=\"$CC\" $WHAT
else
	nice -20 make -j$J $* CC="$CC" $WHAT 2>/tmp/log-$ARCH || FAILED=1
fi

cat /tmp/log-$ARCH
[ "$FAILED" != "" ] && echo "**FAILED**"

