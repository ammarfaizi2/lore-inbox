Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbULDLq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbULDLq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbULDLq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 06:46:56 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:3593 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S262536AbULDLqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 06:46:52 -0500
Message-ID: <41B1A3AA.5060703@benton987.fsnet.co.uk>
Date: Sat, 04 Dec 2004 11:46:50 +0000
From: Andrew Benton <andy@benton987.fsnet.co.uk>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: reiser4 crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using reiser4 for a couple of months. A couple of days ago I
did something stupid with Abiword, the disk started thrashing and as the
system crashed it left this on the screen

------------[ cut here ]------------
kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:58!
invalid operand:0000 [#1]
SMP
Modules linked in: nvidia
CPU:    0
EIP:    0060:[<c020144e>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.10-rc2-bk13)
EIP is at get_nonexclusive_access+0x29/0x33
eax: df033eac   ebx: df032000   ecx: d96fee80   edx: de5a70dc
esi: 00000000   edi: de5a70dc   ebp: de5a7144   esp:df033d84
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 1488, threadinfo=df032000 task=df7df020)
Stack: c0200633 de5a70dc 0804dcc7 00000001 00000001 df033bdc 00000000
df032000
        00000000 00000001 00000001 00000001 00000000 00000001 00000001
c13a0a40
        de91d144 de91d10c c0200183 df033ddc 0804b000 c01c0492 d96fee80
00101cca
Call Trace:
[<c0200633>] write_unix_file+0x2a1/0x45b
[<c0200183>] unix_file_filemap_nopage+0xaa/0xcf
[<c01c0492>] atom_should_commit+0x5a/0x60
[<c01bd241>] init_context+0x75/0xb4
[<c01d3f46>] reiser4_write+0x8f/0xfc
[<c0261e36>] copy_from_user+0x42/0x70
[<c01524b0>] do_readv_writev+0x170/0x29a
[<c01d3eb7>] reiser4_write+0x0/0xfc
[<c037515f>] sys_recv+0x37/0x3b
[<c015268e>] vfs_writev+0x58/0x5c
[<c0152763>] sys_writev+0x51/0x80
[<c010264d>] sysenter_past_esp+0x52/0x71
Code: 00 c3 b8 00 e0 ff ff 21 e0 8b 00 8b 80 d4 04 00 00 8b 54 24 04 8b 
40 44 8b 48 0c 85 c9 75 0c 89 d0 f0 ff 00 0f 88 b8 11 00 00 c3 <0f> 0b 
3a 00 e4 58 43 c0 eb ea 8b 44 24 04 ba ff ff ff ff f0 0f

To me this looked very similar to 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0411.3/0493.html so I 
applied Vladimir Saveliev's patch, recompiled and the patch seems to 
have done the trick.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
# 2004/11/23 14:07:34+03:00 vs@xxxxxxxxxxxxxxxxxxxxx
# read_unix_file: missing calls to txn_restart() are added
#
# plugin/file/file.c
# 2004/11/23 14:07:31+03:00 vs@xxxxxxxxxxxxxxxxxxxxx +4 -1
# read_unix_file: missing calls to txn_restart() are added
#
diff -Nru a/plugin/file/file.c b/plugin/file/file.c
--- a/plugin/file/file.c 2004-11-23 14:45:34 +03:00
+++ b/plugin/file/file.c 2004-11-23 14:45:34 +03:00
@@ -1741,6 +1741,8 @@
while (left > 0) {
size_t to_read;

+ txn_restart_current();
+
size = i_size_read(inode);
if (*off >= size)
/* position to read from is past the end of file */
@@ -1774,7 +1776,6 @@
if (user_space)
reiser4_put_user_pages(pages, nr_pages);
drop_nonexclusive_access(uf_info);
- txn_restart_current();

if (read < 0) {
result = read;
@@ -1974,6 +1975,8 @@

drop_nonexclusive_access(unix_file_inode_data(inode));
up_read(&reiser4_inode_data(inode)->coc_sem);
+
+ txn_restart_current();

reiser4_exit_context(&ctx);
return page;

Now if I give Abiword further abuse, memory fills, the disk thrashes but 
when the swap partition is about half full Abiword caves and the system 
recovers.
