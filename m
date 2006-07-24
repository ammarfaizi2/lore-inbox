Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWGXVvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWGXVvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWGXVvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 17:51:47 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:17937 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932261AbWGXVvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 17:51:46 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Debugging APM - cat /proc/apm produces oops
Date: Mon, 24 Jul 2006 23:51:37 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607231630.53968.linux@rainbow-software.org> <20060724010658.687e78be.sfr@canb.auug.org.au>
In-Reply-To: <20060724010658.687e78be.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607242351.37578.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 17:06, Stephen Rothwell wrote:
> On Sun, 23 Jul 2006 16:30:53 +0200 Ondrej Zary <linux@rainbow-software.org> 
wrote:

> >  printing eip:
> > 00002f9d
> > *pre = 00000000
> > Oops: 0002 [#4]
> > Modules linked in:
> > CPU:    0
> > EIP:    00c0:[<00002f9d>]    Not tainted VLI
>
>           ^^^^
> This is the APM BIOS 16 bit code segment.

Looking at BIOS disassembly:
2F97: push bp
2F98: mov bp,sp
2F9A: add sp,-2
2F9D: mov [bp][-2],bx    <-- it oopses here

I realized that I can modify the BIOS easily as it's stored in shadow RAM. So 
I replaced the offending MOV with three NOPs and tested again. This time it 
oopsed at 0x2FAD:
2FAD: cmp w,[bp][-2],1
2FB1: je 2FCB

that jump was taken during my single stepping, so I NOPped out the CMP and 
replaced JE with JMPS. Then booted Linux and APM seems to work fine - battery 
percentage and remaining time is there as well as AC power status.
There seems to be 4 these operations:
mov [bp][-2],bx
cmp w,[bp][-2],1
cmp w,[bp][-2],8002
cmp w,[bp][-2],8001
but I've hit only the first two of them. I wonder what's that for (especially 
when it works without that).

-- 
Ondrej Zary
