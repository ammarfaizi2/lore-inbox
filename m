Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWDTPZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWDTPZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWDTPZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:25:36 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:58519 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751012AbWDTPZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:25:35 -0400
Date: Thu, 20 Apr 2006 19:25:25 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060420152524.GA14664@2ka.mipt.ru>
References: <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com> <20060416114017.GA30180@2ka.mipt.ru> <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com> <20060416132515.GA25602@2ka.mipt.ru> <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com> <20060418060744.GA20715@2ka.mipt.ru> <369a7ef40604190439v6e8f1bf6lf52cfab5af3a93af@mail.gmail.com> <20060419121423.GA6057@2ka.mipt.ru> <369a7ef40604200812x594a8b3dxc4d730cdbfda720e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604200812x594a8b3dxc4d730cdbfda720e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 20 Apr 2006 19:25:26 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 05:12:33PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:

> - When sending message from kernel, cn_netlink_send returns an error
> in case when there is no reciever - BUT user space "send" doesn't
> return an error when there is no reciever in kernel :-(

Userspace sends it into kernel socket. Groups were created for
userspace's sockets, so there is always a listener in kernelspace.

> - How (if) can I do ACK (acknoledge received and processed message)?

I put seq and ack fields into connector header, and described a simple
protocol for it's usage, but it does require some work by driver author, 
it is impossible to generate automatic ack messages in netlink 
(well, it is possible to generate nlmsgerr message sending but generally 
it is not what people want with protocols designed over connector).

> Thanks for your help,
> Libor Vanek

> /*
>  * 	cn_send.c
>  */

...

> void my_send_test(void)
> {
> 	struct cn_msg *msg;
> 	char data[32];
> 	int ret;
> 	
> 	msg = kmalloc(sizeof(*msg) + sizeof(data), GFP_ATOMIC);

Not a good style of allocating data from atomic pool without checks for
return value.
Btw, you do not need to allocate it dynamically, 
char msg[sizeof(struct cn_msg) + 32] will work too.

...

> /*
>  * 	cn_user_recv.c
>  */

...
 
> 	l_local.nl_family = AF_NETLINK;
> 	l_local.nl_groups = 0x3;
> 	l_local.nl_pid    = getpid();
> 	
> 	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
> 		perror("bind");
> 		close(s);
> 		return -1;
> 	}
> 	int on = l_local.nl_groups;
> 	if (setsockopt(s, 270, 1, &on, sizeof(on))) {
> 		perror("setsockopt");
> 		close(s);
> 		return -1;
> 	}

In this example you will receive messages for groups 1, 2 (bind time
gropus 0x3 is equal to (1<<(1-1)) | (1<<(2-1))) and group 3 (you
have subscribed to that gropu explicitly).


-- 
	Evgeniy Polyakov
