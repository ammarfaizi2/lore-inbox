Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965617AbVKHAFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965617AbVKHAFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965619AbVKHAFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:05:03 -0500
Received: from fmr14.intel.com ([192.55.52.68]:29363 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S965618AbVKHAFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:05:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel performance update - 2.6.14
Date: Mon, 7 Nov 2005 16:04:36 -0800
Message-ID: <2BD5725B505DC54E8CDCF251DC8A2E7E08E17F74@fmsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel performance update - 2.6.14
Thread-Index: AcXj8YDu7cYek7RbTImk5XO2ZeiJvgABUgKw
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Nov 2005 00:04:37.0345 (UTC) FILETIME=[01EA3D10:01C5E3F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Felix Oxley wrote on Friday, October 28, 2005 5:29 PM
>> Something went horribly wrong with this test between 2.6.13 and
>> 2.6.13-git2 (it has never recovered):
>> 
>> System: 4P Itanium
>> Test:Result Group 1
>> Metric: VolcanoMark
>> Result:      -3%         -10%
>> Kernel: 2.6.13 vs 2.6.13-git2
>> 
>> Does anybody know the cause of this?
> 
> Search the archive, it was discussed here:
> http://marc.theaimsgroup.com/?l=linux-ia64&m=112683124124723&w=2
> 
> 
> It is not because of changes in 2.6.13-git2. It would've shown on
> 2.6.13-rc1 when default hz rate was switched to 250.  I happened to
> audit the system at that time and made the hz switch (from 1000 to
> 250 and the problem showed up.  
> 
> More discussion here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112854723926854&w=2
> 
> 
> - Ken

For 4P Itanium, it turns out that Volanaomark is operating 
suboptimally with system idle at 55% for the region of operations 
where regression occurs for Hz changes. Volanomark server broadcasts 
short message (each only ~40 bytes) from each client to the other 
clients in the chatroom (20 clients/chatroom in test).  However each 
message consumes a sk_buff taking up 1 page (16K on Itanium) of 
memory as the message is sent immediately without coalescing with 
other messages.   We hit our default write buffer size limit 
tcp_wmem_max (128K) quickly with 8 outstanding packets. The server 
stalls waiting for acknowledgement.  Due to TCP's delayed 
acknowledgement, the server do not get ack immediately to continue.  
By either increasing the TCP write buffer size or patching the kernel 
to send TCP ACK without delay, we can reduce the system idle to 0% 
and Volanomark performance do not show regression in this case when 
Hz rate changes.

- Tim
