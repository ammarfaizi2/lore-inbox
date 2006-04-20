Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWDTPMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWDTPMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWDTPMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:12:34 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:62112 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750981AbWDTPMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:12:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=G2y3+76ZgpyJ39wBGmvyyFZu+trutataRztx2fxBDbHHbmDYkhlNdUg8ZhieojVJFRSdPR1k/JUdkNU3gJ8woSpVh/xN9FxoUlN5jk5wDDqWOuuTFPOCWnQDtrfNoGvn6S0yJatCfBLCTV27Uf21hyfoLpcscKTn8P68aCFIueY=
Message-ID: <369a7ef40604200812x594a8b3dxc4d730cdbfda720e@mail.gmail.com>
Date: Thu, 20 Apr 2006 17:12:33 +0200
From: "Libor Vanek" <libor.vanek@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: Connector - how to start?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060419121423.GA6057@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10046_14125121.1145545953014"
References: <20060414192634.697cd2e3.rdunlap@xenotime.net>
	 <20060415091801.GA4782@2ka.mipt.ru>
	 <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com>
	 <20060416114017.GA30180@2ka.mipt.ru>
	 <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com>
	 <20060416132515.GA25602@2ka.mipt.ru>
	 <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com>
	 <20060418060744.GA20715@2ka.mipt.ru>
	 <369a7ef40604190439v6e8f1bf6lf52cfab5af3a93af@mail.gmail.com>
	 <20060419121423.GA6057@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10046_14125121.1145545953014
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I got it all finally everything working with "setsockopt" as suggested.

In case anybody else wants to experiment with connector, I attach my
examples (maybe add it to Documentation/connector/?)

Anyway - there are two more issues (not bugs) which I'd like to solve:
- When sending message from kernel, cn_netlink_send returns an error
in case when there is no reciever - BUT user space "send" doesn't
return an error when there is no reciever in kernel :-(

- How (if) can I do ACK (acknoledge received and processed message)?

Thanks for your help,
Libor Vanek

------=_Part_10046_14125121.1145545953014
Content-Type: text/x-csrc; name=cn_recv.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_em9880k3
Content-Disposition: attachment; filename="cn_recv.c"

/*
 * 	cn_recv.c
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/skbuff.h>
#include <linux/timer.h>

#include <linux/connector.h>

static struct cb_id cn_recv_id = { 0x3, 0x1 };
static char cn_recv_name[] = "cn_recv";

void cn_recv_callback(void *data)
{
	struct cn_msg *msg = (struct cn_msg *)data;
	
	printk("%s: %lu: idx=%x, val=%x, seq=%u, ack=%u, len=%d: %s\n",
	       __func__, jiffies, msg->id.idx, msg->id.val,
	       msg->seq, msg->ack, msg->len, (char *)msg->data);
}

static int cn_recv_init(void)
{
	int err;

	err = cn_add_callback(&cn_recv_id, cn_recv_name, cn_recv_callback);

	printk(KERN_INFO "cn_recv loaded, cn_add_callback retval: %i\n", err);
	return 0;
}

static void cn_recv_fini(void)
{
	cn_del_callback(&cn_recv_id);
	printk(KERN_INFO "cn_recv unloaded\n");
}

module_init(cn_recv_init);
module_exit(cn_recv_fini);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Libor Vanek <libor.vanek@gmail.com>");
MODULE_DESCRIPTION("Connector's test recieve module");





------=_Part_10046_14125121.1145545953014
Content-Type: text/x-csrc; name=cn_send.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_em9881ad
Content-Disposition: attachment; filename="cn_send.c"

/*
 * 	cn_send.c
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/skbuff.h>
#include <linux/timer.h>

#include <linux/connector.h>

static struct cb_id cn_send_id = { 0x3, 0x1 };
static int seq_id = 0;

void my_send_test(void)
{
	struct cn_msg *msg;
	char data[32];
	int ret;
	
	msg = kmalloc(sizeof(*msg) + sizeof(data), GFP_ATOMIC);
	memset(msg, 0, sizeof(*msg) + sizeof(data));

	msg->id.idx = cn_send_id.idx;
	msg->id.val = cn_send_id.val;
	msg->ack = 0;
	msg->seq = seq_id++;
	msg->len = 5;

	msg->len = sizeof(data);
	msg->len = scnprintf(data, sizeof(data), "Ping") + 1;
	memcpy(msg + 1, data, msg->len);

	ret = cn_netlink_send(msg, cn_send_id.idx, gfp_any());
	kfree(msg);
	printk("Sent, retval: %i\n", ret);
}

static int cn_send_init(void)
{
	my_send_test();
	return 0;
}

static void cn_send_fini(void)
{
	printk(KERN_INFO "cn_send unloaded\n");
}

module_init(cn_send_init);
module_exit(cn_send_fini);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Libor Vanek <libor.vanek@gmail.com>");
MODULE_DESCRIPTION("Connector's test send module");





------=_Part_10046_14125121.1145545953014
Content-Type: text/x-csrc; name=cn_user_recv.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_em98823g
Content-Disposition: attachment; filename="cn_user_recv.c"

/*
 * 	cn_user_recv.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#include <endian.h>
#include <asm/types.h>

#include <sys/socket.h>
#include <sys/poll.h>
#include <sys/types.h>
#include <sys/socket.h>

#include <linux/connector.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>

void process_msg(int s, struct cn_msg *msg)
{
	fprintf(stdout, "Message: %08x.%08x, len=%u, seq=%u, ack=%u, len=%u %s\n",
		msg->id.idx, msg->id.val, msg->len, msg->seq, msg->ack, msg->len, (void *)msg->data);
}

int main(int argc, char *argv[])
{
	int s;
	unsigned char buf[1024];
	int len, need_exit;

	struct sockaddr_nl l_local;
	struct cn_msg *msg;
	struct pollfd pfd;
	struct nlmsghdr *reply;
	
	memset(buf, 0, sizeof(buf));
	
	s = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
	if (s == -1) {
		perror("socket");
		return -1;
	}
	
	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = 0x3;
	l_local.nl_pid    = getpid();
	
	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
		perror("bind");
		close(s);
		return -1;
	}
	int on = l_local.nl_groups;
	if (setsockopt(s, 270, 1, &on, sizeof(on))) {
		perror("setsockopt");
		close(s);
		return -1;
	}

	pfd.fd = s;

	need_exit = 0;
	while (!need_exit) {
		pfd.events = POLLIN;
		pfd.revents = 0;
		switch (poll(&pfd, 1, -1)) {
			case 0:
				need_exit = 1;
				break;
			case -1:
				if (errno != EINTR) {
					need_exit = 1;
					break;
				}
				continue;
			default:
				break;
		}
		if (need_exit)
			break;

		len = recv(s, buf, sizeof(buf), 0);
		if (len == -1) {
			perror("recv buf");
			close(s);
			return -1;
		}

		reply = (struct nlmsghdr *)buf;

		switch (reply->nlmsg_type) {
			case NLMSG_ERROR:
				fprintf(stdout, "Error message received.\n");
				fflush(stdout);
				break;
			case NLMSG_DONE:
				msg = (struct cn_msg *)NLMSG_DATA(reply);
				process_msg(s, msg);
				break;
			default:
				break;
		}
		
	}
	
	close(s);
	return 0;
}






------=_Part_10046_14125121.1145545953014
Content-Type: text/x-csrc; name=cn_user_send.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_em9882n0
Content-Disposition: attachment; filename="cn_user_send.c"

/*
 * 	cn_user_send.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#include <endian.h>
#include <asm/types.h>

#include <sys/socket.h>
#include <sys/poll.h>
#include <sys/types.h>
#include <sys/socket.h>

#include <linux/connector.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>

#define GROUP	0x3

static int send_seq;

static int send_cmd(int s)
{
	static char txtmsg[] = "Ping pong";
	void *m;
	struct cn_msg *cmsg;
	struct nlmsghdr *nlh;
	int size, err;
	
	size = NLMSG_SPACE(sizeof(struct cn_msg) + sizeof(txtmsg));

	nlh = malloc(size);
	if (!nlh)
		return -ENOMEM;
	
	memset(nlh, 0, size);
	
	nlh->nlmsg_seq = send_seq++;
	nlh->nlmsg_pid = getpid();
	nlh->nlmsg_type = NLMSG_DONE;
	nlh->nlmsg_len = NLMSG_LENGTH(size - sizeof(struct nlmsghdr));
	nlh->nlmsg_flags = 0;

	cmsg = NLMSG_DATA(nlh);
	
	cmsg->id.idx = GROUP;
	cmsg->id.val = 0x1;
	cmsg->seq = nlh->nlmsg_seq;
	cmsg->ack = 0;
	cmsg->len = sizeof(txtmsg);

	m = (void *)(cmsg + 1);
	memcpy(m, (void *)txtmsg, sizeof(txtmsg));
	
	err = send(s, nlh, size, 0);
	if (err == -1) {
		fprintf(stdout, "Failed to send: %s [%d].\n", strerror(errno), errno);
	}
	free(nlh);

	return err;
}

int main(int argc, char *argv[])
{
	int s;
	unsigned char buf[1024];
	int len;

	send_seq = 0;

	struct sockaddr_nl l_local;
	struct cn_msg *msg;
	struct nlmsghdr *reply;
	
	memset(buf, 0, sizeof(buf));
	
	s = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
	if (s == -1) {
		perror("socket");
		return -1;
	}
	
	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = GROUP;
	l_local.nl_pid    = getpid();
	
	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
		perror("bind");
		close(s);
		return -1;
	}
	int on = l_local.nl_groups;
	if (setsockopt(s, 270, 1, &on, sizeof(on))) {
		perror("setseckopt");
		close(s);
		return -1;
	}

	send_cmd(s);
	
	close(s);
	return 0;
}






------=_Part_10046_14125121.1145545953014--
