Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270199AbUJTOZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270199AbUJTOZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270205AbUJTOWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:22:36 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:32643 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S270377AbUJTONN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:13:13 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Cc: "Mikael Starvik" <mikael.starvik@axis.com>
Subject: 2.6.9 PageAnon bug
Date: Wed, 20 Oct 2004 16:13:01 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F59A@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is at least one architecture supported by 2.6.9 that has no alignment
restrictions what so ever and no struct padding added by the compiler. 

The patch named "rmaplock: PageAnon in mapping" in 2.6.9 doesn't work for
this architecture because it assumes that the address of a member in a
struct can't be odd. 

One possible but ugly patch below. Another possible patch would be to move
i_data above i_bytes and i_sock. I would really like a cleaner patch but I
guess its a bad idea to add a new field to struct page?

Index: fs.h
===================================================================
RCS file: /usr/local/cvs/linux/os/lx25/include/linux/fs.h,v
retrieving revision 1.20
retrieving revision 1.21
diff -r1.20 -r1.21
449c449,453
< 	struct address_space	i_data;
---
> 	/* The LSB in i_data below is used for the PAGE_MAPPING_ANON flag. 
> 	 * This assumes that the address of this member isn't odd which
> 	 * is not true for all architectures. Force the compiler to align
it.
> 	 */
> 	struct address_space	i_data __attribute__ ((aligned(4)));

Anyone who knows about similar usage of bit 0 and/or 1 in pointers
anywhere?

/Mikael 

PS. The architecture I'm referring to is CRIS but there may be more with the
same sloppyness regarding alignment. DS

