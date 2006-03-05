Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWCETap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWCETap (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWCETap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:30:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50188 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751714AbWCETao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:30:44 -0500
Date: Sun, 5 Mar 2006 20:30:12 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Keith Ownes <kaos@ocs.com.au>
Subject: kbuild - status on section mismatch warnings
Message-ID: <20060305193012.GA14838@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the last weeks I have worked on improved support for section
mismatch checks.

When a function is marked __init then the implementation will be placed
in a section named .init.text - that section will be discarded by
vmlinux when the module is initialised.
So therefore any references to function marked __init are subject to
references to functions that may suddenly disappear.

So the section mismatch checks originally implmented by Keith Ownes
try to find all cases where a function outside .init.text reference
a function declared inside a section named .init.text - this is a
potential oops candidate.
To add to this picture we have several functions marked __devinit,
where __devinit result in functions being marked __init _only_ when
HOTPLUG is not enabled.

After chasing a number of false positives I am now on 86 warnings for an
allmodconfig build for sparc64.
Browsing throug the warnings several warnings points to harmless
constructs as for example init_module() which is not declared __init and
so on, but others points to real bugs that ought to be fixed.

The typical pattern is:

static void __init foo(void)
{
	...
}

static void __devinit init_bar(void)
{
	foo();		<= boom....
}

When HOTPLUG is enabled we may call init_bar() at any point in time, but
when init_bar() then calls foo() placed in __init section we go oops
because the original foo() implmentation has been freed and is
overwritten by something else.


I have fixed a few of the section mismatch warnings on the way, but so
far the effort has been concentrated on the algorithm.
The fixes are not included in the output posted below.

A kernel has been test-compiled (defconfig + allmodconfig) for following
architectures:
x86_64, ia64, ppc64 and sparc64.
For each architecture a new workaround was needed to fix false positives
but now the result looks good all over these four architectures.

The algorith I consider ready for 2.6.17 as sson as it opens up.
And I hope that relevant people will pick up in their area and get the
warnings fixed.
The patches are all pushed to my kbuild.git tree at
git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git - and will be
available in next -mm.

I you have trouble understanding the warning for a particular driver I
will gladly try to help.

	Sam

For reference is attached the output from a sparc64 run on
2.6.16-rc4-something:
Drivers that causes warnings:

arch/sparc64/solaris/solaris.o
drivers/atm/fore_200e.o
drivers/atm/he.o
drivers/atm/horizon.o
drivers/atm/lanai.o
drivers/atm/zatm.o
drivers/block/cpqarray.o
drivers/block/floppy.o
drivers/char/ip2main.o
drivers/cpufreq/cpufreq_stats.o
drivers/ide/ide-core.o
drivers/isdn/hisax/hisax.o
drivers/media/dvb/bt8xx/dvb-bt8xx.o
drivers/media/dvb/ttpci/dvb-ttpci.o
drivers/net/acenic.o
drivers/net/de620.o
drivers/net/myri_sbus.o
drivers/net/pcnet32.o
drivers/net/rrunner.o
drivers/net/sis900.o
drivers/net/tokenring/3c359.o
drivers/scsi/esp.o
drivers/scsi/fcal.o
drivers/scsi/megaraid/megaraid_mbox.o
drivers/scsi/pluto.o
drivers/scsi/qla1280.o
drivers/scsi/qlogicpti.o
drivers/usb/gadget/g_serial.o
drivers/usb/gadget/g_zero.o
drivers/video/aty/atyfb.o
drivers/video/macmodes.o
drivers/video/savage/savagefb.o
drivers/video/tridentfb.o
fs/jffs2/jffs2.o
net/ipv4/netfilter/ip_conntrack.o
net/ipv4/netfilter/iptable_nat.o
sound/oss/cs46xx.o
sound/oss/forte.o
sound/oss/msnd.o

And the warnings themself:

WARNING: arch/sparc64/solaris/solaris.o - Section mismatch: reference to .init.text:init_socksys from .text between 'init_module' (at offset 0x3848) and 'cleanup_module'
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.text:fore200e_init from .text between 'fore200e_pca_detect' (at offset 0x2d14) and 'fore200e_pca_remove_one'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text:he_start from .text between 'he_init_one' (at offset 0x158) and 'he_remove_one'
WARNING: drivers/atm/horizon.o - Section mismatch: reference to .init.text:hrz_init from .text between 'hrz_probe' (at offset 0x3d04) and 'hrz_remove_one'
WARNING: drivers/atm/lanai.o - Section mismatch: reference to .init.text: from .text between 'sram_test_pass' (at offset 0x1e8) and 'sram_test_and_clear'
WARNING: drivers/atm/zatm.o - Section mismatch: reference to .init.text: from .text after 'zatm_init_one' (at offset 0x2cd0)
WARNING: drivers/atm/zatm.o - Section mismatch: reference to .init.text:zatm_start from .text after 'zatm_init_one' (at offset 0x2ce4)
WARNING: drivers/block/cpqarray.o - Section mismatch: reference to .init.text: from .text between 'cpqarray_register_ctlr' (at offset 0x9e8) and 'alloc_cpqarray_hba'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text:parse_floppy_cfg_string from .text between 'init_module' (at offset 0x91dc) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text:floppy_init from .text between 'init_module' (at offset 0x91e4) and 'cleanup_module'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text:have_requested_irq from .text between 'cleanup_module' (at offset 0x2cd8) and 'ip2_loadmain'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text:clear_requested_irq from .text between 'cleanup_module' (at offset 0x2cfc) and 'ip2_loadmain'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x3024) and 'set_irq'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text:find_eisa_board from .text between 'ip2_loadmain' (at offset 0x312c) and 'set_irq'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text:ip2_init_board from .text between 'ip2_loadmain' (at offset 0x3244) and 'set_irq'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text:have_requested_irq from .text between 'ip2_loadmain' (at offset 0x3570) and 'set_irq'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text:mark_requested_irq from .text between 'ip2_loadmain' (at offset 0x3608) and 'set_irq'
WARNING: drivers/cpufreq/cpufreq_stats.o - Section mismatch: reference to .init.text: from .data between 'cpufreq_stat_cpu_notifier' (at offset 0xf8) and 'notifier_policy_block'
WARNING: drivers/cpufreq/cpufreq_stats.o - Section mismatch: reference to .init.text: from .exit.text after 'cleanup_module' (at offset 0x70)
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text:parse_options from .text between 'init_module' (at offset 0x215c) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text:ide_init from .text between 'init_module' (at offset 0x2164) and 'cleanup_module'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_s0box from .text between 'checkcard' (at offset 0xe64) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_avm_pcipnp from .text between 'checkcard' (at offset 0xe84) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_diva from .text between 'checkcard' (at offset 0xea4) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_niccy from .text between 'checkcard' (at offset 0xed4) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_bkm_a4t from .text between 'checkcard' (at offset 0xee4) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_sct_quadro from .text between 'checkcard' (at offset 0xef4) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_gazel from .text between 'checkcard' (at offset 0xf04) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_w6692 from .text between 'checkcard' (at offset 0xf14) and 'HiSax_shiftcards'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:inithdlc from .text between 'AVM_card_msg' (at offset 0x29d34) and 'ReadHDLCPnP'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:init_ipacx from .text between 'Diva_card_msg' (at offset 0x30fe0) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:clear_pending_jade_ints from .text between 'BKM_card_msg' (at offset 0x40d48) and 'jade_write_indirect'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initjade from .text between 'BKM_card_msg' (at offset 0x40d58) and 'jade_write_indirect'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:initW6692 from .text after 'w6692_card_msg' (at offset 0x47098)
WARNING: drivers/media/dvb/bt8xx/dvb-bt8xx.o - Section mismatch: reference to .init.text: from .text between 'dvb_bt8xx_probe' (at offset 0x148c) and 'dvb_bt8xx_remove'
WARNING: drivers/media/dvb/bt8xx/dvb-bt8xx.o - Section mismatch: reference to .init.text:dvb_bt8xx_load_card from .text between 'dvb_bt8xx_probe' (at offset 0x1518) and 'dvb_bt8xx_remove'
WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text:av7110_ir_init from .text between 'av7110_attach' (at offset 0xef1c) and 'av7110_detach'
WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text:av7110_ir_exit from .text between 'av7110_detach' (at offset 0xf038) and 'av7110_irq'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data: from .text between 'ace_load_firmware' (at offset 0x3a70) and 'eeprom_start'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data: from .text between 'ace_load_firmware' (at offset 0x3a84) and 'eeprom_start'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data:tigon2FwRodata from .text between 'ace_load_firmware' (at offset 0x3a8c) and 'eeprom_start'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data:tigon2FwRodata from .text between 'ace_load_firmware' (at offset 0x3a9c) and 'eeprom_start'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data:tigon2FwData from .text between 'ace_load_firmware' (at offset 0x3aac) and 'eeprom_start'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data:tigon2FwData from .text between 'ace_load_firmware' (at offset 0x3ac0) and 'eeprom_start'
WARNING: drivers/net/de620.o - Section mismatch: reference to .init.text:de620_probe from .text between 'init_module' (at offset 0x2714) and 'cleanup_module'
WARNING: drivers/net/myri_sbus.o - Section mismatch: reference to .init.data: from .text between 'myri_load_lanai' (at offset 0x1f8) and 'myri_clean_rings'
WARNING: drivers/net/myri_sbus.o - Section mismatch: reference to .init.data: from .text between 'myri_load_lanai' (at offset 0x1fc) and 'myri_clean_rings'
WARNING: drivers/net/myri_sbus.o - Section mismatch: reference to .init.data:lanai4_data from .text between 'myri_load_lanai' (at offset 0x240) and 'myri_clean_rings'
WARNING: drivers/net/myri_sbus.o - Section mismatch: reference to .init.data:lanai4_data from .text between 'myri_load_lanai' (at offset 0x244) and 'myri_clean_rings'
WARNING: drivers/net/pcnet32.o - Section mismatch: reference to .init.data: from .text between 'pcnet32_probe_vlbus' (at offset 0x133c) and 'pcnet32_probe_pci'
WARNING: drivers/net/pcnet32.o - Section mismatch: reference to .init.data: from .text between 'pcnet32_probe_vlbus' (at offset 0x1340) and 'pcnet32_probe_pci'
WARNING: drivers/net/pcnet32.o - Section mismatch: reference to .init.data: from .text between 'pcnet32_probe_vlbus' (at offset 0x134c) and 'pcnet32_probe_pci'
WARNING: drivers/net/rrunner.o - Section mismatch: reference to .init.text:rr_init from .text between 'rr_init_one' (at offset 0x304) and 'rr_remove_one'
WARNING: drivers/net/sis900.o - Section mismatch: reference to .init.text:sis900_mii_probe from .text between 'sis900_probe' (at offset 0x598) and 'sis900_default_phy'
WARNING: drivers/net/tokenring/3c359.o - Section mismatch: reference to .init.text:xl_init from .text between 'xl_probe' (at offset 0x300) and 'xl_hw_reset'
WARNING: drivers/scsi/esp.o - Section mismatch: reference to .init.text:esp_detect from .data after 'driver_template' (at offset 0x530)
WARNING: drivers/scsi/fcal.o - Section mismatch: reference to .init.text:fcal_detect from .data after 'driver_template' (at offset 0x1a8)
WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch: reference to .init.text:megaraid_init_mbox from .text between 'megaraid_probe_one' (at offset 0x228) and 'megaraid_detach_one'
WARNING: drivers/scsi/pluto.o - Section mismatch: reference to .init.text:pluto_detect from .data after 'driver_template' (at offset 0x80)
WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to .init.data: from .text between 'qla1280_get_token' (at offset 0x43a0) and 'qla1280_probe_one'
WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to .init.data: from .text between 'qla1280_get_token' (at offset 0x43a8) and 'qla1280_probe_one'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to .init.text:qpti_chain_del from .text between 'qlogicpti_release' (at offset 0xba0) and 'qlogicpti_info'
WARNING: drivers/scsi/qlogicpti.o - Section mismatch: reference to .init.text:qlogicpti_detect from .data after 'driver_template' (at offset 0xf8)
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig_reset from .text between 'gs_bind' (at offset 0x10e4) and 'gs_unbind'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'gs_bind' (at offset 0x10f4) and 'gs_unbind'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'gs_bind' (at offset 0x111c) and 'gs_unbind'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'gs_bind' (at offset 0x1158) and 'gs_unbind'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text:usb_ep_autoconfig_reset from .text between 'zero_bind' (at offset 0x172c) and 'zero_suspend'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'zero_bind' (at offset 0x1738) and 'zero_suspend'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text:usb_ep_autoconfig from .text between 'zero_bind' (at offset 0x1780) and 'zero_suspend'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text:aty_init from .text between 'atyfb_pci_probe' (at offset 0x2fe4) and 'atyfb_remove'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab after '__ksymtab_mac_find_mode' (at offset 0x30)
WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.data: from .text between 'savagefb_probe' (at offset 0x4c34) and 'savagefb_remove'
WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.data: from .text between 'savagefb_probe' (at offset 0x4c38) and 'savagefb_remove'
WARNING: drivers/video/tridentfb.o - Section mismatch: reference to .init.text:get_memsize from .text between 'trident_pci_probe' (at offset 0x2acc) and 'trident_pci_remove'
WARNING: drivers/video/tridentfb.o - Section mismatch: reference to .init.text:get_displaytype from .text between 'trident_pci_probe' (at offset 0x2b34) and 'trident_pci_remove'
WARNING: drivers/video/tridentfb.o - Section mismatch: reference to .init.text:get_nativex from .text between 'trident_pci_probe' (at offset 0x2b4c) and 'trident_pci_remove'
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' (at offset 0x75c) and 'jffs2_compressors_exit'
WARNING: net/ipv4/netfilter/ip_conntrack.o - Section mismatch: reference to .init.text:ip_conntrack_init from .text between 'init_or_cleanup' (at offset 0xaac) and 'ip_conntrack_protocol_register'
WARNING: net/ipv4/netfilter/iptable_nat.o - Section mismatch: reference to .init.text:ip_nat_rule_init from .text after 'init_or_cleanup' (at offset 0xd88)
WARNING: sound/oss/cs46xx.o - Section mismatch: reference to .init.text: from .text between 'cs_hardware_init' (at offset 0x96c4) and 'cs46xx_probe'
WARNING: sound/oss/forte.o - Section mismatch: reference to .init.text: from .text between 'forte_chip_init' (at offset 0x2894) and 'forte_remove'
WARNING: sound/oss/msnd.o - Section mismatch: reference to .init.text:msnd_register from __ksymtab between '__ksymtab_msnd_register' (at offset 0x0) and '__ksymtab_msnd_unregister'
