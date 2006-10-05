Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWJEUAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJEUAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWJEUAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:00:01 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:6551 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751130AbWJEUAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:00:00 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [PATCH 7/11] 2.6.18-mm3 pktcdvd: make procfs interface optional
References: <op.tguqh5r2iudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Oct 2006 21:59:49 +0200
In-Reply-To: <op.tguqh5r2iudtyh@master>
Message-ID: <m3bqoqmt3e.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch makes the procfs interface optional and groups
> the procfs functions together.
> New kernel config parameter: CDROM_PKTCDVD_PROCINTF

Given the fact that Linus doesn't allow breaking user space tools
unless absolutely necessary, I don't think it makes sense to be able
to disable the character device control code.

The /proc/driver/pktcdvd/pktcdvd? file only contains debugging stuff
though, and the main reason it's not already in debugfs is that
debugfs didn't exist when Jens wrote this driver.

Therefore a patch that unconditionally moves
/proc/driver/pktcdvd/pktcdvd? to debugfs would make a lot of sense.

Also, the current change has another problem:

static int pkt_seq_show(struct seq_file *m, void *p)
+{
+       struct pktcdvd_device *pd = m->private;
+       char buf[1024];
+
+       pkt_print_info(pd, buf, sizeof(buf));
+       seq_printf(m, "%s", buf);
+       return 0;
+}

This wastes 1K stack space, and it can corrupt the stack if the
pkt_print_info() function wants to write more than 1K data.

Unconditionally moving to debugfs would remove the need for the
pkt_print_info() function so the buf array wouldn't be needed any
more.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
