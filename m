Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUAHOKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUAHOKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:10:36 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:58374 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264917AbUAHOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:10:30 -0500
Date: Thu, 8 Jan 2004 17:10:06 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Richard Henderson <rth@twiddle.net>
Subject: [patch 2.6] Relocation overflow with modules on Alpha
Message-ID: <20040108171006.A9562@jurassic.park.msu.ru>
References: <yw1xy8sn2nry.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xy8sn2nry.fsf@ford.guide>; from mru@kth.se on Mon, Jan 05, 2004 at 02:21:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 02:21:37AM +0100, Måns Rullgård wrote:
> I compiled Linux 2.6.0 for Alpha, and it mostly works, except the
> somewhat large modules.  They fail to load with the message
> "Relocation overflow vs section 17", or some other section number.

This failure happens with GPRELHIGH relocation, which is *signed*
short, but relocation overflow check in module.c doesn't take into
account the sign extension.
Appended patch should help.

Ivan.

--- 2.6/arch/alpha/kernel/module.c	Wed May 28 01:05:20 2003
+++ linux/arch/alpha/kernel/module.c	Mon Aug 11 23:23:02 2003
@@ -259,7 +259,7 @@ apply_relocate_add(Elf64_Shdr *sechdrs, 
 			*(u64 *)location = value;
 			break;
 		case R_ALPHA_GPRELHIGH:
-			value = (value - gp + 0x8000) >> 16;
+			value = (long)(value - gp + 0x8000) >> 16;
 			if ((short) value != value)
 				goto reloc_overflow;
 			*(u16 *)location = value;
