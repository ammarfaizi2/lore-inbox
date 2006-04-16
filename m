Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWDPNZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWDPNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 09:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWDPNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 09:25:29 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:35990 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750735AbWDPNZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 09:25:28 -0400
Date: Sun, 16 Apr 2006 17:25:15 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060416132515.GA25602@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com> <20060416114017.GA30180@2ka.mipt.ru> <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 16 Apr 2006 17:25:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2006 at 02:09:57PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> On 4/16/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Sun, Apr 16, 2006 at 01:26:10PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> > > Hi,
> > >
> > > > I've attached simple userspace program used with w1, which sends
> > > > and receives connector messages. It can be also used as example of
> > > > netlink usage from userspace point of view.
> > >
> > > Maybe I'm really stupid and/or blind but I can't find in this example
> > > (from my point of view) quite important features:
> > >
> > > - there is no way how can user-space part say what "cb_id.idx" and
> > > "cb_id.val" it should accept (as far as I understand these are used
> > > for settings "message type" - what SW is using these)
> >
> > "idx" field is a group number userspace binds to, "val" is a private
> > identificator which is used as you like.
> 
> See attached example please - I've created simple kernel module
> "cn_test" which on recieving message from cn_user_send should "bounce
> it" to cn_user_recv.
> 
> If I change "l_local.nl_groups" in cn_user_send.c/cn_user/rect.c to
> anything else (e.g. "l_local.nl_groups = 0x5;" it still works... (all
> messages are delivered...)

It looks like you are using old kernel, which had ability to multicast
messages not only to specified group but to any other which has at least
one bit from original group set, since 23 & 0x5 is true, message will be
delivered.
But in more recent kernel this is not the case anymore.

I will test your module tomorrow and report if it works correctly or
not. I've just tested w1 connector with completely different group
number which does have the same bits set (group 3 in kernel and group 4
in bind time in userspace), and message was delivered successfully.
I will investigate it further tomorrow.

> > > - I can't find neither in cn_test.c nor w1_netlink.c (which is the
> > > only part I found connector used in) any way of detecting if message
> > > was delivered to/from user-space
> > If cn_netlink_send() returns zero this means message was queued into
> > userspace socket. In case of error negative value is returned.
> > > - the very same is for detecting if there is some user-space
> > > "reciever" (there is some mention about this in
> > > Documentantation/connector/connector.txt but it's not working to
> > > myself - I got 2.6.17-pre1-mm2)
> >
> > connector uses netlink_has_listeners(), but it can produce false
> > positives, in this case netlink_broadcast() will say the final word.
> > If message has been added into socket's queue netlink_broadcast(), which
> > is used in connector, returns zero, and it's return value is propagated
> > back to original caller of cn_netlink_send().
> 
> Yes, but "cn_netlink_send()" return zero even in case than there is no
> reciever (so message is lost because there is nobody to listen to it)
> - see attached cn_test.c:30

No, cn_netlink_send() only returns zero if there are listeners and
message was successfully delivered.

> > Message from userspace is always delivered, and in this case appropriate
> > callback is called.
> 
> Libor Vanek

> /*
>  * 	cn_test.c
>  */
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/moduleparam.h>
> #include <linux/skbuff.h>
> #include <linux/timer.h>
> 
> #include <linux/connector.h>
> 
> static struct cb_id cn_test_id = { 0x3, 0x1 };
> static char cn_test_name[] = "cn_test";
> static struct sock *nls;

You do not need any socket when you use connector.

> static int seq_id = 0;
> 
> void cn_test_callback(void *data)
> {
> 	int ret;
> 	struct cn_msg *msg = (struct cn_msg *)data;
> 	
> 	printk("%s: %lu: idx=%x, val=%x, seq=%u, ack=%u, len=%d: %s\n",
> 	       __func__, jiffies, msg->id.idx, msg->id.val,
> 	       msg->seq, msg->ack, msg->len, (char *)msg->data);
> 
> 	msg->seq = seq_id++;
> 	msg->ack = 0;
> 
> 	ret = cn_netlink_send(msg, 0x3, gfp_any());

This will deliver message to group 3 but not that one specified in
cn_msg header. You need to set second parameter to zero if you want to
automatically select the right group.

> 	printk("Resend, retval: %i\n", ret);
> }
> 
> static int cn_test_init(void)
> {
> 	int err;
> 
> 	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
> 	if (err)
> 		goto err_out;
> 
> 	printk(KERN_INFO "cn_test loaded\n");
> 	return 0;
> 
> err_out:
> 	if (nls && nls->sk_socket)
> 		sock_release(nls->sk_socket);

No need to release never initialized socket, although it is set to zero
and sock_release() is never called.

> 	return err;
> }
> 
> static void cn_test_fini(void)
> {
> 	cn_del_callback(&cn_test_id);
> 	if (nls && nls->sk_socket)
> 		sock_release(nls->sk_socket);
> 	printk(KERN_INFO "cn_test unloaded\n");
> }
> 
> module_init(cn_test_init);
> module_exit(cn_test_fini);
> 
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Libor Vanek <libor.vanek@gmail.com>");
> MODULE_DESCRIPTION("Connector's test module");
> 

...

-- 
	Evgeniy Polyakov
