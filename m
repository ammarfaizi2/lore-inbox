Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136743AbREAWkh>; Tue, 1 May 2001 18:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136744AbREAWk1>; Tue, 1 May 2001 18:40:27 -0400
Received: from [206.58.79.242] ([206.58.79.242]:21508 "EHLO daffy.thegoop.com")
	by vger.kernel.org with ESMTP id <S136743AbREAWkP>;
	Tue, 1 May 2001 18:40:15 -0400
Date: Tue, 1 May 2001 15:39:41 -0700
From: David Bronaugh <dbronaugh@opensourcedot.com>
To: linux-kernel@vger.kernel.org
Subject: Breakage of opl3sax cards since 2.4.3 (at least)
Message-ID: <20010501153941.E498@Woodbox.gv.shawcable.net>
Reply-To: dbronaugh@opensourcedot.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, cutting to chase:

opl3sax cards have refused to init in Linux with the in-kernel OSS driver
since 2.4.3 at least (last I tested and worked was 2.4.1). I'm pretty sure
this is a kernel issue as it's happened on 2 different machines, one of
which I never goofed around with.

Usually message is something like:

opl3sa2: Control I/O port 0x220 (or whatever is tried) is not a YMF7xx
chipset!

I'm not sure why this occurs, but here is the code block where the error
probably occurs:

	/* SNIP */
        opl3sa2_read(hw_config->io_base, OPL3SA2_MISC, &misc);
        opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc ^ 0x07);
        opl3sa2_read(hw_config->io_base, OPL3SA2_MISC, &tmp);
        if(tmp != misc) {
                printk(KERN_ERR "opl3sa2: Control I/O port %#x is not a
YMF7xx chipset!\n",
                       hw_config->io_base);
                return 0;
        }

        /*
         * Check if the MIC register is accessible.
         */
        opl3sa2_read(hw_config->io_base, OPL3SA2_MIC, &tmp);
        opl3sa2_write(hw_config->io_base, OPL3SA2_MIC, 0x8a);
        opl3sa2_read(hw_config->io_base, OPL3SA2_MIC, &tmp);
        if((tmp & 0x9f) != 0x8a) {
                printk(KERN_ERR
                       "opl3sa2: Control I/O port %#x is not a YMF7xx
chipset!\n",
                       hw_config->io_base);
                return 0;
        }
	/* SNIP */

Maybe this is a dumb check because there's an anomaly with the OPL3SAx
chip. I don't know.

I'm not on the list, so please forward any mail sent about this to me.

David Bronaugh

