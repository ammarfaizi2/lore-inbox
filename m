Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbVIMMSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVIMMSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVIMMSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:18:50 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15559 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932627AbVIMMSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:18:49 -0400
Message-ID: <00df01c5b85d$49a003e0$dba0220a@CARREN>
From: "Hironobu Ishii" <hishii@soft.fujitsu.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Taku Izumi" <izumi2005@soft.fujitsu.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <200509072146.j87LkNv8004076@shell0.pdx.osdl.net> <20050907224911.H19199@flint.arm.linux.org.uk> <4394.10.124.102.246.1126165652.squirrel@dominion> <20050913091740.A8256@flint.arm.linux.org.uk> <00b601c5b858$8a8c4ad0$dba0220a@CARREN> <20050913125326.A14342@flint.arm.linux.org.uk>
Subject: Re: performance-improvement-of-serial-console-via-virtual.patch added to -mm tree
Date: Tue, 13 Sep 2005 21:18:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,
> 
> The problem is that the console write method may be called prior to
> autoconfig() being run for the port in question, so tx_loadsz may be
> uninitialised.

Thank you for explanation.

>> > * if it has been initialised
>> > * how much data is already contained in the FIFO
>> 
>> Right, we can't know how many byte exist in the FIFO.
>> So this patch is waiting the FIFO becomes empty at first
>> by calling "wait_for_xmitr(up)".
>> (This is the same logic with original.)
>> 
>> After TX FIFO become empty, we can decide the available 
>> TX FIFO depth by up->tx_loadsize.
> 
> Only if you ignore the fact that tx_loadsz may not be initialised.

OK.
Before initialization, does tx_loadsz left 0?
If so, we can easily solve the problem:

   tx_loadsz = (up->tx_loadsz ? up->tx_loadsz : 1); <-----
   for (i = 0; i < count; ) {
           int     fifo;

           wait_for_xmitr(up);
           fifo = tx_loadsz;        <------
            .
            .
            .


Best regards,
Hironobu Ishii
