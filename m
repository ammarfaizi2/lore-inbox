Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUCGWb7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 17:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUCGWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 17:31:58 -0500
Received: from smtp07.auna.com ([62.81.186.17]:25526 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S262344AbUCGWby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 17:31:54 -0500
Date: Sun, 7 Mar 2004 23:31:50 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Why fcntl(SETLKW) can fail ?
Message-ID: <20040307223150.GA30562@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have an strange problem with locking over nfs.
I wanto to lock a file, stored on a NFS server, and it used to work.
About 15 clients locked and unlocked the file. After several nodes were
added to the cluster (now total nodes are 45), suddenly, locks have
started to fail:

her002:~/giga> ask-lock kk
fcntl(SETLKW): No locks available

Code is just this:

#include <unistd.h>
#include <fcntl.h>
#include <cstdio>

int main(int argc,char*const* argv)
{
        int fd;
        struct flock lock;
        int     pid;

        if (argc<2)
                return 1;

        while ((fd = open(argv[1],O_WRONLY)) < 0)
                usleep(10000);

        lock.l_type = F_WRLCK;
        lock.l_whence = SEEK_SET;
        lock.l_start = lock.l_len = 0;
        if (fcntl(fd,F_SETLKW,&lock)<0)
        {
                perror("fcntl(SETLKW)");
                return 1;
        }
        fchmod(fd,0);

        return 0;
}

Kernel [lockd] is running both on server and clients. Some clients are still
able to lock the file, so the problem seems to be in the client side.
What is the problem ? Man page for fcntl states:

       ENOLCK Too  many  segment  locks  open, lock table is full, or a remote
              locking protocol failed (e.g. locking over NFS).

Is there any /proc entry to look at the lock table usage ? 
Is there any problem wrt locks with the shared dir to be mounted by 45 clients ?
This really puzzles me...

Systems are Red Hat Linux release 9 (Shrike). Kernels:
- server: kernel-bigmem-2.4.20-8
- clients: 2.4.20-19.9smp, 2.4.20-20.9smp, 2.4.20-30.9smp

Any idea ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Community) for i586
Linux 2.6.4-rc1-jam2 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.4mdk))
