Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVCGU50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVCGU50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVCGU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:56:29 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:10418 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261813AbVCGUNe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:34 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [2/5] bd: userspace utility to control asynchronous block device
In-Reply-To: <11102278582250@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:39 +0300
Message-Id: <1110227859165@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>

#include <linux/types.h>

#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>

#define __USE_LARGEFILE64
#include <fcntl.h>

#include "bd.h"
#include "bd_fd.h"
#include "bd_acrypto.h"
#include "../crypto/crypto_def.h"

#define ulog(f, a...) fprintf(stderr, f, ##a)
struct table;

struct self
{
	char		device[BD_MAX_NAMESIZ];
	char		filter[BD_MAX_NAMESIZ];
};

struct table
{
	int		idx;
	char		name[BD_MAX_NAMESIZ];
	int		(* handler)(struct table *tblp, char *argv[], int argc);
	int		argc;

	struct self	*self;
};

struct param
{
	int		found;
	char		name[BD_MAX_NAMESIZ];
	char		*val;
};

#define walk_through_table(tblp, tbl, i) \
	for (i=sizeof(tbl)/sizeof(tbl[0])-1, tblp=&tbl[i]; i; --i, tblp=&tbl[i]) \

static struct self generic_self;

static int default_action_handler(struct table *tblp, char *argv[], int argc);
static int bind_action_handler(struct table *tblp, char *argv[], int argc);
static int unbind_action_handler(struct table *tblp, char *argv[], int argc);

static struct table action_table[] = 
{
	{0, 	"default", 	default_action_handler, 	0,	&generic_self},
	{0, 	"bind", 	bind_action_handler, 		5,	&generic_self},
	{0, 	"unbind", 	unbind_action_handler, 		5,	&generic_self},
};

static int fd_action_handler(struct table *tblp, char *argv[], int argc);
static int acrypto_action_handler(struct table *tblp, char *argv[], int argc);
static struct table bind_table[] = 
{
	{0, 	"default", 	default_action_handler, 	0,	&generic_self},
	{0, 	"fd", 		fd_action_handler, 		2,	&generic_self},
	{0, 	"acrypto", 	acrypto_action_handler, 	10,	&generic_self},
};

static int run_cmd(int fd, int request, void *arg)
{
	int err;

	err = ioctl(fd, request, arg);
	if (err)
	{
		ulog("Failed to make %d request : %s [%d].\n", 
				request, strerror(errno), errno);
		return err;
	}

	return 0;
}

static int scmp(char *str1, char *str2)
{
	int l1, l2;

	l1 = strlen(str1);
	l2 = strlen(str2);

	if (l1 > l2)
		return strncmp(str1, str2, l2);
	else
		return strncmp(str1, str2, l1);
}

static int default_action_handler(struct table *tblp __attribute__((unused)), char *argv[], int argc __attribute__((unused)))
{
	ulog("Unsupported action \"%s\".\n", argv[0]);

	return -1;
}

static int generic_action_handler(char *argv[])
{
	if (scmp(argv[1], "dev"))
	{
		ulog("Unsupported \"%s\" parameter in \"%s\" action.\n", argv[1], argv[0]);
		return -1;
	}
	
	snprintf(generic_self.device, sizeof(generic_self.device), "%s", argv[2]);

	if (scmp(argv[3], "filter"))
	{
		ulog("Unsupported \"%s\" parameter in \"%s\" action.\n", argv[3], argv[0]);
		return -1;
	}

	snprintf(generic_self.filter, sizeof(generic_self.filter), "%s", argv[4]);
	
	//ulog("filter=%s, device=%s.\n", generic_self.filter, generic_self.device);

	return 0;
}

static int bind_action_handler(struct table *tblp, char *argv[], int argc)
{
	struct table *p;
	int err, i, fd;
	struct bd_user u;
	
	err = generic_action_handler(argv);
	if (err)
		return err;

	argc -= tblp->argc;
	argv += tblp->argc-1;

	//ulog("%s: argv[0]=%s, argc=%d.\n", __func__, argv[0], argc);

	walk_through_table(p, bind_table, i)
	{
		//ulog("i=%d, argc=%d, cnt=%d, name=%s.\n", i, argc, p->argc, p->name);

		if (argc < p->argc)
			continue;

		if (!scmp(p->name, argv[0]))
		{
			err = p->handler(p, argv, argc);
			return err;
		}
	}
	
	fd = open(tblp->self->device, O_RDWR | O_LARGEFILE);
	if (fd == -1)
	{
		ulog("Failed to open device file %s when binding filter %s: %s [%d].\n",
				tblp->self->device, tblp->self->filter,
				strerror(errno), errno);
		return -errno;
	}

	strcpy(u.name, tblp->self->filter);
	u.size = 0;
	
	err = run_cmd(fd, BD_BIND_FILTER, &u);

	return err;
}

static int unbind_action_handler(struct table *tblp, char *argv[], int argc __attribute__((unused)))
{
	int err, fd;
	struct bd_user u;
	
	err = generic_action_handler(argv);
	if (err)
		return err;

	fd = open(tblp->self->device, O_RDWR | O_LARGEFILE);
	if (fd == -1)
	{
		ulog("Failed to open device file %s when binding filter %s: %s [%d].\n",
				tblp->self->device, tblp->self->filter,
				strerror(errno), errno);
		return -errno;
	}

	strcpy(u.name, tblp->self->filter);
	u.size = 0;
	
	err = run_cmd(fd, BD_UNBIND_FILTER, &u);

	return err;
}

static int fd_action_handler(struct table *tblp, char *argv[], int argc __attribute__((unused)))
{
	int err, fd, len, tfd;
	char name[BD_MAX_NAMESIZ];
	char buf[128];
	struct bd_user *u;
	struct bd_fd_user *fdu;
		
	if (scmp(argv[1], "file"))
	{
		ulog("Unsupported \"%s\" parameter in \"%s\" action.\n", argv[1], argv[0]);
		return -1;
	}

	len = snprintf(name, sizeof(name), "%s", argv[2]);

	fd = open(tblp->self->device, O_RDWR | O_LARGEFILE);
	if (fd == -1)
	{
		ulog("Failed to open device file %s when binding filter %s: %s [%d].\n",
				tblp->self->device, tblp->self->filter,
				strerror(errno), errno);
		return -errno;
	}

	tfd = open(name, O_RDWR | O_LARGEFILE);
	if (tfd == -1)
	{
		ulog("Failed to open target file %s: %s [%d].\n",
				name, strerror(errno), errno);
		close(fd);
		return -errno;
	}

	u = (struct bd_user *)buf;
	fdu = (struct bd_fd_user *)(u+1);
	
	strcpy(u->name, tblp->self->filter);
	u->size = sizeof(*fdu);
	fdu->fd = tfd;
	
	err = run_cmd(fd, BD_BIND_FILTER, u);
	if (err)
		ulog("Failed to bind filter %s to device %s: err=%d.\n",
				tblp->self->filter, tblp->self->device, err);

	close(tfd);
	close(fd);
	
	//ulog("%s: len=%d, name=%s, err=%d.\n", __func__, len, name, err);

	
	return err;
}

static int acrypto_action_handler(struct table *tblp, char *argv[], int argc)
{
	struct param args[] = {
		{0,	"cipher", 	NULL},
		{0,	"key", 		NULL},
		{0,	"iv", 		NULL},
		{0,	"priority", 	NULL},
		{0,	"mode",		NULL},
	};
	int i, j, found, sz, fd, err;
	char buf[128];
	struct bd_user *u;
	struct bd_acrypto_private *a;
	
	memset(buf, 0, sizeof(buf));

	u = (struct bd_user *)buf;
	a = (struct bd_acrypto_private *)(u+1);

	found = 0;
	for (i=0; i<(signed)(sizeof(args)/sizeof(args[0])); ++i)
	{
		for (j=1; j<argc; j+=2)
		{
			if (scmp(args[i].name, argv[j]))
				continue;

			if (args[i].found)
			{
				ulog("dev=%s, filter=%s: parameter \"%s\" already found in \"%s\", ignoring.\n",
						tblp->self->device, tblp->self->filter, 
						args[i].name, argv[0]);
				continue;
			}

			args[i].found = 1;
			found++;

			args[i].val = argv[j+1];
		}
	}

	if (found != sizeof(args)/sizeof(args[0]))
	{
		ulog("dev=%s, filter=%s: wrong parameters set: found=%d, sz=%u.\n", 
				tblp->self->device, tblp->self->filter,
				found, sizeof(args)/sizeof(args[0]));
		return -1;
	}

	if (!scmp(args[0].val, "aes128"))
		a->type = CRYPTO_TYPE_AES_128;
	else if (!scmp(args[0].val, "aes192"))
		a->type = CRYPTO_TYPE_AES_192;
	else if (!scmp(args[0].val, "aes256"))
		a->type = CRYPTO_TYPE_AES_256;
	else if (!scmp(args[0].val, "3des"))
		a->type = CRYPTO_TYPE_3DES;
	else
	{
		ulog("dev=%s, filter=%s: unsupported cipher \"%s\".\n", tblp->self->device, tblp->self->filter, args[0].val);
		return -1;
	}

	if (!scmp(args[4].val, "ecb"))
		a->mode = CRYPTO_MODE_ECB;
	else if (!scmp(args[4].val, "cbc"))
		a->mode = CRYPTO_MODE_CBC;
	else if (!scmp(args[4].val, "cfb"))
		a->mode = CRYPTO_MODE_CFB;
	else if (!scmp(args[4].val, "ofb"))
		a->mode = CRYPTO_MODE_OFB;
	else
	{
		ulog("dev=%s, filter=%s: unsupported mode \"%s\".\n", tblp->self->device, tblp->self->filter, args[4].val);
		return -1;
	}

	a->priority = (__u16)(atoi(args[3].val) & 0xffff);

	sz = (signed)strlen(args[1].val)/2;
	if (sz % 2 != 0 || sz > (signed)sizeof(a->key))
	{
		ulog("dev=%s, filter=%s: wrong length of the \"%s\".\n", tblp->self->device, tblp->self->filter, args[1].val);
		return -1;
	}

	
	j = 0;
	for (i=0; i<(signed)strlen(args[1].val)-1; i+=2)
	{
		unsigned char v[2] = {args[1].val[i], args[1].val[i+1]};
		unsigned char val;

		val = (unsigned char)(strtol(v, NULL, 16) & 0xff);

		a->key[j++] = val;
	}

	a->key_size = j;
	
	sz = (signed)strlen(args[2].val)/2;
	if (sz % 2 != 0 || sz > (signed)sizeof(a->iv))
	{
		ulog("dev=%s, filter=%s: wrong length of the \"%s\".\n", tblp->self->device, tblp->self->filter, args[2].val);
		return -1;
	}
	j = 0;
	for (i=0; i<(signed)strlen(args[2].val)-1; i+=2)
	{
		unsigned char v[2] = {args[2].val[i], args[2].val[i+1]};
		unsigned char val;

		val = (unsigned char)(strtol(v, NULL, 16) & 0xff);

		a->iv[j++] = val;
	}
	
	a->iv_size = j;

	ulog("dev=%s, filter=%s: cipher=%s, mode=%s, priority=%d, key_size=%u, iv_size=%u.\n", 
			tblp->self->device, tblp->self->filter, args[0].val, args[4].val, a->priority,
			a->key_size, a->iv_size);


	fd = open(tblp->self->device, O_RDWR | O_LARGEFILE);
	if (fd == -1)
	{
		ulog("Failed to open device file %s when binding filter %s: %s [%d].\n",
				tblp->self->device, tblp->self->filter,
				strerror(errno), errno);
		return -errno;
	}
	
	strcpy(u->name, tblp->self->filter);
	u->size = sizeof(*a);
	
	err = run_cmd(fd, BD_BIND_FILTER, u);
	if (err)
		ulog("Failed to bind filter %s to device %s: err=%d.\n",
				tblp->self->filter, tblp->self->device, err);

	close(fd);
	
	return err;
}

int main(int argc, char *argv[])
{
	int i, err;
	struct table *atp;

	argc--;
	argv++;

	walk_through_table(atp, action_table, i)
	{
		if (argc < action_table[i].argc)
			continue;
		
		//ulog("i=%d, argc=%d, cnt=%d, name=%s.\n", i, argc, atp->argc, atp->name);
		
		if (!scmp(argv[0], atp->name))
		{
			err = atp->handler(atp, argv, argc);
			return err;
		}
	}
	
	return action_table[0].handler(&action_table[0], argv, argc);
}

