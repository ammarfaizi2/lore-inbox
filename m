Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUGAO0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUGAO0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUGAO0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:26:13 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:20939 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S265360AbUGAO0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:26:06 -0400
Date: Thu, 1 Jul 2004 15:26:04 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701142604.GA24713@malvern.uk.w2k.superh.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701032606.GA1564@mail.shareable.org>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 01 Jul 2004 14:28:11.0655 (UTC) FILETIME=[A32C4170:01C45F77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

* Jamie Lokier <jamie@shareable.org> [2004-07-01]:
> 
> I've just written a thorough test.  The attached program tries every
> combination of PROT_* flags, and tells you what protection you really get.
> 
> It'll be interesting to see the results on other architectures.

I've got this working on sh64/2.6 (which was only merged a couple of
days ago); here are the results:

Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
========================================================================
MAP_SHARED     | ---    r--    -w-    rw-    r-x    r-x    rwx    rwx
MAP_PRIVATE    | ---    r--    -w-    rw-    r-x    r-x    rwx    rwx

Although the hardware is capable of distinguish R and X, the kernel
always allows R if X is specified to mmap().  This is for 2 reasons :

1. jump tables for switch() get embedded into the code in 32-bit
   (SHmedia) mode
2. constant pools embedded in the code in 16-bit (SHcompact, i.e. SH-4
   compatible) mode

so in practice an exec-only page is pretty useless to a typical userland
program.

> This program should hopefully run on all architectures, however it
> does depend on an empty function working when relocated.

The empty function relocated fine.  But I had to make 2 trivial changes to
handle using &void_function as an argument to memcpy and when casting
addr to a function pointer.  These result from the way the SH-5 uses the
LSB in function addresses and branch targets to switch between the
SHmedia and SHcompact instruction sets.  (I can send you the patch if you
want.)

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
