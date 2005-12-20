Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVLTKFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVLTKFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 05:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVLTKFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 05:05:39 -0500
Received: from [195.144.244.147] ([195.144.244.147]:52898 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1750907AbVLTKFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 05:05:38 -0500
Message-ID: <43A7D76E.5050008@varma-el.com>
Date: Tue, 20 Dec 2005 13:05:34 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jean Delvare <khali@linux-fr.org>, adi@hexapodia.org,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] i2c: Combined ST m41txx i2c rtc chip driver
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com>
In-Reply-To: <20051219210325.GA21696@mag.az.mvista.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark

Big Thanks, I check it on my board today-tomorrow.
But check some comments below.

Mark A. Greer wrote:
> On Tue, Nov 15, 2005 at 07:57:14PM -0700, Mark A. Greer wrote:
> 
>>I think we can combine the two into an m41txx.c and pass the exact type
>>in via platform_data--that would be the correct mechanism, right?
>>The platform_data could also be used to seed the correct SQW freq and
>>eliminate all the Kconfig noise.
>>
>>Comments?
>>
>>As for Jean's and Andrew's comments about the driver, they seem valid
>>to me and should be addressed.  In Andrey's defense, many of them are my
>>fault.  Once there is a consensus on the merging m41t00 & m41t85
>>question, I'll try to get a fixed up patch within a couple weeks.
> 
> 
> I've made what I think should be close to an acceptable driver that
> supports the m41t00, m41t81, and m41t85 i2c rtc chips.  I only have hw
> to test the m41t00 on a ppc platform, though.
> 
> It was suggested to me a while back to add retries when reading &
> writing the rtc regs.  Personally, I think its overkill but I added the
> code anyway.  You will see in m41txx_get_rtc_time() that 3 tries are
> made to get a good read of all the regs then up to 10 tries are made to
> make sure that the time didn't change while we were doing the reads.
> Something similar is done in m41txx_set().
> 
> Andrey, would you please apply and test this patch on your 5200?
> 
> Andy, I apologize but I didn't take the time to look at the mips tree in
> depth.  I did do a quick scan and I think that you should be able to set
> 'rtc_get_time' to 'm41txx_get_rtc_time' and 'rtc_set_time' to
> 'm41txx_set_rtc_time', and it'll work.  You'll have to hook up the proper
> driver for your host i2c ctlr, though.
> 
> Jean, Andrew, I think I addressed your coding style, etc. issues with
> the driver.  If not, just point out the problems an I'll fix them.
> 
> The patch is against the 2.6.15-rc5-mm3 tree.  Comments welcome.
> 
> [I will send a second patch that contains the changes I made to the ppc
> katana platform that has the m41t00 that I tested with.]
> 
> Thanks,
> 
> Mark

> +	down(&m41txx_mutex);
> +	do {
> +		retries = M41TXX_MAX_RETRIES;
> +
> +		do {
> +			if (((sec = i2c_smbus_read_byte_data(save_client,
> +						m41txx_chip->sec)) >= 0)
> +				&& ((min = i2c_smbus_read_byte_data(save_client,
> +						m41txx_chip->min)) >= 0)
> +				&& ((hour= i2c_smbus_read_byte_data(save_client,
> +						m41txx_chip->hour)) >= 0)
> +				&& ((day = i2c_smbus_read_byte_data(save_client,
> +						m41txx_chip->day)) >= 0)
> +				&& ((mon = i2c_smbus_read_byte_data(save_client,
> +						m41txx_chip->mon)) >= 0)
> +				&& ((year= i2c_smbus_read_byte_data(save_client,
> +						m41txx_chip->year)) >= 0))
> +				break;
> +		} while (--retries > 0);
> +
> +		if ((retries == 0) || ((sec == sec1) && (min == min1)
> +				&& (hour == hour1) && (day == day1)
> +				&& (mon == mon1) && (year == year1)))
> +			break;

I think this code is overburdened (I forgot to point on it last time,
sorry) and may be wrong for m41t8x, since when you send i2c stop
condition (in read_byte_data), you release time registers of m41t8x,
and as a consequence, in the worst case, you must compare/read it an
undetermined number of times, but not 3 times (however, for m41t00 this
code is correct).

I think i2c_master_recv here and i2c_master_send above in m41txx_set
will be more appropriate, since for m41t00 it will have no meaning when
you send STOP (250ms stall), but for m41t8x you could drop this
while-loop completely.

Hint: quotation from m41st85w.pdf p13/34
"The system-to-user transfer of clock data will be
halted whenever the address being read is a clock
address (00h to 07h). The update will resume either
due to a Stop Condition or when the pointer
increments to a non-clock or RAM address."

Also, please, change _obsoleted_ BCD_TO_BIN to BCD2BIN
(see include/linux/bcd.h)


-- 
Regards
Andrey Volkov
