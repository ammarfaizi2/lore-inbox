Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135948AbRDZVvw>; Thu, 26 Apr 2001 17:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135949AbRDZVvc>; Thu, 26 Apr 2001 17:51:32 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:44482 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S135948AbRDZVvX>; Thu, 26 Apr 2001 17:51:23 -0400
Date: Thu, 26 Apr 2001 14:51:20 -0700 (PDT)
From: William Ie <wie@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
cc: mc@CS.Stanford.EDU
Subject: [CHECKER] security rules?
In-Reply-To: <200104130947.CAA21780@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0104261426520.18211-100000@Xenon.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, my name is William Ie and I am currently working with the mc group. We
are currently looking into how capability checks are used in the 2.4.3
kernel. Along the way, we found a few potential bugs that we are not too
sure about. Please bear in mind our checker right now is still very very
crude. 
1.
linux/2.4.3/drivers/block/cciss.c:381:cciss_ioctl:
		put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect,
&geo->start);
		return 0;
	case BLKGETSIZE:
		if (!arg) return -EINVAL;
		put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects,
(long*)arg);
		return 0;
	case BLKRRPART:
		return revalidate_logvol(inode->i_rdev, 1);
Error --->
	case BLKFLSBUF:
our analysis indicates that servicing of the BLKRRPART requires the
CAP_SYS_ADMIN capability check, which is not being done here. Is this a
bug?
2.
linux/2.4.3/drivers/block/cpqarray.c:1182:ida_ioctl:

	case IDAGETDRVINFO:
		return
copy_to_user(&io->c.drv,&hba[ctlr]->drv[dsk],sizeof(drv_info_t));
	case BLKGETSIZE:
		if (!arg) return -EINVAL;

put_user(ida[(ctlr<<CTLR_SHIFT)+MINOR(inode->i_rdev)].nr_sects,
(long*)arg);
		return 0;
	case BLKRRPART:
		return revalidate_logvol(inode->i_rdev, 1);
Error --->
	case IDAPASSTHRU:
		if (!suser()) return -EPERM;
		error = copy_from_user(&my_io, io, sizeof(my_io));
		if (error) return error;
		error = ida_ctlr_ioctl(ctlr, dsk, &my_io);

Same as above.
3.
linux/2.4.3/net/rose/af_rose.c:1290:rose_ioctl:
case SIOCRSSCAUSE: {
			struct rose_cause_struct rose_cause;
			if (copy_from_user(&rose_cause, (void *)arg,
sizeof(struct rose_cause_struct)))
				return -EFAULT;
			sk->protinfo.rose->cause      = rose_cause.cause;
			sk->protinfo.rose->diagnostic =
rose_cause.diagnostic;
			return 0;
		}
The code appears to us to be configuring the device without CAP_NET_ADMIN
capability although we are not too sure that this is actually ok.
4.linux/2.4.3/drivers/net/ppp_async.c:345:ppp_async_ioctl
case PPPIOCGFLAGS:
		val = ap->flags | ap->rbits;
		if (put_user(val, (int *) arg))
			break;
		err = 0;
		break;
case PPPIOCSFLAGS:
		if (get_user(val, (int *) arg))
			break;
		ap->flags = val & ~SC_RCV_BITS;
		spin_lock_bh(&ap->recv_lock);
		ap->rbits = val & SC_RCV_BITS;
		spin_unlock_bh(&ap->recv_lock);
		err = 0;
		break;
seems to be getting and setting some flags without CAP_NET_ADMIN like in
ppp_synctty.c
5.
linux/2.4.3/drivers/isdn/isdn_ppp.c:478:isdn_ppp_ioctl
		case PPPIOCGFLAGS:	/* get configuration flags */
			if ((r = set_arg((void *) arg,
&is->pppcfg,sizeof(is->pppcfg) )))
				return r;
			break;
Error --->
		case PPPIOCSFLAGS:	/* set configuration flags */
			if ((r = get_arg((void *) arg, &val,
sizeof(val) ))) {
				return r;
			}
			if (val & SC_ENABLE_IP && !(is->pppcfg &
SC_ENABLE_IP) && (is->state & IPPP_CONNECT)) {
Same as above.
6.linux/2.4.3/drivers/net/ppp_generic.c:550:ppp_ioctl


	case PPPIOCGFLAGS:
		val = ppp->flags | ppp->xstate | ppp->rstate;
		if (put_user(val, (int *) arg))
			break;
		err = 0;
		break;

Error --->
Same as above.



