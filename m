Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWAKTDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWAKTDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWAKTDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:03:31 -0500
Received: from [195.144.244.147] ([195.144.244.147]:58005 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S932638AbWAKTDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:03:30 -0500
Message-ID: <43C5567C.8070106@varma-el.com>
Date: Wed, 11 Jan 2006 22:03:24 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>, Jean Delvare <khali@linux-fr.org>
Cc: adi@hexapodia.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] i2c: Combined ST m41txx i2c rtc chip driver
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <20051116025714.GK5546@mag.az.mvista.com> <20051219210325.GA21696@mag.az.mvista.com> <43A7D76E.5050008@varma-el.com> <20060111000912.GA11471@mag.az.mvista.com> <43C4D275.2070505@varma-el.com> <20060111161954.GB6405@mag.az.mvista.com>
In-Reply-To: <20060111161954.GB6405@mag.az.mvista.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: multipart/mixed;
 boundary="------------080201020401050702090506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080201020401050702090506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Mark,

Mark A. Greer wrote:
> On Wed, Jan 11, 2006 at 12:40:05PM +0300, Andrey Volkov wrote:
> 
>>
>>Mark A. Greer wrote:
>>
>>>On Tue, Dec 20, 2005 at 01:05:34PM +0300, Andrey Volkov wrote:
>>>
>>>
>>>>Hello Mark
>>>>
>>>>Big Thanks, I check it on my board today-tomorrow.
>>>>But check some comments below.
>>>
>>>
>>>Did you have a chance to test it?
>>>
>>
>>I testing it now (holidays, sorry).
>>Aprrox 3-4 hours delay.
> 
> 
> No problem.  Just curious if it works for you.
> Please let me know.
> 
> Thanks,
> 
> Mark
> 
Attached patch fix some misspellings and, mainly,
_reset_ HT flag. If this flag is set, then STM418xx
doesn't run in spite of ST flag state.
With this patch my board work ok.

P.S. Jean, "i2c_master_send vs i2c_smbus_write_byte_data"
problem still open.
Could you made executive decision about it?

-- 
Regards
Andrey Volkov

--------------080201020401050702090506
Content-Type: text/plain;
 name="01-stm_combind_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-stm_combind_fixes.diff"

	* Misc fixes of Mark A. Greers's stm_combined patch
---

 drivers/i2c/chips/Kconfig  |    2 +-
 drivers/i2c/chips/m41txx.c |   45 +++++++++++++++++++++++++-------------------
 include/linux/m41txx.h     |   34 +++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 4a26fb4..8fa3840 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -134,6 +134,6 @@ config RTC_M41TXX_I2C
 	  of I2C RTC chips.
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called m41t00.
+	  will be called m41txx.
 
 endmenu
diff --git a/drivers/i2c/chips/m41txx.c b/drivers/i2c/chips/m41txx.c
index 82ada1f..97564a1 100644
--- a/drivers/i2c/chips/m41txx.c
+++ b/drivers/i2c/chips/m41txx.c
@@ -124,12 +124,12 @@ m41txx_get_rtc_time(void)
 	mon &= 0x1f;
 	year &= 0xff;
 
-	BCD_TO_BIN(sec);
-	BCD_TO_BIN(min);
-	BCD_TO_BIN(hour);
-	BCD_TO_BIN(day);
-	BCD_TO_BIN(mon);
-	BCD_TO_BIN(year);
+	sec = BCD2BIN(sec);
+	min = BCD2BIN(min);
+	hour = BCD2BIN(hour);
+	day = BCD2BIN(day);
+	mon = BCD2BIN(mon);
+	year = BCD2BIN(year);
 
 	year += 1900;
 	if (year < 1970)
@@ -148,12 +148,12 @@ m41txx_set(void *arg)
 	to_tm(nowtime, &tm);
 	tm.tm_year = (tm.tm_year - 1900) % 100;
 
-	BIN_TO_BCD(tm.tm_sec);
-	BIN_TO_BCD(tm.tm_min);
-	BIN_TO_BCD(tm.tm_hour);
-	BIN_TO_BCD(tm.tm_mday);
-	BIN_TO_BCD(tm.tm_mon);
-	BIN_TO_BCD(tm.tm_year);
+	tm.tm_sec = BIN2BCD(tm.tm_sec);
+	tm.tm_min = BIN2BCD(tm.tm_min);
+	tm.tm_hour = BIN2BCD(tm.tm_hour);
+	tm.tm_mday = BIN2BCD(tm.tm_mday);
+	tm.tm_mon = BIN2BCD(tm.tm_mon);
+	tm.tm_year = BIN2BCD(tm.tm_year);
 
 	down(&m41txx_mutex);
 
@@ -259,14 +259,21 @@ m41txx_probe(struct i2c_adapter *adap, i
 	if ((rc = i2c_attach_client(client)) != 0)
 		goto probe_err;
 
-	/* Sst SQW frequency & enable */
-	if ((m41txx_chip->type != M41TXX_TYPE_M41T00) && m41txx_chip->sqw_freq
-			&& ((rc = i2c_smbus_read_byte_data(client,
-				m41txx_chip->alarm_mon)) >= 0)
+	/* Set SQW frequency & enable */
+	if ((m41txx_chip->type != M41TXX_TYPE_M41T00)) {
+		if (m41txx_chip->sqw_freq  
+			&& ((rc = i2c_smbus_read_byte_data(client, 
+				 m41txx_chip->alarm_mon)) >= 0) 
 			&& !(rc & 0x40) && !(i2c_smbus_write_byte_data(
-				client,m41txx_chip->sqw,m41txx_chip->sqw_freq)))
-		i2c_smbus_write_byte_data(client, m41txx_chip->alarm_mon,
-			rc | 0x40);
+				client,m41txx_chip->sqw, m41txx_chip->sqw_freq)))
+			i2c_smbus_write_byte_data(client, m41txx_chip->alarm_mon,
+				rc | 0x40);
+	   /* Reset HT (Halt Update) flag, if it set */	
+		if ( ((rc = i2c_smbus_read_byte_data(client, 
+				 m41txx_chip->alarm_hour)) >= 0) && (rc & 0x40))
+			i2c_smbus_write_byte_data(client, m41txx_chip->alarm_hour,
+				rc & ~0x40);
+	} 
 
 	/* Make sure oscillator is running (i.e., clear 'ST' bit in sec reg) */
 	if (((rc = i2c_smbus_read_byte_data(client, m41txx_chip->sec)) < 0)
diff --git a/include/linux/m41txx.h b/include/linux/m41txx.h
index 31a40d2..8176721 100644
--- a/include/linux/m41txx.h
+++ b/include/linux/m41txx.h
@@ -25,4 +25,38 @@ struct m41txx_platform_data {
 	u32	sqw_freq;
 };
 
+/* SQW output disabled, this is default value by power on*/
+#define SQW_FREQ_DISABLE	(0)
+
+/* 32.768 KHz */
+#define SQW_FREQ_32KHZ	(1<<4)
+/* 8.192 KHz */
+#define SQW_FREQ_8KHZ	(2<<4)
+/* 4.096 KHz */
+#define SQW_FREQ_4KHZ	(3<<4)
+/* 2.048 KHz */
+#define SQW_FREQ_2KHZ	(4<<4)
+/* 1.024 KHz */
+#define SQW_FREQ_1KHZ	(5<<4)
+/* 512 Hz */
+#define SQW_FREQ_512HZ	(6<<4)
+/* 256 Hz */
+#define SQW_FREQ_256HZ	(7<<4)
+/* 128 Hz */
+#define SQW_FREQ_128HZ	(8<<4)
+/* 64 Hz */
+#define SQW_FREQ_64HZ	(9<<4)
+/* 32 Hz */
+#define SQW_FREQ_32HZ	(10<<4)
+/* 16 Hz */
+#define SQW_FREQ_16HZ	(11<<4)
+/* 8 Hz */
+#define SQW_FREQ_8HZ	(12<<4)
+/* 4 Hz */
+#define SQW_FREQ_4HZ	(13<<4)
+/* 2 Hz */
+#define SQW_FREQ_2HZ	(14<<4)
+/* 1 Hz */
+#define SQW_FREQ_1HZ	(15<<4)
+
 #endif /* _M41TXX_H */

--------------080201020401050702090506--
