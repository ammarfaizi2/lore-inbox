Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266044AbTGIPKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbTGIPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:10:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266044AbTGIPKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:10:30 -0400
Date: Wed, 9 Jul 2003 11:25:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: modutils-2.3.15 'insmod'
Message-ID: <Pine.LNX.4.53.0307091119450.470@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


modutils-2.3.15, and probably later, has a bug that can prevent
modules from being loaded from initrd, this results in not
being able to mount a root file-system. The bug assumes that
malloc() will return a valid pointer when given an allocation
size of zero.

When there are no modules loaded, insmod scans for modules
and allocates data using its xmalloc() based upon the number
of modules found. If the number was 0, it attempts to allocate
0 bytes (0 times the size of a structure). If malloc() returns
NULL (and it can, probably should), xmalloc() will write an
"out of memory" diagnostic and call exit().

The most recent `man` pages that RH 9.0 distributes states that
malloc() can return either NULL of a pointer that is valid for
free(). This, of course, depends upon the 'C' runtime library's
malloc() implementation.

#include <stdio.h>
#include <malloc.h>
int main(void);
int main()
{
    printf("%p\n", malloc(0));
    return 0;
}

It is likely that malloc(0) returning a valid pointer is a bug
that has prevented this problem from being observed. Such a
bug in malloc() is probably necessary to keep legacy software
running, but new software shouldn't use such atrocious side-effects.
An allocation of zero needs to be discovered and fixed early
in code design.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

