Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUJQHgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUJQHgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 03:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUJQHgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 03:36:22 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:21736 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S269076AbUJQHgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 03:36:16 -0400
Date: Sun, 17 Oct 2004 09:36:14 +0200
To: linux-kernel@vger.kernel.org, luc@saillard.org,
       Andrew Morton <akpm@osdl.org>
Subject: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while atomic
Message-ID: <20041017073614.GC7395@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc, hi Andrew, hi list!

I tried to get the unofficial pwc modules from
http://www.saillard.org:8080/pwc/ to work with 2.6.9-rc4-mm1. After
fixing the following two things:
--- pwc-if.c.orig       2004-09-27 01:31:42.000000000 +0200
+++ pwc-if.c    2004-10-17 09:28:26.000000000 +0200
@@ -932,7 +932,7 @@
                if (urb != 0) {
                        if (pdev->iso_init) {
                                Trace(TRACE_MEMORY, "Unlinking URB %p\n", urb);
-                               usb_unlink_urb(urb);
+                               usb_kill_urb(urb);
                        }
                        Trace(TRACE_MEMORY, "Freeing URB\n");
                        usb_free_urb(urb);
@@ -1618,7 +1618,7 @@
        pos = (unsigned long)pdev->image_data;
        while (size > 0) {
                page = kvirt_to_pa(pos);
-               if (remap_page_range(vma, start, page, PAGE_SIZE,
                PAGE_SHARED))
+               if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                        return -EAGAIN;
 
                start += PAGE_SIZE;

the module compiled and loaded without problem, but when starting
gnomemeeting I get the following kernel BUG and scheduling while atomic:

pwc Philips webcam module version 9.0.2-unofficial loaded.
pwc Supports Philips PCA645/646, PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
pwc Also supports the Askey VC010, various Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
pwc the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
pwc Philips PCVC680K (Vesta Pro) USB webcam detected.
pwc Registered as /dev/video0.
usbcore: registered new driver Philips webcam
pwc type = 680
pwc type = 680
pwc set_video_mode(176x144 @ 10, palette 15).
pwc decode_size = 2.
pwc type = 680
pwc type = 680
pwc set_video_mode(176x144 @ 10, palette 15).
pwc decode_size = 2.
pwc type = 680
pwc type = 680
pwc set_video_mode(176x144 @ 10, palette 15).
pwc decode_size = 2.
pwc type = 680
pwc type = 680
pwc set_video_mode(176x144 @ 10, palette 15).
pwc decode_size = 2.
pwc type = 680
pwc type = 680
pwc set_video_mode(176x144 @ 10, palette 15).
pwc decode_size = 2.
------------[ cut here ]------------
kernel BUG at mm/rmap.c:468!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: pwc snd_usb_audio snd_usb_lib nvidia snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore via686a adm1021 i2c_sensor i2c_isa i2c_viapro i2c_core parport_pc lp parport
CPU:    0
EIP:    0060:[<c0145897>]    Tainted: P      VLI
EFLAGS: 00210286   (2.6.9-rc4-mm1) 
EIP is at page_remove_rmap+0x27/0x40
eax: ffffffff   ebx: 00001000   ecx: b4588000   edx: c12a0000
esi: df902624   edi: c12a0000   ebp: 00008000   esp: de18beb4
ds: 007b   es: 007b   ss: 0068
Process gnomemeeting (pid: 11671, threadinfo=de18a000 task=e40bc0c0)
Stack: c013f588 cc027080 00000000 e40bc0c0 c0116090 15000027 b4588000 c041d558 
       b4988000 cc027b48 b4590000 c041d558 c013f6cf 00008000 00000000 00000065 
       3b9a9e6f b4588000 cc027b48 b4590000 c041d558 c013f72d 00008000 00000000 
Call Trace:
 [<c013f588>] zap_pte_range+0x128/0x230
 [<c0116090>] default_wake_function+0x0/0x10
 [<c013f6cf>] zap_pmd_range+0x3f/0x60
 [<c013f72d>] unmap_page_range+0x3d/0x70
 [<c013f84e>] unmap_vmas+0xee/0x200
 [<c0143652>] unmap_region+0x72/0xe0
 [<c01438fd>] do_munmap+0xfd/0x150
 [<c0143990>] sys_munmap+0x40/0x70
 [<c0103fc9>] sysenter_past_esp+0x52/0x71
Code: 00 00 00 00 89 c2 8b 00 f6 c4 08 75 28 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0d 9c 58 fa ff 0d 30 1c 43 c0 50 9d 90 c3 <0f> 0b d4 01 21 f9 31 c0 eb e9 0f 0b d1 01 21 f9 31 c0 eb ce 90 
 <6>note: gnomemeeting[11671] exited with preempt_count 1
scheduling while atomic: gnomemeeting/0x00000001/11671
 [<c03076dd>] schedule+0x4dd/0x4f0
 [<c03080cd>] rwsem_down_read_failed+0x8d/0x190
 [<c012c78b>] .text.lock.futex+0x7/0xbc
 [<c012c64e>] do_futex+0x4e/0x80
 [<c012c760>] sys_futex+0xe0/0xf0
 [<c0119854>] release_console_sem+0xd4/0xe0
 [<c0117388>] mm_release+0x98/0xb0
 [<c011b2ca>] do_exit+0x7a/0x3f0
 [<c01051c0>] do_divide_error+0x0/0x120
 [<c0105520>] do_invalid_op+0x0/0xf0
 [<c0128c61>] search_exception_tables+0x21/0x30
 [<c0105520>] do_invalid_op+0x0/0xf0
 [<c010560b>] do_invalid_op+0xeb/0xf0
 [<c0145897>] page_remove_rmap+0x27/0x40
 [<f0e361a8>] pwc_decompress+0x228/0x2b0 [pwc]
 [<c0307499>] schedule+0x299/0x4f0
 [<c0104a49>] error_code+0x2d/0x38
 [<c0145897>] page_remove_rmap+0x27/0x40
 [<c013f588>] zap_pte_range+0x128/0x230
 [<c0116090>] default_wake_function+0x0/0x10
 [<c013f6cf>] zap_pmd_range+0x3f/0x60
 [<c013f72d>] unmap_page_range+0x3d/0x70
 [<c013f84e>] unmap_vmas+0xee/0x200
 [<c0143652>] unmap_region+0x72/0xe0
 [<c01438fd>] do_munmap+0xfd/0x150
 [<c0143990>] sys_munmap+0x40/0x70
 [<c0103fc9>] sysenter_past_esp+0x52/0x71

Thanks a lot for any information to fix this!

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SLUBBERY (n.)
The gooey drips of wax that dribble down the sides of a candle so
beloved by Italian restaurants with Chianti bottles instead of
wallpaper.
			--- Douglas Adams, The Meaning of Liff
