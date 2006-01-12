Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWALBVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWALBVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWALBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:21:42 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:4175 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964940AbWALBVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:21:41 -0500
X-IronPort-AV: i="3.99,357,1131350400"; 
   d="scan'208"; a="1765839047:sNHT1589919962"
To: Andi Kleen <ak@suse.de>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
X-Message-Flag: Warning: May contain useful information
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
	<200601120156.11529.ak@suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 11 Jan 2006 17:21:20 -0800
In-Reply-To: <200601120156.11529.ak@suse.de> (Andi Kleen's message of "Thu,
 12 Jan 2006 01:56:11 +0100")
Message-ID: <adaace2i6lr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 12 Jan 2006 01:21:25.0654 (UTC) FILETIME=[81882360:01C61716]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> At least some people have complained about the "All Rights
    Andi> reserved" in the past. Best you drop it.

There are hundreds of files in the kernel with "all rights reserved"
as part of the copyright, including things merged as recently as
ocfs2.  I don't see how this could possibly be an issue.

    Andi> 1? If it's called memcpy it should get a byte argument, no? 
    Andi> If not name it something else, otherwise everybody will be
    Andi> confused.

The kernel doc for the function says

+ * @count: number of 32-bit quantities to copy

but maybe that's not the clearest way to define such a function.

    Andi> movsq? I thought you wanted 32bit IO?

The idea is to do I/O in at least 32-bit chunks to cope with hardware
that can't handle 8-bit or 16-bit accesses.  64-bit chunks are OK for
Pathscale hardware.

    Andi> The movsd also looks weird.

I think it's OK.  The code is doing:

 > +	movl %edx,%ecx
 > +	shrl $1,%ecx
 > +	andl $1,%edx
 > +	rep movsq
 > +	movl %edx,%ecx
 > +	rep movsd
 > +	ret

so it does the copy in 64-bit chunks, and then it does "rep movsd" to
copy either 0 or 1 more 32-bit words.

 - R.
