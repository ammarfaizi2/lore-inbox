Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUG2Hoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUG2Hoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUG2Hog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:44:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:15073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267291AbUG2Ho0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:44:26 -0400
Date: Thu, 29 Jul 2004 00:42:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk, davem@redhat.com, cw@f00f.org,
       peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040729004242.7601f777.akpm@osdl.org>
In-Reply-To: <16648.42669.907048.112765@wombat.chubb.wattle.id.au>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<20040729000837.GA24956@taniwha.stupidest.org>
	<20040728171414.5de8da96.davem@redhat.com>
	<20040729002924.GK12308@parcelfarce.linux.theplanet.co.uk>
	<16648.42669.907048.112765@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> wrote:
>
> The nice thing about the current three-copy implementation is that
> it's simple and obviously correct.  Personally, I don't think that the
> increased complexity of arhcitecture-specific callbacks, etc., is
> worth the small performance gain.
> 

hmm.  Here's a Pentium III profile of a 260,000-file
`find 00000000 -type f -mtime 2000':

00000000c015fcb0 __user_walk                                 233   3.0658
00000000c0122498 current_kernel_time                         241   3.5441
00000000c01700b0 __mark_inode_dirty                          263   0.7225
00000000c016dacc set_fs_pwd                                  264   1.8333
00000000c0163510 vfs_readdir                                 315   2.3864
00000000c01f9fc8 copy_to_user                                330   4.8529
00000000c01375f0 find_get_page                               332   4.3684
00000000c015e7e4 path_release                                368   6.5714
00000000c015e580 getname                                     381   2.3813
00000000c0143c0c set_page_address                            411   1.0275
00000000c0143b80 page_address                                449   3.2071
00000000c01a1cc0 ext2_readdir                                482   0.8087
00000000c01637fc filldir64                                   499   2.2277
00000000c01678b0 dput                                        533   1.1897
00000000c013f4b8 kmem_cache_alloc                            612   7.2857
00000000c013f794 kmem_cache_free                             625   8.2237
00000000c01f9c98 strncpy_from_user                           695   8.2738
00000000c015eb2c do_lookup                                   738   5.5909
00000000c01f9db0 __copy_user_intel                           741   4.6312
00000000c01f9510 atomic_dec_and_lock                         801  10.6800
00000000c015b488 cp_new_stat64                              1065   4.2262
00000000c01f9ef0 __copy_to_user_ll                          1090  10.4808
00000000c015af14 vfs_getattr                                1097   8.3106
00000000c0105c0f sysenter_past_esp                          1201  10.6283
00000000c015ae70 generic_fillattr                           1815  11.0671
00000000c015fa1c path_lookup                                1833   4.9810
00000000c015ebb0 link_path_walk                             1915   0.5940
00000000c0168710 __d_lookup                                 6170  22.0357
00000000c0104034 default_idle                             108054 1929.5357
0000000000000000 total                                    138203   0.0547


