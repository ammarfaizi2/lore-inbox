Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUD2TvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUD2TvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264945AbUD2TvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:51:06 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:20657 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264944AbUD2Tuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:50:55 -0400
Subject: RE: [patch 1/3] efivars driver update and move
From: Alex Williamson <alex.williamson@hp.com>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: akpm@osdl.org, linux-ia64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Matt_Domsch@dell.com
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEAB3@fmsmsx406.fm.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEAB3@fmsmsx406.fm.intel.com>
Content-Type: text/plain
Message-Id: <1083268253.8416.100.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 13:50:54 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Good work on the sysfs port, I like it too.  I ran into a little
problem trying it with the newest efibootmgr (test3) on an HP rx2600. 
I'm not sure what the problem is, so this is a bug report/query. 
Efibootmgr complains "show_boot_order(): No such file or directory". 
However, it looks ok:

# find /sys/firmware/efi/vars/ -name BootOrder*
/sys/firmware/efi/vars/BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c 

Looking at the directory a little more closely

# stat BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /
  File: `BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c /'
...

What's the purpose of the ' ' at the end of the directory name?  The
comment in the code suggests it might have a purpose:

        /* This is ugly, but necessary to separate one vendor's
           private variables from another's.         */

        *(short_name + strlen(short_name)) = '-';
        efi_guid_unparse(vendor_guid, short_name + strlen(short_name));
        *(short_name + strlen(short_name)) = ' ';

But the same comment was in the /proc efivar code, without the
additional space tagged onto the end.  All of the EFI variables end with
a space, so there's nothing special about this one.  Is the space
intentional?  The data in the variable looks good otherwise:

# xxd BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /data 
0000000: 0100 0000 0200 0500 0600 0300            ............

# xxd BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /guid 
0000000: 3862 6534 6466 3631 2d39 3363 612d 3131  8be4df61-93ca-11
0000010: 6432 2d61 6130 642d 3030 6530 3938 3033  d2-aa0d-00e09803
0000020: 3262 3863 0a                             2b8c.

# xxd BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /attributes 
0000000: 4546 495f 5641 5249 4142 4c45 5f4e 4f4e  EFI_VARIABLE_NON
0000010: 5f56 4f4c 4154 494c 450a 4546 495f 5641  _VOLATILE.EFI_VA
0000020: 5249 4142 4c45 5f42 4f4f 5453 4552 5649  RIABLE_BOOTSERVI
0000030: 4345 5f41 4343 4553 530a 4546 495f 5641  CE_ACCESS.EFI_VA
0000040: 5249 4142 4c45 5f52 554e 5449 4d45 5f41  RIABLE_RUNTIME_A
0000050: 4343 4553 530a                           CCESS.

# xxd BootOrder-8be4df61-93ca-11d2-aa0d-00e098032b8c\ /size       
0000000: 3078 630a                                0xc.

Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

