Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSG1LU0>; Sun, 28 Jul 2002 07:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSG1LU0>; Sun, 28 Jul 2002 07:20:26 -0400
Received: from mail2.alphalink.com.au ([202.161.124.58]:20799 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S315708AbSG1LUY>; Sun, 28 Jul 2002 07:20:24 -0400
Message-ID: <3D43D3ED.32D803BB@alphalink.com.au>
Date: Sun, 28 Jul 2002 21:22:21 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOAN] CONFIG_SERIAL_CONSOLE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

Russell King wrote:
> Since ppc also include{s,d} drivers/char/Config.in, this means there was
> a define_bool _and_ bool for the same configuration variable.  This sounds
> contary to the shell-nature of the configure scripts, and therefore illegal,
> and as such gets broken when changes happen.

Thanks to Russell for pointing out a problem I had not been aware of.

There are quite a few similar errors in the CML1 corpus, where a query and a
define for the same symbol exist with conditions that can overlap.  A synthetic
example of the problem is

bool 'foo' CONFIG_FOO

if [ "$CONFIG_FOO" = "y" ]; then
    define_bool CONFIG_BAR y
fi

bool 'bar' CONFIG_BAR

There are at least eight variants of this problem, depending on the order
of the query and the define, which is conditional, and whether they're in
the same menu.  All break at least one of the configurators.  The symptoms
vary in severity (mildest first)

*  .config has two copies of the correct value: BAR=y BAR=y
*  .config has two different values, correct one last: BAR=n BAR=y
*  .config has two different values, incorrect one last: BAR=y BAR=n
*  configurator incorrectly displays query and correctly prevents
   user from entering anything except the one valid value
*  configurator incorrectly does not allow user to set a valid value
*  configurator accepts a valid value from the user and saves a
   different value to the .config file.

Also it is typical that different configurators will generate different
.config files in response to the same sequence of selections.

I'm modifying gcml2 to try and detect these problems.  In the meantime, here
are some examples of this problem from 2.5.26, found using a preliminary
version of the overlap detector.

    CONFIG_ACPI_BUS
	drivers/acpi/Config.in:52
	drivers/acpi/Config.in:73
    	
    CONFIG_ACPI_BUTTON
	drivers/acpi/Config.in:57
	drivers/acpi/Config.in:77
    	
    CONFIG_ACPI_FAN
	drivers/acpi/Config.in:58
	drivers/acpi/Config.in:78

    CONFIG_ACPI_INTERPRETER
    	arch/ia64/config.in:45
	drivers/acpi/Config.in:53
	drivers/acpi/Config.in:74
    	
    CONFIG_ACPI_PCI
	drivers/acpi/Config.in:54
	drivers/acpi/Config.in:68
    	
    CONFIG_ACPI_POWER
	drivers/acpi/Config.in:55
	drivers/acpi/Config.in:75
    	
    CONFIG_ACPI_PROCESSOR
	drivers/acpi/Config.in:59
	drivers/acpi/Config.in:79

    CONFIG_ACPI_SYSTEM
	drivers/acpi/Config.in:56
	drivers/acpi/Config.in:76

    CONFIG_ACPI_THERMAL
	drivers/acpi/Config.in:60
	drivers/acpi/Config.in:80
    	
    CONFIG_ALPHA_AVANTI
    	arch/alpha/config.in:16
	arch/alpha/config.in:218

    CONFIG_ALPHA_EB64P
    	arch/alpha/config.in:16
    	arch/alpha/config.in:89

    CONFIG_ALPHA_NONAME
    	arch/alpha/config.in:16
    	arch/alpha/config.in:73

    CONFIG_BUSMOUSE
    	drivers/char/Config.in:116
    	arch/ppc/config.in:384
    
    CONFIG_CD_NO_IDESCSI
    	arch/ppc64/config.in:137
        arch/ppc64/config.in:186

    CONFIG_CD_NO_IDESCSI
    	arch/ppc/config.in:469
    	arch/ppc/config.in:506

    CONFIG_DEBUG_SPINLOCK
    	arch/x86_64/config.in:225
    	arch/x86_64/config.in:228
    
    CONFIG_DEVFS_FS
    	arch/ia64/config.in:77
	fs/Config.in:78
    
    CONFIG_FB
    	drivers/video/Config.in:8
    	arch/ppc/config.in:382

    CONFIG_IDE
    	arch/cris/config.in:147
	arch/cris/drivers/Config.in:114,130

    CONFIG_PARPORT
    	arch/cris/drivers/Config.in:97,101
	drivers/parport/Config.in:11

    CONFIG_PARPORT_1284
    	arch/cris/drivers/Config.in:98
	drivers/parport/Config.in:68

    CONFIG_PC_KEYB (mx,ds,bc,dm)
    	arch/mips/config.in:188
    	arch/mips/config.in:53
	
    CONFIG_PRINTER
    	arch/cris/drivers/Config.in:99
	drivers/char/Config.in:103

    CONFIG_MTD
    	drivers/mtd/Config.in:7
	arch/cris/drivers/Config.in:139
    		
    CONFIG_MTD_AMDSTD
    	drivers/mtd/chips/Config.in:52
	arch/cris/drivers/Config.in:145
    		
    CONFIG_MTD_BLOCK
    	drivers/mtd/Config.in:23
	arch/cris/drivers/Config.in:148
    		
    CONFIG_MTD_CHAR
    	drivers/mtd/Config.in:22
	arch/cris/drivers/Config.in:147
    		
    CONFIG_MTD_CFI
    	drivers/mtd/chips/Config.in:9
	arch/cris/drivers/Config.in:141
    		
    CONFIG_MTD_CFI_AMDSTD
    	drivers/mtd/chips/Config.in:45
	arch/cris/drivers/Config.in:143
    		
    CONFIG_MTD_CFI_INTELEXT
    	drivers/mtd/chips/Config.in:44
	arch/cris/drivers/Config.in:142
    		
    CONFIG_MTD_PARTITIONS
    	drivers/mtd/Config.in:14
	arch/cris/drivers/Config.in:149
    		
    CONFIG_SOUND_CMPCI_FMIO
	sound/oss/Config.in:14
	sound/oss/Config.in:15
    	
    CONFIG_SYSCLK_100
    	arch/mips/config.in:140
    	arch/mips/config.in:24

    CONFIG_VIDEO_SELECT
	drivers/video/Config.in:101
	arch/i386/config.in:387

    CONFIG_VIDEO_SELECT
    	drivers/video/Config.in:101
    	arch/x86_64/config.in:196


Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.	   - Roger Sandall, The Age, 28Sep2001.
