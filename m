Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTALNYy>; Sun, 12 Jan 2003 08:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbTALNYy>; Sun, 12 Jan 2003 08:24:54 -0500
Received: from tag.witbe.net ([81.88.96.48]:3591 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266095AbTALNYw>;
	Sun, 12 Jan 2003 08:24:52 -0500
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Cc: "'Sam Ravnborg'" <sam@ravnborg.org>, <rol@as2917.net>
Subject: [BUG 2.5.56] IDE/CDROM Oops at boot time without /proc
Date: Sun, 12 Jan 2003 14:33:38 +0100
Organization: Witbe.net
Message-ID: <009401c2ba3f$3780a940$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please note that using IDE CDRom without /proc support will result
in Oops at boot time.

In drivers/cdrom/cdrom.c, the code is :

/* Make sure that /proc/sys/dev is there */
ctl_table cdrom_root_table[] = {
#ifdef CONFIG_PROC_FS
        {CTL_DEV, "dev", NULL, 0, 0555, cdrom_cdrom_table},
#endif /* CONFIG_PROC_FS */
        {0}
        };
static struct ctl_table_header *cdrom_sysctl_header;

static void cdrom_sysctl_register(void)
{
        static int initialized;

        if (initialized == 1)
                return;

        cdrom_sysctl_header = register_sysctl_table(cdrom_root_table,
1);
        cdrom_root_table->child->de->owner = THIS_MODULE;

        /* set the defaults */
        cdrom_sysctl_settings.autoclose = autoclose;
        cdrom_sysctl_settings.autoeject = autoeject;
        cdrom_sysctl_settings.debug = debug;
        cdrom_sysctl_settings.lock = lockdoor;
        cdrom_sysctl_settings.check = check_media_type;

        initialized = 1;
}

The line cdrom_root_table->child->de->owner = THIS_MODULE;
(line 2582) is broken is CONFIG_PROC_FS is not defined, as this
is resulting in the following Oops :

Unable to handle kernel NULL pointer dereference at virtual address
00000020
 printing eip:
c032e12c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c032e12c>]    Not tainted
EFLAGS: 00010292
EIP is at cdrom_sysctl_register+0x2a/0x74
eax: 00000000   ebx: c04c3fe0   ecx: dfc8de80   edx: dfc8de84
esi: c04c4014   edi: dfcedcf4   ebp: c059f348   esp: dff8fef8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff8e000 task=dff8c080)
Stack: c04cf120 00000001 c0329e43 c0465400 c059f358 00000001 dfde2037
c046eaa0 
       c02eb6ae dfcedcf4 00000001 dfcedcf4 dfcedc00 c059f348 dfd91080
dfcedc00 
       dff8e000 c02ebc31 c059f348 00000000 0000013c c04c3bc4 c02502c3
c04c3f08 
Call Trace:
 [<c0329e43>] register_cdrom+0x1f7/0x20e
 [<c02eb6ae>] ide_cdrom_setup+0x352/0x4ec
 [<c02ebc31>] ide_cdrom_attach+0x13f/0x24e
 [<c02502c3>] kobject_add+0x87/0xd6
 [<c0289f62>] devclass_add_driver+0x1e/0x9c
 [<c0250331>] kobject_register+0x1f/0x62
 [<c02898f8>] bus_add_driver+0x86/0xac
 [<c02e31c3>] ata_attach+0x5b/0x11c
 [<c02e3eba>] ide_register_driver+0xe6/0x102
 [<c02ebd4f>] ide_cdrom_init+0xf/0x16
 [<c010506f>] init+0x3d/0x15a
 [<c0105032>] init+0x0/0x15a
 [<c0108c11>] kernel_thread_helper+0x5/0xc

Code: 8b 40 20 c7 40 24 00 00 00 00 c7 05 24 3b 5a c0 01 00 00 00 
 <0>Kernel panic: Attempted to kill init!
 <0>Rebooting in 30 seconds..

decoded as :
9 [14:28] rol@donald:~> more oops-cdrom.decode 
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20/ (default)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address
00000020
c032e12c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c032e12c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: c04c3fe0   ecx: dfc8de80   edx: dfc8de84
esi: c04c4014   edi: dfcedcf4   ebp: c059f348   esp: dff8fef8
ds: 007b   es: 007b   ss: 0068
Stack: c04cf120 00000001 c0329e43 c0465400 c059f358 00000001 dfde2037
c046eaa0 
       c02eb6ae dfcedcf4 00000001 dfcedcf4 dfcedc00 c059f348 dfd91080
dfcedc00 
       dff8e000 c02ebc31 c059f348 00000000 0000013c c04c3bc4 c02502c3
c04c3f08 
Call Trace:
 [<c0329e43>] register_cdrom+0x1f7/0x20e
 [<c02eb6ae>] ide_cdrom_setup+0x352/0x4ec
 [<c02ebc31>] ide_cdrom_attach+0x13f/0x24e
 [<c02502c3>] kobject_add+0x87/0xd6
 [<c0289f62>] devclass_add_driver+0x1e/0x9c
 [<c0250331>] kobject_register+0x1f/0x62
 [<c02898f8>] bus_add_driver+0x86/0xac
 [<c02e31c3>] ata_attach+0x5b/0x11c
 [<c02e3eba>] ide_register_driver+0xe6/0x102
 [<c02ebd4f>] ide_cdrom_init+0xf/0x16
 [<c010506f>] init+0x3d/0x15a
 [<c0105032>] init+0x0/0x15a
 [<c0108c11>] kernel_thread_helper+0x5/0xc
Code: 8b 40 20 c7 40 24 00 00 00 00 c7 05 24 3b 5a c0 01 00 00 00 


>>EIP; c032e12c <cdrom_sysctl_register+2a/74>   <=====

>>ebx; c04c3fe0 <ide_cdrom_dops+0/40>
>>esi; c04c4014 <ide_cdrom_dops+34/40>
>>ebp; c059f348 <ide_hwifs+808/4998>

Trace; c0329e43 <register_cdrom+1f7/20e>
Trace; c02eb6ae <ide_cdrom_setup+352/4ec>
Trace; c02ebc31 <ide_cdrom_attach+13f/24e>
Trace; c02502c3 <kobject_add+87/d6>
Trace; c0289f62 <devclass_add_driver+1e/9c>
Trace; c0250331 <kobject_register+1f/62>
Trace; c02898f8 <bus_add_driver+86/ac>
Trace; c02e31c3 <ata_attach+5b/11c>
Trace; c02e3eba <ide_register_driver+e6/102>
Trace; c02ebd4f <ide_cdrom_init+f/16>
Trace; c010506f <init+3d/15a>
Trace; c0105032 <init+0/15a>
Trace; c0108c11 <kernel_thread_helper+5/c>

Code;  c032e12c <cdrom_sysctl_register+2a/74>
00000000 <_EIP>:
Code;  c032e12c <cdrom_sysctl_register+2a/74>   <=====
   0:   8b 40 20                  mov    0x20(%eax),%eax   <=====
Code;  c032e12f <cdrom_sysctl_register+2d/74>
   3:   c7 40 24 00 00 00 00      movl   $0x0,0x24(%eax)
Code;  c032e136 <cdrom_sysctl_register+34/74>
   a:   c7 05 24 3b 5a c0 01      movl   $0x1,0xc05a3b24
Code;  c032e13d <cdrom_sysctl_register+3b/74>
  11:   00 00 00 

 <0>Kernel panic: Attempted to kill init!

One easy trick would be to have :
#ifdef CONFIG_PROC_FS
        cdrom_root_table->child->de->owner = THIS_MODULE;
#endif

but as this doesn't seem to be the favorite approach from people on
the mailing list, I'll leave this one to people in charge of
the module to apply the best approach patch to fix this.

Please note that, however, I've tested this change, and it is 
working fine on my machine.

Regards,
Paul Rolland, rol@as2917.net

