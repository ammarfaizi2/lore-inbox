Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUJGRGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUJGRGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUJGREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:04:11 -0400
Received: from [195.23.16.24] ([195.23.16.24]:37008 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267514AbUJGQj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:39:57 -0400
Message-ID: <41657158.6000909@grupopie.com>
Date: Thu, 07 Oct 2004 17:39:52 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Richard Earnshaw <Richard.Earnshaw@arm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain> <loom.20041005T130541-400@post.gmane.org> <20041005125324.A6910@flint.arm.linux.org.uk> <1096981035.14574.20.camel@pc960.cambridge.arm.com> <20041005141452.B6910@flint.arm.linux.org.uk> <1097016532.32500.357.camel@localhost.localdomain> <41653814.1060405@grupopie.com> <20041007160108.B8579@flint.arm.linux.org.uk>
In-Reply-To: <20041007160108.B8579@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.5; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Oct 07, 2004 at 01:35:32PM +0100, Paulo Marques wrote:
> 
>>The patch by Russel King seems ok to me, although I prefer Rusty's idea 
>>of not using any symbol that is not in the form "[A-Za-z0-9_]+". We just 
>>need to check if there are any real world users of these "weird" symbols.
> 
> 
> This may filter out too much - we have symbols starting with a '.' on
> ARM, particularly used in some of the assembly code, which are useful
> to be decoded back to names, such as ".bug".
> 
> However, including "." means that names like "__func__.0" also get
> included, which is probably a bad thing.  So, maybe it needs to be
> 
> [A-Za-z0-9_\.][A-Za-z0-9_]*

I just checked a "nm -n vmlinux" output on a x86 2.6.9-rc3-mm2 defconfig 
kernel and it has stuff like:

...
c01aed13 t .text.lock.transaction
c01b1db3 t .text.lock.checkpoint
...
c03c7708 r single_rates.0
c03c7714 r double_rate_channels.1
...
c0482280 d get_s16_labels.0
c04822c0 d put_s16_labels.1
c0482300 d get_s16_labels.2
c0482340 d put_s16_labels.3
...
c053d780 b nulldevname.1
c053d800 b bootstrap.2
...

Most of these seem like useful information (although I personally don't 
have any use for them).

The 'b' and 'r' types only get in if CONFIG_KALLSYMS_ALL is specified.

There were 572 "__func__.*" symbols all with type 'r'. If we take into 
account that there were a total of 32881 symbols, these 572 are not that 
many. Even more, with the new compression scheme they would probably 
take only about 3 bytes per symbol to store the name and 4 bytes for the 
address (8 on 64 bit architectures) that would require about 4kb of data 
  for users that choose the CONFIG_KALLSYMS_ALL option. Removing the 
"__func__" symbols would represent less than a 2% decrease in size.

So maybe we could use "[A-Za-z0-9_\.]+" ?

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
