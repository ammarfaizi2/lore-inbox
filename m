Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWEBTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWEBTBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWEBTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:01:35 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:48854 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S964970AbWEBTBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:01:34 -0400
Message-ID: <4457AC8B.4050103@free.fr>
Date: Tue, 02 May 2006 21:01:31 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: john stultz <johnstul@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch broke userspace
 apps
References: <4454B4A1.4060304@free.fr> <1146593819.21288.2.camel@cog.beaverton.ibm.com> <200605022029.05333.ak@suse.de>
In-Reply-To: <200605022029.05333.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Le 02.05.2006 20:29, Andi Kleen a écrit :
> On Tuesday 02 May 2006 20:16, john stultz wrote:
> 
>> It looks like its from the patch:
>> 	i386-x86-64-fix-acpi-disabled-lapic-handling.patch
>>
>>
>> The second chunk adds:
>>
>> +       if (!cpu_has_apic)
>> +               return -ENODEV;
>> +
>>
>> Right before we probe for the ACPI PM timer.
>>
>>
>> Andi, is there some way we can move that to after the ACPI PM probe?
> 
> 
> Yes there was some merging trouble with this and some of the hunks 
> applied to the wrong places and I didn't remove the wrong one 
> in the first fixup patch. Sorry. This should fix it up.
> 
> Andrew, can you send that one to Linus please?
> 
> -Andi
> 
> Remove wrong cpu_has_apic checks that came from mismerging.
> 
> We only need to check cpu_has_apic in the IO-APIC/L-APIC parsing,
> not for all of ACPI.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/i386/kernel/acpi/boot.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/acpi/boot.c
> +++ linux/arch/i386/kernel/acpi/boot.c
> @@ -1102,9 +1102,6 @@ int __init acpi_boot_table_init(void)
>  	dmi_check_system(acpi_dmi_table);
>  #endif
>  
> -	if (!cpu_has_apic)
> -		return -ENODEV;
> -
>  	/*
>  	 * If acpi_disabled, bail out
>  	 * One exception: acpi=ht continues far enough to enumerate LAPICs
> @@ -1151,9 +1148,6 @@ int __init acpi_boot_init(void)
>  
>  	acpi_table_parse(ACPI_BOOT, acpi_parse_sbf);
>  
> -	if (!cpu_has_apic)
> -		return -ENODEV;
> -
>  	/*
>  	 * set sci_int and PM timer address
>  	 */

Hey, nice! acpi_pm clocksource came back!

FYI, here's a diff of dmesg output:

- --- /tmp/dmesg-2.6.17-rc3-mm1	2006-05-02 19:13:18.000000000 +0200
+++ /tmp/dmesg-2.6.17-rc3-mm1-patched	2006-05-02 20:52:54.000000000 +0200
@@ -1,4 +1,4 @@
- -Linux version 2.6.17-rc3-mm1 (laurent@antares.localdomain) (gcc version 4.0.3 (4.0.3-0.20060215.2mdk for Mandriva Linux release 2006.1)) #13 Mon May 1 23:37:11 CEST 2006
+Linux version 2.6.17-rc3-mm1 (laurent@antares.localdomain) (gcc version 4.0.3 (4.0.3-0.20060215.2mdk for Mandriva Linux release 2006.1)) #14 Tue May 2 20:39:28 CEST 2006
 BIOS-provided physical RAM map:
 sanitize start
 sanitize end
@@ -33,8 +33,14 @@ On node 0 totalpages: 131052
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 126956 pages, LIFO batch:31
 DMI 2.3 present.
+ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
+ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec000
+ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec080
+ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec040
+ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
+ACPI: PM-Timer IO Port: 0xe408
 Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
- -Detected 1410.372 MHz processor.
+Detected 1410.227 MHz processor.
 Built 1 zonelists
 Kernel command line: root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb6 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72
 netconsole: local port 6665
@@ -55,7 +61,7 @@ Dentry cache hash table entries: 65536 (
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
 Memory: 516072k/524208k available (1497k kernel code, 7572k reserved, 949k data, 160k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
- -Calibrating delay using timer specific routine.. 2823.26 BogoMIPS (lpj=5646521)
+Calibrating delay using timer specific routine.. 2823.18 BogoMIPS (lpj=5646365)
 Mount-cache hash table entries: 512
 CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
 CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
@@ -113,6 +119,7 @@ TCP established hash table entries: 1638
 TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
 TCP: Hash tables configured (established 16384 bind 8192)
 TCP reno registered
+Simple Boot Flag at 0x3a set to 0x1
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler anticipatory registered
@@ -166,7 +173,7 @@ TCP bic registered
 NET: Registered protocol family 1
 Using IPI Shortcut mode
 Time: tsc clocksource has been installed.
- -Time: pit clocksource has been installed.
+Time: acpi_pm clocksource has been installed.
 ACPI: (supports S0 S1 S3 S4 S5)
 BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
 RAMDISK: Compressed image found at block 0

Thanks 
- -- 
laurent
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEV6yLUqUFrirTu6IRAls0AJ4geYsJQFykMbSzzCtUrlPOzy10FACcCuHN
1xqN6vxpSF9n5Je7JSMY8GY=
=rU08
-----END PGP SIGNATURE-----
