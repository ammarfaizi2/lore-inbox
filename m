Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312579AbSDVFTz>; Mon, 22 Apr 2002 01:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSDVFTy>; Mon, 22 Apr 2002 01:19:54 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:46506 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S312579AbSDVFTy>;
	Mon, 22 Apr 2002 01:19:54 -0400
Message-Id: <3.0.6.32.20020422072320.009347f0@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 22 Apr 2002 07:23:20 +0200
To: sct@redhat.com, akpm@zip.com.au, adilger@turbolinux.com
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: [PATCH] open files in kjounald (2)
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, got it the wrong way around :-(


Hello everybody!

As I wrote in my mail the previous week ("BUG: 2.4.19pre1 & journal_thread
& open filehandles") I followed the problem a little bit further.

Here's my patch; I beg the ext3-maintainers (Stephen, Andreas, Andrew) to
have a look at it and submit it to Marcelo and Linux for inclusion.
(2.4 is for now for me more important than 2.5).


Patch
-----

On every mount of ext3 (and I suppose all journaling filesystems which use
jbd, although I didn't test this) a new kjournald is created. All kjournald
share the same file-information.

Before this patch it would accumulativly fetch open files from the calling
process (normally mount); I verified this via (in bash)
	exec 30< /etc/services
	mount <partition> /mnt/tmp
	ps -aux | grep kjournald
	ls -la <pid of any kjournald>
gives, among 0, 1 and 2
	30 -> /etc/services

This is really awful as you can't umount devfs (normally /dev/console is
opened as from the start-scripts) and so / can't be umounted.

After applying this patch the open files were gone.


Please apply this patch ASAP - thank you very much.


Regards,

Phil


diff -ru linux/fs/jbd/journal.c linux.ori/fs/jbd/journal.c
--- linux.ori/fs/jbd/journal.c  Mon Apr 22 06:28:54 2002
+++ linux/fs/jbd/journal.c      Mon Apr 22 06:29:16 2002
@@ -204,7 +204,6 @@

        lock_kernel();
        daemonize();
+       exit_files(current);
        spin_lock_irq(&current->sigmask_lock);
        sigfillset(&current->blocked);
        recalc_sigpending(current);

