Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVCGVVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVCGVVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVCGVSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:18:34 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:16562 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261823AbVCGUNm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:42 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [??/many] ucon_crypto.c - simple example of the userspace acrypto usage [DIRECT ACCESS]
In-Reply-To: <1110227853606@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <1110227853910@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/*
 * 	ucon_crypto.c
 *
 * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 * 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include <asm/types.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>
#include <sys/mman.h>

#include <linux/netlink.h>
#include <linux/types.h>
#include <linux/rtnetlink.h>

#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#include "../connector/connector.h"

#include "crypto_def.h"
#include "crypto_conn.h"
#include "crypto_user.h"

static int need_exit;
static __u32 seq;

static int netlink_send(FILE *out, int s, struct cn_msg *msg)
{
	struct nlmsghdr *nlh;
	unsigned int size;
	char buf[128];
	int err;
	struct cn_msg *m;
	struct crypto_conn_data *cmd;

	cmd = (struct crypto_conn_data *)(msg + 1);
	size = NLMSG_SPACE(sizeof(struct cn_msg) + msg->len);

	nlh = (struct nlmsghdr *)buf;
	nlh->nlmsg_seq = seq++;
	nlh->nlmsg_pid = getpid();
	nlh->nlmsg_type = NLMSG_DONE;
	nlh->nlmsg_len = NLMSG_LENGTH(size - sizeof(*nlh));
	nlh->nlmsg_flags = 0;

	m = NLMSG_DATA(nlh);

	printf("%s: len=%u, seq=%u, ack=%u, "
	       "name=%s, cmd=%02x.\n",
	       __func__,
	       msg->len, msg->seq, msg->ack,
	       cmd->name, cmd->cmd);

	memcpy(m, msg, sizeof(*m) + msg->len);

	err = send(s, nlh, size, 0);
	if (err == -1)
	{
		fprintf(out, "Failed to send: %s [%d].\n",
			strerror(errno), errno);
		return err;
	}
	fprintf(out, "%d bytes has been sent.\n", size);

	return 0;
}

static int send_cmd(FILE *out, int s, struct crypto_conn_data *cm)
{
	struct cn_msg *data;
	struct crypto_conn_data *m;
	int size;
	
	size = sizeof(*data) + sizeof(*m) + cm->len;

	data = malloc(size);
	if (!data)
		return -ENOMEM;
	
	memset(data, 0, size);

	data->id.idx = 0xdead;
	data->id.val = 0x0000;
	data->seq = seq++;
	data->ack = 0;
	data->len = sizeof(*cm) + cm->len;

	m = (struct crypto_conn_data *)(data + 1);
	memcpy(m, cm, sizeof(*m));
	
	memcpy(m+1, cm->data, cm->len);

	return netlink_send(out, s, data);
}

static int request_stat(FILE *out, int s, char *name)
{
	struct crypto_conn_data m;
	
	memset(&m, 0, sizeof(m));
	
	m.cmd = CRYPTO_GET_STAT;
	m.len = 0;

	snprintf(m.name, sizeof(m.name), "%s", name);

	return send_cmd(out, s, &m);
}

static void process_stat(FILE *out, struct cn_msg *data)
{
	struct crypto_device_stat *stat;
	struct crypto_conn_data *m;
	time_t tm;

	m = (struct crypto_conn_data *)(data + 1);
	stat = (struct crypto_device_stat *)(m+1);

	time(&tm);
	fprintf(out,
		"%.24s : [%x.%x] [seq=%u, ack=%u], name=%s, cmd=%#02x, "
		"sesions: completed=%llu, started=%llu, finished=%llu, kmem_failed=%llu.\n",
		ctime(&tm), data->id.idx, data->id.val,
		data->seq, data->ack, m->name, m->cmd, 
		stat->scompleted, stat->sstarted, stat->sfinished, stat->kmem_failed);
	fflush(out);
}

static void dump_data(FILE *out, unsigned char *ptr)
{
	int i;

	fprintf(out, "UCON DATA: ");
	for (i=0; i<32; ++i)
		fprintf(out, "%02x ", ptr[i]);
	fprintf(out, "\n");
}

static int request_crypto(FILE *out, int s, char *name)
{
	void *ptr;
	int size, err;
	struct crypto_user usr;
	struct crypto_conn_data *m;

	size = 4000;
	ptr = malloc(size);
	if (!ptr)
	{
		fprintf(out, "Failed to allocate %d byte area.\n", size);
		return -1;
	}
	memset(ptr, 0x00, size);

	err = mlock(ptr, size);
	if (err == -1)
	{
		fprintf(out, "Failed to lock %d byte area.\n", size);
		free(ptr);
		return -1;
	}

	memset(&usr, 0, sizeof(usr));

	usr.operation 	= CRYPTO_OP_ENCRYPT;
	usr.mode 	= CRYPTO_MODE_ECB;
	usr.type 	= CRYPTO_TYPE_AES_128;
	usr.priority 	= 0;

	usr.src		= (__u64)ptr;
	usr.src_size	= size;
	usr.dst		= (__u64)ptr;
	usr.dst_size	= size;

	usr.pid		= getpid();

	usr.key_size	= 0;
	usr.iv_size	= 0;

	m = malloc(sizeof(*m) + sizeof(usr) + usr.key_size + usr.iv_size);
	if (!m)
		return -ENOMEM;
	memset(m, 0, sizeof(m));
	memcpy(m+1, &usr, sizeof(usr));
	
	m->cmd = CRYPTO_REQUEST;
	m->len = sizeof(usr);

	snprintf(m->name, sizeof(m->name), "%s", name);

	dump_data(out, ptr);
	err = send_cmd(out, s, m);
	if (err)
		goto err_out_free;

	fprintf(out, "Command was sent.\n");
	sleep(1);
	dump_data(out, ptr);
	
	//return 0;
	
err_out_free:
	free(m);
	
	err = munlock(ptr, size);
	if (err == -1)
	{
		fprintf(out, "Failed to unlock %d byte area.\n", size);
		free(ptr);
		return -1;
	}

	free(ptr);

	return err;
}

int main(int argc, char *argv[])
{
	int s, tmp;
	char buf[128];
	int len;
	struct nlmsghdr *reply;
	struct sockaddr_nl l_local;
	struct cn_msg *data;
	struct crypto_conn_data *m;
	FILE *out;
	struct pollfd pfd;

	if (argc < 2)
		out = stdout;
	else {
		out = fopen(argv[1], "a+");
		if (!out) {
			fprintf(stderr, "Unable to open %s for writing: %s\n",
				argv[1], strerror(errno));
			out = stdout;
		}
	}

	memset(buf, 0, sizeof(buf));

	s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
	if (s == -1) {
		perror("socket");
		return -1;
	}

	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = 0xdead;
	l_local.nl_pid = getpid();

	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) == -1) {
		perror("bind");
		close(s);
		return -1;
	}

	pfd.fd = s;
		
	//request_stat(s, "async_provider0");
	
	for (len=0; len<1000; ++len)
		request_crypto(out, s, "hifn0");

	tmp = 0;
	while (!need_exit) {


		pfd.events = POLLIN;
		pfd.revents = 0;
		switch (poll(&pfd, 1, -1)) 
		{
			case 0:
				need_exit = 1;
				break;
			case -1:
				if (errno != EINTR) 
				{
					need_exit = 1;
					break;
				}
				continue;
		}
		if (need_exit)
			break;

		memset(buf, 0, sizeof(buf));
		len = recv(s, buf, sizeof(buf), 0);
		if (len == -1) {
			perror("recv buf");
			close(s);
			return -1;
		}
		reply = (struct nlmsghdr *)buf;

		switch (reply->nlmsg_type) {
		case NLMSG_ERROR:
			fprintf(out, "Error message received.\n");
			fflush(out);
			break;
		case NLMSG_DONE:
			data = (struct cn_msg *)NLMSG_DATA(reply);
			m = (struct crypto_conn_data *)(data + 1);
			
			switch (m->cmd)
			{
				case CRYPTO_GET_STAT:
					process_stat(out, data);
					break;
				default:
					break;
			}

			break;
		default:
			break;
		}
	}

	close(s);
	return 0;
}

