Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVDFIrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVDFIrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVDFIrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:47:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40964 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262148AbVDFIrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:47:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Robert Hancock <hancockr@shaw.ca>, Paul Jackson <pj@engr.sgi.com>
Subject: Re: AMD64 Machine hardlocks when using memset
Date: Wed, 6 Apr 2005 11:47:04 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <3NZDp-4yY-7@gated-at.bofh.it> <20050401201105.4a03bda1.pj@engr.sgi.com> <424E24A5.4040102@shaw.ca>
In-Reply-To: <424E24A5.4040102@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061147.04977.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[disregard my previous mail. I should have read the whole thread first]

On Saturday 02 April 2005 07:50, Robert Hancock wrote:
> As it turns out, the memset in my version of glibc x86_64 is not using 
> such a string instruction though - it seems to be using two different 
> sets of instructions depending on the size of the memset (not sure 
> exactly how they're calculating the threshold between these..) For sizes 
> below the treshold, this is the inner loop - it's using normal mov 
> instructions:
> 
> 3:	/* Copy 64 bytes.  */
> 	mov	%r8,(%rcx)
> 	mov	%r8,0x8(%rcx)
> 	mov	%r8,0x10(%rcx)
> 	mov	%r8,0x18(%rcx)
> 	mov	%r8,0x20(%rcx)
> 	mov	%r8,0x28(%rcx)
> 	mov	%r8,0x30(%rcx)
> 	mov	%r8,0x38(%rcx)
> 	add	$0x40,%rcx
> 	dec	%rax
> 	jne	3b
> 
> For sizes above the threshold though, this is the inner loop. It's using 
> movnti which is an SSE cache-bypasssing store:
> 
> 11:	/* Copy 64 bytes without polluting the cache.  */
> 	/* We could use	movntdq    %xmm0,(%rcx) here to further
> 	   speed up for large cases but let's not use XMM registers.  */
> 	movnti	%r8,(%rcx)
> 	movnti  %r8,0x8(%rcx)
> 	movnti  %r8,0x10(%rcx)
> 	movnti  %r8,0x18(%rcx)
> 	movnti  %r8,0x20(%rcx)
> 	movnti  %r8,0x28(%rcx)
> 	movnti  %r8,0x30(%rcx)
> 	movnti  %r8,0x38(%rcx)
> 	add	$0x40,%rcx
> 	dec	%rax
> 	jne	11b

This is a very rarely used instruction. People either do
plain old rep stosl or do 3DNOW or SSE2 non-temporal stores.

Maybe movnti is different (buggy?) in subtle way.

Does it blow up if you use 3DNOW or SSE2 non-temporal stores?

If yes, then try different BIOS (not nesessarily latest is best).
BTW, 'Athlon bug' was tracked down similarly. New BIOS enabled
buggy chipset feature - BOOM! non-temporals killed the box
(took several months to figure it out back then).
--
vda

