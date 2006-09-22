Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWIVIKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWIVIKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWIVIKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:10:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:23698 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750897AbWIVIJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:09:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=OFUIojXSFRqFojViYkVUEgRE+AeTG5Ux27176GkZH4brnjVy0fC4x9FGdZozWKOFoLOV0g0FKxOxmmiFnmTQDnEErc+a8Jq1um+JzNVl5ppKAPt++rFThRxUxjG+S2DJvtYwuLCnUk5XkB7otKFsSg023l15cfse5TrCtxrz0bU=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 0/3] make mdelay, udelay and ssleep calls smaller
Date: Fri, 22 Sep 2006 10:03:53 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609221003.53235.vda.linux@googlemail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

This version is basically unchanged except for rediff
against 2.6.18. I was running previous version for
several weeks on 2.6.17.x kernels.

Russell King was giving me some feedback. I think that
my reply satisfied him - I got no further comments:

On Wednesday 23 August 2006 10:39, Denis Vlasenko wrote:
>On Wednesday 23 August 2006 10:14, Russell King wrote:
>> Please keep a "const" version in ARM.  Thanks.
>
> Why do you want to keep it?
> I mean, without it udelay(n) will become slower by the time
> needed for one extra multiply. So we will have maybe
> udelay(n) ==> udelay(n+0.1).
>
>> Since the multiply is pure overhead, it's better
>> to get rid of it. 
>
>You do not need to optimize delay for speed. If you
>really want to, then you can do:
>
>#define udelay(n) do {} while(0)
>
>Makes sense? No it does not. That's what I'm trying to say.
>You WANT to pause for thousands of cycles. Why you are trying
>to shave off ~10 cycles at the very same time?
>
>Hope it makes things clearer.



On with patch explanation:

Currently, magic in include/linux/delay.h
inlines mdelay and ssleep, and various arches
do the same to udelay.

This is pointless. We are going to perform a delay of 1000+
CPU cycles anyway, no need to optimize away a few cycles.

This patchset converts magic calls to these inlines/macros
into pure and simple function calls, with no additional
math done or hidden arguments pushed to stack
at the callsite.

Reduces allyesconfig kernel by about 7 kb.

Signed-off-by: Denis Vlasenko <vda.linux@googlemail.com>
--
vda
