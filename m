Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269496AbUIRN5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269496AbUIRN5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 09:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269497AbUIRN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 09:57:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9486 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269496AbUIRN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 09:57:33 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] trivial patch for 2.4: always inline __constant_*
Date: Sat, 18 Sep 2004 16:57:23 +0300
User-Agent: KMail/1.5.4
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua> <200409172155.29561.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409172155.29561.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D7DTBhvUvC7sbzf"
Message-Id: <200409181657.23833.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_D7DTBhvUvC7sbzf
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > 2.4:
> >
> >   2994 total                                      0.0013
> >    620 link_path_walk                             0.2892
> >    285 d_lookup                                   1.2076
> >    156 dput                                       0.4815
> >    118 kmem_cache_free                            0.7564
> >    109 system_call                                1.9464
> >    106 kmem_cache_alloc                           0.5096
> >    103 strncpy_from_user                          1.2875
> >     97 open_namei                                 0.0767
> >     92 fput                                       0.3710
> >     88 get_unused_fd                              0.2529
> >     85 vfs_permission                             0.3320
> >     79 page_follow_link                           0.2264
> >     79 __constant_c_and_count_memset              0.6583
>
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Someone broke inlining in 2.4 *again*.
> I bet System.map have dozens of __constant_c_and_count_memset's

This is how to find wrongly de-inlined finctions:

a) Find duplicate names:

# cat System.map | cut -d ' ' -f3 | sort | uniq -c | grep -vF $' 1\t' | sort -r

     41	version
     21	debug
     14	options
     14	mdio_write
     14	mdio_read
     14	max_interrupt_work
     14	SysKonnectFileId
     13	rx_copybreak
     13	full_duplex
     12	version_printed.0
     12	set_rx_mode
     12	set_multicast_list
     12	buf.0
     12	__constant_c_and_count_memset
     10	read_eeprom
     10	printed_version.1
     10	multicast_filter_limit
     10	.text.lock.inode
      9	netdev_ioctl
      7	netdev_get_drvinfo
      7	netdev_ethtool_ops
      7	netdev_ethtool_ioctl
      7	mtu
      7	get_stats
      7	card_idx.0
      6	parse_options
      6	netdev_set_msglevel
      6	netdev_get_msglevel
      6	devfs_handle
      6	__constant_memcpy
      5	netcard_portlist
      5	driver
      4	tx_timeout
      4	start_tx
      4	netdev_open
      4	netdev_close
      4	net_debug
      4	media
      4	intr_handler
      4	init_ring
      4	init_once
      4	buf.1
      3	xdr_error
      3	update_stats
      3	ports.0
      3	pci_id_tbl
      3	netdev_timer
      3	netdev_set_settings
      3	netdev_rx
      3	netdev_nway_reset
      3	netdev_get_settings
      3	netdev_get_link
      3	netdev_error
      3	hardware_send_packet
      3	ethtool_stats_keys
      3	__set_rx_mode

Of these, at least the following were intended to be always inlined:

     12	__constant_c_and_count_memset
      6	__constant_memcpy

Prolly #include <linux/compiler.h> is missing in some files,
or included too late to have desired effect.
Let's find them:

{
find -name '*.o' | xargs grep -lF '__constant_c_and_count_memset'
find -name '*.o' | xargs grep -lF '__constant_memcpy'
} | sort | uniq

./arch/i386/kernel/irq.o
./arch/i386/kernel/kernel.o
./arch/i386/mm/init.o
./arch/i386/mm/mm.o
./drivers/block/block.o
./drivers/block/rd.o
./drivers/char/char.o
./drivers/char/n_tty.o
./drivers/char/tty_io.o
./drivers/parport/parport.o
./drivers/parport/procfs.o
./drivers/scsi/sr_mod.o
./drivers/scsi/sr_vendor.o
./fs/dcache.o
./fs/file_table.o
./fs/fs.o
./fs/hpfs/buffer.o
./fs/hpfs/ea.o
./fs/hpfs/hpfs.o
./fs/hpfs/namei.o
./fs/lockd/lockd.o
./fs/lockd/svcsubs.o
./fs/nfs/nfs.o
./fs/nfs/nfsroot.o
./fs/nfsd/nfsd.o
./fs/nfsd/vfs.o
./fs/open.o
./fs/reiserfs/dir.o
./fs/reiserfs/objectid.o
./fs/reiserfs/reiserfs.o
./net/core/core.o
./net/core/scm.o
./net/ipv4/arp.o
./net/ipv4/ipconfig.o
./net/ipv4/ipv4.o
./net/network.o

Redoing this with allyesconfig revealed some more files.

Most of them can be fixed with a single #include <compiler.h>
in <string.h>. Along the way, I fixed some non-compilation buglets.
I will submit those patches as replies now.
--
vda

--Boundary-00=_D7DTBhvUvC7sbzf
Content-Type: text/x-diff;
  charset="koi8-r";
  name="linux-2.4.27-pre3.string_h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.27-pre3.string_h.patch"

diff -urpN linux-2.4.27-pre3.org/include/linux/string.h linux-2.4.27-pre3.fix/include/linux/string.h
--- linux-2.4.27-pre3.org/include/linux/string.h	Sat Sep 18 16:52:10 2004
+++ linux-2.4.27-pre3.fix/include/linux/string.h	Fri Sep 17 23:19:23 2004
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/compiler.h>	/* for inline ((always_inline)) */
 
 #ifdef __cplusplus
 extern "C" {

--Boundary-00=_D7DTBhvUvC7sbzf--

