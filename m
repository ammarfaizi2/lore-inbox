Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314727AbSEPVPW>; Thu, 16 May 2002 17:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314735AbSEPVPV>; Thu, 16 May 2002 17:15:21 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:53777 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S314727AbSEPVPT>; Thu, 16 May 2002 17:15:19 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7825@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Lukasz Trabinski'" <lukasz@lt.wsisiz.edu.pl>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: RE: OX16PCI954 - more than 921600/3000000
Date: Thu, 16 May 2002 14:15:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002, Lukasz Trabinski wrote:
>
> I have serial card with Oxford chipset OX16PCI954-TQC60-A1
> It's identify as "Titan Electronics VScom 400H 4 port serial adaptor"
> vendor_id: 14d2:a003
> I can set speed port to 921600 or 3000000 bits/s, but I would like
> set speed precisely to:
>
> 1843200 bits/s
> 3684400 bits/s
> 2681018 bits/s
> or
> 2268554 bits/s
>
> but I can't because we have in include/asm-i386/termbits.h defines:
> #define   B921600 0010007
> #define  B1000000 0010010
> #define  B1152000 0010011
> #define  B1500000 0010012
> #define  B2000000 0010013
> #define  B2500000 0010014
> #define  B3000000 0010015
> #define  B3500000 0010016
> #define  B4000000 0010017

Good question.  There are actually two separate issues here. 

1. specification of a custom baud rate to the driver.
2. whether the UART baud rate generator can hit the specified value.

You cannot use the setserial command and the custom divisor flag and
parameter value, because your target rates are higher than the baud_base for
this card, (921600 bps) so there can be no integer divisor that hits the
target rate. The tty structure contains a field, tty->alt_speed, that allows
a single custom target baud rate to specified that will be used when the app
requests 38.4kbps.  The field exists to support the
ASYNC_SPD_{HI,VHI,SHI,WARP} flags that implicitly specify 57600, 115200,
230400 and 460800 bps speeds.  This field can do what you need as long as
the ASYNC_SPD_* flags are not set, so the value does not get overwritten.
Unfortunately, I do not personally know of a way to set this tty field from
user level.  Perhaps someone else knows, or has a patch to provide a
mechanism to reach in there and set the tty->alt_speed field.  If you can
find a way to set tty->alt_speed, then you can set any hardware supported
speed by first setting tty->alt_speed to the target baud rate, and then
requesting the 38.4kbps standard speed via a normal termios call. 

BTW, the _really_ugly_but_quick_ way to specify custom baud rates to the
driver is to change the system baud rate table values for speeds that you
don't need.  The table lives in drivers/char/tty_io.c at about line 1929.
For example, if you change the 3500000 entry to 3684400, then selecting the
3500000 standard rate would instead set 3684400. (or as close as the driver
can get, which is the second issue ...)  

As currently released, with a 950-series UART, the driver can only hit rates
that correspond to the baud_base value (multiplied by 1, 2 or 4) divided by
an integer.  The baud_base value first gets multiplied by 2 and then by 4 as
needed to lift it above the target baud rate.  Then an integer divisor is
calculated which may not be anywhere close to the target rate due to the
huge granularity of speeds selected by small divisor values.  For example,
for a target rate of 3000000, the multiplier would be 4, giving a base rate
of 3686400 bps to divide down.  The first few possible integer divisors
give:

3686400 / 1 = 3686400
3686400 / 2 = 1843200
3686400 / 3 = 1228800

Notice that there are no choices that are even close. The 954 UART can do
much better than this with its CPR prescaler register, but this
functionality is not supported by the current driver.  However, a patch to
properly support the CPR register has been posted to the list a few times.
An archived message that contains the patch and caveats is found here:
(Thanks Fabrizio)

http://groups.google.com/groups?dq=&hl=en&group=mlist.linux.serial&safe=off&
selm=linux.serial.OFAB55B09E.868BB835-ONC1256B82.005C3839%40diamond.philips.
com

Good luck.

Ed

----------------------------------------------------------------
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
