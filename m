Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290839AbSBFWGh>; Wed, 6 Feb 2002 17:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290840AbSBFWGZ>; Wed, 6 Feb 2002 17:06:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19467 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290839AbSBFWGW>; Wed, 6 Feb 2002 17:06:22 -0500
Message-ID: <3C61A8C0.7000406@zytor.com>
Date: Wed, 06 Feb 2002 14:05:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com> <20020206132144.A29162@hq.fsmlabs.com> <a3s5gs$94v$1@cesium.transmeta.com> <20020206163118.E21624@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:

> 
>>b) Have the kernel provide another GDT value which can be used by the
>>   single-threaded apps.
>>
> 
> Like above, a fixed address for mmap would have to be chosen, but the
> advantage would be that the TLS ABI would need no changing.
> Simply kernel would add 0x33 to GDT as 4KB -> 0xc0000000 user data segment
> and apps could put that value into %gs if not using threads.
> 
> But I think there is c) and d).
> c) is just minor modification of current ldt handling in kernel, which would
>    mean a single entry LDT (residing in task_struct) could be used instead
>    of vmalloced one - this has the disadvantage of lldt on almost every
>    context switch
> d) default to a single-entry per-cpu LDT, which only non-linux personality
>    apps and apps needing more than 1 LDT entry (threaded apps, wine/dosemu/...)
>    would not use. Non-linux apps would use current default_ldt and those
>    needing more than one LDT would use the current vmalloced mm private area.
>    If a task would be using this per-cpu LDT (common case), context switch
>    would do lldt only if previous task was not using the per-cpu LDT
>    (unlikely) and just store task_struct->thread.ldt_word_0 and ldt_word_1
>    into the per-cpu LDT (dunno how expensive is that, but IMHO it should be
>    cheaper than full load_LDT).
> 


Actually d) is probably better done by allowing CPUs to put *one* entry in
the GDT instead of requesting an LDT.  Since the LDT takes up a GDT entry
anyway, this should be simple enough.

	-hpa



