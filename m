Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUKOSVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUKOSVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUKOSVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:21:19 -0500
Received: from mail.aknet.ru ([217.67.122.194]:24076 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261659AbUKOSVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:21:12 -0500
Message-ID: <4198F3B9.7070604@aknet.ru>
Date: Mon, 15 Nov 2004 21:21:45 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
References: <41967669.3070707@aknet.ru> <20041113133832.101db8d9.akpm@osdl.org>
In-Reply-To: <20041113133832.101db8d9.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080808030109060900010208"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080808030109060900010208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Andrew Morton wrote:
> Here's a random hack for smbfs.  Does it help?
Unfortunately this (and the updated)
patch is very far from any help :(
I did some investigations myself.
At first I checked up the callers and
found that they do smb_rput() themselves
if smb_add_request() returns error. So
we have double-free. Then I found that
smb_rput() does list_del_init() itself,
so this is being done 3 times instead
of one. So all that piece of code you
were trying to correct, was actually
completely useless. I removed it (patch
attached). That made the smbfs to work
for me (for the first time in 2.6!), but
after about 5 minutes I've got the attached
Oops and Slab corruption again. A quick
glance to the code pointed by Oops, revealed
that there are plenty of use-after-rput
instances. Then I've found much more of
them all around the code.
I don't suppose this can ever work.
Now I am just scared to even load the smbfs
module.
I asked our admin to enable the NTLM auth
and mounted everything as cifs instead.
That works like a charm!
If there are any other patches to try -
I'll test them, but what is the current
official status of smbfs? Is it deprecated?
Or broken? Or undergoing some redesign?
Very strange...


--------------080808030109060900010208
Content-Type: text/plain;
 name="slbug1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slbug1"

Nov 15 15:23:31 stas kernel: Unable to handle kernel paging request at virtual address 6b6b6b6b
Nov 15 15:23:31 stas kernel:  printing eip:
Nov 15 15:23:31 stas kernel: c011d4d7
Nov 15 15:23:31 stas kernel: *pde = 00000000
Nov 15 15:23:31 stas kernel: Oops: 0000 [#1]
Nov 15 15:23:31 stas kernel: PREEMPT SMP 
Nov 15 15:23:31 stas kernel: Modules linked in: snd_mixer_oss snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore intel_agp agpgart md5 ipv6 smbfs 3c59x mii sd_mod ntfs nls_cp866 usb_storage scsi_mod uhci_hcd usbcore video thinkpad_acpi
Nov 15 15:23:31 stas kernel: CPU:    0
Nov 15 15:23:31 stas kernel: EIP:    0060:[<c011d4d7>]    Not tainted VLI
Nov 15 15:23:31 stas kernel: EFLAGS: 00010897   (2.6.10-rc1-mm5) 
Nov 15 15:23:31 stas kernel: EIP is at __wake_up_common+0x17/0x70
Nov 15 15:23:31 stas kernel: eax: d1007efc   ebx: d1007ef0   ecx: 00000001   edx: 6b6b6b6b
Nov 15 15:23:31 stas kernel: esi: 00000000   edi: 00000001   ebp: de9caf44   esp: de9caf28
Nov 15 15:23:31 stas kernel: ds: 007b   es: 007b   ss: 0068
Nov 15 15:23:31 stas kernel: Process smbiod (pid: 2567, threadinfo=de9ca000 task=deab5550)
Nov 15 15:23:31 stas kernel: Stack: c014c65f 00000000 00000001 00000001 d1007ef0 00000000 00000001 de9caf68 
Nov 15 15:23:31 stas kernel:        c011d568 00000000 00000000 00000286 00000001 deabcd74 d1007ee4 00000000 
Nov 15 15:23:31 stas kernel:        de9caf80 e0920d35 00000000 00000000 deabcd74 00000007 de9caf94 e091fc97 
Nov 15 15:23:31 stas kernel: Call Trace:
Nov 15 15:23:31 stas kernel:  [<c010600a>] show_stack+0x7a/0x90
Nov 15 15:23:31 stas kernel:  [<c0106196>] show_registers+0x156/0x1c0
Nov 15 15:23:31 stas kernel:  [<c01063a4>] die+0xf4/0x180
Nov 15 15:23:31 stas kernel:  [<c0119c9a>] do_page_fault+0x36a/0x69f
Nov 15 15:23:31 stas kernel:  [<c0105c8f>] error_code+0x2b/0x30
Nov 15 15:23:31 stas kernel:  [<c011d568>] __wake_up+0x38/0x50
Nov 15 15:23:31 stas kernel:  [<e0920d35>] smb_request_recv+0x115/0x1ed [smbfs]
Nov 15 15:23:31 stas kernel:  [<e091fc97>] smbiod_doio+0x27/0xa0 [smbfs]
Nov 15 15:23:31 stas kernel:  [<e091fe4b>] smbiod+0x13b/0x178 [smbfs]
Nov 15 15:23:31 stas kernel:  [<c01032e5>] kernel_thread_helper+0x5/0x10
Nov 15 15:23:31 stas kernel: Code: c0 eb d2 90 55 89 e5 8b 40 04 5d e9 84 e3 ff ff 8d 74 26 00 55 89 e5 57 56 53 83 ec 10 89 55 f0 89 4d ec 8b 50 0c 83 c0 0c 39 c2 <8b> 3a 89 45 e8 74 3b 89 f6 8b 45 0c 8d 5a f4 8b 72 f4 8b 4d 08 
Nov 15 15:23:31 stas kernel:  <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Nov 15 15:23:31 stas kernel: in_atomic():1, irqs_disabled():0
Nov 15 15:23:31 stas kernel:  [<c0106037>] dump_stack+0x17/0x20
Nov 15 15:23:31 stas kernel:  [<c011f102>] __might_sleep+0xa2/0xb0
Nov 15 15:23:31 stas kernel:  [<c0122c73>] profile_task_exit+0x23/0x60
Nov 15 15:23:31 stas kernel:  [<c0124d3c>] do_exit+0x1c/0x580
Nov 15 15:23:32 stas kernel:  [<c0106428>] die+0x178/0x180
Nov 15 15:23:32 stas kernel:  [<c0119c9a>] do_page_fault+0x36a/0x69f
Nov 15 15:23:32 stas kernel:  [<c0105c8f>] error_code+0x2b/0x30
Nov 15 15:23:32 stas kernel:  [<c011d568>] __wake_up+0x38/0x50
Nov 15 15:23:32 stas kernel:  [<e0920d35>] smb_request_recv+0x115/0x1ed [smbfs]
Nov 15 15:23:32 stas kernel:  [<e091fc97>] smbiod_doio+0x27/0xa0 [smbfs]
Nov 15 15:23:32 stas kernel:  [<e091fe4b>] smbiod+0x13b/0x178 [smbfs]
Nov 15 15:23:32 stas kernel:  [<c01032e5>] kernel_thread_helper+0x5/0x10
Nov 15 15:23:32 stas kernel: note: smbiod[2567] exited with preempt_count 1
Nov 15 15:23:38 stas kernel: Slab corruption: start=d1007ee4, len=256
Nov 15 15:23:38 stas kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Nov 15 15:23:38 stas kernel: Last user: [<e0920d1c>](smb_request_recv+0xfc/0x1ed [smbfs])
Nov 15 15:23:38 stas kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 00 6b 6b 6b
Nov 15 15:23:38 stas kernel: Prev obj: start=d1007dd8, len=256
Nov 15 15:23:38 stas kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Nov 15 15:23:38 stas kernel: Last user: [<00000000>](0x0)
Nov 15 15:23:38 stas kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Nov 15 15:23:38 stas kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

--------------080808030109060900010208
Content-Type: text/x-patch;
 name="smb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smb.diff"

--- linux-2.6.10-rc1-mm5/fs/smbfs/request.c	2004-11-05 17:47:35.000000000 +0300
+++ linux-2.6.10-rc1-mm5/fs/smbfs/request.c	2004-11-15 15:09:44.000000000 +0300
@@ -335,18 +335,6 @@
 
 	timeleft = wait_event_interruptible_timeout(req->rq_wait,
 				    req->rq_flags & SMB_REQ_RECEIVED, 30*HZ);
-	if (!timeleft || signal_pending(current)) {
-		/*
-		 * On timeout or on interrupt we want to try and remove the
-		 * request from the recvq/xmitq.
-		 */
-		smb_lock_server(server);
-		if (!(req->rq_flags & SMB_REQ_RECEIVED)) {
-			list_del_init(&req->rq_queue);
-			smb_rput(req);
-		}
-		smb_unlock_server(server);
-	}
 
 	if (!timeleft) {
 		PARANOIA("request [%p, mid=%d] timed out!\n",

--------------080808030109060900010208--
