Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVKSOo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVKSOo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 09:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKSOo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 09:44:26 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28374 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751125AbVKSOo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 09:44:26 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: Compaq Presario "reboot" problems
Date: Sat, 19 Nov 2005 16:44:03 +0200
User-Agent: KMail/1.8.2
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <200511181351.41159.vda@ilport.com.ua> <Pine.LNX.4.61.0511180904470.4215@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511180904470.4215@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511191644.03330.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 16:15, linux-os (Dick Johnson) wrote:
> On Fri, 18 Nov 2005, Denis Vlasenko wrote:
> 
> > On Thursday 17 November 2005 20:51, linux-os (Dick Johnson) wrote:
> >> It appears as though Linux is still restarting as a "warm boot",
> >> rather than a cold boot (in other words, putting magic in the
> >> shutdown byte of CMOS) so the hardware doesn't get properly
> >> initialized. Would somebody please check this out. When changing
> >> operating systems, you need a cold-boot.
> >
> > Can you check which driver does that? The test would be to
> > boot a special Linux setup which reboots immediately
> > (say, wuth init=/some/reboot_script.sh boot param).
> >
> > Then start removing drivers from kernel until you
> > can boot Win successfully after Linux reboots.
> > --
> > vda
> 
> I booted into a shell from a floppy disk. There were no drivers
> installed, not even the IDE driver. I could not reboot windows
> after linux was up and rebooted. This was Linux-2.6.13.4. Then
> I tried linux-2.4.26 which corresponds to the version when I
> first reported this problem. The same thing happens. Therefore,
> I temporarily modified linux-2.6.13.4 to force a triple-fault
> and processor reset when doing a reboot. With this temporary
> modification it is possible to boot windows after Linux was
> running.
> 
> This is the reboot patch. It is not a "solution", just something
> that shows that the current reboot code doesn't force the BIOS
> to start from scratch, which is essential when changing operating
> systems.
> 
> 
> --- linux-2.6.13.4/arch/i386/kernel/reboot.c.orig	2005-11-18 08:29:12.000000000 -0500
> +++ linux-2.6.13.4/arch/i386/kernel/reboot.c	2005-11-18 08:52:40.000000000 -0500
> @@ -337,6 +337,11 @@
> 
>   void machine_restart(char * __unused)
>   {
> +        for(;;) {
> +	__asm__ __volatile__("\tmovl %cr0, %eax\n"
> +			     "\tandl $~0x80000000,  %eax\n"
> +			     "\tmovl %eax, %cr0\n");
> +        }
>   	machine_shutdown();
>   	machine_emergency_restart();
>   }

Does reboot=cb ('cold', 'thru BIOS') work for you?

I read arch/i386/kernel/reboot.c and it looks like reboot=cb
kernel param will triple fault too:

static int reboot_mode;
static int reboot_thru_bios;

static int __init reboot_setup(char *str)
{
        while(1) {
                switch (*str) {
                case 'w': /* "warm" reboot (no memory testing etc) */
                        reboot_mode = 0x1234;
                        break;
                case 'c': /* "cold" reboot (with memory testing etc) */
                        reboot_mode = 0x0;
                        break;
                case 'b': /* "bios" reboot by jumping through the BIOS */
                        reboot_thru_bios = 1;
                        break;
                case 'h': /* "hard" reboot by toggling RESET and/or crashing the CPU */
                        reboot_thru_bios = 0;
                        break;
                }
                if((str = strchr(str,',')) != NULL)
                        str++;
                else
                        break;
        }
        return 1;
}

__setup("reboot=", reboot_setup);
...
void machine_emergency_restart(void)
{
        if (!reboot_thru_bios) {
                if (efi_enabled) {
                        efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
                        load_idt(&no_idt);
                        __asm__ __volatile__("int3");
                }
                /* rebooting needs to touch the page at absolute addr 0 */
                *((unsigned short *)__va(0x472)) = reboot_mode;
                for (;;) {
                        mach_reboot_fixups(); /* for board specific fixups */
                        mach_reboot();
                        /* That didn't work - force a triple fault.. */
                        load_idt(&no_idt);
                        __asm__ __volatile__("int3");
                }
        }
        if (efi_enabled)
                efi.reset_system(EFI_RESET_WARM, EFI_SUCCESS, 0, NULL);

        machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
}

void machine_restart(char * __unused)
{
        machine_shutdown();
        machine_emergency_restart();
}


If it does not, try this reboot=tc - this is closely resembles
what you proposed in your mail (pseudo-patch):

static int __init reboot_setup(char *str)
{
        while(1) {
                switch (*str) {
+               case 't': /* "triple fault" reboot */
+                       reboot_thru_bios = 2;
+                       break;
                case 'w': /* "warm" reboot (no memory testing etc) */
                        reboot_mode = 0x1234;
                        break;
...
void machine_emergency_restart(void)
{
+       if (reboot_thru_bios == 2) {
+               *((unsigned short *)__va(0x472)) = reboot_mode;
+               load_idt(&no_idt);
+               __asm__ __volatile__("int3");
+	}
        if (!reboot_thru_bios) {
                if (efi_enabled) {
                        efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
--
vda
