Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVKURw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVKURw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVKURwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:52:55 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:21514 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932455AbVKURwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:52:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200511191644.03330.vda@ilport.com.ua>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <200511181351.41159.vda@ilport.com.ua> <Pine.LNX.4.61.0511180904470.4215@chaos.analogic.com> <200511191644.03330.vda@ilport.com.ua>
X-OriginalArrivalTime: 21 Nov 2005 17:52:52.0087 (UTC) FILETIME=[64BA7870:01C5EEC4]
Content-class: urn:content-classes:message
Subject: Re: Compaq Presario "reboot" problems
Date: Mon, 21 Nov 2005 12:52:51 -0500
Message-ID: <Pine.LNX.4.61.0511211246390.14321@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq Presario "reboot" problems
Thread-Index: AcXuxGTEtvh1szP3RQWb1StdVyGiHA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Nov 2005, Denis Vlasenko wrote:

> On Friday 18 November 2005 16:15, linux-os (Dick Johnson) wrote:
>> On Fri, 18 Nov 2005, Denis Vlasenko wrote:
>>
>>> On Thursday 17 November 2005 20:51, linux-os (Dick Johnson) wrote:
>>>> It appears as though Linux is still restarting as a "warm boot",
>>>> rather than a cold boot (in other words, putting magic in the
>>>> shutdown byte of CMOS) so the hardware doesn't get properly
>>>> initialized. Would somebody please check this out. When changing
>>>> operating systems, you need a cold-boot.
>>>
>>> Can you check which driver does that? The test would be to
>>> boot a special Linux setup which reboots immediately
>>> (say, wuth init=/some/reboot_script.sh boot param).
>>>
>>> Then start removing drivers from kernel until you
>>> can boot Win successfully after Linux reboots.
>>> --
>>> vda
>>
>> I booted into a shell from a floppy disk. There were no drivers
>> installed, not even the IDE driver. I could not reboot windows
>> after linux was up and rebooted. This was Linux-2.6.13.4. Then
>> I tried linux-2.4.26 which corresponds to the version when I
>> first reported this problem. The same thing happens. Therefore,
>> I temporarily modified linux-2.6.13.4 to force a triple-fault
>> and processor reset when doing a reboot. With this temporary
>> modification it is possible to boot windows after Linux was
>> running.
>>
>> This is the reboot patch. It is not a "solution", just something
>> that shows that the current reboot code doesn't force the BIOS
>> to start from scratch, which is essential when changing operating
>> systems.
>>
>>
>> --- linux-2.6.13.4/arch/i386/kernel/reboot.c.orig	2005-11-18 08:29:12.000000000 -0500
>> +++ linux-2.6.13.4/arch/i386/kernel/reboot.c	2005-11-18 08:52:40.000000000 -0500
>> @@ -337,6 +337,11 @@
>>
>>   void machine_restart(char * __unused)
>>   {
>> +        for(;;) {
>> +	__asm__ __volatile__("\tmovl %cr0, %eax\n"
>> +			     "\tandl $~0x80000000,  %eax\n"
>> +			     "\tmovl %eax, %cr0\n");
>> +        }
>>   	machine_shutdown();
>>   	machine_emergency_restart();
>>   }
>
> Does reboot=cb ('cold', 'thru BIOS') work for you?
>
> I read arch/i386/kernel/reboot.c and it looks like reboot=cb
> kernel param will triple fault too:
>
> static int reboot_mode;
> static int reboot_thru_bios;
>
> static int __init reboot_setup(char *str)
> {
>        while(1) {
>                switch (*str) {
>                case 'w': /* "warm" reboot (no memory testing etc) */
>                        reboot_mode = 0x1234;
>                        break;
>                case 'c': /* "cold" reboot (with memory testing etc) */
>                        reboot_mode = 0x0;
>                        break;
>                case 'b': /* "bios" reboot by jumping through the BIOS */
>                        reboot_thru_bios = 1;
>                        break;
>                case 'h': /* "hard" reboot by toggling RESET and/or crashing the CPU */
>                        reboot_thru_bios = 0;
>                        break;
>                }
>                if((str = strchr(str,',')) != NULL)
>                        str++;
>                else
>                        break;
>        }
>        return 1;
> }
>
> __setup("reboot=", reboot_setup);
> ...
> void machine_emergency_restart(void)
> {
>        if (!reboot_thru_bios) {
>                if (efi_enabled) {
>                        efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
>                        load_idt(&no_idt);
>                        __asm__ __volatile__("int3");
>                }
>                /* rebooting needs to touch the page at absolute addr 0 */
>                *((unsigned short *)__va(0x472)) = reboot_mode;
>                for (;;) {
>                        mach_reboot_fixups(); /* for board specific fixups */
>                        mach_reboot();
>                        /* That didn't work - force a triple fault.. */
>                        load_idt(&no_idt);
>                        __asm__ __volatile__("int3");
>                }
>        }
>        if (efi_enabled)
>                efi.reset_system(EFI_RESET_WARM, EFI_SUCCESS, 0, NULL);
>
>        machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
> }
>
> void machine_restart(char * __unused)
> {
>        machine_shutdown();
>        machine_emergency_restart();
> }
>
>
> If it does not, try this reboot=tc - this is closely resembles
> what you proposed in your mail (pseudo-patch):
>
> static int __init reboot_setup(char *str)
> {
>        while(1) {
>                switch (*str) {
> +               case 't': /* "triple fault" reboot */
> +                       reboot_thru_bios = 2;
> +                       break;
>                case 'w': /* "warm" reboot (no memory testing etc) */
>                        reboot_mode = 0x1234;
>                        break;
> ...
> void machine_emergency_restart(void)
> {
> +       if (reboot_thru_bios == 2) {
> +               *((unsigned short *)__va(0x472)) = reboot_mode;
> +               load_idt(&no_idt);
> +               __asm__ __volatile__("int3");
> +	}
>        if (!reboot_thru_bios) {
>                if (efi_enabled) {
>                        efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
> --
> vda

I don't know how to make `reboot` or `init 0` take the required
parameters! I don't know how to get from user-mode into the kernel
code with any such parameters. I looked through `proc` and couldn't
find anything for such parameters either:

Script started on Mon 21 Nov 2005 12:42:11 PM EST
[root@chaos root]# reboot=cb
[root@chaos root]# strace reboot=cb
strace: reboot=cb: command not found
[root@chaos root]# strace reboot -cb
execve("/sbin/reboot", ["reboot", "-cb"], [/* 22 vars */]) = 0
uname({sys="Linux", node="chaos.analogic.com", ...}) = 0
brk(0)                                  = 0x804b000
open("/etc/ld.so.preload", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0666, st_size=0, ...}) = 0
close(3)                                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=123802, ...}) = 0
old_mmap(NULL, 123802, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f3e000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300{\230"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1455084, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f3d000
old_mmap(0x4a973000, 1158124, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4a973000
old_mmap(0x4aa88000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x115000) = 0x4aa88000
old_mmap(0x4aa8c000, 7148, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4aa8c000
close(3)                                = 0
mprotect(0x4aa88000, 8192, PROT_READ)   = 0
mprotect(0x4a96b000, 4096, PROT_READ)   = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f3d540, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f3e000, 123802)              = 0
geteuid32()                             = 0
write(2, "usage: reboot [-n] [-w] [-d] [-f"..., 44usage: reboot [-n] [-w] [-d] [-f] [-i] [-p]
) = 44
write(2, "\t\t  -n: don\'t sync before reboot"..., 47		  -n: don't sync before rebooting the system
) = 47
write(2, "\t\t  -w: only write a wtmp reboot"..., 50		  -w: only write a wtmp reboot record and exit.
) = 50
write(2, "\t\t  -d: don\'t write a wtmp recor"..., 35		  -d: don't write a wtmp record.
) = 35
write(2, "\t\t  -f: force halt/reboot, don\'t"..., 48		  -f: force halt/reboot, don't call shutdown.
) = 48
write(2, "\t\t  -p: power down the system (i"..., 62		  -p: power down the system (if possible, otherwise reboot)
) = 62
exit_group(1)                           = ?
[root@chaos root]#
[root@chaos root]# exit
exit

Script done on Mon 21 Nov 2005 12:43:09 PM EST


`man reboot` doesn't show any parameters.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.52 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
