Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVCCVgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVCCVgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVCCVdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:33:01 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:6669 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262527AbVCCVb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:31:57 -0500
Date: Thu, 3 Mar 2005 22:32:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: James Chapman <jchapman@katalix.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90
 driver
Message-Id: <20050303223230.15e91bb3.khali@linux-fr.org>
In-Reply-To: <42274958.4050400@katalix.com>
References: <4223513F.4030403@katalix.com>
	<20050302165532.GB2311@kroah.com>
	<20050302203721.7cce650d.khali@linux-fr.org>
	<42274958.4050400@katalix.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> A revised adt7461 patch addressing all of Jean's comments is
> attached.
> 
> This driver will detect the adt7461 chip only if boot firmware
> has left the chip in its default lm90-compatible mode.

I'm fine with the idea but not quite with your implementation:

> @@ -221,6 +229,8 @@
>  	struct i2c_client *client = to_i2c_client(dev); \
>  	struct lm90_data *data = i2c_get_clientdata(client); \
>  	long val = simple_strtol(buf, NULL, 10); \
> +	if ((data->kind == adt7461) && ((val < 0) || (val > 127000))) \
> +		return -EINVAL; \
>  	data->value = TEMP1_TO_REG(val); \
>  	i2c_smbus_write_byte_data(client, reg, data->value); \
>  	return count; \
> @@ -232,6 +242,8 @@
>  	struct i2c_client *client = to_i2c_client(dev); \
>  	struct lm90_data *data = i2c_get_clientdata(client); \
>  	long val = simple_strtol(buf, NULL, 10); \
> +	if ((data->kind == adt7461) && ((val < 0) || (val > 127000))) \
> +		return -EINVAL; \
>  	data->value = TEMP2_TO_REG(val); \
>  	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
>  	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \

This is inconsistent with the rest of the interface. For continuous
values, we do not return errors on out-of-range writes. Instead, we
force the value to whatever range boundary makes sense. See TEMP1_TO_REG
and TEMP2_TO_REG. So I would suggest that you implement
TEMP1_TO_REG_ADT7461 and TEMP2_TO_REG_ADT7461 the same way with
different boundaries, and call them.

> +			if (address == 0x4c
> +			 && chip_id == 0x51 /* ADT7461 */
> +			 && (reg_config1 & 0x3F) == 0x00

That could be broaden to "& 0x1F" is I am not mistaken. We don't really
care about bit 5, do we? And maybe put a comment explaining that we
check for compatibility at this point (similar checks for the other
chips are only for unused bits, not for specific configuration).

Thanks,
-- 
Jean Delvare
