Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUDFRTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263910AbUDFRTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:19:38 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:44752 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261635AbUDFRTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:19:37 -0400
Subject: bugcheck! __get_free_pages calls __init function w/ CONFIG_NUMA
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081271975.2375.73.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Apr 2004 11:19:36 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I'm not sure why we haven't seen this before, but I started seeing a
stack trace on reboot on my rx2600 ia64 box running latest 2.6.  Here it
is:

 [<a0000001006ba020>] get_boot_pages+0x0/0x2c0
                                sp=e00000010267fc80 bsp=e000000102679130
 [<a0000001004a8fb0>] sba_alloc_coherent+0x70/0x1a0
                                sp=e00000010267fc80 bsp=e0000001026790f8
 [<a00000010047e3b0>] mptscsih_synchronize_cache+0x1d0/0x640
                                sp=e00000010267fc80 bsp=e000000102679010
 [<a0000001004665e0>] mptbase_shutdown+0xc0/0xe0
                                sp=e00000010267fd30 bsp=e000000102678fd8
 [<a0000001003a9140>] device_shutdown+0x260/0x280
                                sp=e00000010267fd30 bsp=e000000102678fa8
 [<a0000001000b10a0>] sys_reboot+0x2e0/0x720
                                sp=e00000010267fd30 bsp=e000000102678f50


sba_alloc_coherent is simply calling __get_free_pages() to setup a DMA
mapping for the mpt driver to sync a disk.  However, we've already
cleared system_running in sys_reboot, so w/ CONFIG_NUMA, we blowup
trying to call get_boot_pages, which was already freed.  I'm not sure if
the proper fix is to make get_boot_pages not an __init function or if
the CONFIG_NUMA code really intends to be keying off something else. 
Thoughts on the right fix?  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

