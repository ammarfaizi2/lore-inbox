Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRCPC0R>; Thu, 15 Mar 2001 21:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRCPCZ5>; Thu, 15 Mar 2001 21:25:57 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:61623 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S129486AbRCPCZn>;
	Thu, 15 Mar 2001 21:25:43 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103160224.SAA03920@csl.Stanford.EDU>
Subject: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
To: linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2001 18:24:51 -0800 (PST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote an extension to gcc that does global analysis to determine
which pointers in 2.4.1 are ever treated as user space pointers (i.e,
passed to copy_*_user, verify_area, etc) and then makes sure they are
always treated that way.

It found what looks to be 9 errors, and  3 cases I'm not sure about.
I've tried to eliminate false positives, but if any remain, please let
me know.

Two questions: 
	1. if a verify_area is done to a pointer, can the pointer then
	be manipulated raw?  E.g., is this ok?
		if(!verify_area(VERIFY_READ, p, sizeof *p)))
			tmp = *p;

	2.  And, unrelated:  given the current locking discipline, is
	it bad to hold any type of lock (not just a spin lock) when you
	call a potentially blocking function?  (It at least seems bad
	for performance, since you'll hold the lock for milliseconds.)

Dawson
---------------------------------------------------------
[BUG] sends 'rt' as the user pointer to copy_to_user, but ipddp_find_route
      derferences it directly.

	ipddp_find derefs this struct.
	struct at_addr
	{
        	__u16   s_net;
        	__u8    s_node;
	};

/u2/engler/mc/oses/linux/2.4.1/drivers/net/appletalk/ipddp.c:274:ipddp_ioctl: ERROR:PARAM:277:274: tainted var 'rt' (from line 277) used as arg 0 to 'ipddp_create'

        {
		case SIOCADDIPDDPRT:
Error --->
                        return (ipddp_create(rt));

                case SIOCFINDIPDDPRT:
Start --->
                        if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
                                return -EFAULT;
---------------------------------------------------------
[BUG] sends 'rt' as the user pointer to copy_to_user, but ipddp_find_route
      derferences it directly.

/u2/engler/mc/oses/linux/2.4.1/drivers/net/appletalk/ipddp.c:277:ipddp_ioctl: ERROR:PARAM:277:277: tainted var 'rt' (from line 277) used as arg 0 to 'ipddp_find_route'


                case SIOCFINDIPDDPRT:
Start --->
Error --->
                        if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
                                return -EFAULT;
---------------------------------------------------------
[BUG] sends 'rt' as the user pointer to copy_to_user, but ipddp_find_route
      derferences it directly.

/u2/engler/mc/oses/linux/2.4.1/drivers/net/appletalk/ipddp.c:282:ipddp_ioctl: ERROR:PARAM:277:282: tainted var 'rt' (from line 277) used as arg 0 to 'ipddp_delete'


                case SIOCFINDIPDDPRT:
Start --->
                        if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
                                return -EFAULT;
                        return 0;

                case SIOCDELIPDDPRT:
Error --->
                        return (ipddp_delete(rt));

---------------------------------------------------------
[BUG] copy_to_user taints "arg" on one switch branch, but
      capabilities check derefs it w/o checks on another

/u2/engler/mc/oses/linux/2.4.1/drivers/telephony/ixj.c:5046:ixj_ioctl: ERROR:PARAM:4687:5046: tainted var 'arg' (from line 4687) used as arg 1 to 'capabilities_check'

		break;
	case IXJCTL_VERSION:
Start --->
		if (copy_to_user((char *) arg, ixj_c_revision, strlen(ixj_c_revision)))
			return -EFAULT;
		break;
	case PHONE_RING_CADENCE:
		j->ring_cadence = arg;
		break;
	case IXJCTL_CIDCW:

	... DELETED 345 lines ...

	case PHONE_CAPABILITIES:
		retval = j->caps;
		break;
	case PHONE_CAPABILITIES_LIST:
		if (copy_to_user((char *) arg, j->caplist, sizeof(struct phone_capability) * j->caps))
			 return -EFAULT;
		break;
	case PHONE_CAPABILITIES_CHECK:
Error --->
		retval = capabilities_check(board, (struct phone_capability *) arg);
		break;
	case PHONE_PSTN_SET_STATE:
		daa_set_mode(board, arg);
		break;


static int capabilities_check(int board, struct phone_capability *pcreq)
{
        int cnt;
        IXJ *j = &ixj[board];
        int retval = 0;
        for (cnt = 0; cnt < j->caps; cnt++) {
                if (pcreq->captype == j->caplist[cnt].captype
                    && pcreq->cap == j->caplist[cnt].cap) {
                        retval = 1;
                        break;
                }
        }
        return retval;
}


---------------------------------------------------------
[BUG] Looks like a bug where the memcpy forgets to use the user_buf pointer.

/u2/engler/mc/oses/linux/2.4.1/drivers/usb/serial/digi_acceleport.c:1288:digi_write: ERROR:PARAM:1271:1288: tainted var 'buf' (from line 1271) used as arg 1 to '__constant_memcpy'

	/* copy user data (which can sleep) before getting spin lock */
	count = MIN( 64, MIN( count, port->bulk_out_size-2 ) );
Start --->
	if( from_user && copy_from_user( user_buf, buf, count ) ) {
		return( -EFAULT );
	}

	/* be sure only one write proceeds at a time */
	/* there are races on the port private buffer */
	/* and races to check write_urb->status */

	/* wait for urb status clear to submit another urb */
	if( port->write_urb->status == -EINPROGRESS
	|| priv->dp_write_urb_in_use ) {

		/* buffer data if count is 1 (probably put_char) if possible */
		if( count == 1 ) {
			new_len = MIN( count,
				DIGI_OUT_BUF_SIZE-priv->dp_out_buf_len );
Error --->
			memcpy( priv->dp_out_buf+priv->dp_out_buf_len, buf,
				new_len );
			priv->dp_out_buf_len += new_len;
		} else {
			new_len = 0;

---------------------------------------------------------
[BUG]  put_user taints "optlen", but the dereference doesn't to anything
       special to it.
/u2/engler/mc/oses/linux/2.4.1/net/decnet/af_decnet.c:1433:__dn_getsockopt: ERROR:PARAM:1537:1433: Deref tainted var 'optlen' (tainted from line 1537)

	struct dn_scp *scp = DN_SK(sk);
	struct linkinfo_dn link;
Error --->
	int r_len = *optlen;
	void *r_data = NULL;
	int val;

	switch(optname) {
		case DSO_CONDATA:
			if (r_len > sizeof(struct optdata_dn))

	... DELETED 90 lines ...

				r_len = sizeof(unsigned char);
			r_data = &scp->info_rem;
			break;
	}

	if (r_data) {
		if (copy_to_user(optval, r_data, r_len))
			return -EFAULT;
Start --->
		if (put_user(r_len, optlen))
			return -EFAULT;
	}

	return 0;
---------------------------------------------------------
[BUG]   Looks like this code was grafted on later.  The put_user taints it,
	but the error dereference it without any checks.

/u2/engler/mc/oses/linux/2.4.1/net/decnet/af_decnet.c:1487:__dn_getsockopt: ERROR:PARAM:1537:1487: Deref tainted var 'optlen' (tainted from line 1537)

#ifdef CONFIG_NETFILTER
		{
Error --->
			int val, len = *optlen;
			val = nf_getsockopt(sk, PF_DECnet, optname, 
							optval, &len);
			if (val >= 0)
				val = put_user(len, optlen);
			return val;
		}

	... DELETED 36 lines ...

				r_len = sizeof(unsigned char);
			r_data = &scp->info_rem;
			break;
	}

	if (r_data) {
		if (copy_to_user(optval, r_data, r_len))
			return -EFAULT;
Start --->
		if (put_user(r_len, optlen))
			return -EFAULT;
	}

	return 0;

---------------------------------------------------------
[BUG] In debugging code though
/u2/engler/mc/oses/linux/2.4.1/drivers/usb/serial/omninet.c:308:omninet_write: ERROR:PARAM:315:308: tainted var 'buf' (from line 315) used as arg 3 to 'usb_serial_debug_data'

        }

Error --->
        usb_serial_debug_data (__FILE__, __FUNCTION__, count, buf);

        spin_lock_irqsave (&port->port_lock, flags);

        count = (count > OMNINET_BULKOUTSIZE) ? OMNINET_BULKOUTSIZE : count;

        if (from_user) {
Start --->
                copy_from_user(wport->write_urb->transfer_buffer + OMNINET_DATAOFFSET, buf, count);
        }
---------------------------------------------------------
[BUG] in debugging code though
/u2/engler/mc/oses/linux/2.4.1/drivers/usb/serial/usbserial.c:817:generic_write: ERROR:PARAM:820:817: tainted var 'buf' (from line 820) used as arg 3 to 'usb_serial_debug_data'

                count = (count > port->bulk_out_size) ? port->bulk_out_size : count;

Error --->
                usb_serial_debug_data (__FILE__, __FUNCTION__, count, buf);

                if (from_user) {
Start --->
                        copy_from_user(port->write_urb->transfer_buffer, buf, count);
                }

---------------------------------------------------------
[UNKNOWN]  does a verify_area on pDivalog and then calls Divalog which 
	   derefs it directly --- is this ok?

/u2/engler/mc/oses/linux/2.4.1/drivers/isdn/eicon/linchr.c:132:do_ioctl: ERROR:PARAM:130:132: tainted var 'pDivaLog' (from line 130) used as arg 0 to 'DivasLog'

                        pDivaLog = (dia_log_t *) arg;

Start --->
                        if (!verify_area(VERIFY_READ, pDivaLog, sizeof(dia_log_t)))
                        {
Error --->
                                DivasLog(pDivaLog);
                        }

/u2/engler/mc/oses/linux/2.4.1/drivers/isdn/eicon/linchr.c:173:do_ioctl: ERROR:PARAM:143:173: tainted var 'arg' (from line 143) used as arg 0 to 'DivasGetList'

/u2/engler/mc/oses/linux/2.4.1/drivers/isdn/eicon/linchr.c:187:do_ioctl: ERROR:PARAM:185:187: tainted var 'mem_block' (from line 185) used as arg 0 to 'DivasGetMem'

/u2/engler/mc/oses/linux/2.4.1/drivers/isdn/eicon/linchr.c:65:do_ioctl: ERROR:PARAM:63:65: tainted var 'pDivaConfig' (from line 63) used as arg 0 to 'DivasCardConfig'
---------------------------------------------------------
[UNKNOWN]  I'm not sure about this: "csum_partial_*" calls the generic
	   cksum routine which does guard against user pointers ---
	   is this redundant paranoia in this case?

/u2/engler/mc/oses/linux/2.4.1/net/ipv4/tcp_output.c:643:tcp_retrans_try_collapse: ERROR:PARAM:651:643: tainted var 'skb_put' (from line 651) used as arg 0 to '__constant_memcpy'

		if(skb->len % 4) {
			/* Must copy and rechecksum all data. */
Error --->
			memcpy(skb_put(skb, next_skb_size), next_skb->data, next_skb_size);
			skb->csum = csum_partial(skb->data, skb->len, 0);
		} else {
			/* Optimize, actually we could also combine next_skb->csum
			 * to skb->csum using a single add w/carry operation too.
			 */
			skb->csum = csum_partial_copy_nocheck(next_skb->data,
							      skb_put(skb, next_skb_size),
Start --->
							      next_skb_size, skb->csum);
		}
