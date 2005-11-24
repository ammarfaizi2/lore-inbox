Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbVKXHrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVKXHrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVKXHrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:47:32 -0500
Received: from magic.adaptec.com ([216.52.22.17]:10633 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932626AbVKXHrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:47:31 -0500
Date: Thu, 24 Nov 2005 13:24:20 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-kernel@vger.kernel.org
Subject: Why does insmod _not_ check for symbol redefinition ??
Message-ID: <Pine.LNX.4.44.0511241316460.28640-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2005 07:47:28.0948 (UTC) FILETIME=[51B08F40:01C5F0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
     Let me start by saying that, if we have compiled functionality
X as a built-in part of kernel, and then if we try to load X compiled 
as a module, we get _bad_ results, varying from weird behaviour to 
upfront crashes. 
        The question is : Why does insmod not check for redefinition 
of symbols and hence disallow module loading in such cases ?

For the records, the kernel version I'm using is some flavour of
2.6.9.

        I understand that this is a very basic thing and the kernel 
module subsystem authors would have thought about it and if it behaves 
this way, it would more likely be a feature. I am keenly interested 
in knowing the rationale behind it.

        On my setup, SCSI midlayer was compiled as part of kernel proper
and then the initrd tried to load scsi_mod.ko as a module also (which was 
present in initrd as I accidently used a wrong initrd). I would expect
this to result in insmod failure due to redefinition of various 
functions already exported by the SCSI mid-layer (which is part of 
kernel proper).
        What actually happened is that the scsi_mod.ko module got loaded 
and its init_module() function was called, which apart from lot of other
things, called kmem_cache_create() to create a slab cache. Since the slab 
cache with the same name was already present (the first one was created 
when the SCSI midlayer init function was called as part of kernel proper
initialization), this triggered a BUG.                
       When I checked for the exported SCSI midlayer symbols in 
/proc/kallsyms I saw duplicate symbols for all the SCSI midlayer symbols, 
one in the kernel text segment 0xcXXXXXXX and the other in the module
text segment (this one was 0xeXXXXXXX). 
        I tried this with other components (ext3, jbd, e1000 etc) and the
results were the same; the module gets loaded on top of the builtin 
functionality resulting in multiple definitions of the EXPORTed symbols.
I've tried the same thing on 2.4.20 kernel with _same_ results.
Since we see the same behaviour with different kernels, it is not specific
to a particular kernel.


Thanx,
Tomar




-- "Theory is when you know something, but it doesn't work.
    Practice is when something works, but you don't know why.
    Programmers combine theory and practice: Nothing works 
    and they don't know why ..."

