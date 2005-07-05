Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVGEJ5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVGEJ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 05:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVGEJ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 05:57:25 -0400
Received: from redpine-92-161-hyd.redpinesignals.com ([203.196.161.92]:46053
	"EHLO redpinesignals.com") by vger.kernel.org with ESMTP
	id S261783AbVGEJ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 05:57:20 -0400
Message-ID: <42CA597C.6090403@redpinesignals.com>
Date: Tue, 05 Jul 2005 15:27:16 +0530
From: P Lavin <lavin.p@redpinesignals.com>
Reply-To: lavin.p@redpinesignals.com
Organization: www.redpinesignals.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wireless lan, defragmentation in driver module.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need help in the following issue, i'll explain the mechanisum & the 
problem i'm facing,

1) In the existing wireless lan driver we've MPDU's & MSDU's, all the 
MPDU's are handled by the firmware where as all the MSDU's by the 
driver. Now i need to implement 802.11E protocol based block ack 
mechanisum, in this mechanisum ther will not be any wirelss ack's for 
each MPDU's insted the Transmitter  can request for Blockack by 
transmitting BlockAck.request , for which the receiver will respond with 
an block ack by indication all the lost mpdu's.
The MSDU's given by the driver/os can be fragmented in the MAC(by 
firmware) if the packet is exceeding the fragmentation threshold limit. 
Previously the defragmentation was done in firmware but as firmware is 
lacking memory we've to move the de-fragmentation (only in block ack 
mechansum) into driver. In the old driver this was not a problem because 
driver will get only MSDU's & not MPDU's. So that i can happely copy 
these packets from our h/w queue into an sk_buff & give it to OS,
   a) in the present case i cannot do this if block.ack mechanisum was 
established, i'll get only mpdu's & i've to assemble it & form the MSDU's.
   b) I'll have a scheduler who'll come & take these packets from my 
software queue's & give it to OS.

So i need to know
   a) whenever i've 10mpdu's of an MSDU from Station A to be 
transmitted into StationB

A                                 B

mpdu1---------------->Success
mpdu2---------------->Success
mpdu3---------------->Success
mpdu4---------------->Failed
mpdu5---------------->Success
mpdu6---------------->Success
mpdu7---------------->Failed
mpdu8---------------->Success
mpdu9---------------->Failed
mpdu10---------------->Success

mpdu's 3, 7 & 9 are lost this we'll indicate in the block-acksent 
whenever transmitter is requesting for block ack using blockack.request 
, but in the receiver all these mpdu's has to be stored untill station A 
succesfully transmits all the lost mpdu's. Once these mpdu's are 
received correctly i've to put these mpdu's in the correct position & 
form the MSDU, then only i can give this MSDU to OS.

This is the scenario which can happen in a simple MSDU transfer from 
station A to B.
------------------------------------------------------------------------------------------------------------------------
Is it possible to allocate one skbuff for one packet (this will be 
mainatained in my s/w queues), as &  when some mpdu's come i'll insert 
it in the correct offset ??Weather any kernel calls are available for 
manipulating skbuff. i searched in net/core.c but i was not sure weather 
this can be used in my own de-fragmentation mechanism...

Or should i directly maintain my own buffers & copy it only in the end 
to a single skbuff, i dont think this a good way coz this will decrease 
the performance of the mechanisum !!!
Can anyone help me !

Regards,
P.Lavin

