Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJIWQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTJIWP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:15:59 -0400
Received: from [62.38.237.143] ([62.38.237.143]:24198 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S261345AbTJIWP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:15:56 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: [aic7xxx]: Scheduling while atomic on rmmod - 2.6.0-test5,6
Date: Thu, 9 Oct 2003 20:37:54 +0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092037.54422.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I 've tried to give a 'dirty' solution to the lock at ahc_linux_exit. I 'm on 
a UP, so I thought it might not cause that much trouble. It seems, however 
that there are more locks that prevent aic7xxx from exiting. (see the trace 
below). 

...
	/*ahc_list_lock(&l);*/
	TAILQ_FOREACH(ahc, &ahc_tailq, links) {
		ahc_linux_kill_dv_thread(ahc);
	}
	/*ahc_list_unlock(&l);*/
...

Have you had any look into the matter? Do these traces mean that *nobody* will 
manage to remove the module?


Trace of the 'next' problem..
:  [schedule+1414/1424] schedule+0x586/0x590
:  [<c011bb86>] schedule+0x586/0x590
:  [default_wake_function+42/48] default_wake_function+0x2a/0x30
:  [<c011bc1a>] default_wake_function+0x2a/0x30
:  [wait_for_completion+143/224] wait_for_completion+0x8f/0xe0
:  [<c011bedf>] wait_for_completion+0x8f/0xe0
:  [default_wake_function+0/48] default_wake_function+0x0/0x30
:  [<c011bbf0>] default_wake_function+0x0/0x30
:  [default_wake_function+0/48] default_wake_function+0x0/0x30
:  [<c011bbf0>] default_wake_function+0x0/0x30
:  [queue_work+132/160] queue_work+0x84/0xa0
:  [<c012e764>] queue_work+0x84/0xa0
:  [call_usermodehelper+257/272] call_usermodehelper+0x101/0x110
:  [<c012e6d1>] call_usermodehelper+0x101/0x110
:  [__call_usermodehelper+0/112] __call_usermodehelper+0x0/0x70
:  [<c012e560>] __call_usermodehelper+0x0/0x70
:  [vsprintf+39/48] vsprintf+0x27/0x30
:  [<c01c28f7>] vsprintf+0x27/0x30
:  [sprintf+31/48] sprintf+0x1f/0x30
:  [<c01c291f>] sprintf+0x1f/0x30
:  [kset_hotplug+568/672] kset_hotplug+0x238/0x2a0
:  [<c01c0118>] kset_hotplug+0x238/0x2a0
:  [kobject_del+106/128] kobject_del+0x6a/0x80
:  [<c01c053a>] kobject_del+0x6a/0x80
:  [class_device_del+155/208] class_device_del+0x9b/0xd0
:  [<c021099b>] class_device_del+0x9b/0xd0
:  [class_device_unregister+19/48] class_device_unregister+0x13/0x30
:  [<c02109e3>] class_device_unregister+0x13/0x30
:  [scsi_remove_host+95/128] scsi_remove_host+0x5f/0x80
:  [<c02434df>] scsi_remove_host+0x5f/0x80                   <- is it here?

:  [_end+811983693/1069502604] ahc_platform_free+0x141/0x160 [aic7xxx]
:  [<f0a672c1>] ahc_platform_free+0x141/0x160 [aic7xxx]
:  [_end+811915595/1069502604] ahc_free+0xbf/0x130 [aic7xxx]
:  [<f0a568bf>] ahc_free+0xbf/0x130 [aic7xxx]
:  [_end+812013110/1069502604] ahc_linux_pci_dev_remove+0x6a/0xa0 [aic7xxx]
:  [<f0a6e5aa>] ahc_linux_pci_dev_remove+0x6a/0xa0 [aic7xxx]
:  [pci_device_remove+59/64] pci_device_remove+0x3b/0x40
:  [<c01ce31b>] pci_device_remove+0x3b/0x40
:  [device_release_driver+102/112] device_release_driver+0x66/0x70
:  [<c020fc86>] device_release_driver+0x66/0x70
:  [driver_detach+32/48] driver_detach+0x20/0x30
:  [<c020fcb0>] driver_detach+0x20/0x30
:  [bus_remove_driver+61/128] bus_remove_driver+0x3d/0x80
:  [<c020fedd>] bus_remove_driver+0x3d/0x80
:  [driver_unregister+19/40] driver_unregister+0x13/0x28
:  [<c0210303>] driver_unregister+0x13/0x28
:  [pci_unregister_driver+22/48] pci_unregister_driver+0x16/0x30
:  [<c01ce4f6>] pci_unregister_driver+0x16/0x30
:  [_end+812013659/1069502604] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
:  [<f0a6e7cf>] ahc_linux_pci_exit+0xf/0x20 [aic7xxx]
:  [_end+812017219/1069502604] ahc_linux_exit+0x27/0x54 [aic7xxx]
:  [<f0a6f5b7>] ahc_linux_exit+0x27/0x54 [aic7xxx]
:  [sys_delete_module+338/448] sys_delete_module+0x152/0x1c0
:  [<c01341e2>] sys_delete_module+0x152/0x1c0
:  [do_munmap+339/400] do_munmap+0x153/0x190
:  [<c014bc03>] do_munmap+0x153/0x190
:  [syscall_call+7/11] syscall_call+0x7/0xb
:  [<c010949b>] syscall_call+0x7/0xb

