Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315255AbSELXar>; Sun, 12 May 2002 19:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315452AbSELXar>; Sun, 12 May 2002 19:30:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54204 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315255AbSELXaq>;
	Sun, 12 May 2002 19:30:46 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15582.64211.376045.489317@argo.ozlabs.ibm.com>
Date: Mon, 13 May 2002 09:29:23 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: ext3 deadlock?
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with 2.5.15 on an old slow powerbook 3400.  It
gets stuck during boot at the point where it starts syslogd.  At that
point show_state() reveals that kjournald and one of the two syslogd
processes are stuck in D state.  The stack trace for kjournald is:

schedule
__wait_on_buffer
journal_commit_transaction
kjournald

The stack trace on the syslogd process looks like this:

schedule
sleep_on
log_wait_commit
journal_stop
journal_force_commit
ext3_force_commit
ext3_sync_file
sys_fsync

The machine will boot up quite happily with a 2.4.19-pre7 kernel.
If I boot with the ext3 filesystems dirty (i.e. stuff in the journal)
it will usually hang while recovering the journal for the /data
filesystem (I have two partitions, root and /data).

I have just tried booting again (with clean filesystems) and this time
I have two rc.sysinit processes stuck in D state, and kjournald is
also stuck in D state.  The stack trace for kjournald is as above,
and the stack trace for both rc.sysinit processes is:

schedule
sleep_on
sleep_on_buffer
do_get_write_access
journal_get_write_access
ext3_reserve_inode_write
ext3_mark_inode_dirty
ext3_dirty_inode
__mark_inode_dirty
update_atime
do_generic_file_read
generic_file_read
kernel_read
prepare_binprm
do_execve
sys_execve

I don't see this problem on any of my other powermac systems, but that
could be because this powerbook still has an old LinuxPPC/2000
userland installed on it whereas all my other boxes are running Debian
sid.  I have upgraded mount to 2.11r and e2fsprogs to 1.25 on this box
though.

Can anyone suggest where I could start looking to work out why
kjournald is getting stuck in __wait_on_buffer?  Where in the code
does the corresponding wakeup happen?

Paul.
