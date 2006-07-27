Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWG0WJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWG0WJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWG0WJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:09:15 -0400
Received: from main.gmane.org ([80.91.229.2]:60049 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751377AbWG0WJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:09:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.
Date: Thu, 27 Jul 2006 16:08:53 -0600
Message-ID: <eabdhq$nca$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060101040208040906060900"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101040208040906060900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

fctnl(F_SETSIG) no longer works in 2.6.17, does in 2.6.16.

The attached program (oplocktest.c) illustrates.  Compile and run with 
strace.  In another
shell do "echo >> oplockstest.c".  On 2.6.16 we get:

fcntl64(3, F_SETSIG, 0x23)              = 0
fcntl64(3, 0x400 /* F_??? */, 0x1)      = 0
nanosleep({50, 0}, 0)                   = ? ERESTART_RESTARTBLOCK (To be 
restarted)
--- SIGRT_3 (Real-time signal 1) @ 0 (0) ---
+++ killed by SIGRT_3 +++

on 2.6.17 we get:

fcntl64(3, F_SETSIG, 0x23)              = 0
fcntl64(3, 0x400 /* F_??? */, 0x1)      = 0
nanosleep({50, 0}, 0)                   = ? ERESTART_RESTARTBLOCK (To be 
restarted)
--- SIGIO (I/O possible) @ 0 (0) ---
+++ killed by SIGIO +++

The signal is no longer changed from SIGIO to SIGRT_3.

This causes problems with samba and kernel oplocks.  Windows clients get 
the dreaded "Delayed Write Failed" message when smbd dies with SIGIO.

-- 
Orion Poplawski
System Administrator                   303-415-9701 x222
Colorado Research Associates/NWRA      FAX: 303-415-9702
3380 Mitchell Lane, Boulder CO 80301   http://www.co-ra.com

--------------060101040208040906060900
Content-Type: text/x-csrc;
 name="oplocktest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oplocktest.c"

/* 
   Unix SMB/CIFS implementation.
   kernel oplock processing for Linux
   Copyright (C) Andrew Tridgell 2000
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#define DBGC_CLASS DBGC_LOCKING
#include <signal.h>
#include <errno.h>
#include <sys/fcntl.h>
#include <sys/select.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

typedef unsigned int uint32;

/* these can be removed when they are in glibc headers */
struct  cap_user_header {
	uint32 version;
	int pid;
} header;
struct cap_user_data {
	uint32 effective;
	uint32 permitted;
	uint32 inheritable;
} data;

extern int capget(struct cap_user_header * hdrp,
		  struct cap_user_data * datap);
extern int capset(struct cap_user_header * hdrp,
		  const struct cap_user_data * datap);

#ifndef F_SETLEASE
#define F_SETLEASE	1024
#endif

#ifndef F_GETLEASE
#define F_GETLEASE	1025
#endif

#ifndef CAP_LEASE
#define CAP_LEASE 28
#endif

#ifndef RT_SIGNAL_LEASE
#define RT_SIGNAL_LEASE (SIGRTMIN+1)
#endif

#ifndef F_SETSIG
#define F_SETSIG 10
#endif

/****************************************************************************
 Try to gain a linux capability.
****************************************************************************/

static void set_capability(unsigned capability)
{
#ifndef _LINUX_CAPABILITY_VERSION
#define _LINUX_CAPABILITY_VERSION 0x19980330
#endif
	header.version = _LINUX_CAPABILITY_VERSION;
	header.pid = 0;

	if (capget(&header, &data) == -1) {
		printf("Unable to get kernel capabilities (%s)\n", strerror(errno));
		return;
	}

	data.effective |= (1<<capability);

	if (capset(&header, &data) == -1) {
		printf("Unable to set %d capability (%s)\n", 
			 capability, strerror(errno));
	}
}

/****************************************************************************
 Call SETLEASE. If we get EACCES then we try setting up the right capability and
 try again
****************************************************************************/

static int linux_setlease(int fd, int leasetype)
{
	int ret;

	if (fcntl(fd, F_SETSIG, RT_SIGNAL_LEASE) == -1) {
		printf("Failed to set signal handler for kernel lease\n");
		return -1;
	}

	ret = fcntl(fd, F_SETLEASE, leasetype);
	if (ret == -1 && errno == EACCES) {
		set_capability(CAP_LEASE);
		ret = fcntl(fd, F_SETLEASE, leasetype);
	}

	return ret;
}

int main(int argc, char **argv)
{
	int fd;

	fd = open("oplocktest.c", O_RDONLY);
        linux_setlease(fd, 1);	

   struct timespec ts;

   ts.tv_sec = 50;
   ts.tv_nsec = 0;

   nanosleep(&ts, NULL);

   return(0);
}



--------------060101040208040906060900--

