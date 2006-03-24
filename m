Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWCXS5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWCXS5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWCXS5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:57:53 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:16951 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932605AbWCXS5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:57:51 -0500
X-IronPort-AV: i="4.03,126,1141632000"; 
   d="scan'208"; a="264017947:sNHT41202080"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 0 of 18] ipath driver - for inclusion in 2.6.17
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1143175292@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Mar 2006 10:57:49 -0800
In-Reply-To: <patchbomb.1143175292@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Thu, 23 Mar 2006 20:41:32 -0800")
Message-ID: <ada4q1nr7pu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Mar 2006 18:57:50.0537 (UTC) FILETIME=[D931FB90:01C64F74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Hi - This is a submission of the ipath driver for inclusion
    Bryan> in 2.6.17.  Andrew, if this looks good to you, please
    Bryan> apply.

It's customary to work through subsystem maintainers to merge new drivers...

    Bryan> We have addressed all earlier rounds of feedback; the
    Bryan> driver is stable; it compiles with no compiler or sparse
    Bryan> warnings against current -git (it's comprehensively
    Bryan> annotated for sparse); and I think it's in good shape.  We
    Bryan> have gone to great lengths over the past several months to
    Bryan> make it an exemplary kernel citizen.

I merged this series into my git tree at

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ipath

I fixed a couple of minor whitespace problems and made it actually
build (hint: the constant RDMA_NODE_IB_CA does not exist in the
upstream kernel).

It seems you need to fix up your Kconfig dependencies somewhat.  On
x86_64 allnoconfig + CONFIG_PCI=y, CONFIG_PCI_MSI=y,
CONFIG_INFINIBAND=y, CONFIG_IPATH_CORE=y, CONFIG_INFINIBAND_IPATH=y, I get:

    drivers/built-in.o: In function `ipath_free_pddata': undefined reference to `kfree_skb'
    drivers/built-in.o: In function `ipath_alloc_skb': undefined reference to `__alloc_skb'
    drivers/built-in.o: In function `ipath_kreceive': undefined reference to `skb_over_panic'
    drivers/built-in.o: In function `ipath_init_chip': undefined reference to `kfree_skb'

It also looks like there are a few problems on ia64:

    drivers/infiniband/hw/ipath/ipath_verbs.c:733: warning: implicit declaration of function `atomic_set_mask'
    drivers/infiniband/hw/ipath/ipath_verbs.c:734: warning: implicit declaration of function `atomic_clear_mask'
    drivers/infiniband/hw/ipath/ipath_verbs.c: In function `show_stats':
    drivers/infiniband/hw/ipath/ipath_verbs.c:1184: warning: long long unsigned int format, u64 arg (arg 4)
    drivers/infiniband/hw/ipath/ipath_verbs.c:1184: warning: long long unsigned int format, u64 arg (arg 5)
    drivers/infiniband/hw/ipath/ipath_pe800.c: In function `ipath_pe_handle_hwerrors':
    drivers/infiniband/hw/ipath/ipath_pe800.c:353: warning: long long unsigned int format, long unsigned int arg (arg 5)
    drivers/infiniband/hw/ipath/ipath_pe800.c:353: warning: long long unsigned int format, long unsigned int arg (arg 3)

and then the build fails with:

    drivers/built-in.o(.text+0x133aa2): In function `ipath_modify_port':
    : undefined reference to `atomic_set_mask'
    drivers/built-in.o(.text+0x133ac2): In function `ipath_modify_port':
    : undefined reference to `atomic_clear_mask'

I also wouldn't say the driver is sparse clean.  I get 270 lines of
warnings when I try it:

    drivers/infiniband/hw/ipath/ipath_mad.c:103:17: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:103:17:    expected restricted unsigned long long [usertype] node_guid
    drivers/infiniband/hw/ipath/ipath_mad.c:103:17:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_mad.c:289:9: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:289:9:    expected unsigned short [unsigned] [short] [usertype] <noident>
    drivers/infiniband/hw/ipath/ipath_mad.c:289:9:    got restricted unsigned short [usertype] [force] <noident>
    drivers/infiniband/hw/ipath/ipath_mad.c:537:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_mad.c:537:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_mad.c:537:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_mad.c:902:27: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:902:27:    expected restricted unsigned short [usertype] symbol_error_counter
    drivers/infiniband/hw/ipath/ipath_mad.c:902:27:    got int 
    drivers/infiniband/hw/ipath/ipath_mad.c:916:22: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:916:22:    expected restricted unsigned short [usertype] port_rcv_errors
    drivers/infiniband/hw/ipath/ipath_mad.c:916:22:    got int 
    drivers/infiniband/hw/ipath/ipath_mad.c:921:30: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:921:30:    expected restricted unsigned short [usertype] port_rcv_remphys_errors
    drivers/infiniband/hw/ipath/ipath_mad.c:921:30:    got int 
    drivers/infiniband/hw/ipath/ipath_mad.c:926:25: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:926:25:    expected restricted unsigned short [usertype] port_xmit_discards
    drivers/infiniband/hw/ipath/ipath_mad.c:926:25:    got int 
    drivers/infiniband/hw/ipath/ipath_mad.c:931:21: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:931:21:    expected restricted unsigned int [usertype] port_xmit_data
    drivers/infiniband/hw/ipath/ipath_mad.c:931:21:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_mad.c:935:20: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:935:20:    expected restricted unsigned int [usertype] port_rcv_data
    drivers/infiniband/hw/ipath/ipath_mad.c:935:20:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_mad.c:939:24: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:939:24:    expected restricted unsigned int [usertype] port_xmit_packets
    drivers/infiniband/hw/ipath/ipath_mad.c:939:24:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_mad.c:944:23: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_mad.c:944:23:    expected restricted unsigned int [usertype] port_rcv_packets
    drivers/infiniband/hw/ipath/ipath_mad.c:944:23:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_qp.c:581:9: warning: incorrect type in return expression (different base types)
    drivers/infiniband/hw/ipath/ipath_qp.c:581:9:    expected unsigned int 
    drivers/infiniband/hw/ipath/ipath_qp.c:581:9:    got restricted unsigned int [usertype] [force] <noident>
    drivers/infiniband/hw/ipath/ipath_rc.c:103:16: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:103:16:    expected restricted unsigned int [usertype] aeth
    drivers/infiniband/hw/ipath/ipath_rc.c:103:16:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_rc.c:116:17: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:116:17:    expected restricted unsigned int [usertype] aeth
    drivers/infiniband/hw/ipath/ipath_rc.c:116:17:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_rc.c:147:19: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:147:19:    expected restricted unsigned int [usertype] aeth
    drivers/infiniband/hw/ipath/ipath_rc.c:147:19:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_rc.c:158:16: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:158:16:    expected restricted unsigned int [usertype] aeth
    drivers/infiniband/hw/ipath/ipath_rc.c:158:16:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_rc.c:519:45: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:519:45:    expected restricted unsigned long long [usertype] interface_id
    drivers/infiniband/hw/ipath/ipath_rc.c:519:45:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_rc.c:519:45: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:519:45:    expected restricted unsigned long long [usertype] interface_id
    drivers/infiniband/hw/ipath/ipath_rc.c:519:45:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_rc.c:656:15: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:656:15:    expected restricted unsigned int [usertype] aeth
    drivers/infiniband/hw/ipath/ipath_rc.c:656:15:    got unsigned int 
    drivers/infiniband/hw/ipath/ipath_rc.c:1456:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1456:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1456:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1147:12: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1147:12: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1147:12: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1163:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1163:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1163:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1253:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1253:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1253:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_rc.c:1609:16: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:1609:16:    expected restricted unsigned int [assigned] [usertype] imm_data
    drivers/infiniband/hw/ipath/ipath_rc.c:1609:16:    got unsigned int [unsigned] [usertype] <noident>
    drivers/infiniband/hw/ipath/ipath_rc.c:1650:24: warning: incorrect type in argument 3 (different base types)
    drivers/infiniband/hw/ipath/ipath_rc.c:1650:24:    expected int [signed] sig
    drivers/infiniband/hw/ipath/ipath_rc.c:1650:24:    got restricted unsigned int 
    drivers/infiniband/hw/ipath/ipath_uc.c:288:46: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_uc.c:288:46:    expected restricted unsigned long long [usertype] interface_id
    drivers/infiniband/hw/ipath/ipath_uc.c:288:46:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_uc.c:362:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_uc.c:362:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_uc.c:362:10: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_uc.c:473:16: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_uc.c:473:16:    expected restricted unsigned int [assigned] [usertype] imm_data
    drivers/infiniband/hw/ipath/ipath_uc.c:473:16:    got unsigned int [unsigned] [usertype] <noident>
    drivers/infiniband/hw/ipath/ipath_uc.c:517:24: warning: incorrect type in argument 3 (different base types)
    drivers/infiniband/hw/ipath/ipath_uc.c:517:24:    expected int [signed] sig
    drivers/infiniband/hw/ipath/ipath_uc.c:517:24:    got restricted unsigned int 
    drivers/infiniband/hw/ipath/ipath_uc.c:602:16: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_uc.c:602:16:    expected restricted unsigned int [addressable] [assigned] [usertype] imm_data
    drivers/infiniband/hw/ipath/ipath_uc.c:602:16:    got unsigned int [unsigned] [usertype] <noident>
    drivers/infiniband/hw/ipath/ipath_ud.c:321:46: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_ud.c:321:46:    expected restricted unsigned long long [usertype] interface_id
    drivers/infiniband/hw/ipath/ipath_ud.c:321:46:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ud.c:456:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_ud.c:456:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_ud.c:456:11: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_ud.c:457:13: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_ud.c:457:13: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_ud.c:457:13: warning: cast to restricted type
    drivers/infiniband/hw/ipath/ipath_ud.c:526:16: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_ud.c:526:16:    expected restricted unsigned int [assigned] [usertype] imm_data
    drivers/infiniband/hw/ipath/ipath_ud.c:526:16:    got unsigned int [unsigned] [usertype] <noident>
    drivers/infiniband/hw/ipath/ipath_ud.c:617:23: warning: incorrect type in argument 3 (different base types)
    drivers/infiniband/hw/ipath/ipath_ud.c:617:23:    expected int [signed] sig
    drivers/infiniband/hw/ipath/ipath_ud.c:617:23:    got restricted unsigned int 
    drivers/infiniband/hw/ipath/ipath_verbs.c:654:19: error: incompatible types in conditional expression (different base types)
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2: warning: incorrect type in argument 4 (different base types)
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    expected int 
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    got restricted unsigned short <noident>
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2: warning: incorrect type in argument 5 (different base types)
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    expected int 
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    got restricted unsigned short <noident>
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2: warning: incorrect type in argument 6 (different base types)
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    expected int 
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    got restricted unsigned short <noident>
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2: warning: incorrect type in argument 7 (different base types)
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    expected int 
    drivers/infiniband/hw/ipath/ipath_copy.c:104:2:    got restricted unsigned short <noident>
    drivers/infiniband/hw/ipath/ipath_copy.c:432:14: error: incompatible types for operation (!=)
    drivers/infiniband/hw/ipath/ipath_driver.c:669:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:671:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:673:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:675:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:677:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:679:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:681:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:683:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:685:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:687:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:689:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:691:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:693:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:695:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:697:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:699:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:701:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:703:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:705:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:707:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:709:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:711:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:713:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:715:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:717:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:719:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:721:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:723:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:725:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:727:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:729:10: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_driver.c:1075:4: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:290:5: warning: incorrect type in initializer (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:290:5:    expected restricted unsigned long long static const [toplevel] [usertype] infinipath_hwe_htcmemparityerr_mask
    drivers/infiniband/hw/ipath/ipath_ht400.c:290:5:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ht400.c:295:5: warning: incorrect type in initializer (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:295:5:    expected restricted unsigned long long static const [toplevel] [usertype] infinipath_hwe_htclnkabyte0crcerr
    drivers/infiniband/hw/ipath/ipath_ht400.c:295:5:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ht400.c:297:5: warning: incorrect type in initializer (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:297:5:    expected restricted unsigned long long static const [toplevel] [usertype] infinipath_hwe_htclnkabyte1crcerr
    drivers/infiniband/hw/ipath/ipath_ht400.c:297:5:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ht400.c:299:5: warning: incorrect type in initializer (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:299:5:    expected restricted unsigned long long static const [toplevel] [usertype] infinipath_hwe_htclnkbbyte0crcerr
    drivers/infiniband/hw/ipath/ipath_ht400.c:299:5:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ht400.c:301:5: warning: incorrect type in initializer (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:301:5:    expected restricted unsigned long long static const [toplevel] [usertype] infinipath_hwe_htclnkbbyte1crcerr
    drivers/infiniband/hw/ipath/ipath_ht400.c:301:5:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ht400.c:346:17: warning: cast from restricted type
    drivers/infiniband/hw/ipath/ipath_ht400.c:382:8: warning: incorrect type in argument 3 (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:382:8:    expected unsigned long long [unsigned] [usertype] value
    drivers/infiniband/hw/ipath/ipath_ht400.c:382:8:    got restricted unsigned long long [usertype] ipath_hwerrmask
    drivers/infiniband/hw/ipath/ipath_ht400.c:385:3: warning: cast from restricted type
    drivers/infiniband/hw/ipath/ipath_ht400.c:411:9: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_ht400.c:411:9:    expected restricted unsigned long long [usertype] hwerrs
    drivers/infiniband/hw/ipath/ipath_ht400.c:411:9:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_ht400.c:421:20: error: incompatible types for operation (==)
    drivers/infiniband/hw/ipath/ipath_ht400.c:434:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:448:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:449:3: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:449:3: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_ht400.c:449:3: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:449:3: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_ht400.c:492:9: error: incompatible types for operation (<<)
    drivers/infiniband/hw/ipath/ipath_ht400.c:493:25: error: incompatible types for operation (>>)
    drivers/infiniband/hw/ipath/ipath_ht400.c:493:11: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_ht400.c:500:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:502:25: error: incompatible types for operation (>>)
    drivers/infiniband/hw/ipath/ipath_ht400.c:502:11: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_ht400.c:509:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:511:25: error: incompatible types for operation (>>)
    drivers/infiniband/hw/ipath/ipath_ht400.c:511:11: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_ht400.c:518:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:520:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:522:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:524:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:526:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:532:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:534:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:536:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:538:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:553:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:556:34: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:556:6: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_ht400.c:559:35: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:564:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:574:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_ht400.c:576:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_init_chip.c:415:24: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_init_chip.c:415:24:    expected restricted unsigned long long volatile [usertype] *ipath_hdrqtailptr
    drivers/infiniband/hw/ipath/ipath_init_chip.c:415:24:    got unsigned long long [usertype] *extern [addressable] [toplevel] ipath_port0_rcvhdrtail
    drivers/infiniband/hw/ipath/ipath_init_chip.c:822:7: warning: incorrect type in argument 3 (different base types)
    drivers/infiniband/hw/ipath/ipath_init_chip.c:822:7:    expected unsigned long long [unsigned] [usertype] value
    drivers/infiniband/hw/ipath/ipath_init_chip.c:822:7:    got restricted unsigned long long [usertype] ipath_hwerrmask
    drivers/infiniband/hw/ipath/ipath_init_chip.c:829:5: warning: incorrect type in argument 3 (different base types)
    drivers/infiniband/hw/ipath/ipath_init_chip.c:829:5:    expected unsigned long long [unsigned] [usertype] value
    drivers/infiniband/hw/ipath/ipath_init_chip.c:829:5:    got restricted unsigned long long [usertype] ipath_maskederrs
    drivers/infiniband/hw/ipath/ipath_intr.c:103:12: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:297:26: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:298:57: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:300:27: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:370:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:375:24: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:376:3: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:376:3: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_intr.c:376:3: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:376:3: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_intr.c:380:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:397:55: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:432:31: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:444:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:452:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:456:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:459:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:471:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:503:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:521:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:539:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:542:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_intr.c:770:18: error: incompatible types for operation (==)
    drivers/infiniband/hw/ipath/ipath_layer.c:1083:14: error: incompatible types for operation (!=)
    drivers/infiniband/hw/ipath/ipath_pe800.c:316:9: warning: incorrect type in assignment (different base types)
    drivers/infiniband/hw/ipath/ipath_pe800.c:316:9:    expected restricted unsigned long long [usertype] hwerrs
    drivers/infiniband/hw/ipath/ipath_pe800.c:316:9:    got unsigned long long 
    drivers/infiniband/hw/ipath/ipath_pe800.c:325:20: error: incompatible types for operation (==)
    drivers/infiniband/hw/ipath/ipath_pe800.c:338:11: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:352:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:389:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:398:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:400:25: error: incompatible types for operation (>>)
    drivers/infiniband/hw/ipath/ipath_pe800.c:400:11: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_pe800.c:407:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:409:25: error: incompatible types for operation (>>)
    drivers/infiniband/hw/ipath/ipath_pe800.c:409:11: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_pe800.c:416:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:418:25: error: incompatible types for operation (>>)
    drivers/infiniband/hw/ipath/ipath_pe800.c:418:11: error: cast from unknown type
    drivers/infiniband/hw/ipath/ipath_pe800.c:425:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:427:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:433:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:439:35: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:444:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:454:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:456:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:466:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:468:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:470:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:472:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:474:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:477:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_pe800.c:479:13: error: incompatible types for operation (&)
    drivers/infiniband/hw/ipath/ipath_stats.c:243:55: error: incompatible types for operation (&)
