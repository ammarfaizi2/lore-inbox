Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQLGXgP>; Thu, 7 Dec 2000 18:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbQLGXgG>; Thu, 7 Dec 2000 18:36:06 -0500
Received: from 62-6-231-122.btconnect.com ([62.6.231.122]:27908 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129314AbQLGXfo>;
	Thu, 7 Dec 2000 18:35:44 -0500
Date: Thu, 7 Dec 2000 23:07:19 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
cc: linux-kernel@vger.kernel.org, drew@colorado.edu
Subject: Re: bug in scsi.c
In-Reply-To: <Pine.GHP.4.21.0012072342460.24819-100000@wpax13.physik.uni-wuerzburg.de>
Message-ID: <Pine.LNX.4.21.0012072305060.933-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Andreas Klein wrote:
> > A proper way to release the references to resources is to call daemonize()
> > function from within the kernel thread function, which calls
> > exit_fs()/exit_files() internally.
> 
> Nearly correct, the daemonize function does NOT call exit_files.

I do not post messages to linux-kernel without checking the facts
first. Read the daemonize() function and see for yourself that you are
wrong.

Regards,
Tigran

PS, Here it is, to save you time opening kernel/sched.c. The kernel is, of
course, test12-pre7.

/*
 *      Put all the gunge required to become a kernel thread without
 *      attached user resources in one place where it belongs.
 */

void daemonize(void)
{
        struct fs_struct *fs;


        /*
         * If we were started as result of loading a module, close all of
the
         * user space pages.  We don't need them, and if we didn't close
them
         * they would be locked into memory.
         */
        exit_mm(current);

        current->session = 1;
        current->pgrp = 1;

        /* Become as one with the init task */

        exit_fs(current);       /* current->fs->count--; */
        fs = init_task.fs;
        current->fs = fs;
        atomic_inc(&fs->count);
        exit_files(current);
        current->files = init_task.files;
        atomic_inc(&current->files->count);
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
