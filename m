Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270168AbRIAIy1>; Sat, 1 Sep 2001 04:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270174AbRIAIyI>; Sat, 1 Sep 2001 04:54:08 -0400
Received: from mail.altkom.com.pl ([195.94.220.102]:3601 "EHLO
	nmail.altkom.com.pl") by vger.kernel.org with ESMTP
	id <S270168AbRIAIx4>; Sat, 1 Sep 2001 04:53:56 -0400
Message-ID: <3B90A231.8030005@altkom.com.pl>
Date: Sat, 01 Sep 2001 10:54:09 +0200
From: Aleksander Adamowski <olo@altkom.com.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.3+) Gecko/20010831
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in ReiserFS
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think I got bitten by a bug in reiserfs.

Kernels tested:
2.4.7 with patch-int
2.4.9 with patch-int (you can get its config from here: 
http://office.altkom.com.pl/olo/domowa/249i)
plain 2.4.9
My distro: Mandrake 7.1

I can reproduce it on my machine using gftp 2.0.8. I suspect that when 
it tries to write to files (or create ones) in the ~/.gftp/cache, it 
triggers that bug. It clearly fails when trying to update its remote 
directory cache, which is stored there.
I suspect that, because every time I connect to ftp.mozilla.org with 
gftp I see the same outdated directory listing.
However, I were able to copy the ~/.gftp with cp -R in whole, so that's 
probably not a problem with reading but writing.
When I had tried to refresh the remote dir, gftp-gtk segfaulted (it 
probably tried to update the cache), kernel error occured and files on 
the whole /home filesystem were inaccessible. I could list dirs in 
/home, but any process that tried to open a file instantly freezed (even 
if run by root).

The segfault message:

/usr/bin/gftp: line 9:  1349 Segmentation fault      /usr/bin/gftp-gtk $@


When I tried to do an emergency sync using the Alt-SysRq-S combo, I got 
the following message:

Syncing device 03:06 ... OK
Syncing device 03:08 ...


ll /dev/hda8 shows this:

brw-rw----    1 root     disk       3,   8 May  5  1998 /dev/hda8


mount shows this for dev/hda8:

/dev/hda8 on /home type reiserfs (rw)


Here are two snippets from /var/log messages - what the kernel said when 
the error occured (including some lines of context):

Sep  1 10:00:20 karpaty PAM_pwdb[734]: (login) session closed for user olo
Sep  1 10:00:34 karpaty kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000008
Sep  1 10:00:34 karpaty kernel:  printing eip:
Sep  1 10:00:34 karpaty kernel: c01721ce
Sep  1 10:00:34 karpaty kernel: *pde = 00000000
Sep  1 10:00:34 karpaty kernel: Oops: 0000
Sep  1 10:00:34 karpaty kernel: CPU:    0
Sep  1 10:00:34 karpaty kernel: EIP: 
0010:[leaf_copy_boundary_item+786/1796]
Sep  1 10:00:34 karpaty kernel: EFLAGS: 00010246
Sep  1 10:00:34 karpaty kernel: eax: 00001000   ebx: 00000015   ecx: 
c14ad600   edx: 00000000
Sep  1 10:00:34 karpaty kernel: esi: 00003a70   edi: c149c018   ebp: 
c15d31f8   esp: c30cd7f8
Sep  1 10:00:34 karpaty kernel: ds: 0018   es: 0018   ss: 0018
Sep  1 10:00:34 karpaty kernel: Process gftp-gtk (pid: 990, 
stackpage=c30cd000)
Sep  1 10:00:34 karpaty kernel: Stack: c149c018 00001000 00000010 
00000015 ffffffff c14ad600 c30cdf18 c1195200
Sep  1 10:00:34 karpaty kernel:        c2aad140 c016c05a c30be07c 
00000015 c145ba20 c0172da9 c30cd8a4 c14ad600
Sep  1 10:00:34 karpaty kernel:        00000001 ffffffff c30cd8a4 
c30cd894 ffffffff 00000010 c0172ff0 c30cd8a4
Sep  1 10:00:34 karpaty kernel: Call Trace: [get_num_ver+330/864] 
[leaf_copy_items+153/244] [leaf_move_items+68/132] 
[leaf_shift_right+27/68] [balance_leaf+3666/9696]
Sep  1 10:00:34 karpaty kernel:    [schedule+614/916] 
[__wait_on_buffer+128/140] [bread+89/120] [clear_all_dirty_bits+17/24] 
[do_balance+142/256] [leaf_delete_items+91/344]
Sep  1 10:00:34 karpaty kernel:    [reiserfs_insert_item+158/240] 
[indirect2direct+474/572] [maybe_indirect_to_direct+497/508] 
[reiserfs_cut_from_item+208/1104] [reiserfs_do_truncate+780/1052] 
[reiserfs_truncate_file+170/372]
Sep  1 10:00:34 karpaty kernel:    [reiserfs_file_release+828/864] 
[fput+56/192] [filp_close+92/100] [sys_close+67/84] [system_call+51/64]
Sep  1 10:00:34 karpaty kernel:
Sep  1 10:00:34 karpaty kernel: Code: 8b 42 08 ff d0 83 c4 08 85 c0 75 
07 31 c0 e9 d4 03 00 00 66
Sep  1 10:00:46 karpaty chronyd[416]: Selected source 149.156.2.100
Sep  1 10:01:00 karpaty CROND[993]: (root) CMD ( 
/usr/share/msec/promisc_check.sh)

Another one:

Sep  1 10:06:01 karpaty CROND[781]: (root) CMD ( 
/usr/share/msec/promisc_check.sh)
Sep  1 10:06:29 karpaty kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000008
Sep  1 10:06:29 karpaty kernel:  printing eip:
Sep  1 10:06:29 karpaty kernel: c01721ce
Sep  1 10:06:29 karpaty kernel: *pde = 00000000
Sep  1 10:06:29 karpaty kernel: Oops: 0000
Sep  1 10:06:29 karpaty kernel: CPU:    0
Sep  1 10:06:29 karpaty kernel: EIP: 
0010:[leaf_copy_boundary_item+786/1796]
Sep  1 10:06:29 karpaty kernel: EFLAGS: 00010246
Sep  1 10:06:29 karpaty kernel: eax: 00001000   ebx: 00000017   ecx: 
c2d68f00   edx: 00000000
Sep  1 10:06:29 karpaty kernel: esi: 00003a70   edi: c0a18018   ebp: 
c0afe228   esp: c1ed57f8
Sep  1 10:06:29 karpaty kernel: ds: 0018   es: 0018   ss: 0018
Sep  1 10:06:29 karpaty kernel: Process gftp-gtk (pid: 768, 
stackpage=c1ed5000)
Sep  1 10:06:29 karpaty kernel: Stack: c0a18018 00001000 00000011 
00000017 ffffffff c2d68f00 00000240 c0175ad3
Sep  1 10:06:29 karpaty kernel:        c23c9000 c016c05a c2b38094 
00000017 c2555d20 c0172da9 c1ed58a4 c2d68f00
Sep  1 10:06:29 karpaty kernel:        00000001 ffffffff c1ed58a4 
c1ed5894 ffffffff 00000011 c0172ff0 c1ed58a4
Sep  1 10:06:29 karpaty kernel: Call Trace: [is_tree_node+67/88] 
[get_num_ver+330/864] [leaf_copy_items+153/244] [leaf_move_items+68/132] 
[leaf_shift_right+27/68]
Sep  1 10:06:29 karpaty kernel:    [balance_leaf+3666/9696] 
[schedule+614/916] [__wait_on_buffer+128/140] [bread+89/120] 
[clear_all_dirty_bits+17/24] [do_balance+142/256]
Sep  1 10:06:29 karpaty kernel:    [get_cnode+17/104] 
[reiserfs_insert_item+158/240] [indirect2direct+474/572] 
[maybe_indirect_to_direct+497/508] [reiserfs_cut_from_item+208/1104] 
[reiserfs_do_truncate+780/1052]
Sep  1 10:06:29 karpaty kernel:    [reiserfs_truncate_file+170/372] 
[reiserfs_file_release+828/864] [fput+56/192] [filp_close+92/100] 
[sys_close+67/84] [system_call+51/64]
Sep  1 10:06:29 karpaty kernel:
Sep  1 10:06:29 karpaty kernel: Code: 8b 42 08 ff d0 83 c4 08 85 c0 75 
07 31 c0 e9 d4 03 00 00 66
Sep  1 10:06:30 karpaty chronyd[415]: Selected source 153.19.253.204
Sep  1 10:07:00 karpaty CROND[792]: (root) CMD ( 
/usr/share/msec/promisc_check.sh)


I'm leaving on a vacation right now, and will be back on Sep 10, so if 
you want me to do further investigatons for you, contact me by e-mail then.

Best regards,
		Olo

