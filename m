Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVCWIPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVCWIPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVCWIPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:15:51 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34970 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262855AbVCWIPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:15:20 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Ram <linuxram@us.ibm.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Erich Focht <efocht@hpce.nec.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <424060DE.4050701@engr.sgi.com>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
	 <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	 <424060DE.4050701@engr.sgi.com>
Date: Wed, 23 Mar 2005 09:15:07 +0100
Message-Id: <1111565707.8332.63.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/03/2005 09:24:46,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/03/2005 09:24:48,
	Serialize complete at 23/03/2005 09:24:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 10:15 -0800, Jay Lan wrote:
> Guillaume Thouvenin wrote:
> > On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
> > 
> >>     If a bunch of applications are listening for fork events, 
> >>     your patch allows any application to turn off the 
> >>     fork event notification?  Is this the right behavior?
> > 
> > 
> > Yes it is. The main management is done by application so, if several
> > applications are listening for fork events you need to choose which one
> > will turn off the fork connector. 
> 
> It is not practical. One listener never know who else are listening
> to the fork connector.
> 
> We also need to protect yet another global variable "cn_fork_enable".
> 
> Also, in order to implement "cn_fork_enable" as a counter, we need
> some sort of registration to prevent an application from sending
> repeated "off" notification. One can only turn off its own switch.

  I agree with the Evgeniy's ip example. I can provide a fork connector
interface utility to enable or disable the fork connector. Thus,
listeners don't have to start and stop the fork connector and they don't
have to worry about who else are listening the fork connector. It also
removes the need of registration.

  I copy at the end of this email the code of the fork connector
controller application (called fcctl).

  I need to add the possibility to get the state of the fork connector.
I also need to extend the fork connector to send to everyone information
when it is turned off/on.


Regards,
Guillaume


/*
 * fcctl.c - Fork connector interface utility
 *
 * Used to turn on/off the fork connector
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <sys/socket.h>
#include <sys/types.h>

#include <linux/connector.h>
#include <linux/netlink.h>

#define MESSAGE_SIZE    (sizeof(struct nlmsghdr) + \
                         sizeof(struct cn_msg)   + \
                         sizeof(int))

#define FORK_CN_DISABLE	0
#define FORK_CN_ENABLE	1
#define FORK_CN_UNKNOWN	2

void show_help()
{
	printf("usage: fcctl {on|off}\n\n");
}

int main(int argc, char **argv)
{
	int sk_nl;
	int err;
	int action = FORK_CN_UNKNOWN;
	struct sockaddr_nl sa_nl;	/* info for the netlink interface */
	char buff[128];		/* must be > MESSAGE_SIZE */
	struct nlmsghdr *hdr;
	struct cn_msg *mesg;

	if (getuid() != 0) {
		printf("Only root can start/stop the fork connector\n");
		return 0;
	}

	if (argc != 2) {
		show_help();
		return 0;
	}

	if (strcmp(argv[1], "on") == 0)
		action = FORK_CN_ENABLE;
	else if (strcmp(argv[1], "off") == 0)
		action = FORK_CN_DISABLE;

	if (action == FORK_CN_UNKNOWN) {
		show_help();
		return 0;
	}

	/*
	 * Create an endpoint for communication. Use the kernel user
	 * interface device (PF_NETLINK) which is a datagram oriented
	 * service (SOCK_DGRAM). The protocol used is the netfilter/iptables 
	 * ULOG protocol (NETLINK_NFLOG)
	 */
	sk_nl = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
	if (sk_nl == -1) {
		printf("socket sk_nl error");
		return -1;
	}

	sa_nl.nl_family = AF_NETLINK;
	sa_nl.nl_groups = CN_IDX_FORK;
	sa_nl.nl_pid = getpid();

	err = bind(sk_nl, (struct sockaddr *)&sa_nl, sizeof(sa_nl));
	if (err == -1) {
		printf("binding sk_nl error");
		close(sk_nl);
		return -1;
	}

	/* Clear the buffer */
	memset(buff, '\0', sizeof(buff));

	/* fill the message header */
	hdr = (struct nlmsghdr *)buff;

	hdr->nlmsg_len = MESSAGE_SIZE;
	hdr->nlmsg_type = NLMSG_DONE;
	hdr->nlmsg_flags = 0;
	hdr->nlmsg_seq = 0;
	hdr->nlmsg_pid = getpid();

	/* the message */
	mesg = (struct cn_msg *)NLMSG_DATA(hdr);
	mesg->id.idx = CN_IDX_FORK;
	mesg->id.val = CN_VAL_FORK;
	mesg->seq = 0;
	mesg->ack = 0;
	mesg->len = sizeof(int);
	mesg->data[0] = action;

	send(sk_nl, hdr, hdr->nlmsg_len, 0);

	close(sk_nl);

	return 0;
}
   

