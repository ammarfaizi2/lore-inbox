Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUKIKYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUKIKYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKIKYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:24:31 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:2824 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261463AbUKIKY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:24:26 -0500
Date: Tue, 9 Nov 2004 11:17:47 +0100 (CET)
To: greg@kroah.com, arjan@infradead.org, torvalds@osdl.org
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <zxUdaK3b.1099995467.6672570.khali@gcu.info>
In-Reply-To: <10999778553443@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>ChangeSet 1.2014.1.8, 2004/11/05 13:42:18-08:00, arjan@infradead.org
>
>[PATCH] I2C: remove dead code from i2c
>
>i2c-core.c has a few never used functions, patch below removes these dead
>functions.
>(...)
>@@ -1322,11 +1266,7 @@
> EXPORT_SYMBOL(i2c_smbus_write_byte_data);
> EXPORT_SYMBOL(i2c_smbus_read_word_data);
> EXPORT_SYMBOL(i2c_smbus_write_word_data);
>-EXPORT_SYMBOL(i2c_smbus_process_call);
>-EXPORT_SYMBOL(i2c_smbus_read_block_data);
>-EXPORT_SYMBOL(i2c_smbus_write_block_data);
> EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
>-EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
>
> EXPORT_SYMBOL(i2c_get_functionality);
> EXPORT_SYMBOL(i2c_check_functionality);

U-ho. At least i2c_smbus_read_block_data will have a user soon (the lm93
driver written by Mark M. Hoffman will certainly be ported to Linux 2.6
at some point). Also, removing these functions without dropping relevant
defines, updating the definition of I2C_FUNC_SMBUS_EMUL and removing the
extern declarations in linux/i2c.h is inconsistent and possibly
dangerous.

These functions are part of the SMBus specs. The fact that no client uses
them for now doesn't mean that they will never be used. In particular,
we see that newer chips such as the LM93, which have a high number of
registers, tend to use these as a way to lower the pressure of the
SMBus. It would come to no surprise if newer chips would make use of
block writes or process calls. Removing these functions at this point
doesn't sound like a clever move.

This kind of change to the i2c core should really have been discussed on
the lm_sensors mailing list before hitting the main kernel tree. This
one in particular wasn't as trivial at it seemed (left apart the
question of whether the functions should be removed at all).

Thanks,
Jean
