Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUESMCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUESMCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUESMCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:02:48 -0400
Received: from holomorphy.com ([207.189.100.168]:9359 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263624AbUESMCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:02:24 -0400
Date: Wed, 19 May 2004 05:01:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, arjanv@redhat.com,
       benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040519120138.GI1223@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>, arjanv@redhat.com,
	benh@kernel.crashing.org, kronos@kronoz.cjb.net,
	linux-kernel@vger.kernel.org
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org> <20040517233515.GR5414@waste.org> <20040519102846.GG1223@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519102846.GG1223@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 06:35:15PM -0500, Matt Mackall wrote:
>> I have a cleaned up version of this script in -tiny which is a bit
>> nicer for adding new arches to and produces simpler output:
>>  1428 huft_build
>>  1292 inflate_dynamic
>>  1168 inflate_fixed
>>   528 ip_setsockopt
>>   496 tcp_check_req
>>   496 tcp_v4_conn_request
>>   484 tcp_timewait_state_process
>>   440 ip_getsockopt
>>   408 extract_entropy
>>   364 shrink_zone
>>   324 do_execve

On Wed, May 19, 2004 at 03:28:46AM -0700, William Lee Irwin III wrote:
> By eyeballing things, I see >= 384B on-stack in ep_send_events(). Hence:

I might as well hit something higher up in the list. Does this help
ip_setsockopt() any (untested)?


-- wli


Index: mm3-2.6.6/net/ipv4/ip_sockglue.c
===================================================================
--- mm3-2.6.6.orig/net/ipv4/ip_sockglue.c	2004-05-09 19:32:27.000000000 -0700
+++ mm3-2.6.6/net/ipv4/ip_sockglue.c	2004-05-19 04:48:13.000000000 -0700
@@ -384,6 +384,312 @@
  *	an IP socket.
  */
 
+static int ip_options_setsockopt(struct inet_opt *inet, struct sock *sk, char *optval, int optlen)
+{
+	int err;
+	struct ip_options *opt = NULL;
+
+	if (optlen > 40 || optlen < 0)
+		return -EINVAL;
+	err = ip_options_get(&opt, optval, optlen, 1);
+	if (err)
+		return err;
+	if (sk->sk_type == SOCK_STREAM) {
+		struct tcp_opt *tp = tcp_sk(sk);
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+		if (sk->sk_family == PF_INET ||
+		    (!((1 << sk->sk_state) &
+		       (TCPF_LISTEN | TCPF_CLOSE)) &&
+		     inet->daddr != LOOPBACK4_IPV6)) {
+#endif
+			if (inet->opt)
+				tp->ext_header_len -= inet->opt->optlen;
+			if (opt)
+				tp->ext_header_len += opt->optlen;
+			tcp_sync_mss(sk, tp->pmtu_cookie);
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+		}
+#endif
+	}
+	opt = xchg(&inet->opt, opt);
+	if (opt)
+		kfree(opt);
+	return err;
+}
+
+static int ip_membership_setsockopt(struct sock *sk, char *optval, int optlen, int optname)
+{
+	int err;
+	struct ip_mreqn mreq;
+
+	if (optlen < sizeof(struct ip_mreq))
+		return -EINVAL;
+	if (optlen >= sizeof(struct ip_mreqn)) {
+		if(copy_from_user(&mreq,optval,sizeof(mreq)))
+			return -EFAULT;
+	} else {
+		memset(&mreq, 0, sizeof(mreq));
+		if (copy_from_user(&mreq,optval,sizeof(struct ip_mreq)))
+			return -EFAULT; 
+	}
+
+	if (optname == IP_ADD_MEMBERSHIP)
+		err = ip_mc_join_group(sk, &mreq);
+	else
+		err = ip_mc_leave_group(sk, &mreq);
+	return err;
+}
+
+static int ip_multicast_if_setsockopt(struct inet_opt *inet, struct sock *sk, char *optval, int optlen)
+{
+	struct ip_mreqn mreq;
+	struct net_device *dev = NULL;
+
+	if (sk->sk_type == SOCK_STREAM)
+		return -EINVAL;
+	/*
+	 *	Check the arguments are allowable
+	 */
+
+	if (optlen >= sizeof(struct ip_mreqn)) {
+		if (copy_from_user(&mreq,optval,sizeof(mreq)))
+			return -EFAULT;
+	} else {
+		memset(&mreq, 0, sizeof(mreq));
+		if (optlen >= sizeof(struct in_addr) &&
+		    copy_from_user(&mreq.imr_address,optval,sizeof(struct in_addr)))
+			return -EFAULT;
+	}
+
+	if (!mreq.imr_ifindex) {
+		if (mreq.imr_address.s_addr == INADDR_ANY) {
+			inet->mc_index = 0;
+			inet->mc_addr  = 0;
+			return 0;
+		}
+		dev = ip_dev_find(mreq.imr_address.s_addr);
+		if (dev) {
+			mreq.imr_ifindex = dev->ifindex;
+			dev_put(dev);
+		}
+	} else
+		dev = __dev_get_by_index(mreq.imr_ifindex);
+
+
+	if (!dev)
+		return -EADDRNOTAVAIL;
+
+	if (sk->sk_bound_dev_if && mreq.imr_ifindex != sk->sk_bound_dev_if)
+		return -EINVAL;
+
+	inet->mc_index = mreq.imr_ifindex;
+	inet->mc_addr  = mreq.imr_address.s_addr;
+	return 0;
+}
+
+static int ip_msfilter_setsockopt(struct sock *sk, char *optval, int optlen)
+{
+	extern int sysctl_optmem_max;
+	extern int sysctl_igmp_max_msf;
+	int err;
+	struct ip_msfilter *msf;
+
+	if (optlen < IP_MSFILTER_SIZE(0))
+		return -EINVAL;
+	if (optlen > sysctl_optmem_max)
+		return -ENOBUFS;
+	msf = kmalloc(optlen, GFP_KERNEL);
+	if (!msf)
+		return -ENOBUFS;
+	if (copy_from_user(msf, optval, optlen)) {
+		kfree(msf);
+		return -EFAULT;
+	}
+	/* numsrc >= (1G-4) overflow in 32 bits */
+	if (msf->imsf_numsrc >= 0x3ffffffcU ||
+	    msf->imsf_numsrc > sysctl_igmp_max_msf) {
+		kfree(msf);
+		return -ENOBUFS;
+	}
+	if (IP_MSFILTER_SIZE(msf->imsf_numsrc) > optlen) {
+		kfree(msf);
+		return -EINVAL;
+	}
+	err = ip_mc_msfilter(sk, msf, 0);
+	kfree(msf);
+	return err;
+}
+
+static int ip_source_membership_setsockopt(struct sock *sk, char *optval, int optlen, int optname)
+{
+	struct ip_mreq_source mreqs;
+	int omode, add;
+
+	if (optlen != sizeof(struct ip_mreq_source))
+		return -EINVAL;
+	if (copy_from_user(&mreqs, optval, sizeof(mreqs)))
+		return -EFAULT;
+	if (optname == IP_BLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 1;
+	} else if (optname == IP_UNBLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 0;
+	} else if (optname == IP_ADD_SOURCE_MEMBERSHIP) {
+		struct ip_mreqn mreq;
+		int err;
+
+		mreq.imr_multiaddr.s_addr = mreqs.imr_multiaddr;
+		mreq.imr_address.s_addr = mreqs.imr_interface;
+		mreq.imr_ifindex = 0;
+		err = ip_mc_join_group(sk, &mreq);
+		if (err)
+			return err;
+		omode = MCAST_INCLUDE;
+		add = 1;
+	} else /*IP_DROP_SOURCE_MEMBERSHIP */ {
+		omode = MCAST_INCLUDE;
+		add = 0;
+	}
+	return ip_mc_source(add, omode, sk, &mreqs, 0);
+}
+
+static int ip_mcast_group_setsockopt(struct sock *sk, char *optval, int optlen, int optname)
+{
+	int err;
+	struct group_req greq;
+	struct sockaddr_in *psin;
+	struct ip_mreqn mreq;
+
+	if (optlen < sizeof(struct group_req))
+		return -EINVAL;
+	if(copy_from_user(&greq, optval, sizeof(greq)))
+		return -EFAULT;
+	psin = (struct sockaddr_in *)&greq.gr_group;
+	if (psin->sin_family != AF_INET)
+		return -EINVAL;
+	memset(&mreq, 0, sizeof(mreq));
+	mreq.imr_multiaddr = psin->sin_addr;
+	mreq.imr_ifindex = greq.gr_interface;
+
+	if (optname == MCAST_JOIN_GROUP)
+		err = ip_mc_join_group(sk, &mreq);
+	else
+		err = ip_mc_leave_group(sk, &mreq);
+	return err;
+}
+
+static int ip_mcast_source_setsockopt(struct sock *sk, char *optval, int optlen, int optname)
+{
+	struct group_source_req greqs;
+	struct ip_mreq_source mreqs;
+	struct sockaddr_in *psin;
+	int omode, add;
+
+	if (optlen != sizeof(struct group_source_req))
+		return -EINVAL;
+	if (copy_from_user(&greqs, optval, sizeof(greqs)))
+		return -EFAULT;
+	if (greqs.gsr_group.ss_family != AF_INET ||
+	    greqs.gsr_source.ss_family != AF_INET)
+		return -EADDRNOTAVAIL;
+	psin = (struct sockaddr_in *)&greqs.gsr_group;
+	mreqs.imr_multiaddr = psin->sin_addr.s_addr;
+	psin = (struct sockaddr_in *)&greqs.gsr_source;
+	mreqs.imr_sourceaddr = psin->sin_addr.s_addr;
+	mreqs.imr_interface = 0; /* use index for mc_source */
+
+	if (optname == MCAST_BLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 1;
+	} else if (optname == MCAST_UNBLOCK_SOURCE) {
+		omode = MCAST_EXCLUDE;
+		add = 0;
+	} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
+		int err;
+		struct ip_mreqn mreq;
+
+		psin = (struct sockaddr_in *)&greqs.gsr_group;
+		mreq.imr_multiaddr = psin->sin_addr;
+		mreq.imr_address.s_addr = 0;
+		mreq.imr_ifindex = greqs.gsr_interface;
+		err = ip_mc_join_group(sk, &mreq);
+		if (err)
+			return err;
+		omode = MCAST_INCLUDE;
+		add = 1;
+	} else /* MCAST_LEAVE_SOURCE_GROUP */ {
+		omode = MCAST_INCLUDE;
+		add = 0;
+	}
+	return ip_mc_source(add, omode, sk, &mreqs, greqs.gsr_interface);
+}
+
+static int ip_mcast_msfilter_setsockopt(struct sock *sk, char *optval, int optlen)
+{
+	extern int sysctl_optmem_max;
+	extern int sysctl_igmp_max_msf;
+	struct sockaddr_in *psin;
+	struct ip_msfilter *msf = NULL;
+	struct group_filter *gsf = NULL;
+	int msize, i, ifindex, err;
+
+	if (optlen < GROUP_FILTER_SIZE(0))
+		return -EINVAL;
+	if (optlen > sysctl_optmem_max)
+		return -ENOBUFS;
+	gsf = kmalloc(optlen, GFP_KERNEL);
+	if (!gsf)
+		return -ENOBUFS;
+	if (copy_from_user(gsf, optval, optlen)) {
+		err = -EFAULT;
+		goto mc_msf_out;
+	}
+	/* numsrc >= (4G-140)/128 overflow in 32 bits */
+	if (gsf->gf_numsrc >= 0x1ffffff ||
+	    gsf->gf_numsrc > sysctl_igmp_max_msf) {
+		err = -ENOBUFS;
+		goto mc_msf_out;
+	}
+	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen) {
+		err = -EINVAL;
+		goto mc_msf_out;
+	}
+	msize = IP_MSFILTER_SIZE(gsf->gf_numsrc);
+	msf = kmalloc(msize, GFP_KERNEL);
+	if (!msf) {
+		err = -ENOBUFS;
+		goto mc_msf_out;
+	}
+	ifindex = gsf->gf_interface;
+	psin = (struct sockaddr_in *)&gsf->gf_group;
+	if (psin->sin_family != AF_INET) {
+		err = -EADDRNOTAVAIL;
+		goto mc_msf_out;
+	}
+	msf->imsf_multiaddr = psin->sin_addr.s_addr;
+	msf->imsf_interface = 0;
+	msf->imsf_fmode = gsf->gf_fmode;
+	msf->imsf_numsrc = gsf->gf_numsrc;
+	err = -EADDRNOTAVAIL;
+	for (i=0; i<gsf->gf_numsrc; ++i) {
+		psin = (struct sockaddr_in *)&gsf->gf_slist[i];
+
+		if (psin->sin_family != AF_INET)
+			goto mc_msf_out;
+		msf->imsf_slist[i] = psin->sin_addr.s_addr;
+	}
+	kfree(gsf);
+	gsf = NULL;
+	err = ip_mc_msfilter(sk, msf, ifindex);
+mc_msf_out:
+	if (msf)
+		kfree(msf);
+	if (gsf)
+		kfree(gsf);
+	return err;
+}
+
 int ip_setsockopt(struct sock *sk, int level, int optname, char *optval, int optlen)
 {
 	struct inet_opt *inet = inet_sk(sk);
@@ -424,35 +730,8 @@
 
 	switch (optname) {
 		case IP_OPTIONS:
-		{
-			struct ip_options * opt = NULL;
-			if (optlen > 40 || optlen < 0)
-				goto e_inval;
-			err = ip_options_get(&opt, optval, optlen, 1);
-			if (err)
-				break;
-			if (sk->sk_type == SOCK_STREAM) {
-				struct tcp_opt *tp = tcp_sk(sk);
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-				if (sk->sk_family == PF_INET ||
-				    (!((1 << sk->sk_state) &
-				       (TCPF_LISTEN | TCPF_CLOSE)) &&
-				     inet->daddr != LOOPBACK4_IPV6)) {
-#endif
-					if (inet->opt)
-						tp->ext_header_len -= inet->opt->optlen;
-					if (opt)
-						tp->ext_header_len += opt->optlen;
-					tcp_sync_mss(sk, tp->pmtu_cookie);
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-				}
-#endif
-			}
-			opt = xchg(&inet->opt, opt);
-			if (opt)
-				kfree(opt);
+			err = ip_options_setsockopt(inet, sk, optval, optlen);
 			break;
-		}
 		case IP_PKTINFO:
 			if (val)
 				inet->cmsg_flags |= IP_CMSG_PKTINFO;
@@ -540,304 +819,34 @@
 			inet->mc_loop = !!val;
 	                break;
 		case IP_MULTICAST_IF: 
-		{
-			struct ip_mreqn mreq;
-			struct net_device *dev = NULL;
-
-			if (sk->sk_type == SOCK_STREAM)
-				goto e_inval;
-			/*
-			 *	Check the arguments are allowable
-			 */
-
-			err = -EFAULT;
-			if (optlen >= sizeof(struct ip_mreqn)) {
-				if (copy_from_user(&mreq,optval,sizeof(mreq)))
-					break;
-			} else {
-				memset(&mreq, 0, sizeof(mreq));
-				if (optlen >= sizeof(struct in_addr) &&
-				    copy_from_user(&mreq.imr_address,optval,sizeof(struct in_addr)))
-					break;
-			}
-
-			if (!mreq.imr_ifindex) {
-				if (mreq.imr_address.s_addr == INADDR_ANY) {
-					inet->mc_index = 0;
-					inet->mc_addr  = 0;
-					err = 0;
-					break;
-				}
-				dev = ip_dev_find(mreq.imr_address.s_addr);
-				if (dev) {
-					mreq.imr_ifindex = dev->ifindex;
-					dev_put(dev);
-				}
-			} else
-				dev = __dev_get_by_index(mreq.imr_ifindex);
-
-
-			err = -EADDRNOTAVAIL;
-			if (!dev)
-				break;
-
-			err = -EINVAL;
-			if (sk->sk_bound_dev_if &&
-			    mreq.imr_ifindex != sk->sk_bound_dev_if)
-				break;
-
-			inet->mc_index = mreq.imr_ifindex;
-			inet->mc_addr  = mreq.imr_address.s_addr;
-			err = 0;
+			err = ip_multicast_if_setsockopt(inet, sk, optval, optlen);
 			break;
-		}
-
 		case IP_ADD_MEMBERSHIP:
 		case IP_DROP_MEMBERSHIP: 
-		{
-			struct ip_mreqn mreq;
-
-			if (optlen < sizeof(struct ip_mreq))
-				goto e_inval;
-			err = -EFAULT;
-			if (optlen >= sizeof(struct ip_mreqn)) {
-				if(copy_from_user(&mreq,optval,sizeof(mreq)))
-					break;
-			} else {
-				memset(&mreq, 0, sizeof(mreq));
-				if (copy_from_user(&mreq,optval,sizeof(struct ip_mreq)))
-					break; 
-			}
-
-			if (optname == IP_ADD_MEMBERSHIP)
-				err = ip_mc_join_group(sk, &mreq);
-			else
-				err = ip_mc_leave_group(sk, &mreq);
+			err = ip_membership_setsockopt(sk, optval, optlen, optname);
 			break;
-		}
 		case IP_MSFILTER:
-		{
-			extern int sysctl_optmem_max;
-			extern int sysctl_igmp_max_msf;
-			struct ip_msfilter *msf;
-
-			if (optlen < IP_MSFILTER_SIZE(0))
-				goto e_inval;
-			if (optlen > sysctl_optmem_max) {
-				err = -ENOBUFS;
-				break;
-			}
-			msf = (struct ip_msfilter *)kmalloc(optlen, GFP_KERNEL);
-			if (msf == 0) {
-				err = -ENOBUFS;
-				break;
-			}
-			err = -EFAULT;
-			if (copy_from_user(msf, optval, optlen)) {
-				kfree(msf);
-				break;
-			}
-			/* numsrc >= (1G-4) overflow in 32 bits */
-			if (msf->imsf_numsrc >= 0x3ffffffcU ||
-			    msf->imsf_numsrc > sysctl_igmp_max_msf) {
-				kfree(msf);
-				err = -ENOBUFS;
-				break;
-			}
-			if (IP_MSFILTER_SIZE(msf->imsf_numsrc) > optlen) {
-				kfree(msf);
-				err = -EINVAL;
-				break;
-			}
-			err = ip_mc_msfilter(sk, msf, 0);
-			kfree(msf);
+			err = ip_msfilter_setsockopt(sk, optval, optlen);
 			break;
-		}
 		case IP_BLOCK_SOURCE:
 		case IP_UNBLOCK_SOURCE:
 		case IP_ADD_SOURCE_MEMBERSHIP:
 		case IP_DROP_SOURCE_MEMBERSHIP:
-		{
-			struct ip_mreq_source mreqs;
-			int omode, add;
-
-			if (optlen != sizeof(struct ip_mreq_source))
-				goto e_inval;
-			if (copy_from_user(&mreqs, optval, sizeof(mreqs))) {
-				err = -EFAULT;
-				break;
-			}
-			if (optname == IP_BLOCK_SOURCE) {
-				omode = MCAST_EXCLUDE;
-				add = 1;
-			} else if (optname == IP_UNBLOCK_SOURCE) {
-				omode = MCAST_EXCLUDE;
-				add = 0;
-			} else if (optname == IP_ADD_SOURCE_MEMBERSHIP) {
-				struct ip_mreqn mreq;
-
-				mreq.imr_multiaddr.s_addr = mreqs.imr_multiaddr;
-				mreq.imr_address.s_addr = mreqs.imr_interface;
-				mreq.imr_ifindex = 0;
-				err = ip_mc_join_group(sk, &mreq);
-				if (err)
-					break;
-				omode = MCAST_INCLUDE;
-				add = 1;
-			} else /*IP_DROP_SOURCE_MEMBERSHIP */ {
-				omode = MCAST_INCLUDE;
-				add = 0;
-			}
-			err = ip_mc_source(add, omode, sk, &mreqs, 0);
+			err = ip_source_membership_setsockopt(sk, optval, optlen, optname);
 			break;
-		}
 		case MCAST_JOIN_GROUP:
 		case MCAST_LEAVE_GROUP: 
-		{
-			struct group_req greq;
-			struct sockaddr_in *psin;
-			struct ip_mreqn mreq;
-
-			if (optlen < sizeof(struct group_req))
-				goto e_inval;
-			err = -EFAULT;
-			if(copy_from_user(&greq, optval, sizeof(greq)))
-				break;
-			psin = (struct sockaddr_in *)&greq.gr_group;
-			if (psin->sin_family != AF_INET)
-				goto e_inval;
-			memset(&mreq, 0, sizeof(mreq));
-			mreq.imr_multiaddr = psin->sin_addr;
-			mreq.imr_ifindex = greq.gr_interface;
-
-			if (optname == MCAST_JOIN_GROUP)
-				err = ip_mc_join_group(sk, &mreq);
-			else
-				err = ip_mc_leave_group(sk, &mreq);
+			err = ip_mcast_group_setsockopt(sk, optval, optlen, optname);
 			break;
-		}
 		case MCAST_JOIN_SOURCE_GROUP:
 		case MCAST_LEAVE_SOURCE_GROUP:
 		case MCAST_BLOCK_SOURCE:
 		case MCAST_UNBLOCK_SOURCE:
-		{
-			struct group_source_req greqs;
-			struct ip_mreq_source mreqs;
-			struct sockaddr_in *psin;
-			int omode, add;
-
-			if (optlen != sizeof(struct group_source_req))
-				goto e_inval;
-			if (copy_from_user(&greqs, optval, sizeof(greqs))) {
-				err = -EFAULT;
-				break;
-			}
-			if (greqs.gsr_group.ss_family != AF_INET ||
-			    greqs.gsr_source.ss_family != AF_INET) {
-				err = -EADDRNOTAVAIL;
-				break;
-			}
-			psin = (struct sockaddr_in *)&greqs.gsr_group;
-			mreqs.imr_multiaddr = psin->sin_addr.s_addr;
-			psin = (struct sockaddr_in *)&greqs.gsr_source;
-			mreqs.imr_sourceaddr = psin->sin_addr.s_addr;
-			mreqs.imr_interface = 0; /* use index for mc_source */
-
-			if (optname == MCAST_BLOCK_SOURCE) {
-				omode = MCAST_EXCLUDE;
-				add = 1;
-			} else if (optname == MCAST_UNBLOCK_SOURCE) {
-				omode = MCAST_EXCLUDE;
-				add = 0;
-			} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
-				struct ip_mreqn mreq;
-
-				psin = (struct sockaddr_in *)&greqs.gsr_group;
-				mreq.imr_multiaddr = psin->sin_addr;
-				mreq.imr_address.s_addr = 0;
-				mreq.imr_ifindex = greqs.gsr_interface;
-				err = ip_mc_join_group(sk, &mreq);
-				if (err)
-					break;
-				omode = MCAST_INCLUDE;
-				add = 1;
-			} else /* MCAST_LEAVE_SOURCE_GROUP */ {
-				omode = MCAST_INCLUDE;
-				add = 0;
-			}
-			err = ip_mc_source(add, omode, sk, &mreqs,
-				greqs.gsr_interface);
+			err = ip_mcast_source_setsockopt(sk, optval, optlen, optname);
 			break;
-		}
 		case MCAST_MSFILTER:
-		{
-			extern int sysctl_optmem_max;
-			extern int sysctl_igmp_max_msf;
-			struct sockaddr_in *psin;
-			struct ip_msfilter *msf = 0;
-			struct group_filter *gsf = 0;
-			int msize, i, ifindex;
-
-			if (optlen < GROUP_FILTER_SIZE(0))
-				goto e_inval;
-			if (optlen > sysctl_optmem_max) {
-				err = -ENOBUFS;
-				break;
-			}
-			gsf = (struct group_filter *)kmalloc(optlen,GFP_KERNEL);
-			if (gsf == 0) {
-				err = -ENOBUFS;
-				break;
-			}
-			err = -EFAULT;
-			if (copy_from_user(gsf, optval, optlen)) {
-				goto mc_msf_out;
-			}
-			/* numsrc >= (4G-140)/128 overflow in 32 bits */
-			if (gsf->gf_numsrc >= 0x1ffffff ||
-			    gsf->gf_numsrc > sysctl_igmp_max_msf) {
-				err = -ENOBUFS;
-				goto mc_msf_out;
-			}
-			if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen) {
-				err = -EINVAL;
-				goto mc_msf_out;
-			}
-			msize = IP_MSFILTER_SIZE(gsf->gf_numsrc);
-			msf = (struct ip_msfilter *)kmalloc(msize,GFP_KERNEL);
-			if (msf == 0) {
-				err = -ENOBUFS;
-				goto mc_msf_out;
-			}
-			ifindex = gsf->gf_interface;
-			psin = (struct sockaddr_in *)&gsf->gf_group;
-			if (psin->sin_family != AF_INET) {
-				err = -EADDRNOTAVAIL;
-				goto mc_msf_out;
-			}
-			msf->imsf_multiaddr = psin->sin_addr.s_addr;
-			msf->imsf_interface = 0;
-			msf->imsf_fmode = gsf->gf_fmode;
-			msf->imsf_numsrc = gsf->gf_numsrc;
-			err = -EADDRNOTAVAIL;
-			for (i=0; i<gsf->gf_numsrc; ++i) {
-				psin = (struct sockaddr_in *)&gsf->gf_slist[i];
-
-				if (psin->sin_family != AF_INET)
-					goto mc_msf_out;
-				msf->imsf_slist[i] = psin->sin_addr.s_addr;
-			}
-			kfree(gsf);
-			gsf = 0;
-
-			err = ip_mc_msfilter(sk, msf, ifindex);
-mc_msf_out:
-			if (msf)
-				kfree(msf);
-			if (gsf)
-				kfree(gsf);
+			err = ip_mcast_msfilter_setsockopt(sk, optval, optlen);
 			break;
-		}
 		case IP_ROUTER_ALERT:	
 			err = ip_ra_control(sk, val ? 1 : 0, NULL);
 			break;
