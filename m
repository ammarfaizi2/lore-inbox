Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbUAKLpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUAKLpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:45:41 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:52096 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261928AbUAKLpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:45:38 -0500
Message-ID: <4001374D.5010402@steudten.com>
Date: Sun, 11 Jan 2004 12:45:17 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, ink@jurassic.park.msu.ru, rth@twiddle.net
Subject: Re: Relocation overflow vs section  kernel-2.6.1 for alpha 
References: <3FB92938.8040906@steudten.com>	<87r806d6n6.fsf@student.uni-tuebingen.de>	<3FB93EF6.807@steudten.com>	<87islid5tq.fsf@student.uni-tuebingen.de>	<20031118021922.A7816@den.park.msu.ru>	<3FBA8F20.3050701@steudten.com>	<40002F69.9020302@steudten.com> <20040110143409.0e591596.akpm@osdl.org>
In-Reply-To: <20040110143409.0e591596.akpm@osdl.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
X-Authenticated-Sender: user thomas from 192.168.1.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I run in this problem too on my alpha sx164 and the patch fix this, so
i can load all the modules without problems.

Please add the patch to the kernel 2.6.x alpha mainline.

Regards
Tom

On Mon, Jan 05, 2004 at 02:21:37AM +0100, Måns Rullgård wrote:
 > I compiled Linux 2.6.0 for Alpha, and it mostly works, except the
 > somewhat large modules. They fail to load with the message
 > "Relocation overflow vs section 17", or some other section number.

This failure happens with GPRELHIGH relocation, which is *signed*
short, but relocation overflow check in module.c doesn't take into
account the sign extension.
Appended patch should help.

Ivan.

--- 2.6/arch/alpha/kernel/module.c Wed May 28 01:05:20 2003
+++ linux/arch/alpha/kernel/module.c Mon Aug 11 23:23:02 2003
@@ -259,7 +259,7 @@ apply_relocate_add(Elf64_Shdr *sechdrs,
*(u64 *)location = value;
break;
case R_ALPHA_GPRELHIGH:
- value = (value - gp + 0x8000) >> 16;
+ value = (long)(value - gp + 0x8000) >> 16;
if ((short) value != value)
goto reloc_overflow;
*(u16 *)location = value;

