Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288122AbSACCE5>; Wed, 2 Jan 2002 21:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288126AbSACCEs>; Wed, 2 Jan 2002 21:04:48 -0500
Received: from intra.cyclades.com ([209.81.55.6]:16903 "HELO
	intra.cyclades.com") by vger.kernel.org with SMTP
	id <S288122AbSACCEa>; Wed, 2 Jan 2002 21:04:30 -0500
Message-ID: <3C33BCF3.20BE9E92@cyclades.com>
Date: Wed, 02 Jan 2002 18:07:47 -0800
From: Ivan Passos <ivan@cyclades.com>
Organization: Cyclades Corporation
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial Driver Name Question (kernels 2.4.x)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please CC your answer to me, as I'm not a subscriber of this list.)

Hello,

By looking at tty_io.c:_tty_make_name(), it seems that the TTY 
subsystem in the Linux 2.4.x kernel series expects driver.name to be 
in the form "ttyX%d", even if you're not using devfs. I say that 
because as of now the definition in serial.c for this variable is:

#if defined(CONFIG_DEVFS_FS)
        serial_driver.name = "tts/%d";
#else
        serial_driver.name = "ttyS";
#endif


, when it seems it should be:

#if defined(CONFIG_DEVFS_FS)
        serial_driver.name = "tts/%d";
#else
        serial_driver.name = "ttyS%d";
#endif

to work properly with the _tty_make_name() function (otherwise, in 
case you're not using devfs, it'll just print "ttyS" without any 
reference to the port number the msg is referring to).

This was spotted by a Cyclades customer who was getting overrun msgs 
as:

ttyC: 1 input overrun(s)

After he changed the driver.name to be "ttyC%d", he started to get 
properly formatted msgs, such as:

ttyC39: 1 input overrun(s)


This problem would happen on any msg that used the function 
tty_name() to get the TTY name, and after the change the problem 
disappeared completely.

After checking the kernel code, I believe that he's found a bug that 
should be fixed in all drivers that define driver.name.

Please advise so that we may change the Cyclades driver to behave 
properly. 

Regards,
-- 
Ivan Passos							 -o)
Integration Manager, Cyclades	- http://www.cyclades.com	 /\\
Project Leader, NetLinOS	- http://www.netlinos.org	_\_V
--------------------------------------------------------------------
