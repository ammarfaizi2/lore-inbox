Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbUKTALJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbUKTALJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbUKTAIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:08:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36301 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261709AbUKTAED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:04:03 -0500
Subject: 2.6.10-rc2-mm2 crashes in early boot
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Haren Myneni [imap]" <haren@us.ibm.com>
Content-Type: text/plain
Message-Id: <1100909034.6236.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 19 Nov 2004 16:03:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I enabled crashdump on 2.6.10-rc2-mm2 with CONFIG_SMP=y and hit the bug
in smp_alloc_memory() because trampoline_base was allocated too high. 
It needs to be below 0x9F000 and crash_reserve_bootmem() reserves
everything below 0xa0000.  I'm not sure how this ever worked with SMP.  

Here's my .config: http://sprucegoose.sr71.net/~dave/lkcd-config

Commenting out the following line makes it boot:

static inline void crash_reserve_bootmem(void)
{
        if (!dump_enabled) {
------->        reserve_bootmem(0, CRASH_RELOCATE_SIZE);
                reserve_bootmem(CRASH_BACKUP_BASE,
                        CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE + PAGE_SIZE);
        }
}

The comments don't quite tell *why* LKCD needs any of the memory.  (Oh,
wait, there *aren't* any comments :)

-- Dave

