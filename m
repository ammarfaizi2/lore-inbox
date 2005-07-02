Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVGBXiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVGBXiq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 19:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGBXip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 19:38:45 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:63588 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261327AbVGBXiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 19:38:10 -0400
Message-ID: <42C72563.7040103@gentoo.org>
Date: Sun, 03 Jul 2005 00:38:11 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: =?UTF-8?B?RGF2aWQgR8OzbWV6?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy> <20050630193320.GA1136@fargo> <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk> <20050630204832.GA3854@fargo> <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk> <42C65A8B.9060705@gentoo.org> <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Anton Altaparmakov wrote:
> Thinking about it some more made me realize that there may be a problem in 
> inotify after all...  Could you try the below patch to fs/inotify.c and 
> tell me if it cures the lockup you are seeing?  (Note patch compiles but 
> is otherwise untested.  But given it locks up without the patch it can't 
> do much worse with it!)

Thanks for writing that patch, the effort is much appreciated. Unfortunately
it does not help :(

I've done a bit more investigating for you though. I did some tests purely on
the console, using inotify-test (from inotify-utils) which is the most
simplistic way you can use inotify: it just prints out the recieved events to
the screen.

I found out that unmount works perfectly well as long as there are no active
inotify watches (this might be quite obvious though!) - i.e. closing
inotify-test before unmounting results in a clean unmount. Unmounting while
inotify-test is watching the NTFS partition causes the freeze.

When the machine freezes, it still responds to ping, but not to ssh. Sysrq
works, so I got a sysrq-p trace:

Pid 8997 comm umount
EIP is at inotify_unmount_inodes+0x38/0x140

stack trace:
invalidate_inodes+0x40/0x90
generic_shutdown_super+0x59/0x140
kill_block_super+0x2d/0x50
deactivate_super+0x5a/0x90
sys_umount+0x3f/0x90
filp_close+0x52/0xa0
sys_oldumount+0x17/0x20
sysenter_past_esp+0x54/0x75

Investigating that function:

(gdb) list *inotify_unmount_inodes+0x38
0x9c8 is in inotify_unmount_inodes (inotify.c:565).
560      */
561     void inotify_unmount_inodes(struct list_head *list)
562     {
563             struct inode *inode, *next_i, *need_iput = NULL;
564
565             list_for_each_entry_safe(inode, next_i, list, i_sb_list) {
566                     struct inode *need_iput_tmp;
567                     struct inotify_watch *watch, *next_w;
568                     struct list_head *watches;
569

I then added a loop counter printk in at line 569 above. It shows that the
loop iterates 8 times on a clean unmount, and goes into a seemingly infinite
loop (i.e. freeze) when unmounting with inotify watches active.

I don't know much about filesystem internals so I'm pretty stuck here, haven't
reached that chapter of Robert's book yet ;)

Please let me know if theres any other info I can provide.

Thanks,
Daniel
