Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbTLCPo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264603AbTLCPo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:44:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:34439 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264574AbTLCPoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:44:54 -0500
Date: Wed, 3 Dec 2003 10:43:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
Message-ID: <Pine.LNX.4.53.0312031037440.17092@chaos>
References: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Bloch, Jack wrote:

> I try to open a non-existan device driver node file. The Kernel returns a
> value of -1 (expected). However, when I read the value of errno it contains
> a value of 29. A call to the perror functrion does print out the correct
> error message (a value of 2). Why does this happen?
>
> Jack Bloch
> Siemens ICN
> phone                (561) 923-6550
> e-mail                jack.bloch@icn.siemens.com


Because it doesn't happen! You are likely polluting the errno
variable either with another system call before you test it
or by not including the correct header file (errno may be a
MACRO).


Try this program:


#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

int main(int args, char *argv[])
{
    int fd, save_errno;
    if(args < 2) {
        fprintf(stderr, "Usage:\n%s <filename>\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    if((fd = open(argv[1], O_RDONLY)) < 0) {
        save_errno = errno;
        perror("open");
        fprintf(stderr, "Was %d (%s)\n", save_errno, strerror(save_errno));
        exit(EXIT_FAILURE);
    }
    (void)close(fd);
    return 0;
}

Script started on Wed Dec  3 10:41:24 2003
# ./xxx /dev/XXX
open: No such file or directory
Was 2 (No such file or directory)
# ./xxx /dev/VXI
open: Operation not supported by device
Was 19 (Operation not supported by device)
# exit
exit
Script done on Wed Dec  3 10:42:12 2003

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


