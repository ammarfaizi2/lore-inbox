Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUDQVkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUDQVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 17:40:18 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:7299 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S264045AbUDQVj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 17:39:58 -0400
Subject: [CHECKER] More probably security holes in 2.6.5
From: Ken Ashcraft <ken@coverity.com>
To: linux-kernel@vger.kernel.org
Cc: linux@coverity.com
Content-Type: text/plain
Message-Id: <1082237846.748.4.camel@dns.coverity.int>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Apr 2004 14:37:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, I reported a number of security holes in 2.6.5 that I found
using static analysis at Coverity.  Thanks to Chris Wright for providing
patches and feedback on many of them.

The reports today are all different from yesterday's.  All of them are
interprocedural, meaning that the error trace spans multiple functions. 
Luckily, it looks like they all have straightforward fixes.

The bugs in kcapi.c are incredibly subtle.  Take a look and you'll
probably learn something about type conversion in C.

Your feedback is appreciated,
Ken Ashcraft

PS- Visit http://linuxbugs.coverity.com for hundreds of other bugs in
the Linux Kernel found by Coverity.

#  Total 				  = 17
# BUGs	|	File Name
12	|	/drivers/message/fusion/mptctl.c
3	|	/drivers/isdn/capi/kcapi.c
2	|	/drivers/char/drm/i810_dma.c

---------------------------------------------------------
[BUG] get_capi_ctr_by_nr is broken: unsigned short is promoted to int in
comparison.  if contr is 0, user can index off left of array.
/home/kash/linux/linux-2.6.5/drivers/isdn/capi/kcapi.c:804:old_capi_manufacturer: ERROR:TAINT: 802:804:Passing unbounded user value "(rdef).contr" as arg 0 to function "get_capi_ctr_by_nr", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/isdn/capi/kcapi.c,get_capi_ctr_by_nr,0,trustingsink)]    [PATH=] 
		}
		capi_ctr_put(card);
		return 0;

	case AVMB1_RESETCARD:
Start --->
		if (copy_from_user((void *)&rdef, data, sizeof(avmb1_resetdef)))
			return -EFAULT;
Error --->
		card = get_capi_ctr_by_nr(rdef.contr);
		if (!card)
			return -ESRCH;

---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/isdn/capi/kcapi.c:848:capi20_manufacturer: ERROR:TAINT: 845:848:Passing unbounded user value "(fdef).contr" as arg 0 to function "get_capi_ctr_by_nr", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/isdn/capi/kcapi.c,get_capi_ctr_by_nr,0,trustingsink)]    [PATH=] 
#endif
	case KCAPI_CMD_TRACE:
	{
		kcapi_flagdef fdef;

Start --->
		if (copy_from_user((void *)&fdef, data, sizeof(kcapi_flagdef)))
			return -EFAULT;

Error --->
		card = get_capi_ctr_by_nr(fdef.contr);
		if (!card)
			return -ESRCH;

---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/isdn/capi/kcapi.c:749:old_capi_manufacturer: ERROR:TAINT: 739:749:Passing unbounded user value "(ldef).contr" as arg 0 to function "get_capi_ctr_by_nr", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/isdn/capi/kcapi.c,get_capi_ctr_by_nr,0,trustingsink)]    [PATH=] 

	case AVMB1_LOAD:
	case AVMB1_LOAD_AND_CONFIG:

		if (cmd == AVMB1_LOAD) {
Start --->
			if (copy_from_user((void *)&ldef, data,
					   sizeof(avmb1_loaddef)))
				return -EFAULT;
			ldef.t4config.len = 0;
			ldef.t4config.data = 0;
		} else {
			if (copy_from_user((void *)&ldef, data,
					   sizeof(avmb1_loadandconfigdef)))
				return -EFAULT;
		}
Error --->
		card = get_capi_ctr_by_nr(ldef.contr);
		card = capi_ctr_get(card);
		if (!card)
			return -ESRCH;
---------------------------------------------------------
[BUG] no lower bound check
/home/kash/linux/linux-2.6.5/drivers/char/drm/i810_dma.c:1276:i810_dma_mc: ERROR:TAINT: 1267:1276:Passing unbounded user value "(mc).used" as arg 2 to function "i810_dma_dispatch_mc", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/char/drm/i810_dma.c,i810_dma_dispatch_mc,1,trustingsink)]    [PATH= "(*((*dev).lock).hw_lock).lock & -2147483648 == 0" on line 1271 is false => "copy_from_user != 0" on line 1267 is false] 
	u32 *hw_status = dev_priv->hw_status_page;
	drm_i810_sarea_t *sarea_priv = (drm_i810_sarea_t *)
		dev_priv->sarea_priv;
	drm_i810_mc_t mc;

Start --->
	if (copy_from_user(&mc, (drm_i810_mc_t *)arg, sizeof(mc)))
		return -EFAULT;


	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("i810_dma_mc called without lock held\n");
		return -EINVAL;
	}

Error --->
	i810_dma_dispatch_mc(dev, dma->buflist[mc.idx], mc.used,
		mc.last_render );

	atomic_add(mc.used, &dev->counts[_DRM_STAT_SECONDARY]);
---------------------------------------------------------
[BUG] in subroutine: *(u32 *)((u32)buf_priv->virtual + used) = 0;
without lower bounds check
/home/kash/linux/linux-2.6.5/drivers/char/drm/i810_dma.c:1071:i810_dma_vertex: ERROR:TAINT: 1057:1071:Passing unbounded user value "(vertex).used" as arg 3 to function "i810_dma_dispatch_vertex", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/char/drm/i810_dma.c,i810_dma_dispatch_vertex,1,trustingsink)]    [PATH= "(vertex).idx > (*dma).buf_count" on line 1068 is false => "(vertex).idx < 0" on line 1068 is false => "i810_flags & 1 != 0" on line 1065 is false => "(*((*dev).lock).hw_lock).lock & -2147483648 == 0" on line 1060 is false => "copy_from_user != 0" on line 1057 is false] 
      	u32 *hw_status = dev_priv->hw_status_page;
   	drm_i810_sarea_t *sarea_priv = (drm_i810_sarea_t *)
     					dev_priv->sarea_priv;
	drm_i810_vertex_t vertex;

Start --->
	if (copy_from_user(&vertex, (drm_i810_vertex_t *)arg, sizeof(vertex)))
		return -EFAULT;

	if (!_DRM_LOCK_IS_HELD(dev->lock.hw_lock->lock)) {
		DRM_ERROR("i810_dma_vertex called without lock held\n");
		return -EINVAL;
	}

	DRM_DEBUG("i810 dma vertex, idx %d used %d discard %d\n",
		  vertex.idx, vertex.used, vertex.discard);

	if (vertex.idx < 0 || vertex.idx > dma->buf_count) 
		return -EINVAL;

Error --->
	i810_dma_dispatch_vertex( dev,
				  dma->buflist[ vertex.idx ],
				  vertex.discard, vertex.used );




---------------------------------------------------------
[BUG] mpt_verify_adapter fails to do a lower bound check.  it is called
with user input 12 times in mptctl.c.  Since the error is really in
mpt_verify_adapter, I removed the code snippets for 10 of the call sites
that look identical to this first one.  Let me know if you want them
back.


/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1675:mptctl_eventreport: ERROR:TAINT: 1668:1675:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
	MPT_ADAPTER		 *ioc;
	int			 iocnum;
	int			 numBytes, maxEvents, max;

	dctlprintk(("mptctl_eventreport called.\n"));
Start --->
	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_eventreport)))
{
		printk(KERN_ERR "%s@%d::mptctl_eventreport - "
			"Unable to read in mpt_ioctl_eventreport struct @ %p\n",
				__FILE__, __LINE__, (void*)uarg);
		return -EFAULT;
	}

Error --->
	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
	    (ioc == NULL)) {
		dctlprintk((KERN_ERR "%s::mptctl_eventreport() @%d - ioc%d not
found!\n",
				__FILE__, __LINE__, iocnum));
---------------------------------------------------------
[BUG] calls mpt_verify_adapter
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:748:mptctl_fw_download: ERROR:TAINT: 741:748:Passing unbounded user value "(kfwdl).iocnum" as arg 0 to function "mptctl_do_fw_download", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptctl.c,mptctl_do_fw_download,0,trustingsink)]    [PATH= "copy_from_user != 0" on line 741 is false] 
{
	struct mpt_fw_xfer	*ufwdl = (struct mpt_fw_xfer *) arg;
	struct mpt_fw_xfer	 kfwdl;

	dctlprintk((KERN_INFO "mptctl_fwdl called. mptctl_id = %xh\n",
mptctl_id)); //tc
Start --->
	if (copy_from_user(&kfwdl, ufwdl, sizeof(struct mpt_fw_xfer))) {
		printk(KERN_ERR "%s@%d::_ioctl_fwdl - "
				"Unable to copy mpt_fw_xfer struct @ %p\n",
				__FILE__, __LINE__, (void*)ufwdl);
		return -EFAULT;
	}

Error --->
	return mptctl_do_fw_download(kfwdl.iocnum, kfwdl.bufp, kfwdl.fwlen);
}

/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1729:mptctl_replace_fw: ERROR:TAINT: 1722:1729:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1529:mptctl_readtest: ERROR:TAINT: 1522:1529:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:2422:mptctl_hp_hostinfo: ERROR:TAINT: 2415:2422:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:2604:mptctl_hp_targetinfo: ERROR:TAINT: 2597:2604:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1367:mptctl_gettargetinfo: ERROR:TAINT: 1360:1367:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1627:mptctl_eventenable: ERROR:TAINT: 1620:1627:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:687:mptctl_do_reset: ERROR:TAINT: 680:687:Passing unbounded user value "((krinfo).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1589:mptctl_eventquery: ERROR:TAINT: 1582:1589:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1236:mptctl_getiocinfo: ERROR:TAINT: 1229:1236:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH=] 
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/drivers/message/fusion/mptctl.c:1815:mptctl_mpt_command: ERROR:TAINT: 1808:1815:Passing unbounded user value "((karg).hdr).iocnum" as arg 0 to function "mpt_verify_adapter", which uses it unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)] [SINK_MODEL=(.root/drivers/message/fusion/mptbase.c,mpt_verify_adapter,0,trustingsink)]    [PATH= "ioc == 0" on line 1815 is false => "iocnum = mpt_verify_adapter < 0" on line 1815 is false => "copy_from_user != 0" on line 1808 is false] 



