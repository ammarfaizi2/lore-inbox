Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTBRMJO>; Tue, 18 Feb 2003 07:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTBRMJN>; Tue, 18 Feb 2003 07:09:13 -0500
Received: from [199.203.178.211] ([199.203.178.211]:28496 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S267761AbTBRMJN> convert rfc822-to-8bit; Tue, 18 Feb 2003 07:09:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Possible bug in ext3 versus filter drivers in 2.4.18-3, 2.4.18-14 and 2.4.20.
Date: Tue, 18 Feb 2003 14:17:28 +0200
Message-ID: <AE0DC697C2336C4A9767AE031CE4B344134FCE@exchange.store-age.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Possible bug in ext3 versus filter drivers in 2.4.18-3, 2.4.18-14 and 2.4.20.
Thread-Index: AcLXR7RGd+52c7NBRAaawKL5QYRRaw==
From: "Alexander Sandler" <ASandler@store-age.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Ohad Levin" <OLevin@store-age.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

I am working on a filter driver. 

In my driver, I am monitoring whether requests I redirected to other driver were successful or not. To do so, I am replacing b_end_io and b_private fields in buffer header. This way, instead of calling the default completion routine, system is calling my completion routine, which used to, among the other things, recover original b_end_io and b_private fields from value I placed in b_private when mapped the request and call original b_end_io with appropriate uptodate value. 

The problem with ext3 is that it is accessing b_private field in locked buffer headers. It is treating b_private field I placed in buffer header, as journal header. As a result, I am getting multiple segmentation faults in different places and you can imagine what else. 

The problem starts somewhere in ext3_new_block() in fs/ext3/balloc.c. In the begging it's obtaining buffer header and eventually it's calling __ext3_journal_get_undo_access() in  include/linux/ext3_jbd.h. From there, it goes to journal_get_undo_access() in fs/jbd/transaction.c, then to journal_add_journal_head() in fs/jbd/journal.c and so on. Journal header is obtained in line stating "jh = bh2jh(bh);" in journal_add_journal_head().

I see two possible fixes. First, we can make sure filter drivers do not change b_private field in buffer header. It seems to be quite odd solution since as far as I understood, this is what b_private filed is there for (among the other things of course). Other option is to make sure that ext3_new_block() won't access locked buffer headers. This seems to be more reasonable. 
I am afraid I am not really an expert in file systems in general and in ext3 in particularly, so I don't know what exactly to do. Perhaps someone can fix this thing or guide me how to do so.

Finally, I found this thing in 2.4.18-3 (RH 7.3). I checked 2.4.18-14 (RH 8.0) and 2.4.20. It seems that the problem is there for all three versions of kernel.

Thank you.

Alexandr Sandler.
