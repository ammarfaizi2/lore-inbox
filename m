Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSICQrC>; Tue, 3 Sep 2002 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSICQrC>; Tue, 3 Sep 2002 12:47:02 -0400
Received: from www.southpole.se ([213.212.2.2]:3986 "EHLO www.southpole.se")
	by vger.kernel.org with ESMTP id <S317170AbSICQrB>;
	Tue, 3 Sep 2002 12:47:01 -0400
Date: Tue, 3 Sep 2002 18:51:33 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 --> 2.4.19. Ramdisk requires floppy?
Message-ID: <20020903165133.GA8726@southpole.se>
Mail-Followup-To: jakob@southpole.se, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: jakob@southpole.se (Jakob Sandgren)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed that the 2.4.19 version of "prepare_namespace"
(init/do_mounts.c) not allows you to mount a non floppy as a
ramdisk(?). This has changed since 2.4.18 (split of main.c ->
{do_mounts,main}.c).

2.4.18 does a very simple check (below):

--- 2.4.18 ---
#ifdef CONFIG_BLK_DEV_RAM
#ifdef CONFIG_BLK_DEV_INITRD
        if (mount_initrd)
                initrd_load();
        else
#endif
        rd_load();
#endif
--- 2.4.18 ---

however, in 2.4.19 it just tries to load a ramdisk if it's on a
floppy. Why? There may still be a ramdisk on an other device, NOT
using initrd. 

--- 2.4.19 ---
if (mount_initrd) {
       if (initrd_load() && ROOT_DEV != MKDEV(RAMDISK_MAJOR, 0)) {
              handle_initrd();
              goto out;
       }
} else if (is_floppy && rd_doload && rd_load_disk(0))
       ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
mount_root();
out:
--- 2.4.19 ---


Best Regards,
Jakob Sandgren
South Pole AB
-- 
Jakob Sandgren                  South Pole AB
Phone:  +46 8 51420420          Gelbjutarvägen 5
Fax:    +46 8 51420429          SE - 17148 Solna 
e-mail: jakob@southpole.se      www.southpole.se
