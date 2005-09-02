Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVIBR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVIBR1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVIBR1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:27:00 -0400
Received: from ixca-out.ixiacom.com ([67.133.120.10]:8410 "EHLO
	ixca-ex1.ixiacom.com") by vger.kernel.org with ESMTP
	id S1750735AbVIBR07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:26:59 -0400
Message-ID: <43188B60.6030501@rincewind.tv>
Date: Fri, 02 Sep 2005 10:26:56 -0700
X-Sybari-Trust: 55b23c9b 453feeff 7d2c5ead 0000010c
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch-sh csum_partial_copy_generic() bugfix
References: <430E0697.5000503@rincewind.tv>
In-Reply-To: <430E0697.5000503@rincewind.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been about a week since I posted this bug report, and I haven't 
gotten any responses.  Is there someone I should contact directly?  Can 
someone please point me in the right direction?

Thanks,
Ollie

Ollie Wild wrote:

> There's a bug in Hitachi SuperH csum_partial_copy_generic() 
> implementation.  If the supplied length is 1 (and several alignment 
> conditions are met), the function immediately branches to label 4.  
> However, the assembly at label 4 expects the length to be stored in 
> register r2.  Since this has not occurred, subsequent behavior is 
> undefined.
>
> This can cause bad payload checksums in TCP connections.
>
> I've fixed the problem by initializing register r2 prior to the branch 
> instruction.
>
> Ollie
>
>------------------------------------------------------------------------
>
>diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
>--- a/arch/sh/lib/checksum.S
>+++ b/arch/sh/lib/checksum.S
>@@ -202,8 +202,9 @@ ENTRY(csum_partial_copy_generic)
> 	cmp/pz	r6		! Jump if we had at least two bytes.
> 	bt/s	1f
> 	 clrt
>+	add	#2,r6		! r6 was < 2.	Deal with it.
> 	bra	4f
>-	 add	#2,r6		! r6 was < 2.	Deal with it.
>+	 mov	r6,r2
> 
> 3:	! Handle different src and dest alignments.
> 	! This is not common, so simple byte by byte copy will do.
>  
>

