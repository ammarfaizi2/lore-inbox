Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVL0Ay6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVL0Ay6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 19:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVL0Ay6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 19:54:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:18103 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932182AbVL0Ay5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 19:54:57 -0500
Date: Mon, 26 Dec 2005 16:54:33 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.14.5
Message-ID: <20051227005433.GB21786@kroah.com>
References: <20051227005327.GA21786@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227005327.GA21786@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f00339c..ea6f2f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Affluent Albatross
 
 # *DOCUMENTATION*
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e383d61..00fe1cd 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -813,7 +813,7 @@ acpi_video_device_write_brightness(struc
 
 	ACPI_FUNCTION_TRACE("acpi_video_device_write_brightness");
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || !dev->brightness || count + 1 > sizeof str)
 		return_VALUE(-EINVAL);
 
 	if (copy_from_user(str, buffer, count))
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 8a603ea..9aa2d02 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -660,7 +660,12 @@ static int adpt_abort(struct scsi_cmnd *
 	msg[2] = 0;
 	msg[3]= 0; 
 	msg[4] = (u32)cmd;
-	if( (rcode = adpt_i2o_post_wait(pHba, msg, sizeof(msg), FOREVER)) != 0){
+	if (pHba->host)
+		spin_lock_irq(pHba->host->host_lock);
+	rcode = adpt_i2o_post_wait(pHba, msg, sizeof(msg), FOREVER);
+	if (pHba->host)
+		spin_unlock_irq(pHba->host->host_lock);
+	if (rcode != 0) {
 		if(rcode == -EOPNOTSUPP ){
 			printk(KERN_INFO"%s: Abort cmd not supported\n",pHba->name);
 			return FAILED;
@@ -697,10 +702,15 @@ static int adpt_device_reset(struct scsi
 	msg[2] = 0;
 	msg[3] = 0;
 
+	if (pHba->host)
+		spin_lock_irq(pHba->host->host_lock);
 	old_state = d->state;
 	d->state |= DPTI_DEV_RESET;
-	if( (rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER)) ){
-		d->state = old_state;
+	rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER);
+	d->state = old_state;
+	if (pHba->host)
+		spin_unlock_irq(pHba->host->host_lock);
+	if (rcode != 0) {
 		if(rcode == -EOPNOTSUPP ){
 			printk(KERN_INFO"%s: Device reset not supported\n",pHba->name);
 			return FAILED;
@@ -708,7 +718,6 @@ static int adpt_device_reset(struct scsi
 		printk(KERN_INFO"%s: Device reset failed\n",pHba->name);
 		return FAILED;
 	} else {
-		d->state = old_state;
 		printk(KERN_INFO"%s: Device reset successful\n",pHba->name);
 		return SUCCESS;
 	}
@@ -721,6 +730,7 @@ static int adpt_bus_reset(struct scsi_cm
 {
 	adpt_hba* pHba;
 	u32 msg[4];
+	u32 rcode;
 
 	pHba = (adpt_hba*)cmd->device->host->hostdata[0];
 	memset(msg, 0, sizeof(msg));
@@ -729,7 +739,12 @@ static int adpt_bus_reset(struct scsi_cm
 	msg[1] = (I2O_HBA_BUS_RESET<<24|HOST_TID<<12|pHba->channel[cmd->device->channel].tid);
 	msg[2] = 0;
 	msg[3] = 0;
-	if(adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER) ){
+	if (pHba->host)
+		spin_lock_irq(pHba->host->host_lock);
+	rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER);
+	if (pHba->host)
+		spin_unlock_irq(pHba->host->host_lock);
+	if (rcode != 0) {
 		printk(KERN_WARNING"%s: Bus reset failed.\n",pHba->name);
 		return FAILED;
 	} else {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0074f28..a71ad5a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1129,6 +1129,26 @@ static void scsi_generic_done(struct scs
 	scsi_io_completion(cmd, cmd->result == 0 ? cmd->bufflen : 0, 0);
 }
 
+void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd, int retries)
+{
+	struct request *req = cmd->request;
+
+	BUG_ON(sizeof(req->cmd) > sizeof(cmd->cmnd));
+	memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
+	cmd->cmd_len = req->cmd_len;
+	if (!req->data_len)
+		cmd->sc_data_direction = DMA_NONE;
+	else if (rq_data_dir(req) == WRITE)
+		cmd->sc_data_direction = DMA_TO_DEVICE;
+	else
+		cmd->sc_data_direction = DMA_FROM_DEVICE;
+
+	cmd->transfersize = req->data_len;
+	cmd->allowed = retries;
+	cmd->timeout_per_command = req->timeout;
+}
+EXPORT_SYMBOL_GPL(scsi_setup_blk_pc_cmnd);
+
 static int scsi_prep_fn(struct request_queue *q, struct request *req)
 {
 	struct scsi_device *sdev = q->queuedata;
@@ -1264,18 +1284,7 @@ static int scsi_prep_fn(struct request_q
 				goto kill;
 			}
 		} else {
-			memcpy(cmd->cmnd, req->cmd, sizeof(cmd->cmnd));
-			cmd->cmd_len = req->cmd_len;
-			if (rq_data_dir(req) == WRITE)
-				cmd->sc_data_direction = DMA_TO_DEVICE;
-			else if (req->data_len)
-				cmd->sc_data_direction = DMA_FROM_DEVICE;
-			else
-				cmd->sc_data_direction = DMA_NONE;
-			
-			cmd->transfersize = req->data_len;
-			cmd->allowed = 3;
-			cmd->timeout_per_command = req->timeout;
+			scsi_setup_blk_pc_cmnd(cmd, 3);
 			cmd->done = scsi_generic_done;
 		}
 	}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9a1dc0c..3229961 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -231,24 +231,10 @@ static int sd_init_command(struct scsi_c
 	 * SG_IO from block layer already setup, just copy cdb basically
 	 */
 	if (blk_pc_request(rq)) {
-		if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
-			return 0;
-
-		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-		SCpnt->cmd_len = rq->cmd_len;
-		if (rq_data_dir(rq) == WRITE)
-			SCpnt->sc_data_direction = DMA_TO_DEVICE;
-		else if (rq->data_len)
-			SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-		else
-			SCpnt->sc_data_direction = DMA_NONE;
-
-		this_count = rq->data_len;
+		scsi_setup_blk_pc_cmnd(SCpnt, SD_PASSTHROUGH_RETRIES);
 		if (rq->timeout)
 			timeout = rq->timeout;
 
-		SCpnt->transfersize = rq->data_len;
-		SCpnt->allowed = SD_PASSTHROUGH_RETRIES;
 		goto queue;
 	}
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 561901b..ffdcd60 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -320,25 +320,11 @@ static int sr_init_command(struct scsi_c
 	 * these are already setup, just copy cdb basically
 	 */
 	if (SCpnt->request->flags & REQ_BLOCK_PC) {
-		struct request *rq = SCpnt->request;
+		scsi_setup_blk_pc_cmnd(SCpnt, MAX_RETRIES);
 
-		if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
-			return 0;
-
-		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-		SCpnt->cmd_len = rq->cmd_len;
-		if (!rq->data_len)
-			SCpnt->sc_data_direction = DMA_NONE;
-		else if (rq_data_dir(rq) == WRITE)
-			SCpnt->sc_data_direction = DMA_TO_DEVICE;
-		else
-			SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-
-		this_count = rq->data_len;
-		if (rq->timeout)
-			timeout = rq->timeout;
+		if (SCpnt->timeout_per_command)
+			timeout = SCpnt->timeout_per_command;
 
-		SCpnt->transfersize = rq->data_len;
 		goto queue;
 	}
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index d001c04..6ded0f5 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4196,27 +4196,10 @@ static void st_intr(struct scsi_cmnd *SC
  */
 static int st_init_command(struct scsi_cmnd *SCpnt)
 {
-	struct request *rq;
-
 	if (!(SCpnt->request->flags & REQ_BLOCK_PC))
 		return 0;
 
-	rq = SCpnt->request;
-	if (sizeof(rq->cmd) > sizeof(SCpnt->cmnd))
-		return 0;
-
-	memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
-	SCpnt->cmd_len = rq->cmd_len;
-
-	if (rq_data_dir(rq) == WRITE)
-		SCpnt->sc_data_direction = DMA_TO_DEVICE;
-	else if (rq->data_len)
-		SCpnt->sc_data_direction = DMA_FROM_DEVICE;
-	else
-		SCpnt->sc_data_direction = DMA_NONE;
-
-	SCpnt->timeout_per_command = rq->timeout;
-	SCpnt->transfersize = rq->data_len;
+	scsi_setup_blk_pc_cmnd(SCpnt, 0);
 	SCpnt->done = st_intr;
 	return 1;
 }
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
index 0b64522..f72d705 100644
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -137,6 +137,7 @@ static void hidinput_configure_usage(str
 			switch (usage->hid & 0xffff) {
 				case 0xba: map_abs(ABS_RUDDER); break;
 				case 0xbb: map_abs(ABS_THROTTLE); break;
+				default:   goto ignore;
 			}
 			break;
 
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 7cbf068..fc95c4d 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -107,7 +107,7 @@ static int nfsacld_proc_setacl(struct sv
 	dprintk("nfsd: SETACL(2acl)   %s\n", SVCFH_fmt(&argp->fh));
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_SATTR);
 
 	if (!nfserr) {
 		nfserr = nfserrno( nfsd_set_posix_acl(
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 64ba405..16e10c1 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -101,7 +101,7 @@ static int nfsd3_proc_setacl(struct svc_
 	int nfserr = 0;
 
 	fh = fh_copy(&resp->fh, &argp->fh);
-	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP);
+	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_SATTR);
 
 	if (!nfserr) {
 		nfserr = nfserrno( nfsd_set_posix_acl(
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index c231e9a..d50482b 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -866,6 +866,7 @@ enum rtnetlink_groups {
 #define	RTNLGRP_IPV4_MROUTE	RTNLGRP_IPV4_MROUTE
 	RTNLGRP_IPV4_ROUTE,
 #define RTNLGRP_IPV4_ROUTE	RTNLGRP_IPV4_ROUTE
+	RTNLGRP_NOP1,
 	RTNLGRP_IPV6_IFADDR,
 #define RTNLGRP_IPV6_IFADDR	RTNLGRP_IPV6_IFADDR
 	RTNLGRP_IPV6_MROUTE,
@@ -876,8 +877,11 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV6_IFINFO	RTNLGRP_IPV6_IFINFO
 	RTNLGRP_DECnet_IFADDR,
 #define RTNLGRP_DECnet_IFADDR	RTNLGRP_DECnet_IFADDR
+	RTNLGRP_NOP2,
 	RTNLGRP_DECnet_ROUTE,
 #define RTNLGRP_DECnet_ROUTE	RTNLGRP_DECnet_ROUTE
+	RTNLGRP_NOP3,
+	RTNLGRP_NOP4,
 	RTNLGRP_IPV6_PREFIX,
 #define RTNLGRP_IPV6_PREFIX	RTNLGRP_IPV6_PREFIX
 	__RTNLGRP_MAX
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 5beae1c..1cdb879 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -890,6 +890,7 @@ struct xfrm_state * xfrm_find_acq(u8 mod
 extern void xfrm_policy_flush(void);
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 extern int xfrm_flush_bundles(void);
+extern void xfrm_flush_all_bundles(void);
 extern int xfrm_bundle_ok(struct xfrm_dst *xdst, struct flowi *fl, int family);
 extern void xfrm_init_pmtu(struct dst_entry *dst);
 
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index bed4b7c..ebb6a16 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -150,5 +150,6 @@ extern struct scsi_cmnd *scsi_get_comman
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_io_completion(struct scsi_cmnd *, unsigned int, unsigned int);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
+extern void scsi_setup_blk_pc_cmnd(struct scsi_cmnd *cmd, int retries);
 
 #endif /* _SCSI_SCSI_CMND_H */
diff --git a/kernel/params.c b/kernel/params.c
index 1a8614b..fe8f1e9 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -618,7 +618,7 @@ static void __init param_sysfs_builtin(v
 
 
 /* module-related sysfs stuff */
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_SYSFS
 
 #define to_module_attr(n) container_of(n, struct module_attribute, attr);
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b748648..f2a8750 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -165,6 +165,9 @@ int vlan_skb_recv(struct sk_buff *skb, s
 
 	skb_pull(skb, VLAN_HLEN); /* take off the VLAN header (4 bytes currently) */
 
+	/* Need to correct hardware checksum */
+	skb_postpull_rcsum(skb, vhdr, VLAN_HLEN);
+
 	/* Ok, lets check to make sure the device (dev) we
 	 * came in on is what this VLAN is attached to.
 	 */
diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index d8e36b7..43a0b35 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -295,7 +295,7 @@ static int check_hbh_len(struct sk_buff 
 	len -= 2;
 
 	while (len > 0) {
-		int optlen = raw[off+1]+2;
+		int optlen = skb->nh.raw[off+1]+2;
 
 		switch (skb->nh.raw[off]) {
 		case IPV6_TLV_PAD0:
@@ -308,18 +308,15 @@ static int check_hbh_len(struct sk_buff 
 		case IPV6_TLV_JUMBO:
 			if (skb->nh.raw[off+1] != 4 || (off&3) != 2)
 				goto bad;
-
 			pkt_len = ntohl(*(u32*)(skb->nh.raw+off+2));
-
+			if (pkt_len <= IPV6_MAXPLEN ||
+			    skb->nh.ipv6h->payload_len)
+				goto bad;
 			if (pkt_len > skb->len - sizeof(struct ipv6hdr))
 				goto bad;
-			if (pkt_len + sizeof(struct ipv6hdr) < skb->len) {
-				if (__pskb_trim(skb,
-				    pkt_len + sizeof(struct ipv6hdr)))
-					goto bad;
-				if (skb->ip_summed == CHECKSUM_HW)
-					skb->ip_summed = CHECKSUM_NONE;
-			}
+			if (pskb_trim_rcsum(skb,
+			    pkt_len+sizeof(struct ipv6hdr)))
+				goto bad;
 			break;
 		default:
 			if (optlen > len)
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 896ce3f..fa64931 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -617,7 +617,7 @@ static int ipgre_rcv(struct sk_buff *skb
 
 		skb->mac.raw = skb->nh.raw;
 		skb->nh.raw = __pskb_pull(skb, offset);
-		skb_postpull_rcsum(skb, skb->mac.raw, offset);
+		skb_postpull_rcsum(skb, skb->h.raw, offset);
 		memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
 		skb->pkt_type = PACKET_HOST;
 #ifdef CONFIG_NET_IPGRE_BROADCAST
diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
index dab4b58..a76cb0d 100644
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -12,6 +12,7 @@ ip_nat_pptp-objs	:= ip_nat_helper_pptp.o
 
 # connection tracking
 obj-$(CONFIG_IP_NF_CONNTRACK) += ip_conntrack.o
+obj-$(CONFIG_IP_NF_NAT) += ip_nat.o
 
 # conntrack netlink interface
 obj-$(CONFIG_IP_NF_CONNTRACK_NETLINK) += ip_conntrack_netlink.o
@@ -41,7 +42,7 @@ obj-$(CONFIG_IP_NF_IPTABLES) += ip_table
 # the three instances of ip_tables
 obj-$(CONFIG_IP_NF_FILTER) += iptable_filter.o
 obj-$(CONFIG_IP_NF_MANGLE) += iptable_mangle.o
-obj-$(CONFIG_IP_NF_NAT) += iptable_nat.o ip_nat.o
+obj-$(CONFIG_IP_NF_NAT) += iptable_nat.o
 obj-$(CONFIG_IP_NF_RAW) += iptable_raw.o
 
 # matches
diff --git a/net/ipv4/netfilter/ip_conntrack_netlink.c b/net/ipv4/netfilter/ip_conntrack_netlink.c
index 97fab76..e6d3b5c 100644
--- a/net/ipv4/netfilter/ip_conntrack_netlink.c
+++ b/net/ipv4/netfilter/ip_conntrack_netlink.c
@@ -506,7 +506,7 @@ nfattr_failure:
 }
 
 static const int cta_min_proto[CTA_PROTO_MAX] = {
-	[CTA_PROTO_NUM-1]	= sizeof(u_int16_t),
+	[CTA_PROTO_NUM-1]	= sizeof(u_int8_t),
 	[CTA_PROTO_SRC_PORT-1]	= sizeof(u_int16_t),
 	[CTA_PROTO_DST_PORT-1]	= sizeof(u_int16_t),
 	[CTA_PROTO_ICMP_TYPE-1]	= sizeof(u_int8_t),
@@ -532,7 +532,7 @@ ctnetlink_parse_tuple_proto(struct nfatt
 
 	if (!tb[CTA_PROTO_NUM-1])
 		return -EINVAL;
-	tuple->dst.protonum = *(u_int16_t *)NFA_DATA(tb[CTA_PROTO_NUM-1]);
+	tuple->dst.protonum = *(u_int8_t *)NFA_DATA(tb[CTA_PROTO_NUM-1]);
 
 	proto = ip_conntrack_proto_find_get(tuple->dst.protonum);
 
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
index 0658e8f..73f2153 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -341,9 +341,10 @@ static int tcp_print_conntrack(struct se
 static int tcp_to_nfattr(struct sk_buff *skb, struct nfattr *nfa,
 			 const struct ip_conntrack *ct)
 {
-	struct nfattr *nest_parms = NFA_NEST(skb, CTA_PROTOINFO_TCP);
+	struct nfattr *nest_parms;
 	
 	read_lock_bh(&tcp_lock);
+	nest_parms = NFA_NEST(skb, CTA_PROTOINFO_TCP);
 	NFA_PUT(skb, CTA_PROTOINFO_TCP_STATE, sizeof(u_int8_t),
 		&ct->proto.tcp.state);
 	read_unlock_bh(&tcp_lock);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index a970b47..99ca46d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1456,9 +1456,17 @@ void addrconf_prefix_rcv(struct net_devi
 	   not good.
 	 */
 	if (valid_lft >= 0x7FFFFFFF/HZ)
-		rt_expires = 0;
+		rt_expires = 0x7FFFFFFF - (0x7FFFFFFF % HZ);
 	else
-		rt_expires = jiffies + valid_lft * HZ;
+		rt_expires = valid_lft * HZ;
+
+	/*
+	 * We convert this (in jiffies) to clock_t later.
+	 * Avoid arithmetic overflow there as well.
+	 * Overflow can happen only if HZ < USER_HZ.
+	 */
+	if (HZ < USER_HZ && rt_expires > 0x7FFFFFFF / USER_HZ)
+		rt_expires = 0x7FFFFFFF / USER_HZ;
 
 	if (pinfo->onlink) {
 		struct rt6_info *rt;
@@ -1470,12 +1478,12 @@ void addrconf_prefix_rcv(struct net_devi
 					ip6_del_rt(rt, NULL, NULL, NULL);
 					rt = NULL;
 				} else {
-					rt->rt6i_expires = rt_expires;
+					rt->rt6i_expires = jiffies + rt_expires;
 				}
 			}
 		} else if (valid_lft) {
 			addrconf_prefix_route(&pinfo->prefix, pinfo->prefix_len,
-					      dev, rt_expires, RTF_ADDRCONF|RTF_EXPIRES|RTF_PREFIX_RT);
+					      dev, jiffies_to_clock_t(rt_expires), RTF_ADDRCONF|RTF_EXPIRES|RTF_PREFIX_RT);
 		}
 		if (rt)
 			dst_release(&rt->u.dst);
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index bb7ccfe..0f2e654 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -211,7 +211,7 @@ config IP6_NF_TARGET_REJECT
 
 config IP6_NF_TARGET_NFQUEUE
 	tristate "NFQUEUE Target Support"
-	depends on IP_NF_IPTABLES
+	depends on IP6_NF_IPTABLES
 	help
 	  This Target replaced the old obsolete QUEUE target.
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5d5bbb4..1e6f256 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -829,7 +829,7 @@ int ip6_route_add(struct in6_rtmsg *rtms
 	}
 
 	rt->u.dst.obsolete = -1;
-	rt->rt6i_expires = clock_t_to_jiffies(rtmsg->rtmsg_info);
+	rt->rt6i_expires = jiffies + clock_t_to_jiffies(rtmsg->rtmsg_info);
 	if (nlh && (r = NLMSG_DATA(nlh))) {
 		rt->rt6i_protocol = r->rtm_protocol;
 	} else {
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index cbb0ba3..27afded 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1014,13 +1014,12 @@ int __xfrm_route_forward(struct sk_buff 
 }
 EXPORT_SYMBOL(__xfrm_route_forward);
 
-/* Optimize later using cookies and generation ids. */
-
 static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 {
-	if (!stale_bundle(dst))
-		return dst;
-
+	/* If it is marked obsolete, which is how we even get here,
+	 * then we have purged it from the policy bundle list and we
+	 * did that for a good reason.
+	 */
 	return NULL;
 }
 
@@ -1104,6 +1103,16 @@ int xfrm_flush_bundles(void)
 	return 0;
 }
 
+static int always_true(struct dst_entry *dst)
+{
+	return 1;
+}
+
+void xfrm_flush_all_bundles(void)
+{
+	xfrm_prune_bundles(always_true);
+}
+
 void xfrm_init_pmtu(struct dst_entry *dst)
 {
 	do {
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9d206c2..367b483 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -435,6 +435,8 @@ void xfrm_state_insert(struct xfrm_state
 	spin_lock_bh(&xfrm_state_lock);
 	__xfrm_state_insert(x);
 	spin_unlock_bh(&xfrm_state_lock);
+
+	xfrm_flush_all_bundles();
 }
 EXPORT_SYMBOL(xfrm_state_insert);
 
@@ -482,6 +484,9 @@ out:
 	spin_unlock_bh(&xfrm_state_lock);
 	xfrm_state_put_afinfo(afinfo);
 
+	if (!err)
+		xfrm_flush_all_bundles();
+
 	if (x1) {
 		xfrm_state_delete(x1);
 		xfrm_state_put(x1);
