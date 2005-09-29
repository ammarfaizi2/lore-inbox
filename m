Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVI2Tse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVI2Tse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVI2Tsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:48:33 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:64519 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750767AbVI2Tsc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:48:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 29 Sep 2005 19:48:30.0382 (UTC) FILETIME=[C46184E0:01C5C52E]
Content-class: urn:content-classes:message
Subject: Making thread time visible to `ps`
Date: Thu, 29 Sep 2005 15:48:30 -0400
Message-ID: <Pine.LNX.4.61.0509291545540.26152@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Making thread time visible to `ps`
Thread-Index: AcXFLsR+eWMCvTLoQuu9bVwnmTIuiA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

This is the kernel thread in a module. It gets awakened
to do some work as a result of an interrupt. It does
the right thing and works.

But.... `ps` never shows it using ANY cpu time!  I know
that the procedure, read_fifo() takes about 600,000 cpu
clocks, measured with rdtsc, so I would expect that
that time would be visible. Does anybody know how to
make the time that a kernel thread uses, become visible
to `ps` ???


static int32_t local_thread(void *unused)
{
     DAEMONIZE;                                  // In config.h
     SET_PRIORITY(-19);                          // In config.h
     memcpy(current->comm, task_name, sizeof(task_name));
     set_current_state(TASK_INTERRUPTIBLE);
     schedule_timeout(0);                        // Let insmod complete
     __asm__ __volatile__("thread:\n.global thread\n");
     for(;;)
     {
         set_current_state(TASK_INTERRUPTIBLE);
         if(signal_pending(current))
             complete_and_exit(&info->quit, 0);
         interruptible_sleep_on(&info->twait);
         set_current_state(TASK_RUNNING);
         read_fifo();
     }
     return 0;	// Just quiet the compiler
}

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
