Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbUDOP2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbUDOP2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:28:40 -0400
Received: from mail.shareable.org ([81.29.64.88]:11938 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264320AbUDOP2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:28:15 -0400
Date: Thu, 15 Apr 2004 16:26:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: davidm@hpl.hp.com
Cc: linux-ia64@linuxia64.org, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
Message-ID: <20040415152600.GA18331@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com> <20040414082355.GA8303@mail.shareable.org> <20040414113753.GA9413@mail.shareable.org> <16509.25006.96933.584153@napali.hpl.hp.com> <20040414184603.GA12105@mail.shareable.org> <16509.35554.807689.904871@napali.hpl.hp.com> <20040414192844.GD12105@mail.shareable.org> <16509.39308.8764.219@napali.hpl.hp.com> <20040414210538.GG12105@mail.shareable.org> <16509.48237.556502.218222@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16509.48237.556502.218222@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>   >> No, Alpha Linux didn't map data without execute permission.
> 
>   Jamie> That was true from Linux 1.1.67 (when Alpha was introduced)
>   Jamie> to 1.1.84 (when __[PS]* was introduced).  I'm not sure the
>   Jamie> Alpha target even worked during those versions.  Since Linux
>   Jamie> 1.1.84, it has mapped pages on the Alpha without execute
>   Jamie> permission: the _PAGE_FOE (fault on exec) bit is set for
>   Jamie> mappings which don't have PROT_EXEC.
> 
> $ uname -a
> Linux hostname 2.2.20 #2 Wed Mar 20 19:57:28 EST 2002 alpha GNU/Linux
> $ cat /proc/self/maps | grep cat
> 0000000120000000-0000000120006000 r-xp 0000000000000000 08:01 309740     /bin/cat
> 0000000120014000-0000000120016000 rwxp 0000000000004000 08:01 309740     /bin/cat
> 
> As you can see, the data-segment is mapped with EXEC bit turned on.
> Ditto for the stack segment, which I think is this one:
> 
> 000000011fffe000-0000000120000000 rwxp 0000000000000000 00:00 0

Lest we get more wires crossed, the "x" in /proc/self/maps indicates
that userspace _requested_ executable mapping with PROT_EXEC.

It is independent of whether the kernel and hardware can grant a
non-executable mapping.  On my Athlon:

08048000-0804c000 r-xp 00000000 03:02 95153      /bin/cat
0804c000-0804d000 rw-p 00003000 03:02 95153      /bin/cat
bfffe000-c0000000 rwxp fffff000 00:00 0

The stack is mapped executable, and the data segment is mapped
non-executable, according to /proc/self/maps which reflects the
PROT_EXEC request.  But in fact because of hardware limitations,
despite the "rw-p" my data segment is actually executable.

If you map a segment without PROT_EXEC on Alpha, using a kernel newer
than 1.1.84, you'll get a non-executable mapping.  That's what I mean
when I say the Alpha maps data without executable permission.  The ELF
loader appears to ask for exec permission anyway, which is another
thing entirely.

-- Jamie
