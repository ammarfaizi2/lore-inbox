Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUIPOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUIPOIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268083AbUIPOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:08:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26499 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268082AbUIPOIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:08:12 -0400
Date: Thu, 16 Sep 2004 10:07:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Having problem with mmap system call!!!
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in>
Message-ID: <Pine.LNX.4.53.0409160958070.12146@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Srinivas G. wrote:

> Hi All,
>
> I have a doubt about mmap system call.
>

mmap() works. Otherwise you wouldn't be sending any email.
It is used every time you open an application because that's
how shared libraries work.

You need to return the PHYSICAL address of your camera buffer
to user-space (probably using a driver ioctl()). Then the
user-mode code does ....


#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#define HINT  0x20000000
#define PROT (PROT_READ|PROT_WRITE)
#define FLAGS (MAP_FIXED|MAP_SHARED)
#define SHM_FAIL (void *)-1


void *init_shmem(size_t addr, size_t len)
{
    int fd;
    void *vp;
    if((fd = open("/dev/mem", O_RDWR, 0)) < 0)
    {
        fprintf(stderr, "Can't open memory device\n");
        exit(EXIT_FAILURE);
    }
    if((vp = mmap((caddr_t) HINT, len, PROT, FLAGS, fd, addr)) == SHM_FAIL)
    {
        fprintf(stderr, "Can't access shared memory\n");
        exit(EXIT_FAILURE);
    }
    (void)close(fd);
    return vp;
}

After that, anything the camera writes to its address will
be available in user-mode at the memory-mapped address.
This DOES work. That's how I do direct DMA to user-space
all the time.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

