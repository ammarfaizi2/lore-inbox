Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130786AbQLGXxf>; Thu, 7 Dec 2000 18:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQLGXxU>; Thu, 7 Dec 2000 18:53:20 -0500
Received: from cip.physik.uni-wuerzburg.de ([132.187.42.13]:55305 "EHLO
	wpax13.physik.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id <S129352AbQLGXwq>; Thu, 7 Dec 2000 18:52:46 -0500
Date: Thu, 7 Dec 2000 23:58:21 +0100 (MET)
From: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org, drew@colorado.edu
Subject: Re: bug in scsi.c
In-Reply-To: <Pine.LNX.4.21.0012071858460.4388-100000@penguin.homenet>
Message-ID: <Pine.GHP.4.21.0012072342460.24819-100000@wpax13.physik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Tigran Aivazian wrote:

> On Thu, 7 Dec 2000, Andreas Klein wrote:
> 
> > hello,
> > 
> > I have found a problem in scsi.c which in present in the 2.2 and 2.4
> > series. the scsi error handler thread is created with:
> > 
> > kernel_thread((int (*)(void *)) scsi_error_handler,
> >                                 (void *) shpnt, 0);
> > 
> > This will lead to problems, when you have to umount the filesystem on
> > which the scsi-hostapter module is located.
> > To solve to problem I would propose to change this to:
> > 
> > kernel_thread((int (*)(void *)) scsi_error_handler,
> >                       (void *) shpnt, CLONE_FILES);
> 
> Hi Andreas,
> 
> Unfortunately, CLONE_FILES is not enough because the module may be loaded
> from the directory containing it, i.e. the thread's cwd may point to that
> filesystem and that would keep it busy. Or-ing CLONE_FS into flags
> wouldn't help either...

Yes, you are right with that.

> A proper way to release the references to resources is to call daemonize()
> function from within the kernel thread function, which calls
> exit_fs()/exit_files() internally.

Nearly correct, the daemonize function does NOT call exit_files. This has
to be done manually. Looking at the 2.4.0-test10 source I saw, that
someone has already fixed the problem by calling exit_files and daemonize.
In the 2.2 series someone tried cut-copy-paste programing from the
daemonize function, but exit_files was forgotten. The following patch
should fix the problem for 2.2.16, while leaving scsi.c untouched.

--- linux/drivers/scsi/scsi_error.c.orig        Thu Dec  7 23:56:47 2000
+++ linux/drivers/scsi/scsi_error.c     Fri Dec  8 00:13:20 2000
@@ -1935,6 +1935,7 @@
         * user space pages.  We don't need them, and if we didn't close 
them
         * they would be locked into memory.
         */
+       exit_files(current);
        exit_mm(current);
 
        current->session = 1;

Bye,

-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
