Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVDLLmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVDLLmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVDLLjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:39:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:12254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262340AbVDLLiq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:38:46 -0400
Date: Tue, 12 Apr 2005 04:37:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: firewire and/or sbp2 problem with rc2-mm3, but not rc2-mm2
Message-Id: <20050412043736.7fec243e.akpm@osdl.org>
In-Reply-To: <20050412111859.GA29765@gamma.logic.tuwien.ac.at>
References: <20050412111859.GA29765@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> Hi Andrew! Hi 1394 developers!
> 
> I have a bit of a problem with firewire. WIth 2.6.12-rc2-mm3 it does not
> recognize my external hard disk any more:
> 
> I use an external hard disk via firewire, and when I plug it in I get:
> vmunix: sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
> vmunix: Device not ready. Make sure there is a disc in the drive.
> 
> With -mm2 it was working, also with older kernels.

There are no 1394 changes in 2.6.12-rc2-mm3.

> Now, there is also a problem with removing modules:
> 
> I remove sbp2, works.
> 
> Then I try to remove ohci1394 and it stucks:

It's not very obvious who called wait_for_completion() here.  Possibly
driver_unregister(), but it's way up the stack.  You might get a better
trace if you enable CONFIG_FRAME_POINTER.

Still.  I assume this is some interaction between 1394 and Pat's new device
management work.


> vmunix: rmmod         D C036EBC0     0  5310 5175                     (NOTLB)
> vmunix: cec79de8 00200246 cec79dd0 c036ebc0 cec79e18 d9c40500 dec808ec df7923bc 
> vmunix:        00000941 f7ae5f13 0000004d cf8dea90 cf8debb8 defc4058 cec78000 cec78000 
> vmunix:        cec79e3c c0305e08 00000000 cf8dea90 c0117bb0 00000000 00000000 defc4150 
> vmunix: Call Trace:
> vmunix:  [<c0305e08>] wait_for_completion+0x78/0xf0
> vmunix:  [<c0117bb0>] default_wake_function+0x0/0x10
> vmunix:  [<c0227c64>] class_dev_release+0x64/0x70
> vmunix:  [<c0117bb0>] default_wake_function+0x0/0x10
> vmunix:  [<c01c64db>] kobject_cleanup+0x8b/0xa0
> vmunix:  [<e096b400>] __nodemgr_remove_host_dev+0x0/0x10 [ieee1394]
> vmunix:  [<c02260cb>] device_del+0x1b/0x80
> vmunix:  [<c0226138>] device_unregister+0x8/0x10
> vmunix:  [<e096b3e0>] nodemgr_remove_ne+0x70/0x90 [ieee1394]
> vmunix:  [<e096b408>] __nodemgr_remove_host_dev+0x8/0x10 [ieee1394]
> vmunix:  [<c0226193>] device_for_each_child+0x33/0x50
> vmunix:  [<e096b422>] nodemgr_remove_host_dev+0x12/0x40 [ieee1394]
> kernel:  [exit_notify+766/2080] exit_notify+0x2fe/0x820
> vmunix:  [<e0968187>] __unregister_host+0xc7/0xd0 [ieee1394]
> vmunix:  [<c012f080>] autoremove_wake_function+0x0/0x50
> vmunix:  [<e0968bfb>] highlevel_remove_host+0x3b/0x70 [ieee1394]
> vmunix:  [<e0967b68>] hpsb_remove_host+0x38/0x60 [ieee1394]
> vmunix:  [<e095c3a0>] ohci1394_pci_remove+0x60/0x230 [ohci1394]
> vmunix:  [<c018c2a5>] sysfs_hash_and_remove+0xd5/0x105
> vmunix:  [<c01cf288>] pci_device_remove+0x28/0x30
> vmunix:  [<c022752f>] device_release_driver+0x7f/0x90
> vmunix:  [<c0227545>] __remove_driver+0x5/0x10
> vmunix:  [<c0227635>] driver_for_each_device+0x45/0x60
> vmunix:  [<c0227563>] driver_detach+0x13/0x15
> vmunix:  [<c0227540>] __remove_driver+0x0/0x10
> vmunix:  [<c0226fd6>] bus_remove_driver+0x26/0x40
> vmunix:  [<c022774b>] driver_unregister+0xb/0x20
> vmunix:  [<c01cf48b>] pci_unregister_driver+0xb/0x20
> vmunix:  [<e095c830>] ohci1394_cleanup+0x0/0xa [ohci1394]
> vmunix:  [<c0133a3d>] sys_delete_module+0x12d/0x160
> vmunix:  [<c014c29a>] unmap_vma_list+0x1a/0x30
> vmunix:  [<c014c60a>] do_munmap+0xfa/0x130
> vmunix:  [<c014c680>] sys_munmap+0x40/0x70
> vmunix:  [<c0103095>] syscall_call+0x7/0xb
> kernel:  [do_futex+53/144] do_futex+0x35/0x90
> 
> 
> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
> sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> TINGRITH (n.)
> The feeling of silver paper against your fillings.
> 			--- Douglas Adams, The Meaning of Liff
