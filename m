Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSKRWcY>; Mon, 18 Nov 2002 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKRWcY>; Mon, 18 Nov 2002 17:32:24 -0500
Received: from mort.demon.co.uk ([158.152.28.197]:61095 "EHLO mort.demon.co.uk")
	by vger.kernel.org with ESMTP id <S265532AbSKRWcV>;
	Mon, 18 Nov 2002 17:32:21 -0500
From: mbm@mort.demon.co.uk
Message-Id: <200211182239.gAIMdBL04074@mort.demon.co.uk>
Subject: Re: 2.5.48: BUG() at kernel/module.c:1000
To: "Petr Vandrovec" <vandrove@vc.cvut.cz>, rusty@rustcorp.com.au
Date: Mon, 18 Nov 2002 22:39:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
Reply-To: mbm@tinc.org.uk
In-Reply-To: <20021118192001.21441.11326.Mailman@lists.us.dell.com> from "linux-kernel-digest-request@lists.us.dell.com" at Nov 18, 2002 01:20:01 
Reply-To: "Malcolm Mladenovic" <mbm@tinc.org.uk>
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 18 Nov 2002 19:06:56 +0100
> From: Petr Vandrovec <vandrove@vc.cvut.cz>
> To: rusty@rustcorp.com.au
> Cc: linux-kernel@vger.kernel.org
> Subject: 2.5.48: BUG() at kernel/module.c:1000
> 
> Hi Rusty,
>   I'm trying to get VMware working, and unfortunately new insmod
> is not able to load generated module. It died at line 1000 of 
> kernel/module.c, because of used.core_size > mod->core_size:
>      INIT=0/0  CORE=34252/34228

Hi,

This appears to be due to the COMMON symbol "errno".

The code (get_sizes) that calculates the amount of space required
by the sections assumes that the first one is loaded at address
zero (or large alignment) when performing subsequent alignments.

Unfortunately, this is not the case when the actual load takes
place because the common area (length common_length) is allocated
first.  This needs to be rounded up to the strictest alignment of
any of the ALLOC sections before the copies start.  (Hence the
difference of (2**5 - 8) which is apparent in the CORE values above.)

cheers,

-Malcolm

