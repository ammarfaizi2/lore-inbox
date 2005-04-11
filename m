Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVDKLm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVDKLm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVDKLja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:39:30 -0400
Received: from general.keba.co.at ([193.154.24.243]:20937 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261785AbVDKLjB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:39:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RT 45-01: CF Card read: High latency?
Date: Mon, 11 Apr 2005 13:38:54 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231EA@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT 45-01: CF Card read: High latency?
Thread-Index: AcU48Xrl1sK/Hr4PQf2OhbptXin5JgFlVePA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the three sources of multi-millisecond latency in my experiments
(console messages to dead serial console, USB I/O, CF Card bulk read), 
I've analyzed one:

The latency of around 70 milliseconds in low-priority RT processes
when running a "dd if=/dev/hda of=/dev/null" in parallel (where hda
is a CF card) is due to readahead.

Two indications for that:
* Per default, maximum readahead is 128 KB. 70 ms is exactly the time
needed to transfer 128 KB 
(our CF cards have a sustained transfer rate of 1800 KB/sec).
* If the readahead constants in the kernel are changed,
the observed latencies scale almost linearly.

So obviously:
* The PIO mode IDE transfers keep the CPU 100 % busy.
* No other processes get scheduled between the data transfer of
individual "sectors", i.e. there are no holes between the IDE 
interrupts.

However, there is no need to change the readahead mechanism,
because even the transfer of a single sector would exceed our
latency requirements. So we either need to switch to DMA (which we
can't in the short term), or run the time-critical tasks above IDE 
priority. 

So the question is, what exactly is the IDE priority?
Is the PIO transfer done in the IRQ handler or in a bh?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
