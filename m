Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVEEFkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVEEFkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 01:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEEFjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 01:39:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:12700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261922AbVEEFic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 01:38:32 -0400
Date: Wed, 4 May 2005 22:38:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH 3/3] add open iscsi netlink interface to iscsi transport class
Message-ID: <20050505053824.GV23013@shell0.pdx.osdl.net>
References: <42798ADD.5070803@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42798ADD.5070803@cs.wisc.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Christie (michaelc@cs.wisc.edu) wrote:

> +static int
> +iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> +{
> +	int err = 0;
> +	struct iscsi_uevent *ev = NLMSG_DATA(nlh);
> +	struct iscsi_transport *transport = iscsi_ptr(ev->transport_handle);
> +
> +	if (nlh->nlmsg_type != ISCSI_UEVENT_TRANS_LIST &&
> +	    iscsi_if_transport_lookup(transport) < 0)
> +		return -EEXIST;
> +
> +	daemon_pid = NETLINK_CREDS(skb)->pid;
> +

Are any of these message types privileged operations?  I didn't notice
any real credential check.

> +	switch (nlh->nlmsg_type) {
> +	case ISCSI_UEVENT_TRANS_LIST: {
> +		int i;
> +
> +		for (i = 0; i < ISCSI_TRANSPORT_MAX; i++) {
> +			if (transport_table[i]) {
> +				ev->r.t_list.elements[i].trans_handle =
> +					iscsi_handle(transport_table[i]);
> +				strncpy(ev->r.t_list.elements[i].name,
> +					transport_table[i]->name,
> +					ISCSI_TRANSPORT_NAME_MAXLEN);
> +			} else
> +				ev->r.t_list.elements[i].trans_handle =
> +					iscsi_handle(NULL);
> +		}
> +	      } break;
> +	case ISCSI_UEVENT_CREATE_SESSION:
> +		err = iscsi_if_create_snx(transport, ev);
> +		break;
> +	case ISCSI_UEVENT_DESTROY_SESSION:
> +		err = iscsi_if_destroy_snx(transport, ev);
> +		break;
> +	case ISCSI_UEVENT_CREATE_CNX:
> +		err = iscsi_if_create_cnx(transport, ev);
> +		break;
> +	case ISCSI_UEVENT_DESTROY_CNX:
> +		err = iscsi_if_destroy_cnx(transport, ev);
> +		break;
> +	case ISCSI_UEVENT_BIND_CNX:
> +		if (!iscsi_if_find_cnx(ev->u.b_cnx.cnx_handle, H_TYPE_TRANS))
> +			return -EEXIST;
> +		ev->r.retcode = transport->bind_cnx(
> +			ev->u.b_cnx.session_handle,
> +			ev->u.b_cnx.cnx_handle,
> +			ev->u.b_cnx.transport_fd,
> +			ev->u.b_cnx.is_leading);
> +		break;
> +	case ISCSI_UEVENT_SET_PARAM:
> +		if (!iscsi_if_find_cnx(ev->u.set_param.cnx_handle,
> +				       H_TYPE_TRANS))
> +			return -EEXIST;
> +		ev->r.retcode = transport->set_param(
> +			ev->u.set_param.cnx_handle,
> +			ev->u.set_param.param, ev->u.set_param.value);
> +		break;
> +	case ISCSI_UEVENT_START_CNX:
> +		if (!iscsi_if_find_cnx(ev->u.start_cnx.cnx_handle,
> +				       H_TYPE_TRANS))
> +			return -EEXIST;
> +		ev->r.retcode = transport->start_cnx(
> +			ev->u.start_cnx.cnx_handle);
> +		break;
> +	case ISCSI_UEVENT_STOP_CNX:
> +		if (!iscsi_if_find_cnx(ev->u.stop_cnx.cnx_handle, H_TYPE_TRANS))
> +			return -EEXIST;
> +		transport->stop_cnx(ev->u.stop_cnx.cnx_handle,
> +			ev->u.stop_cnx.flag);
> +		break;
> +	case ISCSI_UEVENT_SEND_PDU:
> +		if (!iscsi_if_find_cnx(ev->u.send_pdu.cnx_handle,
> +				       H_TYPE_TRANS))
> +			return -EEXIST;
> +		ev->r.retcode = transport->send_pdu(
> +		       ev->u.send_pdu.cnx_handle,
> +		       (struct iscsi_hdr*)((char*)ev + sizeof(*ev)),
> +		       (char*)ev + sizeof(*ev) + ev->u.send_pdu.hdr_size,
> +			ev->u.send_pdu.data_size);
> +		break;
> +	case ISCSI_UEVENT_GET_STATS: {
> +		struct iscsi_stats *stats;
> +		struct sk_buff *skbstat;
> +		struct iscsi_if_cnx *cnx;
> +		struct nlmsghdr	*nlhstat;
> +		struct iscsi_uevent *evstat;
> +		int len = NLMSG_SPACE(sizeof(*ev) +
> +				sizeof(struct iscsi_stats) +
> +                                sizeof(struct iscsi_stats_custom) *
> +                                                ISCSI_STATS_CUSTOM_MAX);
> +		int err;
> +
> +		cnx = iscsi_if_find_cnx(ev->u.get_stats.cnx_handle,
> +					H_TYPE_TRANS);
> +		if (!cnx)
> +			return -EEXIST;
> +
> +		do {
> +			int actual_size;
> +
> +			skbstat = mempool_zone_get_skb(&cnx->z_pdu);
> +			if (!skbstat) {
> +				printk("iscsi%d: can not deliver stats: OOM\n",
> +				       cnx->host->host_no);
> +				return -ENOMEM;
> +			}
> +
> +			nlhstat = __nlmsg_put(skbstat, daemon_pid, 0, 0,
> +						(len - sizeof(*nlhstat)));
> +			evstat = NLMSG_DATA(nlhstat);
> +			memset(evstat, 0, sizeof(*evstat));
> +			evstat->transport_handle = iscsi_handle(cnx->transport);
> +			evstat->type = nlh->nlmsg_type;
> +			if (cnx->z_pdu.allocated >= cnx->z_pdu.hiwat)
> +				evstat->iferror = -ENOMEM;
> +			evstat->u.get_stats.cnx_handle =
> +					ev->u.get_stats.cnx_handle;
> +			stats = (struct iscsi_stats *)
> +					((char*)evstat + sizeof(*evstat));
> +			memset(stats, 0, sizeof(*stats));
> +
> +			transport->get_stats(ev->u.get_stats.cnx_handle, stats);
> +			actual_size = NLMSG_SPACE(sizeof(struct iscsi_uevent) +
> +					sizeof(struct iscsi_stats) +
> +                                	sizeof(struct iscsi_stats_custom) *
> +						stats->custom_length);
> +			actual_size -= sizeof(*nlhstat);
> +			actual_size = NLMSG_LENGTH(actual_size);
> +			skb_trim(skb, NLMSG_ALIGN(actual_size));
> +			nlhstat->nlmsg_len = actual_size;
> +
> +			err = iscsi_unicast_skb(&cnx->z_pdu, skbstat);
> +		} while (err < 0 && err != -ECONNREFUSED);
> +		} break;
> +	default:
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	return err;
> +}
