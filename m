Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCAPms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUCAPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:42:48 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:57238 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261344AbUCAPmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:42:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kernel-janitors@lists.osdl.org
Subject: Re: [Kernel-janitors] Re: finding unused globals in the kernel
Date: Mon, 1 Mar 2004 16:34:39 +0100
User-Agent: KMail/1.6.1
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <5138.1078121472@kao2.melbourne.sgi.com>
In-Reply-To: <5138.1078121472@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403011634.39204.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 March 2004 07:11, Keith Owens wrote:
> namespace.pl below handles all the special cases on kernels from 2.0
> through 2.4.  It needs updating for 2.6 kernels, enjoy.
> 

I've added the module names and linker-defined symbol names from
2.6.3, so this version should do better with 2.6.
It still lacks support for seperate object trees and better handling
of weak symbols.

	Arnd <><

#!/usr/bin/perl -w
#
#       namespace.pl.  Mon Jan 27 1997
#
#       Perform a name space analysis on the linux kernel.
#
#       Copyright Keith Owens <kaos@ocs.com.au>.  GPL.
#
#       Invoke by changing directory to the top of the kernel source
#       tree then namespace.pl, no parameters.
#
#       Tuned for 2.1.x kernels with the new module handling, it will
#       work with 2.0 kernels as well.  Last change 2.4.25 for ia64.
#
#       The source must be compiled/assembled first, the object files
#       are the primary input to this script.  Incomplete or missing
#       objects will result in a flawed analysis.  Compile both vmlinux
#       and modules.
#
#       Even with complete objects, treat the result of the analysis
#       with caution.  Some external references are only used by
#       certain architectures, others with certain combinations of
#       configuration parameters.  Ideally the source should include
#       something like
#
#       #ifndef CONFIG_...
#       static
#       #endif
#       symbol_definition;
#
#       so the symbols are defined as static unless a particular
#       CONFIG_... requires it to be external.
#

require 5;      # at least perl 5
use strict;
use File::Find;

my $nm = "/usr/bin/nm -p";      # in case somebody moves nm

if ($#ARGV != -1) {
        print STDERR "usage: $0 takes no parameters\n";
        die("giving up\n");
}

my %nmdata = ();        # nm data for each object
my %def = ();           # all definitions for each name
my %ksymtab = ();       # names that appear in __ksymtab_
my %ref = ();           # $ref{$name} exists if there is a true external reference to $name
my %export = ();        # $export{$name} exists if there is an EXPORT_... of $name

&find(\&linux_objects, '.');    # find the objects and do_nm on them
list_multiply_defined();
resolve_external_references();
list_extra_externals();

exit(0);

sub linux_objects
{
        # Select objects, ignoring objects which are only created by
        # merging other objects.  Also ignore all of modules, scripts
        # and compressed.
        my $basename = $_;
        $_ = $File::Find::name;
        s:^\./::;
        if (/.*\.o$/ && ! (
            m:/built-in.o$:
            || m:/cpqphp.o$: || m:/iforce.o$: || m:/a100u2w.o$:
            || m:/aacraid.o$: || m:/acpiphp.o$: || m:/adfs.o$:
            || m:/aha152x_cs.o$: || m:/aic79xx.o$: || m:/arlan.o$:
            || m:/atm.o$: || m:/atyfb.o$: || m:/auth_rpcgss.o$:
            || m:/befs.o$: || m:/bnep.o$: || m:/bootflag.o$:
            || m:/ccw_device.o$: || m:/cmtp.o$: || m:/coda.o$: || m:/ctc.o$:
            || m:/cx8800.o$: || m:/cx88xx.o$: || m:/cyclomx.o$:
            || m:/daemon.o$: || m:/dasd_diag_mod.o$: || m:/dasd_eckd_mod.o$:
            || m:/dasd_fba_mod.o$: || m:/dasd_mod.o$: || m:/decnet.o$:
            || m:/diva_idi.o$: || m:/diva_mnt.o$: || m:/divacapi.o$:
            || m:/divadidd.o$: || m:/divas.o$: || m:/dm-mod.o$:
            || m:/dm-snapshot.o$: || m:/dmasound_pmac.o$: || m:/dss1_divert.o$:
            || m:/dvb-core.o$: || m:/econet.o$: || m:/efs.o$:
            || m:/exportfs.o$: || m:/fc4.o$: || m:/fd1772_mod.o$:
            || m:/fdomain_cs.o$: || m:/ffb.o$: || m:/font.o$:
            || m:/fore_200e.o$: || m:/g_file_storage.o$: || m:/g_serial.o$:
            || m:/g_zero.o$: || m:/gadgetfs.o$: || m:/gamma.o$:
            || m:/genksyms.o$: || m:/gus.o$: || m:/harddog.o$: || m:/hdlc.o$:
            || m:/head.o$: || m:/hfs.o$: || m:/hisax.o$: || m:/hugetlbpage.o$:
            || m:/hysdn.o$: || m:/i810fb.o$: || m:/i830.o$: || m:/ibmphp.o$:
            || m:/inftl.o$: || m:/ip_nf_compat.o$: || m:/ip_nf_conntrack.o$:
            || m:/ip_nf_nat.o$: || m:/ip_vs.o$: || m:/ipfwadm.o$:
            || m:/ipmi_kcs_drv.o$: || m:/ircomm.o$: || m:/ircomm-tty.o$:
            || m:/irda.o$: || m:/irnet.o$: || m:/isapnp-proc.o$:
            || m:/ixgb.o$: || m:/jffs.o$: || m:/jfs.o$: || m:/kernelcapi.o$:
            || m:/kyrofb.o$: || m:/leds.o$: || m:/libata.o$: || m:/llc.o$:
            || m:/llc2.o$: || m:/mconsole.o$: || m:/mfmhd_mod.o$: || m:/mga.o$:
            || m:/miropcm20.o$: || m:/mk_sc.o$: || m:/mmu.o$: || m:/modpost.o$:
            || m:/mounts.o$: || m:/mpoa.o$: || m:/mwave.o$: || m:/ntfs.o$:
            || m:/nwfpe.o$: || m:/oprofile.o$: || m:/pas2.o$: || m:/pc300.o$:
            || m:/pci_hotplug.o$: || m:/pcmcia_core.o$: || m:/pnpbios-proc.o$:
            || m:/powernow-k8.o$: || m:/proc-crypto.o$: || m:/profdrvr.o$:
            || m:/psmouse.o$: || m:/pwc.o$: || m:/qeth.o$: || m:/qla2100.o$:
            || m:/qla2200.o$: || m:/qla2300.o$: || m:/qla2322.o$:
            || m:/qla2xxx.o$: || m:/qla6322.o$: || m:/qlogic_cs.o$:
            || m:/qnx4.o$: || m:/r128.o$: || m:/radeon.o$: || m:/radeonfb.o$:
            || m:/raid6.o$: || m:/rcpci.o$: || m:/rpcsec_gss_krb5.o$:
            || m:/reiserfs.o$: || m:/rfcomm.o$: || m:/rio.o$: || m:/rxrpc.o$:
            || m:/sa1100_cs.o$: || m:/sa1111_cs.o$: || m:/saa7134.o$:
            || m:/saa7146_vv.o$: || m:/sb_lib.o$: || m:/sctp.o$:
            || m:/selinux.o$: || m:/serial-8250.o$: || m:/sir-dev.o$:
            || m:/sisfb.o$: || m:/skfp.o$: || m:/slirp.o$:
            || m:/snd-ad1816a-lib.o$: || m:/snd-ad1816a.o$:
            || m:/snd-ad1848-lib.o$: || m:/snd-ad1848.o$:
            || m:/snd-ainstr-fm.o$: || m:/snd-ainstr-gf1.o$:
            || m:/snd-ainstr-iw.o$: || m:/snd-ainstr-simple.o$:
            || m:/snd-ak4531-codec.o$: || m:/snd-ak4xxx-adda.o$:
            || m:/snd-ali5451.o$: || m:/snd-als100.o$:
            || m:/snd-als4000.o$: || m:/snd-azt2320.o$:
            || m:/snd-azt3328.o$: || m:/snd-bt87x.o$:
            || m:/snd-cmi8330.o$: || m:/snd-cmipci.o$:
            || m:/snd-cs4231-lib.o$: || m:/snd-cs4231.o$:
            || m:/snd-cs4232.o$: || m:/snd-cs4236-lib.o$:
            || m:/snd-cs4236.o$: || m:/snd-cs4281.o$:
            || m:/snd-cs46xx.o$: || m:/snd-cs8427.o$:
            || m:/snd-dt019x.o$: || m:/snd-dummy.o$:
            || m:/snd-emu10k1.o$: || m:/snd-emu8000-synth.o$:
            || m:/snd-emux-synth.o$: || m:/snd-ens1371.o$:
            || m:/snd-es1688-lib.o$: || m:/snd-es1688.o$:
            || m:/snd-es18xx.o$: || m:/snd-es1938.o$:
            || m:/snd-es1968.o$: || m:/snd-es968.o$:
            || m:/snd-fm801.o$: || m:/snd-gus-lib.o$:
            || m:/snd-gusclassic.o$: || m:/snd-gusextreme.o$:
            || m:/snd-gusmax.o$: || m:/snd-harmony.o$:
            || m:/snd-hdsp.o$: || m:/snd-hwdep.o$:
            || m:/snd-i2c.o$: || m:/snd-ice1712.o$:
            || m:/snd-ice1724.o$: || m:/snd-ice17xx-ak4xxx.o$:
            || m:/snd-intel8x0.o$: || m:/snd-interwave.o$:
            || m:/snd-interwave-stb.o$: || m:/snd-ioctl32.o$:
            || m:/snd-korg1212.o$: || m:/snd-maestro3.o$:
            || m:/snd-mixer-oss.o$: || m:/snd-mpu401.o$:
            || m:/snd-mpu401-uart.o$: || m:/snd-mtpav.o$:
            || m:/snd-nm256.o$: || m:/snd.o$:
            || m:/snd-opl3-synth.o$: || m:/snd-opl3sa2.o$:
            || m:/snd-opl4-lib.o$: || m:/snd-opl4-synth.o$:
            || m:/snd-opti92x-ad1848.o$: || m:/snd-opti92x-cs4231.o$:
            || m:/snd-opti93x.o$: || m:/snd-page-alloc.o$:
            || m:/snd-pc98-cs4232.o$: || m:/snd-pcm.o$:
            || m:/snd-rawmidi.o$: || m:/snd-rme32.o$:
            || m:/snd-rme96.o$: || m:/snd-rme9652.o$:
            || m:/snd-rtctimer.o$: || m:/snd-sa11xx-uda1341.o$:
            || m:/snd-sb-common.o$: || m:/snd-sb16-csp.o$:
            || m:/snd-sb16-dsp.o$: || m:/snd-sb16.o$:
            || m:/snd-sb8-dsp.o$: || m:/snd-sb8.o$:
            || m:/snd-sbawe.o$: || m:/snd-seq-device.o$:
            || m:/snd-seq-dummy.o$: || m:/snd-seq-instr.o$:
            || m:/snd-seq-midi-emul.o$: || m:/snd-seq-midi-event.o$:
            || m:/snd-seq-midi.o$: || m:/snd-seq.o$:
            || m:/snd-serial-u16550.o$: || m:/snd-sgalaxy.o$:
            || m:/snd-sonicvibes.o$: || m:/snd-sscape.o$:
            || m:/snd-sun-amd7930.o$: || m:/snd-sun-cs4231.o$:
            || m:/snd-tea575x-tuner.o$: || m:/snd-tea6330t.o$:
            || m:/snd-timer.o$: || m:/snd-trident.o$:
            || m:/snd-trident-synth.o$: || m:/snd-uda1341.o$:
            || m:/snd-usb-audio.o$: || m:/snd-util-mem.o$:
            || m:/snd-via82xx.o$: || m:/snd-virmidi.o$: || m:/snd-vx-cs.o$:
            || m:/snd-vx-lib.o$: || m:/snd-vx222.o$: || m:/snd-vxp440.o$:
            || m:/snd-vxpocket.o$: || m:/snd-wavefront.o$: || m:/snd-ymfpci.o$:
            || m:/solaris.o$: || m:/tdfx.o$: || m:/topology.o$: || m:/tape.o$:
            || m:/tpam.o$: || m:/tub3270.o$: || m:/ubd.o$:
            || m:/usb-storage-obj.o$: || m:/usb-storage.o$:
            || m:/usbserial-obj.o$: || m:/usbserial.o$: || m:/vfc.o$:
            || m:/vidc_mod.o$: || m:/wanpipe.o$: || m:/wanrouter.o$:
            || m:/wavefront.o$: || m:/zalon7xx.o$:
            || m:/zfcp.o$: || m:/zftape.o$:
            || m:/fs.o$: || m:/isofs.o$: || m:/nfs.o$:
            || m:/xiafs.o$: || m:/umsdos.o$: || m:/hpfs.o$:
            || m:/smbfs.o$: || m:/ncpfs.o$: || m:/ufs.o$:
            || m:/affs.o$: || m:/romfs.o$: || m:/kernel.o$:
            || m:/mm.o$: || m:/ipc.o$: || m:/ext.o$:
            || m:/msdos.o$: || m:proc/proc.o$: || m:/minix.o$:
            || m:/ext2.o$: || m:/sysv.o$: || m:/fat.o$:
            || m:/vfat.o$: || m:/unix.o$: || m:/802.o$:
            || m:/appletalk.o$: || m:/ax25.o$:
            || m:/ethernet.o$: || m:/ipv4.o$: || m:/ipx.o$:
            || m:/netrom.o$: || m:/ipv6.o$: || m:/x25.o$:
            || m:/rose.o$: || m:/bridge.o$: || m:/lapb.o$:
            || m:/sock_n_syms.o$: || m:/teles.o$: || m:/pcbit.o$:
            || m:/isdn.o$: || m:/ftape.o$: || m:/scsi_mod.o$:
            || m:/sd_mod.o$: || m:/sr_mod.o$:
            || m:/sound.o$: || m:/piggy.o$: || m:/bootsect.o$:
            || m:/boot/setup.o$: || m:^modules/: || m:^scripts/:
            || m:/compressed/: || m:/vmlinux-obj.o$:
            || m:/autofs.o$: || m:lockd/lockd.o$: || m:/nfsd.o$:
            || m:/sunrpc.o$: || m:/scsi_n_syms.o$:
            || m:boot/bbootsect.o$: || m:boot/bsetup.o$:
            || m:misc/parport.o$: || m:nls/nls.o$:
            || m:debug/debug.o$: || m:netlink/netlink.o$:
            || m:sched/sched.o$: || m:sound/sb.o$: 
            || m:sound/soundcore.o$: || m:pci/pci_syms.o$: 
            || m:devpts/devpts.o$: || m:video/fbdev.o$: 
            || m:arch/i386/kdb/kdba.o$: || m:crypto/crypto.o$:
            || m:drivers/block/block.o$: || m:drivers/cdrom/driver.o$:
            || m:drivers/char/char.o$:
            || m:drivers/ide/arm/idedriver-arm.o$:
            || m:drivers/ide/ide-core.o$: || m:drivers/ide/ide-detect.o$:
            || m:drivers/ide/idedriver.o$:
            || m:drivers/ide/legacy/idedriver-legacy.o$:
            || m:drivers/ide/pci/idedriver-pci.o$:
            || m:drivers/ide/ppc/idedriver-ppc.o$:
            || m:drivers/ide/raid/idedriver-raid.o$:
            || m:drivers/md/lvm-mod.o$: || m:drivers/md/mddev.o$:
            || m:drivers/media/media.o$: || m:drivers/media/radio/radio.o$:
            || m:drivers/media/video/video.o$: || m:drivers/misc/misc.o$:
            || m:drivers/net/e1000/e1000.o$: || m:drivers/net/net.o$:
            || m:lib/zlib_deflate/zlib_deflate.o$:
            || m:net/8021q/8021q.o$:
            || m:net/bluetooth/bluez.o$:
            || m:net/ipv4/netfilter/ipchains.o$:
            || m:net/ipv4/netfilter/iptable_nat.o$:
            || m:net/ipv4/netfilter/ip_conntrack.o$:
            || m:net/ipv4/netfilter/netfilter.o$:
            || m:net/ipv6/netfilter/netfilter.o$:
            || m:drivers/parport/driver.o$: || m:drivers/pci/driver.o$:
            || m:drivers/scsi/aic7xxx/aic7xxx_drv.o$:
            || m:drivers/scsi/aic7xxx/aic7xxx.o$:
            || m:drivers/scsi/scsidrv.o$:
            || m:drivers/sound/sounddrivers.o$: || m:drivers/video/video.o$:
            || m:fs/autofs4/autofs4.o$: || m:fs/ext3/ext3.o$:
            || m:fs/jbd/jbd.o$: || m:fs/partitions/partitions.o$:
            || m:fs/ramfs/ramfs.o$: || m:fs/xfs/linux/linux_xfs.o$:
            || m:fs/xfs/pagebuf/pagebuf.o$:
            || m:fs/xfs/support/support_xfs.o$: || m:fs/xfs/xfs.o$:
            || m:kdb/kdb.o$:
            || m:lib/zlib_inflate/zlib_inflate.o$: || m:net/network.o$:
            || m:net/packet/packet.o$:
            || m:fs/xfs/quota/xfs_quota.o$:
            || m:fs/udf/udf.o$:
            || m:fs/intermezzo/intermezzo.o$:
            || m:fs/hugetlbfs/hugetlbfs.o$:
            || m:fs/freevxfs/freevxfs.o$:
            || m:fs/devfs/devfs.o$:
            || m:fs/cramfs/cramfs.o$:
            || m:drivers/usb/hid.o$:
            || m:drivers/usb/usbcore.o$:
            || m:drivers/sound/emu10k1/emu10k1.o$:
            || m:drivers/sound/cs4281/cs4281.o$:
            || m:drivers/net/tulip/tulip.o$:
            || m:drivers/net/sk98lin/sk98lin.o$:
            || m:drivers/net/bonding/bonding.o$:
            || m:drivers/message/fusion/fusion.o$:
            || m:drivers/input/inputdrv.o$:
            || m:drivers/ieee1394/ieee1394.o$:
            || m:drivers/char/joystick/js.o$:
            || m:drivers/char/agp/agpgart.o$:
            || m:drivers/char/agp/agp.o$:
            || m:drivers/bluetooth/hci_uart.o$:
            || m:drivers/acpi/acpi.o$:
            || m:drivers/acpi/utilities/utilities.o$:
            || m:drivers/acpi/tables/tables.o$:
            || m:drivers/acpi/resources/resources.o$:
            || m:drivers/acpi/parser/parser.o$:
            || m:drivers/acpi/namespace/namespace.o$:
            || m:drivers/acpi/hardware/hardware.o$:
            || m:drivers/acpi/executer/executer.o$:
            || m:drivers/acpi/events/events.o$:
            || m:drivers/acpi/dispatcher/dispatcher.o$:
            || m:arch/ia64/lib/__divsi3.o$:
            || m:arch/ia64/lib/__udivsi3.o$:
            || m:arch/ia64/lib/__modsi3.o$:
            || m:arch/ia64/lib/__umodsi3.o$:
            || m:arch/ia64/lib/__divdi3.o$:
            || m:arch/ia64/lib/__udivdi3.o$:
            || m:arch/ia64/lib/__moddi3.o$:
            || m:arch/ia64/lib/__umoddi3.o$:
            || m:arch/ia64/ia32/ia32.o$:
          )
        ) {
                do_nm($basename, $_);
        }
        $_ = $basename;         # File::Find expects $_ untouched (undocumented)
}

sub do_nm
{
        my ($basename, $fullname) = @_;
        my ($source, $type, $name);
        if (! -e $basename) {
                printf STDERR "$basename does not exist\n";
                return;
        }
        if ($fullname !~ /\.o$/) {
                printf STDERR "$fullname is not an object file\n";
                return;
        }
        $source = $basename;
        $source =~ s/\.o$//;
#        if (! -e "$source.c" && ! -e "$source.S") {
#                printf STDERR "No source file found for $fullname\n";
#                return;
#        }
        if (! open(NMDATA, "$nm $basename|")) {
                printf STDERR "$nm $fullname failed $!\n";
                return;
        }
        my @nmdata;
        while (<NMDATA>) {
                chop;
                ($type, $name) = (split(/ +/, $_, 3))[1..2];
                # Expected types
                # B weak external reference to data that has been resolved
                # C global variable, uninitialised
                # D global variable, initialised
                # G global variable, initialised, small data section
                # R global array, initialised
                # S global variable, uninitialised, small bss
                # T global label/procedure
                # U external reference
                # W weak external reference to text that has been resolved
                # a assembler equate
                # b static variable, uninitialised
                # d static variable, initialised
                # g static variable, initialised, small data section
                # r static array, initialised
                # s static variable, uninitialised, small bss
                # t static label/procedures
                # w weak external reference to text that has not been resolved
                # ? undefined type, used a lot by modules
                if ($type !~ /^[BCDGRSTUWabdgrstw?]$/) {
                        printf STDERR "nm output for $fullname contains unknown type '$_'\n";
                }
                elsif ($name =~ /\./) {
                        # name with '.' is local static
                }
                else {
                        $type = 'R' if ($type eq '?');  # binutils replaced ? with R at one point
                        $name =~ s/_R[a-f0-9]{8}$//;    # module versions adds this
                        if ($type =~ /[BCDGRSTW]/ &&
                                $name ne 'init_module' &&
                                $name ne 'cleanup_module' &&
                                $name ne 'Using_Versions' &&
                                $name !~ /^Version_[0-9]+$/ &&
                                $name !~ /^__module_parm_/ &&
                                $name !~ /^__kstrtab/ &&
                                $name !~ /^__ksymtab/ &&
                                $name ne '__module_description' &&
                                $name ne '__module_author' &&
                                $name ne '__module_device' &&
                                $name ne '__this_module' &&
                                $name ne 'kernel_version') {
                                if (!exists($def{$name})) {
                                        $def{$name} = [];
                                }
                                push(@{$def{$name}}, $fullname);
                        }
                        push(@nmdata, "$type $name");
                        if ($name =~ /^__ksymtab_/) {
                                $name = substr($name, 10);
                                if (!exists($ksymtab{$name})) {
                                        $ksymtab{$name} = [];
                                }
                                push(@{$ksymtab{$name}}, $fullname);
                        }
                }
        }
        close(NMDATA);
        if ($#nmdata < 0) {
                printf "No nm data for $fullname\n";
                return;
        }
        $nmdata{$fullname} = \@nmdata;
}

sub list_multiply_defined
{
        my ($name, $module);
        foreach $name (keys(%def)) {
                if ($#{$def{$name}} > 0) {
                        printf "$name is multiply defined in :-\n";
                        foreach $module (@{$def{$name}}) {
                                printf "\t$module\n";
                        }
                }
        }
}

sub resolve_external_references
{
        my ($object, $type, $name, $i, $j, $kstrtab, $ksymtab, $export);
        printf "\n";
        foreach $object (keys(%nmdata)) {
                my $nmdata = $nmdata{$object};
                for ($i = 0; $i <= $#{$nmdata}; ++$i) {
                        ($type, $name) = split(' ', $nmdata->[$i], 2);
                        if ($type eq "U" || $type eq "w") {
                                if (exists($def{$name}) || exists($ksymtab{$name})) {
                                        # add the owning object to the nmdata
                                        $nmdata->[$i] = "$type $name $object";
                                        # only count as a reference if it is not EXPORT_...
                                        $kstrtab = "R __kstrtab_$name";
                                        $ksymtab = "R __ksymtab_$name";
                                        $export = 0;
                                        for ($j = 0; $j <= $#{$nmdata}; ++$j) {
                                                if ($nmdata->[$j] eq $kstrtab ||
                                                    $nmdata->[$j] eq $ksymtab) {
                                                        $export = 1;
                                                        last;
                                                }
                                        }
                                        if ($export) {
                                                $export{$name} = "";
                                        }
                                        else {
                                                $ref{$name} = ""
                                        }
                                }
                                elsif ($name ne "mod_use_count_" &&
				       $name ne "__con_initcall_end" &&
				       $name ne "__con_initcall_start" &&
				       $name ne "__stop___param" &&
				       $name ne "__start___param" &&
				       $name ne "__per_cpu_end" &&
				       $name ne "__per_cpu_start" &&
				       $name ne "__initramfs_end" &&
				       $name ne "__initramfs_start" &&
				       $name ne "__stop___ksymtab_gpl" &&
				       $name ne "__start___ksymtab_gpl" &&
				       $name ne "__per_cpu_start" &&
				       $name ne "__per_cpu_end" &&
				       $name ne "_einittext" &&
				       $name ne "_sinittext" &&
				       $name ne "_einittext" &&
				       $name ne "_sinittext" &&
				       $name ne "kallsyms_names" &&
				       $name ne "kallsyms_num_syms" &&
				       $name ne "kallsyms_addresses" &&
				       $name ne "__security_initcall_end" &&
				       $name ne "__security_initcall_start" &&
				       $name ne "__this_module" &&
                                       $name ne "_etext" &&
                                       $name ne "_edata" &&
                                       $name ne "_end" &&
                                       $name ne "__start___ksymtab" &&
                                       $name ne "__start___ex_table" &&
                                       $name ne "__stop___ksymtab" &&
                                       $name ne "__stop___ex_table" &&
                                       $name ne "__stop___ex_table" &&
                                       $name ne "__bss_start" &&
                                       $name ne "_text" &&
                                       $name ne "_stext" &&
                                       $name ne "__start_gate_section" &&
                                       $name ne "__start___kallsyms" &&
                                       $name ne "__stop___kallsyms" &&
                                       $name ne "__gp" &&
                                       $name ne "__start_gate_section" &&
                                       $name ne "__stop_gate_section" &&
                                       $name ne "ia64_unw_start" &&
                                       $name ne "__setup_start" &&
                                       $name ne "__setup_end" &&
                                       $name ne "__initcall_start" &&
                                       $name ne "__initcall_end" &&
                                       $name ne "ia64_unw_end" &&
                                       $name ne "__init_begin" &&
                                       $name ne "__init_end") {
                                        printf "Cannot resolve reference to $name from $object\n";
                                }
                        }
                }
        }
}

sub list_extra_externals
{
        my %noref = ();
        my ($name, @module, $module, $export);
        foreach $name (keys(%def)) {
                if (! exists($ref{$name})) {
                        @module = @{$def{$name}};
                        foreach $module (@module) {
                                if (! exists($noref{$module})) {
                                        $noref{$module} = [];
                                }
                                push(@{$noref{$module}}, $name);
                        }
                }
        }
        if (%noref) {
                printf "\nExternally defined symbols with no external references\n";
                foreach $module (sort(keys(%noref))) {
                        printf "  $module\n";
                        foreach (sort(@{$noref{$module}})) {
                                if (exists($export{$_})) {
                                        $export = " (export only)";
                                }
                                else {
                                        $export = "";
                                }
                                printf "    $_$export\n";
                        }
                }
        }
}
