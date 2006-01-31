Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWAaHeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWAaHeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWAaHeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:34:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:35976
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030359AbWAaHeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:34:23 -0500
Date: Mon, 30 Jan 2006 23:34:18 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.14.7
Message-ID: <20060131073418.GB25397@kroah.com>
References: <20060131073354.GA25397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131073354.GA25397@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 8c6fcb0..8d4c07b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION = .6
+EXTRAVERSION = .7
 NAME=Affluent Albatross
 
 # *DOCUMENTATION*
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index fb3991e..66c8c53 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1937,7 +1937,7 @@ static void ack_edge_ioapic_vector(unsig
 {
 	int irq = vector_to_irq(vector);
 
-	move_irq(vector);
+	move_native_irq(vector);
 	ack_edge_ioapic_irq(irq);
 }
 
@@ -1952,7 +1952,7 @@ static void end_level_ioapic_vector (uns
 {
 	int irq = vector_to_irq(vector);
 
-	move_irq(vector);
+	move_native_irq(vector);
 	end_level_ioapic_irq(irq);
 }
 
diff --git a/arch/sparc64/kernel/entry.S b/arch/sparc64/kernel/entry.S
index 11a8484..7100029 100644
--- a/arch/sparc64/kernel/entry.S
+++ b/arch/sparc64/kernel/entry.S
@@ -1657,13 +1657,10 @@ ret_sys_call:
 	/* Check if force_successful_syscall_return()
 	 * was invoked.
 	 */
-	ldub		[%curptr + TI_SYS_NOERROR], %l0
-	brz,pt		%l0, 1f
-	 nop
-	ba,pt		%xcc, 80f
+	ldub            [%curptr + TI_SYS_NOERROR], %l2
+	brnz,a,pn       %l2, 80f
 	 stb		%g0, [%curptr + TI_SYS_NOERROR]
 
-1:
 	cmp		%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn		%xcc, 1f
 	 andcc		%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6
diff --git a/arch/sparc64/kernel/systbls.S b/arch/sparc64/kernel/systbls.S
index 53eaf23..4821ef1 100644
--- a/arch/sparc64/kernel/systbls.S
+++ b/arch/sparc64/kernel/systbls.S
@@ -98,7 +98,7 @@ sys_call_table:
 	.word sys_umount, sys_setgid, sys_getgid, sys_signal, sys_geteuid
 /*50*/	.word sys_getegid, sys_acct, sys_memory_ordering, sys_nis_syscall, sys_ioctl
 	.word sys_reboot, sys_nis_syscall, sys_symlink, sys_readlink, sys_execve
-/*60*/	.word sys_umask, sys_chroot, sys_newfstat, sys_stat64, sys_getpagesize
+/*60*/	.word sys_umask, sys_chroot, sys_newfstat, sys_fstat64, sys_getpagesize
 	.word sys_msync, sys_vfork, sys_pread64, sys_pwrite64, sys_nis_syscall
 /*70*/	.word sys_nis_syscall, sys_mmap, sys_nis_syscall, sys64_munmap, sys_mprotect
 	.word sys_madvise, sys_vhangup, sys_nis_syscall, sys_mincore, sys_getgroups
diff --git a/net/bridge/netfilter/ebt_ip.c b/net/bridge/netfilter/ebt_ip.c
index 7323805..f158fe6 100644
--- a/net/bridge/netfilter/ebt_ip.c
+++ b/net/bridge/netfilter/ebt_ip.c
@@ -15,6 +15,7 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_ip.h>
 #include <linux/ip.h>
+#include <net/ip.h>
 #include <linux/in.h>
 #include <linux/module.h>
 
@@ -51,6 +52,8 @@ static int ebt_filter_ip(const struct sk
 		if (!(info->bitmask & EBT_IP_DPORT) &&
 		    !(info->bitmask & EBT_IP_SPORT))
 			return EBT_MATCH;
+		if (ntohs(ih->frag_off) & IP_OFFSET)
+			return EBT_NOMATCH;
 		pptr = skb_header_pointer(skb, ih->ihl*4,
 					  sizeof(_ports), &_ports);
 		if (pptr == NULL)
diff --git a/net/ipv4/netfilter/ip_nat_helper_pptp.c b/net/ipv4/netfilter/ip_nat_helper_pptp.c
index 56e29fa..0633f14 100644
--- a/net/ipv4/netfilter/ip_nat_helper_pptp.c
+++ b/net/ipv4/netfilter/ip_nat_helper_pptp.c
@@ -148,14 +148,14 @@ pptp_outbound_pkt(struct sk_buff **pskb,
 {
 	struct ip_ct_pptp_master *ct_pptp_info = &ct->help.ct_pptp_info;
 	struct ip_nat_pptp *nat_pptp_info = &ct->nat.help.nat_pptp_info;
-
-	u_int16_t msg, *cid = NULL, new_callid;
+	u_int16_t msg, new_callid;
+	unsigned int cid_off;
 
 	new_callid = htons(ct_pptp_info->pns_call_id);
 	
 	switch (msg = ntohs(ctlh->messageType)) {
 		case PPTP_OUT_CALL_REQUEST:
-			cid = &pptpReq->ocreq.callID;
+			cid_off = offsetof(union pptp_ctrl_union, ocreq.callID);
 			/* FIXME: ideally we would want to reserve a call ID
 			 * here.  current netfilter NAT core is not able to do
 			 * this :( For now we use TCP source port. This breaks
@@ -172,10 +172,10 @@ pptp_outbound_pkt(struct sk_buff **pskb,
 			ct_pptp_info->pns_call_id = ntohs(new_callid);
 			break;
 		case PPTP_IN_CALL_REPLY:
-			cid = &pptpReq->icreq.callID;
+			cid_off = offsetof(union pptp_ctrl_union, icreq.callID);
 			break;
 		case PPTP_CALL_CLEAR_REQUEST:
-			cid = &pptpReq->clrreq.callID;
+			cid_off = offsetof(union pptp_ctrl_union, clrreq.callID);
 			break;
 		default:
 			DEBUGP("unknown outbound packet 0x%04x:%s\n", msg,
@@ -197,18 +197,15 @@ pptp_outbound_pkt(struct sk_buff **pskb,
 
 	/* only OUT_CALL_REQUEST, IN_CALL_REPLY, CALL_CLEAR_REQUEST pass
 	 * down to here */
-
-	IP_NF_ASSERT(cid);
-
 	DEBUGP("altering call id from 0x%04x to 0x%04x\n",
-		ntohs(*cid), ntohs(new_callid));
+		ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_callid));
 
 	/* mangle packet */
 	if (ip_nat_mangle_tcp_packet(pskb, ct, ctinfo,
-		(void *)cid - ((void *)ctlh - sizeof(struct pptp_pkt_hdr)),
-				 	sizeof(new_callid), 
-					(char *)&new_callid,
-				 	sizeof(new_callid)) == 0)
+	                             cid_off + sizeof(struct pptp_pkt_hdr) +
+	                             sizeof(struct PptpControlHeader),
+	                             sizeof(new_callid), (char *)&new_callid,
+	                             sizeof(new_callid)) == 0)
 		return NF_DROP;
 
 	return NF_ACCEPT;
@@ -297,7 +294,8 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 		 union pptp_ctrl_union *pptpReq)
 {
 	struct ip_nat_pptp *nat_pptp_info = &ct->nat.help.nat_pptp_info;
-	u_int16_t msg, new_cid = 0, new_pcid, *pcid = NULL, *cid = NULL;
+	u_int16_t msg, new_cid = 0, new_pcid;
+	unsigned int pcid_off, cid_off = 0;
 
 	int ret = NF_ACCEPT, rv;
 
@@ -305,23 +303,23 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 
 	switch (msg = ntohs(ctlh->messageType)) {
 	case PPTP_OUT_CALL_REPLY:
-		pcid = &pptpReq->ocack.peersCallID;	
-		cid = &pptpReq->ocack.callID;
+		pcid_off = offsetof(union pptp_ctrl_union, ocack.peersCallID);
+		cid_off = offsetof(union pptp_ctrl_union, ocack.callID);
 		break;
 	case PPTP_IN_CALL_CONNECT:
-		pcid = &pptpReq->iccon.peersCallID;
+		pcid_off = offsetof(union pptp_ctrl_union, iccon.peersCallID);
 		break;
 	case PPTP_IN_CALL_REQUEST:
 		/* only need to nat in case PAC is behind NAT box */
-		break;
+		return NF_ACCEPT;
 	case PPTP_WAN_ERROR_NOTIFY:
-		pcid = &pptpReq->wanerr.peersCallID;
+		pcid_off = offsetof(union pptp_ctrl_union, wanerr.peersCallID);
 		break;
 	case PPTP_CALL_DISCONNECT_NOTIFY:
-		pcid = &pptpReq->disc.callID;
+		pcid_off = offsetof(union pptp_ctrl_union, disc.callID);
 		break;
 	case PPTP_SET_LINK_INFO:
-		pcid = &pptpReq->setlink.peersCallID;
+		pcid_off = offsetof(union pptp_ctrl_union, setlink.peersCallID);
 		break;
 
 	default:
@@ -343,25 +341,24 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 	 * WAN_ERROR_NOTIFY, CALL_DISCONNECT_NOTIFY pass down here */
 
 	/* mangle packet */
-	IP_NF_ASSERT(pcid);
 	DEBUGP("altering peer call id from 0x%04x to 0x%04x\n",
-		ntohs(*pcid), ntohs(new_pcid));
+		ntohs(*(u_int16_t *)pptpReq + pcid_off), ntohs(new_pcid));
 	
-	rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo, 
-				      (void *)pcid - ((void *)ctlh - sizeof(struct pptp_pkt_hdr)),
+	rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo,
+	                              pcid_off + sizeof(struct pptp_pkt_hdr) +
+				      sizeof(struct PptpControlHeader),
 				      sizeof(new_pcid), (char *)&new_pcid, 
 				      sizeof(new_pcid));
 	if (rv != NF_ACCEPT) 
 		return rv;
 
 	if (new_cid) {
-		IP_NF_ASSERT(cid);
 		DEBUGP("altering call id from 0x%04x to 0x%04x\n",
-			ntohs(*cid), ntohs(new_cid));
-		rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo, 
-					      (void *)cid - ((void *)ctlh - sizeof(struct pptp_pkt_hdr)), 
-					      sizeof(new_cid),
-					      (char *)&new_cid, 
+			ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_cid));
+		rv = ip_nat_mangle_tcp_packet(pskb, ct, ctinfo,
+		                              cid_off + sizeof(struct pptp_pkt_hdr) +
+					      sizeof(struct PptpControlHeader),
+					      sizeof(new_cid), (char *)&new_cid,
 					      sizeof(new_cid));
 		if (rv != NF_ACCEPT)
 			return rv;
