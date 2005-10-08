Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVJHV3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVJHV3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVJHV3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:29:55 -0400
Received: from bay108-dav13.bay108.hotmail.com ([65.54.162.85]:54930 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751144AbVJHV3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:29:55 -0400
Message-ID: <BAY108-DAV13E4A07219D7EF5A47636193870@phx.gbl>
X-Originating-IP: [143.182.124.4]
X-Originating-Email: [multisyncfe991@hotmail.com]
From: "LeoY" <multisyncfe991@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Is this skb recycle buffer helpful to improve network stack performance?
Date: Sat, 8 Oct 2005 14:29:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 08 Oct 2005 21:29:54.0624 (UTC) FILETIME=[6C96EC00:01C5CC4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Motivation: we noticed alloc_skb()/kfree() used lots of clock ticks when 
handling heavy network traffic. As Linux kernel always need to call 
kmalloc()/kfree() to allocate and deallocate a skb DATA buffer(not sk_buff) 
for each incoming/outgoing packet, we try to reduce the frequence of calling 
these memory functions.

I wangt to set up a ring buffer in Linux kernel(skbuff.c) and recycle those 
skb data buffers. The basic idea is as follows:
1. Create a ring buffer. This ring buffer has a head pointer which points to 
the virtual address of the data buffer to be reused; It also has a tail 
pointer, which can be used to store the virutal address of skb data buffer 
for those transmitted packets.
2. If the ring buffer is full, just use normal kmalloc()/kfree() operation 
to manager those skb data buffers instead of recycling them.
3. if any DATA buffer is available, Instead of calling kmalloc(), assign a 
skb data buffer directly from ring buffer to the incoming packets.
4. If ring buffer still has space, Instead of calling kfree(), store the skb 
data buffer into the ring buffer.
5. if the head and tail pointer overlap and head pointer is not empty, just 
stop accpeting more DATA buffer until some DATA buffer is used for the 
incoming packets.

I tested my method on the latest Linux kernel 2.6.13.3, it works with the 
normal traffic; However, the Linux kernel crashed under the heavy network 
traffic.

Any idea to make this ring bufer work under the heavy network traffic?

Thanks a lot,

Leo Y 
