Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVI3NOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVI3NOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVI3NOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:14:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35287 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030293AbVI3NOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:14:54 -0400
Date: Fri, 30 Sep 2005 09:14:51 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Virtual Memory Mapping...!
Message-ID: <20050930131451.GV1020@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <7EC22963812B4F40AE780CF2F140AFE9168302@IN01WEMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE9168302@IN01WEMBX1.internal.synopsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 06:28:58PM +0530, Arijit Das wrote:
> I have RH3.0 installed in an AMD64 machine. 
>  
> In this system, when I look at the virtual address space mappings of a
> process (say a sleep process), I see quite a few strange memory region
> mappings which are neither readable, nor writable/executable and all of
> them are Private (i.e. unshared). Check this:
>  
>       1024    ---p    /lib64/tls/libc-2.3.2.so
>       1024    ---p    /lib64/tls/libm-2.3.2.so
>       1024    ---p    /lib64/tls/librtkaio-2.3.2.so
>       1024    ---p    /lib64/tls/libpthread-0.60.so

Those are PROT_NONE mapping.  As x86-64 has far bigger ELF page size
than the actual hardware page size commonly used ATM, there is usually
a gap between read-only/execute and read-write ELF segments.
It is undesirable to map anything in there (e.g. exception handling
would be very upset if you mapped a really small shared library in the
hole inside of another shared library) and PROT_NONE mapping prevents that.
If you strace some small process, you'll see that creating them is at most
as expensive as would be unmapping the regions.

	Jakub
