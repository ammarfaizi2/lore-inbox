Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbUBBSKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUBBSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:10:41 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:289 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265751AbUBBSJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:09:48 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 19:09:40 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression] 2.4.25-pre8: 126 warnings 0 errors
Message-ID: <20040202180940.GA6367@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401301855410.3140@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Jan 30, 2004 at 06:57:03PM -0200, Marcelo Tosatti ha scritto: 
> On Fri, 30 Jan 2004, Kronos wrote:
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> ha scritto:
> > > This is a shame. These warnings piled up during time.
> > >
> > > It is very likely that all of them are harmless,
> > > but they need to be fixed.
> > >
> > > Will find to look into some of them. Help is appreciated.
> >
> > If you want I can work on them in the weekend.
> 
> If you feel like it, sure :)
> 
> I want only "obvious" fixes for 2.4.25, the rest during 2.4.26-pre.

Done. Allmost all of them seem obvious. I'm splitting diffs right now, I'll 
send patches in reply to this mail. Below is a summary:


Warning List:

aachba.c:1682: warning: cast to pointer from integer of different size
aachba.c:1744: warning: cast to pointer from integer of different size

There is a comment that says that they are ok.

ac97_plugin_ad1980.c:92: warning: initialization from incompatible pointer type

Fixed.

ad1889.c:361: warning: unsigned int format, different type arg (arg 4)

It happens only with CONFIG_HIGHMEM64G=y as dma_addr_t becomes u64.
Fixed by casting dma_addr_t to dma64_addr_t.

agpgart_be.c:5647:17: warning: extra tokens at end of #undef directive

Trivial fix.

../aha152x.c:853: warning: `do_setup' defined but not used

Hum, cannot reproduce.  do_setup is defined and _used_ if
!defined(MODULE).

aha1542.c:114: warning: `setup_str' defined but not used

Fixed.

ali5455.c:2939: warning: `addr2' might be used uninitialized in this function
ali5455.c:2939: warning: `data' might be used uninitialized in this function

Not sure. They are  initialized in a if-branch in a  for loop. I suppose
that sooner or later the branch will be taken.

amd74xx.c:389: warning: `ata66_amd74xx' defined but not used

Yes, this is really unused.

amd76x_pm.c:483: warning: `activate_amd76x_SLP' defined but not used

Fixed.

amd76xrom.c:181: warning: label `err_out_none' defined but not used

This is called by code enclosed in #if 0. Should I remove the label?

amd7930_fn.h:35: warning: `initAMD' defined but not used

There is a static array in a header file. I moved it in the c file.

applicom.c:268:2: warning: #warning "LEAK"
applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"

Ask the author...

aty128fb.c:1066: warning: `aty128_set_crt_enable' defined but not used
aty128fb.c:1076: warning: `aty128_set_lcd_enable' defined but not used
aty128fb.c:2485: warning: unused variable `fb'
aty128fb.c:2486: warning: unused variable `value'
aty128fb.c:2487: warning: unused variable `rc'

Fixed.

cardbus.c:239: warning: assignment makes pointer from integer without a cast
cardbus.c:239: warning: implicit declaration of function `pci_scan_device_Rsmp_aceae718'

This can  be a real bug.  cardbus.c is calling pci_scan_device  which is
marked as __devinit. Also pci_scan_device prototype isn't exported.  Who
is cardbus maintainer? I founded only a comment by Linus saying that the
file will be removed (dated 2000...).

cfi_cmdset_0001.c:1135: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0001.c:1165: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0001.c:826: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0020.c:1137: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c:1286: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c:491: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c:851: warning: unsigned int format, different type arg (arg 3)

cfi_word can be either 64 or 32 bit wide. Should I cast it to u64 in the
kprintf?

cmdlinepart.c:345: warning: `mtdpart_setup' defined but not used

Fixed.

cpqfcTSi2c.c:62: warning: `i2c_delay' declared `static' but never defined

Fixed.

crc32.c:91: warning: static declaration for `fn_calc_memory_chunk_crc32' follows non-static

Fixed. Btw, while fixing it I found 3 crc32.c:
kronos@notebook:~/src/linux-2.4$ find -name crc32.c
./lib/crc32.c
./arch/mips/lasat/crc32.c
(This one under mips is usign a lookup table to compute the crc)
./drivers/net/wan/8253x/crc32.c

Maybe two of them can be removed...

csr.c:120: warning: long unsigned int format, int arg (arg 3)

Fixed.

/datos/kernel/linux/include/asm/smpboot.h:126: warning: deprecated use of label at end of compound statement

Fixed, seems trivial.

/datos/kernel/linux/include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used

It is used in drivers/telephony/ixj.c but it seems to me quite useless.

/datos/kernel/linux/include/linux/kdev_t.h:81:1: warning: this is the location of the previous definition

Minor is redefined in drivers/char/tipar.c. Fixed.

/datos/kernel/linux/include/linux/modules/sunrpc_syms.ver:38:1: warning: this is the location of the previous definition

Don't know :)

doc1000.c:85:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

Can't fix.

dtc.c:182: warning: `dtc_setup' defined but not used

Fixed.

fbcon.c:2138: warning: unused variable `line'
fbcon.c:2141: warning: unused variable `dst'
fbcon.c:2141: warning: unused variable `src'
fbcon.c:2142: warning: unused variable `x1'
fbcon.c:2142: warning: unused variable `y1'

They are used under several #defines, I don't think that it's worth
moving them around.

fbdev.c:2224: warning: label `err_out_kfree' defined but not used

Fixed.

../fdomain.c:565: warning: `fdomain_setup' defined but not used

Done.

file.c:64: warning: `rc' might be used uninitialized in this function

(under fs/intermezzo) I think it's ok:

static int presto_open_upcall(int minor, struct dentry *de)
{
        int rc;
	struct presto_dentry_data *dd = presto_d2d(de);
	...
	if (dd->remote_ino == 0) {
		rc = presto_get_fileid(minor, fset, de);
	}
	...
	if (dd->remote_ino > 0) {
		...
	} else
		CPRINTF("blabla", rc);

remote_ino is unsigned so rc won't be used without initialization.
	
gamma_dma.c:608:18: warning: #warning list_entry() is needed here

Yup, the same thing should be done in drmP.h...done.

g_NCR5380.c:212: warning: `do_NCR5380_setup' defined but not used
g_NCR5380.c:230: warning: `do_NCR53C400_setup' defined but not used
g_NCR5380.c:248: warning: `do_NCR53C400A_setup' defined but not used
g_NCR5380.c:266: warning: `do_DTC3181E_setup' defined but not used

Fixed.

hc_sl811_rh.c:171: warning: duplicate `const'
hc_sl811_rh.c:416: warning: duplicate `const'
hc_sl811_rh.c:421: warning: duplicate `const'

I doesn't even compile if not build as module... fixed. Warnings comes
from nested min(), gcc 3.3.2 doesn't whine.

hid-core.c:879: warning: implicit declaration of function `hiddev_report_event'

Missing prototype in include/linux/hiddev.h, fixed

i2o_block.c:510: warning: `i2ob_flush' defined but not used

Wrapped with #if 0

i2o_pci.c:393:1: warning: no newline at end of file

Not true :)

idt77252.c:669: warning: unsigned int format, different type arg (arg 5)

dma_addr_t...

interrupt.c:201: warning: unsigned int format, different type arg (arg 4)

dma_addr_t again. Maybe we need a special printf conversion specifier.

ip_conntrack_core.c:1161: warning: passing arg 1 of `unhelp' discards qualifiers from pointer target type

LIST_FIND_W cast to const the first element that gets passed to the
helper function (unhelp). I see no easy way to fix this (I'm not
familiar with netfilter code) because unhelp modifies its first arg.

ircomm_param.c:202: warning: concatenation of string literals with __FUNCTION__ is deprecated

Fixed (btw somebody half-fixed this...)

irlmp.c:1244: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1258: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1277: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1284: warning: concatenation of string literals with __FUNCTION__ is deprecated

Fixed

it8181fb.c:162: warning: `fontname' defined but not used

Fixed + plus removal of unneeded initialization to zero.

ixj.h:41: warning: `ixj_h_rcsid' defined but not used

Shut up! Don't know why it complains. ixj_h_rcsid seems used.

kaweth.c:738: warning: assignment from incompatible pointer type

Fixed.

linuxvfs.c:682: warning: `befs_listxattr' defined but not used
linuxvfs.c:690: warning: `befs_getxattr' defined but not used
linuxvfs.c:697: warning: `befs_setxattr' defined but not used
linuxvfs.c:703: warning: `befs_removexattr' defined but not used

Extended attribute not implemented yet. Wrapped with #if 0 + comment.

ma600.c:51:22: warning: extra tokens at end of #undef directive

Trivial.

main.c:236:2: warning: #warning "Initialisation order race. Must register after usable"

This is /drivers/sound/emu10k1/main.c. Don't know how to fix.

make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.

Uh?

matroxfb_g450.c:134: warning: duplicate `const'
matroxfb_g450.c:135: warning: duplicate `const'
matroxfb_g450.c:561: warning: unused variable `minfo'
matroxfb_maven.c:359: warning: duplicate `const'
matroxfb_maven.c:360: warning: duplicate `const'

Fixed.

meye.c:212: warning: passing arg 3 of `dma_alloc_coherent' from incompatible pointer type

Fixed, but be carefull with  this. The driver consider dma_addr_t == u32
which is  not always true  even on i386  (CONFIG_HIGHMEM64G). I replaced
u32 with dma_addr_t where appropriate, but I don't think that the driver
is 64 bit clean anyway.

mpc.c:330: warning: `mpoa_device_type_string' defined but not used

It's marked as unused. Maybe the OP is using an older gcc.

mptbase.c:2906: warning: `pCached' might be used uninitialized in this function

Fixed.

NCR5380.c:402: warning: `NCR5380_print' defined but not used
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:684: warning: `NCR5380_probe_irq' defined but not used
NCR5380.c:738: warning: `NCR5380_print_options' defined but not used

Not  sure. Comments   says  that  NCR5380_probe_irq  is   defined  under
AUTOPROBE_IRQ but it's not. It's  also stated that NCR5380_print_options
must be called  in the init code (but again  it's not). You'd better ask
the maintainer.

nfs3proc.c:48:1: warning: "rpc_call_sync" redefined

Hum, here the function rpc_call_sync is overridded with a macro. At
least this is unclean.

ns83820.c:1708: warning: `ns83820_probe_phy' defined but not used

Fixed.

pc300_tty.c:706: warning: passing arg 2 of pointer to function discards qualifiers from pointer target type

We are losing a volatile and I don't see why it's used. Also there a lot
of "volatile" all over the driver. Not touched.

pci-pc.c:180:1: warning: "PCI_CONF1_ADDRESS" redefined
pci-pc.c:58:1: warning: this is the location of the previous definition

PCI_CONF1_ADDRESS is defined on line 58 #if CONFIG_MULTIQUAD. It's
redefined on line 180 (outside #if CONFIG_MULTIQUAD). I added an #undef
right before the end of the CONFIG_MULTIQUAD block

pm3fb.c:3835: warning: passing arg 2 of `__release_region_Rsmp_d49501d4' makes integer from pointer without a cast
pm3fb.c:3838: warning: passing arg 2 of `__release_region_Rsmp_d49501d4' makes integer from pointer without a cast

The author didn't understand how to use ioremap ;) I think that it's ok
on i386 though, I can add a cast to shut up gcc.

r128_cce.c:357: warning: unsigned int format, different type arg (arg 3)

dma_addr_t

radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)

idem

radeon_mem.c:135: warning: `print_heap' defined but not used

Gone.

scsi_merge.c:104: warning: long unsigned int format, different type arg (arg 4)

page_to_phys returns a u64 if CONFIG_HIGHMEM64G is defined.

sddr09.c:448: warning: `sddr09_request_sense' defined but not used

-EWONTFIX ;) sddr09_request_sense is called by the init function, which
is wrapped by a #if 0.

siimage.c:65: warning: control reaches end of non-void function

The last statement before the end is BUG(), but I added a return to
silence the warning.

sstfb.c:971: warning: unused variable `i'

Fixed.

st5481_b.c:122: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_b.c:176: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_b.c:367: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:362: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:386: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:419: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:453: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:602: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:134: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:188: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:244: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:253: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:263: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:360: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:474: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:504: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:510: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:512: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:514: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:51: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:522: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:609: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:612: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:67: warning: concatenation of string literals with __FUNCTION__ is deprecated

Fixed.

sundance.c:1678: warning: unsigned int format, different type arg (arg 3)
sundance.c:994: warning: unsigned int format, different type arg (arg 3)

dma_addr_t

super.c:164: warning: `fork' might be used uninitialized in this function
super.c:164: warning: `names' might be used uninitialized in this function

This may be real. Don't know how to fix.

tipar.c:76:1: warning: "minor" redefined

Fixed, see above.

tms380tr.c:1449: warning: long unsigned int format, different type arg (arg 3)

Bad cast, fixed.

/datos/kernel/linux/include/linux/autoconf.h:2070:1: warning: "CONFIG_SERIAL_SHARE_IRQ" redefined
vac-serial.c:13:1: warning: this is the location of the previous definition

Fixed. But why vac-serial.c and serial.c defines
CONFIG_SERIAL_SHARE_IRQ? It should be defined by the build system (if
user configured it...)

vesafb.c:93: warning: `fbcon_cmap' defined but not used

It's used if CONFIG_FBCON_CFB16 or CONFIG_FBCON_CFB32 are defined.

wd7000.c:832: warning: `p' might be used uninitialized in this function

Can't happen. needed is always >= 1 so p will be initialized. gcc is not
smart enough ;)

xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function

Fixed by Nathan Scott

yellowfin.c:1282: warning: unsigned int format, different type arg (arg 2)
yellowfin.c:1294: warning: unsigned int format, different type arg (arg 2)

Fixed.


ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Se non puoi convincerli, confondili.
