Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUBMIcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 03:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266811AbUBMIcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 03:32:35 -0500
Received: from herkules.viasys.com ([194.100.28.129]:61326 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S266808AbUBMIcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 03:32:32 -0500
Date: Fri, 13 Feb 2004 10:32:23 +0200
From: Ville Herva <vherva@viasys.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4: hung spamassassin processes on reiserfs+LVM
Message-ID: <20040213083223.GC11555@viasys.com>
Reply-To: vherva@viasys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.21-pre4aa3+secfixes3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing deadlocks with kernel 2.4.21-pre4aa3+secfixes
(secfixes includes ptrace, do_brk and mremap). I've seen at least one
similar hang with 2.4.13ac2.

The deadlocks have appeared when weekly cron jobs have run for some time,
but also at other times. The kernel is still running, pingable, remote
screen session is accessible, but process table seems full. It seems spamd
from spamassassin package has to do with this, since on one occasion,
alt-sysrq-t listed a huge number of hanging spamd processes. On other
occasions, the alt-sysrq-t listing showed hanging crond and rsync processes
(the list was way too long to see all of them.)

Now I think I finally have a clue on what is going on. 39 spamd processes
hung, and I was able to stop spamassassin before the box deadlocked totally.
The spamd processes were unkillable (-KILL). After a while a couple of rsync
processes hung, too, and I was able to find out that they tried to access
/home/spamc/.spamassassin/ . "ls /home/spamc/.spamassassin" hangs too.

/home is a reiserfs partition on LVM.

I did alt-sysrq-t and ksymoopsed it. Most of the spamd processes have a
stack trace like this:

 >>EIP; e71ec000 <END_OF_CODE+1c70d7c1/????>   <=====

 Trace; c0107b6d <__down+5d/b0>
 Trace; c0107cc0 <__down_failed+8/c>
 Trace; c0146ad6 <.text.lock.namei+37/221>
 Trace; c012a835 <do_brk+155/240>
 Trace; c0139f46 <filp_open+36/60>
 Trace; c013a274 <sys_open+34/80>   
 Trace; c0108deb <system_call+33/38>
 Proc;  spamd

Some have have

 >>EIP; d72fe000 <END_OF_CODE+c81f7c1/????>   <=====

 Trace; c0107b6d <__down+5d/b0>
 Trace; c017f4d0 <reiserfs_readdir+0/460>
 Trace; c0107cc0 <__down_failed+8/c>
 Trace; c01481d1 <.text.lock.readdir+5/54>
 Trace; c014815f <sys_getdents64+4f/bc>
 Trace; c0147fd0 <filldir64+0/140>
 Trace; c0108deb <system_call+33/38>
 Proc;  spamd

some

 >>EIP; f79a0000 <END_OF_CODE+2cec17c1/????>   <=====

 Trace; c013b6c8 <__wait_on_buffer+78/a0>
 Trace; c013e7db <try_to_free_buffers+cb/120>
 Trace; c013c9d6 <discard_buffer+46/90>
 Trace; c013cab4 <discard_bh_page+44/80>
 Trace; c012ad79 <do_flushpage+29/30>
 Trace; c012ad94 <truncate_complete_page+14/50>
 Trace; c012af16 <truncate_list_pages+146/1a0>
 Trace; c012afab <truncate_inode_pages+3b/70> 
 Trace; c014e0c4 <iput+b4/1c0>
 Trace; c014ba86 <dentry_iput+46/70>
 Trace; c014bb58 <dput+a8/110>
 Trace; c0145952 <sys_unlink+92/100>
 Trace; c0108deb <system_call+33/38>
 Proc;  spamd

and rsync processes have this:

 >>EIP; e0cca000 <END_OF_CODE+161eb7c1/????>   <=====

 Trace; c0121af4 <schedule_timeout+14/a0>
 Trace; c020e15f <sock_poll+1f/30>
 Trace; c01485f6 <do_select+206/240> 
 Trace; c0148999 <sys_select+339/480>
 Trace; c0108deb <system_call+33/38>
 Proc;  rsync                       

or this

 >>EIP; cfa9c000 <END_OF_CODE+4fbd7c1/????>   <=====

 Trace; c0121af4 <schedule_timeout+14/a0>
 Trace; c020e15f <sock_poll+1f/30>
 Trace; c01485f6 <do_select+206/240>
 Trace; c0148999 <sys_select+339/480>
 Trace; c0214312 <net_tx_action+52/c0>
 Trace; c0108deb <system_call+33/38>
 Proc;  rsync

Before I upgrade the kernel and move /home/spamc to an ext3 partition, is
anyone aware of this kind of bug having been fixed in reiserfs (or elsewhere
in kernel)? Has someone seen something like this? I can provide more info,
in case anyone is interested.


-- v --

v@iki.fi
