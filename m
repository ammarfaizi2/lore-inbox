Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVCCT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVCCT4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVCCTxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:53:22 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:24591 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261389AbVCCTtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:49:02 -0500
Date: Thu, 3 Mar 2005 20:49:34 +0100
From: Jean Delvare <khali@linux-fr.org>
To: James Chapman <jchapman@katalix.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-Id: <20050303204934.69620667.khali@linux-fr.org>
In-Reply-To: <422747FB.9020004@katalix.com>
References: <cIyC5ZN2.1109756623.5808030.khali@localhost>
	<422747FB.9020004@katalix.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> A revised ds1337 patch addressing all of Jean's comments is attached.

Fine with me except for:

> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK))

I don't this it is correct. You are using master_xfer, not
i2c_smbus_{read,write}_i2c_block_data. Adapter which declare themselves
I2C_FUNC_SMBUS_I2C_BLOCK-capable may not implement master_xfer. You
really need to check for I2C_FUNC_I2C.

Now I agree that the transfers you do ARE i2c block transfers, and I
find it highly questionable that our implementation of
i2c_smbus_read_i2c_block_data will always read 32 bytes of data from the
chip. It would be much more convenient to allow I2C block reads of
arbitrary length, (just like we do with I2C block writes) so that
clients can use this function instead of master_xfer.

It should be a quite simple fix if I correctly remember the i2c-core
code, with the only drawback that it alters the API. That being said,
the only kernel user (in kernel) of this function that I could find is
the eeprom driver (this can be easily explained by the fact that this
function, as it is now, is essentially useless), so I wouldn't mind the
risk. The net benefit would be that i2c chip drivers could start using
this function instead of master_xfer, so they would possibly work with
more than just the fully I2C-capable adapters (not that many of them,
see list right below).

i2c-dev might be a problem if we go that way, because we will silently
change the way I2C block reads requested from userspace are handled. Not
sure it is a big issue though, because as underlined before, the
function as it is now is rather useless. I doubt that anything but
i2cdump uses it in userspace.

Then we would need to fix bus drivers that implement the call by
themselves (as opposed to emulation), but in fact only a few of them do
(i2c-amd8111 and i2c-nforce2) so that should be quickly done.
[Reading the two bus drivers code...]

And it turns out that both bus drivers ALREADY honor the length
requested by the caller, which is not consistent with the emulated
variant of the call. Something definitely must be done.

Any thoughts anyone?

Thanks,
-- 
Jean Delvare
