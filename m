Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVEYHAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVEYHAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVEYHAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:00:35 -0400
Received: from general.keba.co.at ([193.154.24.243]:17259 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262305AbVEYG4P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:56:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: RT patch acceptance
Date: Wed, 25 May 2005 08:55:50 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F36732321D@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT patch acceptance
Thread-Index: AcVg2bJeizHqa/x1Q9+bTHmGCGahCAAGpG4Q
From: "kus Kusche Klaus" <kus@keba.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Lee Revell" <rlrevell@joe-job.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Sven Dietrich" <sdietrich@mvista.com>,
       <dwalker@mvista.com>, <bhuey@lnxw.com>, <mingo@elte.hu>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lee Revell wrote:
> >On Tue, 2005-05-24 at 19:20 -0700, Andrew Morton wrote:
> >
> >>Sven Dietrich <sdietrich@mvista.com> wrote:
> >>
> >>>I think people would find their system responsiveness / tunability
> >>> goes up tremendously, if you drop just a few unimportant IRQs into
> >>> threads.
> >>>
> >>People cannot detect the difference between 1000usec and 
> 50usec latencies,
> >>so they aren't going to notice any changes in responsiveness at all.
> >
> >The IDE IRQ handler can in fact run for several ms, which people sure
> >can detect.
> 
> Are you serious? Even at 10ms, the monitor refresh rate would 
> have to be
> over 100Hz for anyone to "notice" anything, right?... What 
> sort of numbers
> are you talking when you say several?

I measured IDE delays just a few weeks ago.

We are talking about up to 100 ms. 
Absolutely unacceptable for realtime systems.
*Very* noticeable even for interactive systems:
Keyboard and mouse lags, lost timer ticks, ...

Why that long?
* The system I tested uses a CF card connected to the standard IDE
  controller as its primary disk.
* The CF card runs in PIO mode. Hence, all data transfer is done
  by the CPU itself, in the interrupt handler, blocking the CPU.
* CF cards are slow, the worst I've seen does about 1.5 MB/s.
* On the other hand, CF cards deliver data continuosly:
  As soon as one sector has been read, the interrupt for the
  next sector arrives. No hole in between to do other things.
* Now, calculate the time for the standard sequential readahead,
  which is 128 KB. You end up with something close to 100 ms.

During this time, the CPU is completely occupied by IDE,
not reacting to anything else in the standard kernel.

With the RT kernel, at least everything above the IDE interrupt
priority level is able to continue.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
