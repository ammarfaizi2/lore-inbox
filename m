Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSHCFNo>; Sat, 3 Aug 2002 01:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSHCFNo>; Sat, 3 Aug 2002 01:13:44 -0400
Received: from mx2.fuse.net ([216.68.1.120]:62351 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S317495AbSHCFNO>;
	Sat, 3 Aug 2002 01:13:14 -0400
Message-ID: <3D4B673D.4050507@fuse.net>
Date: Sat, 03 Aug 2002 01:16:45 -0400
From: Nathaniel <wfilardo@fuse.net>
Organization: BentTroll Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.5.30
References: <Pine.LNX.4.33.0208021424520.2532-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On 2 Aug 2002, Alan Cox wrote:
> 
>>The PnPBIOS gdt setup changes I did are wrong somewhere.
> 
> 
> Alan, in your PnP patches you seem to have changed the 
> 
> 	"set_limit()"
> 
> to a 
> 
> 	"_set_limit()"
> 
> which looks wrong (or at least doesn't look consistent with the notion of 
> just doing the same code as before, except on all CPU's).
> 
> It _looks_ to me like the QX_SET_SET() macros should be have the "_" 
> removed from the set_limit part. As it is, _set_limit() gets the address 
> calculations wrong (because you don't cast it to "char *") and also gets 
> the limit wrong (because you no longer do the page size adjustment).
> 
> Does it work with that small change? I have no idea about the pnpbios 
> code, I'm just looking at Alan's diff.

Applying the following change will make 2.5.30 get past the PNPBIOS load (at least on my box).

However, it still doesn't work (I'll post something later).

That said, here:

--- linux-2.5.30/drivers/pnp/pnpbios_core.c.orig        Sat Aug  3 01:13:48 2002
+++ linux-2.5.30/drivers/pnp/pnpbios_core.c     Sat Aug  3 01:13:20 2002
@@ -126,11 +126,11 @@

  #define Q_SET_SEL(cpu, selname, address, size) \
  set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-_set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)

  #define Q2_SET_SEL(cpu, selname, address, size) \
  set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-_set_limit((char *)&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)

  /*
   * At some point we want to use this stack frame pointer to unwind


--Nathan


