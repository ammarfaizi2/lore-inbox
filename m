Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUBVPtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUBVPtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:49:22 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:36833 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261570AbUBVPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:49:19 -0500
Date: Sun, 22 Feb 2004 07:49:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>, Steve Kieu <haiquy@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@linuxtestproject.org>
Subject: Re: 2.6.3-mjb1  vmware modules compile error..
Message-ID: <35790000.1077464951@[10.10.2.4]>
In-Reply-To: <20040222042853.GD7483@vana.vc.cvut.cz>
References: <20040222011344.GB7483@vana.vc.cvut.cz> <20040222034938.1016.qmail@web10407.mail.yahoo.com> <20040222042853.GD7483@vana.vc.cvut.cz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> bash-2.05b# make      
>> Unable to find VMware installation database. Using
>> 'vmware'.
>> Building for VMware Workstation 3.2.0.
>> Using 2.6.x kernel build system.
>> make -C /lib/modules/2.6.1-mm4/build/include/..
>> SUBDIRS=$PWD SRCROOT=$PWD/. modu
>> les
>> make[1]: Entering directory `/vol/hdb5/linux'
>> *** Warning: Overriding SUBDIRS on the command line
>> can cause
>> ***          inconsistencies
>> make[2]: `arch/i386/kernel/asm-offsets.s' is up to
>> date.
>>   CHK     include/asm-i386/asm_offsets.h
>>   CC [M]  /root/vmmon-6/linux/driver.o
>> driver.c:7:27: driver-config.h: No such file or
>> directory
> 
>> I just extract the vmmon.tar from the vmware-any---
>> package and run make in the source dir. It works with
>> all vanila kernels and mm tree, but not with mjb1.
> 
> WTF? It prepends $(TOPDIR)/ to all include paths. I have
> no idea what is this supposed to do, but I can guarantee
> that I'm not going to support that kernel.
> 				Petr Vandrovec
> 

Sigh. That's gcov. Paul, any idea why it's doing that?

M.


> diff -purN -X /home/mbligh/.diff.exclude 000-virgin/scripts/Makefile.build 790-irq_vector/scripts/Makefile.build
> --- 000-virgin/scripts/Makefile.build   2003-10-14 15:50:40.000000000 -0700
> +++ 790-irq_vector/scripts/Makefile.build       2004-02-18 16:23:03.000000000 -0800
> @@ -128,7 +128,16 @@ cmd_cc_i_c       = $(CPP) $(c_flags)   -
>  quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
> 
>  ifndef CONFIG_MODVERSIONS
> -cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
> +new1_c_flags = $(c_flags:-I%=-I$(TOPDIR)/%)
> +new2_c_flags = $(new1_c_flags:-Wp%=)
> +PWD = $(TOPDIR)
> +
> +quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
> +cmd_cc_o_c = $(CC) $(c_flags) -E -o $@ $< \
> +               && cd $(dir $<) \
> +               && $(CC) $(new2_c_flags) -c -o $(notdir $@) $(notdir $<) \
> +               && cd $(TOPDIR)
> +#cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
> 
>  else
>  # When module versioning is enabled the following steps are executed:

