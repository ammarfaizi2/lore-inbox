Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWF0CpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWF0CpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWF0CpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:45:19 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53133 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S933335AbWF0CpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:45:17 -0400
Subject: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Stas Sergeev <stsp@aknet.ru>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 21:45:13 -0500
Message-Id: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The basic problem with this function is that on most architectures
smp_processor_id() is an alias for current_thread_info()->cpu which
isn't given its correct value until setup_arch(), so adding a
boot_cpu_init() that uses it *before* setup_arch() is called is plain
wrong.  You manage to get away with it 99% of the time because its
uninitialised value is zero and mostly the id of the booting CPU is
zero ... but guess who's got a box currently booting on CPU 1 with no
CPU 0?

Unfortunately, I can't think of a good solution for what you want to do.
The thing that looks most plausible is hard_smp_processor_id() which
reads the actual register value of the processor id.  However, on x86
(and any other architectures that renumber their CPUs in setup_arch())
this will ultimately turn out wrong again.

James


