Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVCQElh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVCQElh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 23:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVCQElf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 23:41:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:42476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261527AbVCQElb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 23:41:31 -0500
Message-ID: <42390A65.7090501@osdl.org>
Date: Wed, 16 Mar 2005 20:41:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
       kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - io_remap_pfn_range
References: <E1DBX27-0000te-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1DBX27-0000te-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> This patch introduces a new interface function for mapping bus/device
> memory: io_remap_pfn_range. This accepts the same parameters as
> remap_pfn_range (indeed, by default it is implemented by this existing
> function) but should be used in any situation where the caller is not
> simply remapping ordinary RAM. For example, when mapping device
> registers the new function should be used. 
> 
> The distinction between remapping device memory and ordinary RAM is
> critical for the Xen hypervisor. This may also serve as a starting
> point for cleaning up remaining users of io_remap_page_range (in
> particular, the several sparc-specific sections in various drivers
> that use a special form of io_remap_page_range).
> 
> I have audited the drivers/ and sound/ directories. Most uses of
> remap_pfn_range are okay, but there are a small handful that are
> remapping device memory (mostly AGP and DRM drivers).
> 
> Of particular driver is the HPET driver, whose mmap function is broken
> even for native (non-Xen) builds. If nothing else, vmalloc_to_phys
> should be used instead of __pa to convert an ioremapped virtual
> address to a valid physical address. The fix in this patch is to
> remember the original bus address as probed at boot time and to pass
> this to io_remap_pfn_range.
> 
> Signed-off-by: Keir Fraser <keir@xensource.com>

Hi-

Our io_remap_pfn_range() patches don't contain many collisions.
My first patch [adding io_remap_pfn_range() to all arches]
<http://marc.theaimsgroup.com/?l=linux-mm&m=111049473410099&w=2>
does go a little further than yours in that regard.

Also, I was under the impression (only, so this is a question)
that this type of construct (from your patch):

+#ifndef io_remap_pfn_range
+#define io_remap_pfn_range remap_pfn_range
+#endif

only works for #defines (macros), while in some arches
io_remap_page_range() (and presumably io_remap_pfn_range)
is a function [sparc32/64] or inline function [mips].

My first patch referenced a future patch to convert
all callers of io_remap_page_range() to io_remap_pfn_range(),
which I have now done and built succesfully on 8 arches.
I'll post it now.

-- 
~Randy
