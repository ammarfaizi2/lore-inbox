Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTLNRWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 12:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTLNRWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 12:22:13 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:34722 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262181AbTLNRV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 12:21:57 -0500
Date: Sun, 14 Dec 2003 09:21:56 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: bitkeeper-users@bitmover.com
Subject: RFC - tarball/patch server in BitKeeper
Message-ID: <20031214172156.GA16554@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, bitkeeper-users@bitmover.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merry Christmas.

I've prototyped an extension to BitKeeper that provides tarballs
and patches.  The idea is to make it possible for all trees hosted by
bkbits.net provide access to the data with a free client (included below
in prototype form).

The system is simplistic, it just provides a way to get the most recent
sources as a tarball and then any later updates as a patch.  There is
no provision for generating diffs, editing files, merging, etc.  All of
that is something that you can write, if you want, using standard tools
(think hard linked trees).

Before rolling this out, I want to know if this is going to (finally)
put to rest any complaints about BK not being open source, available on
all platforms, etc.  You need to understand that this is all you get,
we're not going to extend this so you can do anything but track the most
recent sources accurately.  No diffs.  No getting anything but the most
recent version.  No revision history.  

If you want anything other than the most recent version your choices
are to use BitKeeper itself or, if you want the main branches of the
Linux kernel, the BK2CVS exports.  This is not a gateway product, it
is a way for developers to track the latest and greatest with a free
(source based) client.  It is not a way to convert BK repos to $SCM.

If the overwhelming response is positive then I'll add this to the
bkbits.net server and perhaps eventually to the BK product itself.

--lm

Example of it being used on the mysql BK repo (note that server/port is
hardwired, it is a prototype after all)

$ rm -rf tmp
$ tarball
OK-tarball coming, 10535416 bytes to transfer...
OK-tarball transferred, enjoy!
$ ls -F tmp
BUILD/              cmd-line-utils/  libmysqld/      pstack/
BitKeeper/          config.guess*    ltconfig*       regex/
Build-tools/        config.sub*      ltmain.sh       scripts/
Docs/               configure.in     man/            sql/
INSTALL-WIN-SOURCE  dbug/            merge/          sql-bench/
Makefile.am         depcomp*         missing*        sql-common/
NEW-RPMS/           extra/           mkinstalldirs*  strings/
README              heap/            myisam/         support-files/
SSL/                include/         myisammrg/      tests/
VC++Files/          innobase/        mysql-test/     tools/
acconfig.h          install-sh*      mysys/          vio/
acinclude.m4        isam/            mytest-old.c    zlib/
bdb/                libmysql/        netware/
client/             libmysql_r/      os2/
$ update
INFO-generating patch, please wait...
OK-patch coming, 6053 bytes...
patching file mysql-test/r/query_cache.result
patching file mysql-test/r/sp-error.result
patching file mysql-test/r/sp.result
patching file mysql-test/r/variables.result
patching file mysql-test/t/sp-error.test
patching file mysql-test/t/sp.test
patching file sql/handler.cc
patching file sql/handler.h
patching file sql/item_subselect.cc
patching file sql/lex.h
patching file sql/slave.cc
patching file sql/sp.cc
patching file sql/sp_head.cc
patching file sql/sql_parse.cc
patching file sql/sql_table.cc
patching file sql/sql_yacc.yy
OK-patch transferred, enjoy!
$

Source code for the tarball/update clients:

/*
 * tarball.c copyright (c) 2003 BitMover, Inc.
 *
 * Licensed under the NWL - No Whining License.
 *
 * You may use this, modify this, redistribute this provided you agree:
 * - not to whine about this product or any other products from BitMover, Inc.
 * - that there is no warranty of any kind.
 * - retain this copyright in full.
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

#define	min(x, y)	((x) < (y) ? (x) : (y))
#define	unless(x)	if (!(x))

/*
 * Connect to the TCP socket advertised as "port" on "host" and
 * return the connected socket.
 */
int
tcp_connect(char *host, int port)
{
	struct	hostent *h;
	struct	sockaddr_in s;
	int	sock;

	if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
		perror("socket");
		return (-1);
	}
	unless (h = gethostbyname(host)) return (-2);
	memset((void *) &s, 0, sizeof(s));
	s.sin_family = AF_INET;
	memmove((void *)&s.sin_addr, (void*)h->h_addr, h->h_length);
	s.sin_port = htons(port);
	if (connect(sock, (struct sockaddr*)&s, sizeof(s)) < 0) {
		return (-3);
	}
	return (sock);
}

/*
 * Get the tarball and unpack it.
 */
int
main(void)
{
	int	sock = tcp_connect("localhost", 2000);
	int	n, left, want, i, bytes;
	FILE	*f;
	char	buf[BUFSIZ];

	unless (write(sock, "tarball\n", 8) == 8) exit(1);
line:	for (i = 0; ; i++) {
		unless (read(sock, &buf[i], 1) == 1) exit(1);
		if (buf[i] == '\n') {
			buf[i+1] = 0;
			break;
		}
	}
	switch (buf[0]) {
	    case 'I':
		fprintf(stderr, "%s", buf);
		goto line;
	    case 'E':
		fprintf(stderr, "%s", buf);
		exit(1);
	    case 'O':
		fprintf(stderr, "%s", buf);
		sscanf(buf, "OK-tarball coming, %u bytes", &bytes);
		left = bytes;
		break;
	    default:
	    	exit(1);
	}
	system("rm -rf tmp");
	mkdir("tmp", 0775);
	chdir("tmp");
	unless (f = popen("tar xzf -", "w")) exit(1);
	want = min(sizeof(buf), left);
	while ((n = read(sock, buf, want)) > 0) {
		fwrite(buf, 1, n, f);
		left -= n;
		if (left <= 0) break;
		want = min(sizeof(buf), left);
	}
	pclose(f);
	while (read(sock, buf, 1) == 1) write(2, buf, 1);
	return (0);
}

/*
 * update.c copyright (c) 2003 BitMover, Inc.
 *
 * Licensed under the NWL - No Whining License.
 *
 * You may use this, modify this, redistribute this provided you agree:
 * - not to whine about this product or any other products from BitMover, Inc.
 * - that there is no warranty of any kind.
 * - retain this copyright in full.
 */

#include <errno.h>
#include <zlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

#define	min(x, y)	((x) < (y) ? (x) : (y))
#define	unless(x)	if (!(x))
#define	u32		unsigned int

/*
 * Connect to the TCP socket advertised as "port" on "host" and
 * return the connected socket.
 */
int
tcp_connect(char *host, int port)
{
	struct	hostent *h;
	struct	sockaddr_in s;
	int	sock;

	if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
		perror("socket");
		return (-1);
	}
	unless (h = gethostbyname(host)) return (-2);
	memset((void *) &s, 0, sizeof(s));
	s.sin_family = AF_INET;
	memmove((void *)&s.sin_addr, (void*)h->h_addr, h->h_length);
	s.sin_port = htons(port);
	if (connect(sock, (struct sockaddr*)&s, sizeof(s)) < 0) {
		return (-3);
	}
	return (sock);
}

/*
 * Get the patch and unpack it.
 */
int
main(void)
{
	int	sock = tcp_connect("localhost", 2000);
	int	n, left, want, i;
	FILE	*f;
	char	buf[BUFSIZ];

	if (chdir("tmp")) exit(1);
	unless (write(sock, "patch\n", 6) == 6) exit(1);
	unless (f = fopen("BitKeeper/etc/keys", "r")) exit(1);
	while (fgets(buf, sizeof(buf), f)) {
		if (write(sock, buf, strlen(buf)) != strlen(buf)) exit(1);
	}
	fclose(f);
line:	for (i = 0; ; i++) {
		unless (read(sock, &buf[i], 1) == 1) exit(1);
		if (buf[i] == '\n') {
			buf[i+1] = 0;
			break;
		}
	}
	switch (buf[0]) {
	    case 'I':
		fprintf(stderr, "%s", buf);
		goto line;
	    case 'E':
		fprintf(stderr, "%s", buf);
		exit(1);
	    case 'O':
		fprintf(stderr, "%s", buf);
		sscanf(buf, "OK-patch coming, %u bytes...", &left);
		break;
	    default:
	    	exit(1);
	}
	unless (f = popen("gunzip | patch -p1", "w")) exit(1);
	want = min(sizeof(buf), left);
	while ((n = read(sock, buf, want)) > 0) {
		fwrite(buf, 1, n, f);
		left -= n;
		if (left <= 0) break;
		want = min(sizeof(buf), left);
	}
	pclose(f);
	while (read(sock, buf, 1) == 1) write(2, buf, 1);
	return (0);
}
