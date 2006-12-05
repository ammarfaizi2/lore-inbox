Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968561AbWLESTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968561AbWLESTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968563AbWLESTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:19:15 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51484 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968561AbWLESTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:19:14 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4575B804.1060006@s5r6.in-berlin.de>
Date: Tue, 05 Dec 2006 19:18:44 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Import fw-sbp2 driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052253.7213.41796.stgit@dinky.boston.redhat.com> <45750C9A.607@garzik.org>
In-Reply-To: <45750C9A.607@garzik.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Kristian Høgsberg wrote:
>> +struct sbp2_status {
>> +    unsigned int orb_high:16;
> 
> unsigned short?  probably generates better code than a bitfield:16
> 
> 
>> +    unsigned int sbp_status:8;
> 
> unsigned char?
> 
> 
>> +    unsigned int len:3;
>> +    unsigned int dead:1;
>> +    unsigned int response:2;
>> +    unsigned int source:2;
>> +    u32 orb_low;
>> +    u8 data[24];
>> +};

This as well as ORBs and responses are series of u32 that go in or out
in big endian byte order.

The old FireWire drivers have two styles to deal with such data
structures: Define them as a struct or array of u32 and manipulate bits
by arithmetic expressions, or define them as bitfields similarly to what
you see above. Of course either approach has to account for host byte
order in one or another way.

...
>> +
>> +    /* FIXME: Make this work for multi-lun devices. */
>> +    lun = 0;
> 
> doesn't allowing the stack to issue REPORT LUNS take care of this?

SBP-2 LUs and their LUNs are obtained from the ISO/IEC 13213
configuration ROM of the target.

The FIXME comment is misleadingly worded, at least as far as the "old"
sbp2 driver is concerned, which AFAIU served as a starting point for
fw-sbp2. The sbp2 driver supports multi-unit targets; it just represents
each LU behind an own Scsi_Host. This had several reasons, most of them
historic now. I am considering to make sbp2 use a single Scsi_Host for
all its LUs and perhaps join LUs of the same target beneath a single
scsi_target. But this project doesn't have priority for me.
-- 
Stefan Richter
-=====-=-==- ==-- --=-=
http://arcgraph.de/sr/
