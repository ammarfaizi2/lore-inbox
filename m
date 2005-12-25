Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVLYCn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVLYCn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 21:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLYCn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 21:43:26 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:8622 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVLYCnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 21:43:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=fMkFtDGxMgisIaSFlmxcS5xWeo+mUIpSnX739swlQV2FsACallpEaOLerkZuvHEIDrUqi+bZ+ahxApCRN1n20u2GX+aR/tci4sSO4cla6jLyWaoepOrTDfBpTgtpR6IR9ooW4gtJ+BpJ9lEhH68FUL6J7L/W4ipdNLfZvLjMHlE=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: 4k stacks
Date: Sat, 24 Dec 2005 21:43:09 -0500
User-Agent: KMail/1.8.3
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512241403.38482.vda@ilport.com.ua>
In-Reply-To: <200512241403.38482.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512242143.10291.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2005 07:03, Denis Vlasenko wrote:
> +       movl    %esp, %edi
> +       movl    %edi, %ecx
> +       andl    $~0x1000, %edi
> +       subl    %edi, %ecx
> 
> ecx will be equal to ?

0x1000 with 8k stacks, so long as %esp in in the top page of the 2 page
stack. 0x0 otherwise. Which explains why the poisoning crashes the kernel
with 4k stacks. 

But there's another problem with Dick Johnson's approach, and that is that
he doesn't clear the poison when a kernel stack is freed. (I don't believe
the kernel does this automatically, though I could be mistaken). And that
means that the results can't be trusted: if you have a string of 20 Qs,
_something's_ overwritten the rest, but that something wasn't necessarily
using the memory as a stack at the time. More than that, with the Qs
spread over two pages it's quite possible for one page to be overwritten
and the other still free with it's 20 or so Qs.

HTH,
Andrew Wade
