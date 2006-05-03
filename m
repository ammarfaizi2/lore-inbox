Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWECWEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWECWEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWECWEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:04:25 -0400
Received: from gw-cistron.kwaak.net ([62.216.22.210]:60334 "EHLO
	mail.kwaak.net") by vger.kernel.org with ESMTP id S1751372AbWECWEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:04:25 -0400
Date: Thu, 4 May 2006 00:04:17 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: possible bug in kmem_cache related code
Message-ID: <20060503220417.GI24722@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44560FE0.2000004@voltaire.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ard van Breemen <ard@kwaak.net>
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.878,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL -0.58)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or Gerlitz wrote:
> However, for the mean time can more people of the openib and
> open iscsi communities set 2.6.17-rcX to see that the issue
> reproduces with my synthetic module and with ib/iscsi code (you
> know this kernel will be out in few weeks from now...)

For what it's worth:
On a dual opteron running 2.6.17-rc2-git6 with reiser4 for 2.6.16
patch:
md layer, raid5 on 4 disks, no other stuff then that.
at 23:38 I said: mdadm --stop /dev/md6
May  2 20:38:27 jip kernel: <5>reiser4[dd(2791)]: disable_write_barrier (fs/reiser4/wander.c:234)[zam-1055]:
May  2 20:38:27 jip kernel: NOTICE: md6 does not support write barriers, using synchronous write instead.
May  2 20:38:27 jip kernel: 
May  3 23:38:19 jip kernel: slab error in kmem_cache_destroy(): cache `raid5/md6': Can't free all objects
May  3 23:38:19 jip kernel: 
May  3 23:38:19 jip kernel: Call Trace: <ffffffff802749cc>{kmem_cache_destroy+156}
May  3 23:38:19 jip kernel:        <ffffffff8044ed71>{shrink_stripes+33} <ffffffff80452993>{stop+51}
May  3 23:38:19 jip kernel:        <ffffffff8045daf5>{do_md_stop+245} <ffffffff80255035>{filemap_nopage+389}
May  3 23:38:19 jip kernel:        <ffffffff8045f648>{md_ioctl+744} <ffffffff802631a0>{do_no_page+576}
May  3 23:38:19 jip kernel:        <ffffffff8035ba14>{blkdev_driver_ioctl+100} <ffffffff8035bc3d>{blkdev_ioctl+493}
May  3 23:38:19 jip kernel:        <ffffffff80369451>{__up_read+33} <ffffffff802826bb>{block_ioctl+27}
May  3 23:38:19 jip kernel:        <ffffffff8028c83a>{do_ioctl+58} <ffffffff8028cb61>{vfs_ioctl+449}
May  3 23:38:19 jip kernel:        <ffffffff8028cbdd>{sys_ioctl+77} <ffffffff802a814b>{do_ioctl32_pointer+11}
May  3 23:38:19 jip kernel:        <ffffffff802a61e2>{compat_sys_ioctl+386} <ffffffff8021c85e>{ia32_sysret+0}
May  3 23:38:19 jip kernel: md: md6 stopped.

Second system, same specs, except running drbd on all sata disks instead of
raid5 (yes, external module):
May  3 15:49:19 localhost kernel: drbd1: drbd_cleanup: (!list_empty(&mdev->data.work.q)) in /usr/src/kernel/tyan-s2891/git/modules/drbd/drbd/drbd_main.c:2173
May  3 15:49:19 localhost kernel: drbd1: lp = ffff81007c4f8888 in /usr/src/kernel/tyan-s2891/git/modules/drbd/drbd/drbd_main.c:2176
May  3 15:49:19 localhost kernel: slab error in kmem_cache_destroy(): cache `drbd_ee_cache': Can't free all objects
May  3 15:49:19 localhost kernel: 
May  3 15:49:19 localhost kernel: Call Trace: <ffffffff802749cc>{kmem_cache_destroy+156}
May  3 15:49:19 localhost kernel:        <ffffffff8807df01>{:drbd:drbd_destroy_mempools+113}
May  3 15:49:19 localhost kernel:        <ffffffff8807f2f2>{:drbd:drbd_cleanup+1074} <ffffffff802484e8>{sys_delete_module+312}
May  3 15:49:19 localhost kernel:        <ffffffff802663b5>{sys_munmap+85} <ffffffff80209b5a>{system_call+126}
May  3 15:49:19 localhost kernel: drbd: kmem_cache_destroy(drbd_ee_cache) FAILED
May  3 15:49:19 localhost kernel: slab error in kmem_cache_destroy(): cache `drbd_req_cache': Can't free all objects
May  3 15:49:19 localhost kernel: 
May  3 15:49:19 localhost kernel: Call Trace: <ffffffff802749cc>{kmem_cache_destroy+156}
May  3 15:49:19 localhost kernel:        <ffffffff8807df24>{:drbd:drbd_destroy_mempools+148}
May  3 15:49:19 localhost kernel:        <ffffffff8807f2f2>{:drbd:drbd_cleanup+1074} <ffffffff802484e8>{sys_delete_module+312}
May  3 15:49:19 localhost kernel:        <ffffffff802663b5>{sys_munmap+85} <ffffffff80209b5a>{system_call+126}
May  3 15:49:19 localhost kernel: drbd: kmem_cache_destroy(drbd_request_cache) FAILED
May  3 15:49:19 localhost kernel: drbd: module cleanup done.


NUMA and such is enabled


-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end
