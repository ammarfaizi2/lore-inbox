Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbQLGTcm>; Thu, 7 Dec 2000 14:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130190AbQLGTcc>; Thu, 7 Dec 2000 14:32:32 -0500
Received: from 212-140-94-250.btopenworld.com ([212.140.94.250]:2056 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130026AbQLGTcR>;
	Thu, 7 Dec 2000 14:32:17 -0500
Date: Thu, 7 Dec 2000 19:03:50 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
cc: linux-kernel@vger.kernel.org, drew@colorado.edu
Subject: Re: bug in scsi.c
In-Reply-To: <Pine.GHP.4.21.0012071809140.18350-100000@wpax13.physik.uni-wuerzburg.de>
Message-ID: <Pine.LNX.4.21.0012071858460.4388-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Andreas Klein wrote:

> hello,
> 
> I have found a problem in scsi.c which in present in the 2.2 and 2.4
> series. the scsi error handler thread is created with:
> 
> kernel_thread((int (*)(void *)) scsi_error_handler,
>                                 (void *) shpnt, 0);
> 
> This will lead to problems, when you have to umount the filesystem on
> which the scsi-hostapter module is located.
> To solve to problem I would propose to change this to:
> 
> kernel_thread((int (*)(void *)) scsi_error_handler,
>                       (void *) shpnt, CLONE_FILES);

Hi Andreas,

Unfortunately, CLONE_FILES is not enough because the module may be loaded
from the directory containing it, i.e. the thread's cwd may point to that
filesystem and that would keep it busy. Or-ing CLONE_FS into flags
wouldn't help either...

A proper way to release the references to resources is to call daemonize()
function from within the kernel thread function, which calls
exit_fs()/exit_files() internally.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
