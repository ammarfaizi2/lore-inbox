Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVFQNal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVFQNal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVFQNak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:30:40 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:43481 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261961AbVFQNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:30:25 -0400
Message-ID: <000901c57348$14c5e400$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: x86 descriptor base fetching performance opportunities
Date: Fri, 17 Jun 2005 10:22:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is something I've just started investigating, but preliminary
benchmarks of trial instruction sequences look VERY favorable for
conditional compilation of different code for those CPU's that can do a
BSWAP instruction.

The Linux src appears not conditionalized in any way in its handling of
descriptor get/set operations at the moment.

The fetching of descriptor bases is a necessarily clumsy affair on 386
resulting in several shift/rotate/masking operations because the upper 16
bytes of the base are split in a rather un-handy way in the 2nd dword of a
descriptor.

However, for 486 and better CPU's this un-handy layout looks like it can be
mitigated by BSWAP.  ex(pseudo-asm)

movl 4(des_ptr),eax   // Take hi-dword of descriptor
rol  8,eax            // AL=des-hi8, AH=des-hi-mid8
bswap eax             // Now, EAX high 16 == high 16 of descriptor
movw 2(des_ptr),ax    // Fill in the low 16 bits



