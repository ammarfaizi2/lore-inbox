Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVCGUwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVCGUwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVCGUvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:51:54 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:2738 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261801AbVCGUNa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:30 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [??/many] iok.c - simple example of the userspace acrypto usage [IOCTL]
In-Reply-To: <1110227853899@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <1110227853606@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>

#include <linux/types.h>

#include "crypto_user.h"
#include "crypto_user_ioctl.h"
#include "crypto_def.h"

#define ulog(f, a...) fprintf(stderr, f, ##a)

int session_add(int fd, void *ptr)
{
	int err;

	err = ioctl(fd, CRYPTO_SESSION_ADD, ptr);
	if (err == -1)
	{
		ulog("Failed to do CRYPTO_SESSION_ADD: %s [%d].\n", strerror(errno), errno);
		return -1;
	}

	ulog("CRYPTO_SESSION_ADD finished.\n");

	return 0;
}
int session_alloc(int fd, struct crypto_user_ioctl *io)
{
	int err;

	err = ioctl(fd, CRYPTO_SESSION_ALLOC, io);
	if (err == -1)
	{
		ulog("Failed to do CRYPTO_SESSION_ALLOC: %s [%d].\n", strerror(errno), errno);
		return -1;
	}

	ulog("CRYPTO_SESSION_ALLOC finished.\n");

	return 0;
}

int fill_data(int fd, unsigned short size, unsigned short type, void *ptr)
{
	int err;
	struct crypto_user_data *d;
	void *data;

	data = malloc(size + sizeof(*d));
	if (!data)
	{
		ulog("Failed to allocate %d bytes for CRYPTO_FILL_DATA[%u.%x].\n",
				size + sizeof(*d), size, type);
		return -ENOMEM;
	}

	d = (struct crypto_user_data *)data;

	d->data_size = size;
	d->data_type = type;

	memcpy(d+1, ptr, size);

	err = ioctl(fd, CRYPTO_FILL_DATA, d);
	if (err == -1)
	{
		ulog("Failed to do CRYPTO_FILL_DATA[%u.%x]: %s [%d].\n", 
				size, type, strerror(errno), errno);
		free(data);
		return -1;
	}
	free(data);

	ulog("CRYPTO_FILL_DATA[%u.%x] finished.\n", size, type);

	return 0;
}

static void dump_data(unsigned char *ptr, int size)
{
	int i;

	ulog("IOK DATA: ");
	for (i=0; i<size; ++i)
		ulog("%02x ", ptr[i]);
	ulog("\n");
}

int main(int argc, char *argv[])
{
	int fd, err, size;
	void *ptr;
	unsigned char key[16];
	struct crypto_user_ioctl io;

	if (argc != 2)
	{
		ulog("Usage: %s path\n", argv[0]);
		return -1;
	}

	fd = open(argv[1], O_RDWR);
	if (fd == -1)
	{
		ulog("Failed to open file %s: %s [%d].\n", argv[1], strerror(errno), errno);
		return -1;
	}
	
	size = 2048;

	io.operation = CRYPTO_OP_ENCRYPT;
	io.type = CRYPTO_TYPE_AES_128;
	io.mode = CRYPTO_MODE_ECB;
	io.priority = 0;
	
	io.src_size = size;
	io.dst_size = size;
	io.key_size = 16;
	io.iv_size = 0;

	err = session_alloc(fd, &io);
	if (err)
		goto err_out_close_fd;

	ptr = malloc(size);
	if (!ptr)
	{
		ulog("Failed to create data.\n");
		goto err_out_close_fd;
	}
	memset(ptr, 0, size);

	memset(key, 0, sizeof(key));

	err = fill_data(fd, size, CRYPTO_USER_DATA_SRC, ptr);
	if (err)
		goto err_out_free_ptr;
	err = fill_data(fd, size, CRYPTO_USER_DATA_DST, ptr);
	if (err)
		goto err_out_free_ptr;
	err = fill_data(fd, 16, CRYPTO_USER_DATA_KEY, key);
	if (err)
		goto err_out_free_ptr;
	
	dump_data(ptr, size);

	err = session_add(fd, ptr);
	if (err)
		goto err_out_free_ptr;

	dump_data(ptr, size);
	
err_out_free_ptr:
	free(ptr);

err_out_close_fd:
	close(fd);

	return err;
}

