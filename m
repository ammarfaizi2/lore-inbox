Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbVJMTSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbVJMTSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbVJMTSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:18:08 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:64593 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751576AbVJMTSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:18:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:mime-version:content-disposition:to:cc:content-type:content-transfer-encoding:message-id;
        b=espS/SHlW2BZxnIAl0EvYpgj3G7hsoTxG4fU2sMKlizivmAkjOtI/Fzc5INA9Er+fv+7ziAQN8YDG9XmR6tzJuOWUKtoIBh+dzrfWEush/7M4HA+5/HwqZeQ2IEjo1J38cRm8tT+k3HHl4ZdPirlU85eoagUDuv2OfFzsndmyfs=
From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH 00/14] Big kfree NULL check cleanup
Date: Thu, 13 Oct 2005 21:21:02 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132121.02649.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Over the past few months I've submitted quite a few patches to clean up
pointless NULL pointer checks prior to calls to kfree(). Instead of continuing
to let those changes trickle in in little bits I decided to once and for all
get rid of the bulk of them in one go.

I did a search through the kernel for constructs like
  if (<whatever>)
	kfree

and then went through all the files that produced a match that seemed like it
contained code that could be cleaned up.
Naturally this won't have found *all* instances where this type of cleanup can
be made, but judging from the number of files found and the number of changes I
ended up making, I'd say that I've probably caught the vast majority.

For those wondering why these patches should be merged, let me say a little 
about the reasons.

- Since kfree always checks for a NULL argument there's no reason to have an
additional check prior to calling kfree. It's redundant.
- In many cases gcc produce significantly smaller code without the redundant
check before the call.
- It's been shown in the past (in discussions on LKML) that it's generally a
win performance wise to avoid the extra NULL check even though it might save
a function call. Only when the NULL check avoids the function call in the vast
majority of cases and the code is in a hot path does it make sense to have it.
- This patch removes quite a few more source lines than it adds, cutting down
on the overall number of source lines is generally a good thing.
- This patch reduces the indentation level, which is nice when the kfree call
is inside some deeply nested construct.

These patches touch many parts of the kernel under the responsability of a *lot*
of different people, so in order to keep the number of people who need to be
Cc'ed down to a resonable level I've split the patch into chunks that are 
roughly related.
I'll try to include all relevant people on each mail, but I'll probably miss
some, sop lease forgive me if I don't manage to include /all/ the relevant 
people on each patch, I'll do my best though.
I'll also like to apologize up-front for the very long Cc lists on some of the
mails, but I wanted to make sure I included everyone who's code I've changed.

I've tried to refrain from making any style changes, but in a few cases I've 
made a few but still tried to stick with the style of the file I've changed 
rather than turning this into a whitespace/codingstyle cleanup at the same
time.
There are a few cases where I've removed a few redundant casts when I noticed
them, but these are few and far between and I've only done the really obvious 
ones.
This should be a mostly pure kfree() cleanup.

The patches have been compile tested as well as I could on a single i386 box
with allyesconfig.
A few files I have not been able to test, mainly in arch/, so please review 
those extra carefully.
Due to lack of hardware I obviously haven't been able to test all drivers for
real, I have however tried to thoroughly inspect the changes visually to ensure
correctness.

I'll send a diffstat with each chunk of the patch for the chunk in that email,
but I thought maybe someone would like to see a complete difstat in one place 
for all the changes in the 14 emails, so here's a complete diffstat of all the
changes :

 Documentation/DocBook/writing_usb_driver.tmpl |    3
 arch/arm/mach-integrator/impd1.c              |    3
 arch/cris/arch-v32/drivers/cryptocop.c        |   14 ++--
 arch/ia64/kernel/perfmon.c                    |    2
 arch/mips/au1000/common/dbdma.c               |    3
 arch/mips/au1000/common/usbdev.c              |    6 -
 arch/mips/kernel/irixelf.c                    |    5 -
 arch/parisc/kernel/ioctl32.c                  |   32 ++--------
 arch/ppc/8xx_io/cs4218_tdm.c                  |    3
 arch/ppc/syslib/prom.c                        |    6 -
 arch/ppc64/kernel/lparcfg.c                   |    4 -
 arch/ppc64/kernel/pSeries_reconfig.c          |    6 -
 arch/ppc64/kernel/rtas_flash.c                |    3
 arch/ppc64/kernel/scanlog.c                   |    3
 arch/s390/mm/extmem.c                         |    8 +-
 arch/sparc64/kernel/us2e_cpufreq.c            |    7 --
 arch/sparc64/kernel/us3_cpufreq.c             |    7 --
 arch/um/drivers/ubd_kern.c                    |   24 ++-----
 arch/um/kernel/sigio_user.c                   |    2
 drivers/acpi/container.c                      |    6 -
 drivers/acpi/scan.c                           |    6 -
 drivers/acpi/video.c                          |   12 +--
 drivers/block/DAC960.c                        |   31 +++------
 drivers/block/cciss.c                         |   12 +--
 drivers/char/consolemap.c                     |   12 +--
 drivers/char/drm/ffb_context.c                |    6 -
 drivers/char/drm/ffb_drv.c                    |    4 -
 drivers/char/ip2/i2ellis.c                    |    4 -
 drivers/char/istallion.c                      |    7 --
 drivers/char/n_hdlc.c                         |    3
 drivers/char/pcmcia/synclink_cs.c             |    3
 drivers/char/rocket.c                         |    6 -
 drivers/char/selection.c                      |    3
 drivers/char/stallion.c                       |    6 -
 drivers/char/synclink.c                       |   10 ---
 drivers/char/synclinkmp.c                     |    9 --
 drivers/char/tty_io.c                         |    9 --
 drivers/fc4/fc.c                              |    5 -
 drivers/hwmon/w83781d.c                       |    6 -
 drivers/i2c/busses/i2c-amd756-s4882.c         |    6 -
 drivers/ide/ide-cd.c                          |   18 +----
 drivers/ide/ide-probe.c                       |    6 -
 drivers/ide/ide-taskfile.c                    |    6 -
 drivers/ide/ide.c                             |    3
 drivers/infiniband/core/mad.c                 |    6 -
 drivers/input/misc/uinput.c                   |   10 ---
 drivers/isdn/hardware/avm/avm_cs.c            |    5 -
 drivers/isdn/hisax/avm_pci.c                  |   12 +--
 drivers/isdn/hisax/avma1_cs.c                 |    4 -
 drivers/isdn/hisax/config.c                   |    9 --
 drivers/isdn/hisax/hfc_2bds0.c                |   18 +----
 drivers/isdn/hisax/hfc_2bs0.c                 |   12 +--
 drivers/isdn/hisax/hscx.c                     |   12 +--
 drivers/isdn/hisax/icc.c                      |   12 +--
 drivers/isdn/hisax/ipacx.c                    |   12 +--
 drivers/isdn/hisax/isac.c                     |   15 +---
 drivers/isdn/hisax/isar.c                     |    6 -
 drivers/isdn/hisax/jade.c                     |   12 +--
 drivers/isdn/hisax/netjet.c                   |   32 +++-------
 drivers/isdn/hisax/st5481_usb.c               |   12 +--
 drivers/isdn/hisax/w6692.c                    |   12 +--
 drivers/isdn/hysdn/hysdn_procconf.c           |    3
 drivers/isdn/i4l/isdn_ppp.c                   |   21 ++----
 drivers/isdn/i4l/isdn_tty.c                   |   24 ++-----
 drivers/isdn/pcbit/drv.c                      |    6 -
 drivers/macintosh/adbhid.c                    |    3
 drivers/media/dvb/bt8xx/dst.c                 |    8 --
 drivers/media/dvb/frontends/dvb_dummy_fe.c    |    4 -
 drivers/media/dvb/frontends/l64781.c          |    3
 drivers/media/dvb/frontends/lgdt330x.c        |    3
 drivers/media/dvb/frontends/mt312.c           |    3
 drivers/media/dvb/frontends/or51132.c         |    3
 drivers/media/video/arv.c                     |   12 +--
 drivers/media/video/bttv-driver.c             |    6 -
 drivers/media/video/v4l1-compat.c             |    6 -
 drivers/media/video/videocodec.c              |    6 -
 drivers/media/video/videodev.c                |    3
 drivers/media/video/zoran_card.c              |   14 +---
 drivers/mmc/wbsd.c                            |    3
 drivers/mtd/chips/cfi_cmdset_0001.c           |    3
 drivers/mtd/chips/cfi_cmdset_0002.c           |    4 -
 drivers/mtd/devices/blkmtd.c                  |    7 --
 drivers/mtd/inftlcore.c                       |   12 +--
 drivers/mtd/maps/amd76xrom.c                  |    4 -
 drivers/mtd/maps/bast-flash.c                 |    3
 drivers/mtd/maps/ceiva.c                      |    3
 drivers/mtd/maps/ichxrom.c                    |    5 -
 drivers/mtd/maps/integrator-flash.c           |    6 -
 drivers/mtd/maps/ipaq-flash.c                 |    3
 drivers/mtd/maps/iq80310.c                    |    3
 drivers/mtd/maps/ixp2000.c                    |    3
 drivers/mtd/maps/ixp4xx.c                     |    3
 drivers/mtd/maps/lubbock-flash.c              |    3
 drivers/mtd/maps/omap-toto-flash.c            |    3
 drivers/mtd/maps/sa1100-flash.c               |    3
 drivers/mtd/maps/sun_uflash.c                 |    4 -
 drivers/mtd/maps/tqm8xxl.c                    |    6 -
 drivers/mtd/nand/nand_base.c                  |    5 -
 drivers/mtd/nftlcore.c                        |   12 +--
 drivers/net/acenic.c                          |    6 -
 drivers/net/au1000_eth.c                      |    6 -
 drivers/net/b44.c                             |   12 +--
 drivers/net/bmac.c                            |    6 -
 drivers/net/bnx2.c                            |   12 +--
 drivers/net/e1000/e1000_ethtool.c             |    7 --
 drivers/net/hamradio/mkiss.c                  |    6 -
 drivers/net/ibmveth.c                         |   19 +-----
 drivers/net/irda/donauboe.c                   |    6 -
 drivers/net/irda/irda-usb.c                   |    6 -
 drivers/net/irda/irport.c                     |    3
 drivers/net/irda/sir_dev.c                    |    3
 drivers/net/irda/vlsi_ir.c                    |    3
 drivers/net/mace.c                            |    6 -
 drivers/net/ni65.c                            |    9 --
 drivers/net/rrunner.c                         |    6 -
 drivers/net/s2io.c                            |    3
 drivers/net/saa9730.c                         |    8 --
 drivers/net/sb1250-mac.c                      |   12 ---
 drivers/net/tg3.c                             |    6 -
 drivers/net/tulip/de2104x.c                   |    6 -
 drivers/net/tulip/tulip_core.c                |    6 -
 drivers/net/via-velocity.c                    |    6 -
 drivers/net/wireless/airo.c                   |   48 ++++++---------
 drivers/net/wireless/airo_cs.c                |    4 -
 drivers/net/wireless/atmel.c                  |    6 -
 drivers/net/wireless/atmel_cs.c               |    3
 drivers/net/wireless/hostap/hostap_ioctl.c    |    9 --
 drivers/net/wireless/prism54/islpci_dev.c     |    3
 drivers/net/wireless/prism54/oid_mgt.c        |    9 +-
 drivers/net/wireless/strip.c                  |   38 ++++--------
 drivers/parport/probe.c                       |   21 +++---
 drivers/parport/share.c                       |   19 ++----
 drivers/pci/hotplug/cpqphp_pci.c              |   15 +---
 drivers/pcmcia/cistpl.c                       |   12 +--
 drivers/pcmcia/cs.c                           |    6 -
 drivers/s390/block/dasd.c                     |   12 +--
 drivers/s390/block/dasd_devmap.c              |    3
 drivers/s390/char/con3215.c                   |    3
 drivers/s390/char/keyboard.c                  |   15 +---
 drivers/s390/char/raw3270.c                   |    3
 drivers/s390/char/tape_core.c                 |    9 --
 drivers/s390/cio/cmf.c                        |    3
 drivers/s390/cio/device_ops.c                 |    6 -
 drivers/s390/cio/qdio.c                       |    9 --
 drivers/s390/crypto/z90main.c                 |    7 --
 drivers/s390/net/claw.c                       |   36 +++--------
 drivers/s390/net/fsm.c                        |    3
 drivers/s390/net/iucv.c                       |   14 +---
 drivers/s390/net/lcs.c                        |    3
 drivers/s390/net/qeth_eddp.c                  |    3
 drivers/s390/scsi/zfcp_aux.c                  |    3
 drivers/sbus/char/envctrl.c                   |   13 +---
 drivers/scsi/3w-9xxx.c                        |    3
 drivers/scsi/aacraid/commsup.c                |   14 +---
 drivers/scsi/advansys.c                       |   12 +--
 drivers/scsi/aha1542.c                        |   36 +++--------
 drivers/scsi/aic7xxx_old.c                    |    3
 drivers/scsi/arm/queue.c                      |    3
 drivers/scsi/dc395x.c                         |    3
 drivers/scsi/dpt_i2o.c                        |   27 ++------
 drivers/scsi/eata.c                           |    3
 drivers/scsi/ide-scsi.c                       |   10 +--
 drivers/scsi/ips.c                            |   18 +----
 drivers/scsi/lpfc/lpfc_els.c                  |    9 --
 drivers/scsi/lpfc/lpfc_init.c                 |    6 -
 drivers/scsi/lpfc/lpfc_mbox.c                 |    7 --
 drivers/scsi/lpfc/lpfc_sli.c                  |    7 --
 drivers/scsi/megaraid/megaraid_mbox.c         |    5 -
 drivers/scsi/megaraid/megaraid_mm.c           |   11 ---
 drivers/scsi/qla2xxx/qla_init.c               |   16 +----
 drivers/scsi/sg.c                             |    9 --
 drivers/scsi/st.c                             |    3
 drivers/scsi/u14-34f.c                        |    9 +-
 drivers/usb/class/bluetty.c                   |   18 +----
 drivers/usb/input/keyspan_remote.c            |    3
 drivers/video/i810/i810_main.c                |    3
 drivers/w1/w1_ds2433.c                        |    6 -
 fs/9p/trans_sock.c                            |    3
 fs/affs/super.c                               |   16 +----
 fs/afs/file.c                                 |    3
 fs/autofs/waitq.c                             |    6 -
 fs/autofs4/inode.c                            |    6 -
 fs/autofs4/waitq.c                            |    6 -
 fs/befs/linuxvfs.c                            |   12 +--
 fs/binfmt_elf.c                               |    3
 fs/binfmt_elf_fdpic.c                         |   15 +---
 fs/cifs/asn1.c                                |    3
 fs/cifs/connect.c                             |   81 ++++++++------------------
 fs/cifs/link.c                                |   23 ++-----
 fs/cifs/misc.c                                |   15 +---
 fs/cifs/xattr.c                               |   15 +---
 fs/compat_ioctl.c                             |    3
 fs/devfs/base.c                               |    6 -
 fs/ext2/acl.c                                 |    6 -
 fs/hostfs/hostfs_kern.c                       |    3
 fs/hpfs/dnode.c                               |    8 +-
 fs/hpfs/super.c                               |   10 +--
 fs/isofs/inode.c                              |   12 +--
 fs/jbd/commit.c                               |    6 -
 fs/jbd/transaction.c                          |    9 --
 fs/jffs/intrep.c                              |   18 ++---
 fs/jffs2/readinode.c                          |    8 --
 fs/jffs2/wbuf.c                               |    3
 fs/lockd/clntproc.c                           |    3
 fs/mbcache.c                                  |    3
 fs/nfs/delegation.c                           |    3
 fs/nfs/inode.c                                |   15 +---
 fs/nfs/nfs4state.c                            |    9 --
 fs/nfs/proc.c                                 |    3
 fs/nfs/unlink.c                               |    3
 fs/nfsd/export.c                              |    6 -
 fs/nfsd/nfs4xdr.c                             |    9 --
 fs/nfsd/nfscache.c                            |    3
 fs/openpromfs/inode.c                         |    3
 fs/reiserfs/super.c                           |   27 ++------
 fs/reiserfs/xattr_acl.c                       |    3
 fs/udf/udf_sb.h                               |    3
 fs/ufs/super.c                                |   14 ++--
 fs/xattr.c                                    |    9 --
 include/net/ax25.h                            |    3
 include/net/netrom.h                          |    3
 net/802/p8023.c                               |    3
 net/ax25/af_ax25.c                            |    6 -
 net/ax25/ax25_in.c                            |    6 -
 net/ax25/ax25_route.c                         |   19 +-----
 net/bluetooth/hidp/core.c                     |    4 -
 net/core/dev_mcast.c                          |    3
 net/core/sock.c                               |    3
 net/dccp/ipv4.c                               |    6 -
 net/dccp/proto.c                              |    3
 net/decnet/dn_table.c                         |   16 ++---
 net/ethernet/pe2.c                            |    3
 net/ipv4/af_inet.c                            |    3
 net/ipv4/fib_frontend.c                       |    3
 net/ipv4/ip_options.c                         |    3
 net/ipv4/ip_output.c                          |   12 +--
 net/ipv4/ip_sockglue.c                        |   12 +--
 net/ipv4/ipvs/ip_vs_app.c                     |    6 -
 net/ipv4/multipath_wrandom.c                  |   10 ---
 net/ipv4/netfilter/ip_nat_snmp_basic.c        |    3
 net/ipv4/tcp_ipv4.c                           |    3
 net/ipv6/addrconf.c                           |    3
 net/ipv6/ip6_output.c                         |   15 +---
 net/ipv6/ip6_tunnel.c                         |    6 -
 net/ipv6/ipcomp6.c                            |    3
 net/ipv6/ipv6_sockglue.c                      |    3
 net/irda/discovery.c                          |    3
 net/irda/irias_object.c                       |   16 +----
 net/rose/rose_route.c                         |    6 -
 net/sched/cls_fw.c                            |    3
 net/sched/cls_route.c                         |    3
 net/sched/cls_rsvp.h                          |    3
 net/sched/cls_tcindex.c                       |    9 --
 net/sched/cls_u32.c                           |    4 -
 net/sched/em_meta.c                           |    3
 net/sched/sch_gred.c                          |    9 --
 net/sctp/associola.c                          |    4 -
 net/sctp/sm_make_chunk.c                      |    6 -
 net/sunrpc/auth_gss/gss_krb5_seal.c           |    2
 net/sunrpc/auth_gss/gss_krb5_unseal.c         |    2
 net/sunrpc/auth_gss/gss_mech_switch.c         |    3
 net/sunrpc/auth_gss/gss_spkm3_seal.c          |    3
 net/sunrpc/auth_gss/gss_spkm3_token.c         |    3
 net/sunrpc/auth_gss/gss_spkm3_unseal.c        |    6 -
 net/sunrpc/svc.c                              |    9 --
 net/sunrpc/xdr.c                              |    3
 net/wanrouter/af_wanpipe.c                    |   20 ++----
 net/wanrouter/wanmain.c                       |   12 +--
 net/xfrm/xfrm_state.c                         |   12 +--
 security/keys/key.c                           |    3
 security/selinux/ss/policydb.c                |   12 +--
 sound/pci/ad1889.c                            |    3
 sound/pci/rme9652/hdspm.c                     |    3
 273 files changed, 781 insertions(+), 1474 deletions(-)

One final note: These patches are all cut against 2.6.14-rc4 as that was the
latest kernel available at the time I started doing this cleanup.


-- 
 Jesper Juhl <jesper.juhl@gmail.com>



