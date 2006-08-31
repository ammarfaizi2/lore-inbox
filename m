Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWHaPEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWHaPEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHaPEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:04:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:42191 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932343AbWHaPEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:04:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iYXee6oA3eFF4+ZZ4C6+SIdyjBq72ljh72TZkSvz7qrbVkb3UBIaL2skT9io1FzPzw50WJ5wunDj26zabbJf1bxll4JcuTxOQRm9gN8Y3AvMR0VlIego8gPXbVZss2BYMw9yFcyqdDAFQ7Gu9tViPQnYjhKl79q4knaH4c8v/kM=
Message-ID: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>
Date: Thu, 31 Aug 2006 10:04:11 -0500
From: "madhu chikkature" <crmadhu210@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SDIO card support in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is regarding the discussion going on in the list about the
support of SDIO cards in Linux. I read some discussion happening to
support SDIO cards using the existing Linux MMC core but I could not
figure out what would be the direction the community to support the
SDIO cards.

I have done some work using our own hardware platform runing ARM
Linux. My hardware platform can support MMC/SD/SDIO cards.

>From the SDIO specification, i understand that we need to add support
for the following commonds in the MMC core to support SDIO cards.

IO_SEND_OP_COND -- CMD5 --- This command is very much simillar to CMD1 of MMC.

CMD3 of MMC can be reused during the discover cards phase, except that
the card will respond back with the RCA.

IO_RW_DIRECT -- CMD52
IO_RW_EXTENDED -- CMD53
The above two are data transfer commands. CMD52 does not use data
lines. This command can be used to read/write 1 byte of data on the
CMD line.

CMD53 is equavalent to CMD17/CMD18/CMD24/CMD25 of MMC to read/write
data on data lines.

The SDIO spec only exposes a few set of registers called CARD COMMON
CONTROL REGISTERS which are common to all types of SDIO cards.

Functionality specific SDIO card registers are left to the vendor to describe.

With this, is it a fissible solution to have the MMC core do the
initialization part of the card by having the CMD sequence for SDIO
card (CMD5 and CMD3) in the mmc_setup sequence and maintain the SDIO
card list along with MMC/SD?

The CMD52 and CMD53 can be implemented with a simple pointer to
mmc_data structure(An instance of it for SDIO) to send and receive
data. Exporting the functions that implement CMD52 and CMD53 need to
be done, so that any card specific driver sitting on the top of the
MMC core can call these functions to read/write data from the card and
configure the card.

Couple of issues i faced are, how do we maintain the list of SDIO
cards? Right now, i am not adding it to the list of MMC cards. SDIO
combo cards need more work.

Second issue is related to how well the data transfer commands can be
supported in such a way that the middleware, which does not exist as
of today to hook the SDIO cards to specific Linux subsystems based on
the type of the SDIO cards detected, for exaple WLAN SDIO card may
need to talk to the networking subsystem etc.

I am leaving the SDIO generic interrupts to the card specific driver.
With this setup and few additions to the MMC controller driver, i
could get the SDIO cards to be detected and i am able to read and
write data from the SDIO card CCCR registers.In fact the MMC/SD and
SDIO cards can co-exist.

Does this provide a basic support on which SDIO support can be worked
on? or does community have any other idea?

SD support came in at 2.6.14 times and many people still does not have
access to SD specification easily. Is there any such issues related to
SDIO as well which might prevent the community from supporting SDIO
cards?

Please let me know views on this.

Regards,
Madhu
