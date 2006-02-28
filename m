Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWB1UgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWB1UgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWB1UgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:36:11 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:37340 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932561AbWB1UgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:36:10 -0500
Message-ID: <4404B41C.10404@free.fr>
Date: Tue, 28 Feb 2006 21:35:40 +0100
From: Olivier Croquette <ocroquette@free.fr>
Reply-To: ocroquette@free.fr
User-Agent: Thunderbird 1.5 (Macintosh/20051025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: nfs@lists.sourceforge.net
Subject: NFS client hangs under certain circumstances on SMP machine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have already sent this message on the NFS mailing-list, but I had no 
reaction there. May be you kernel hackers have an idea?



I have a strange problem since a few months on some Linux clients.

I have a file server accessed through:
   - NFS from Linux clients (autofs, but direct mount causes same effect)
   - Samba from Windows clients

This works since several years like a charm, but as I said there is a
strange problem that appeared recently:

I have a directory, to which I generate code from Windows (\\server\dir)
I can see it under Linux (/mount/dir) where I can access (compile) the
files.

However, when I regenerate the file under Windows again (ie. I overwrite
the old files), and I try to compile the files again under Linux, "make"
hangs simply in D state:

# ps aux | grep make
user 7177 0.0  0.0 1984 760 pts/1 D+ 16:13 0:00 make -f myMakefile

The load average goes up one unit each time I reproduce this test 
(apparently, processes in non-interruptible state are considered as 
running).

 From then, the following actions does NOT unblock the process:
   - stopping or restarting the NFS service on the server
   - restarting the server
   - restarting autofs on the client
   - trying to unmount the NFS mount

If I reboot the client, all goes back to normal, until I repeat the
process below (ie. overwriting and compiling).
Typically, "shutdown -r" does not work, I have to "reboot -f".

There is nothing interesting in /var/log on the server nor on the
client.

Versions used on the server:
   - SuSE 9.3
   - kernel-default-2.6.11.4-21.11
   - nfs-utils-1.0.7-3
   - samba-3.0.13-1.1
   - filesystem: reiserfs

On the client:
   - SuSE 9.3
   - kernel-smp-2.6.11.4-21.10
   - nfs-utils-1.0.7-3
   - mounts:
     automount on /mount type autofs 
(rw,fd=4,pgrp=6529,minproto=2,maxproto=4)
     serv:/dir on /mount/dir type nfs (rw,addr=*IP*)
   - CPU: P4 with hyper threading (2 virtual CPUs)
Note: maxcpus=0 does not make any difference regarding this issue. I
could not test yet with kernel compiled without SMP at all.


On the following clients with the very same server, network, and mount 
tables I could not reproduce the problem:

   - SuSE 9.1
   - kernel-default-2.6.5-7.202.7
   - nfs-utils-1.0.6-103
   - CPU: P4 single core

   - SuSE 10.0
   - Kernel: 2.6.14.3-default (from kernel.org)
   - nfs-utils-1.0.7-13


Any idea?
Seems to me as it is related to the SMP. What do you think?
How can I debug further?


