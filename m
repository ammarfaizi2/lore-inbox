Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270295AbTGWNRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270321AbTGWNRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:17:09 -0400
Received: from H-135-207-24-32.research.att.com ([135.207.24.32]:64746 "EHLO
	mailman.research.att.com") by vger.kernel.org with ESMTP
	id S270295AbTGWNRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:17:03 -0400
Date: Wed, 23 Jul 2003 09:32:09 -0400 (EDT)
From: David Korn <dgk@research.att.com>
Message-Id: <200307231332.JAA26197@raptor.research.att.com>
X-Mailer: mailx (AT&T/BSD) 9.9 2003-01-17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: kernel bug in socketpair() 
Cc: gsf@research.att.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am not sure what the procedure for reporting bugs, but here
is a description of two bugs and a program that can can be used
to produce them.

$ uname -a 
Linux fror.research.att.com 2.4.18-18.7.xsmp #1 SMP Wed Nov 13 19:01:42 EST 2002


The first problem is that files created with socketpair() are not accessible
via /dev/fd/n or /proc/$$/fd/n where n is the file descriptor returned
by socketpair().  Note that this is not a problem with pipe().

The second problem is that if fchmod(fd,S_IWUSR) is applied to the write end
of a pipe(),  it causes the read() end to also be write only so that
opening  /dev/fd/n for read fails.

The following program demonstrates these problems.  If invoked without
arguments, socketpair() is used to create to files.  Later the
open /dev/fd/n and /proc/$$/fd/n fail.

With one argument, pipe() is used instead of socketpair() and the
program works.  With two arguments, pipe() is used bug fchmod()
is also called, and then it fails.

==================cut here======================
#include	<sys/socket.h>
#include	<sys/stat.h>
#include	<stdio.h>
#include	<errno.h>


int main(int argc, char *argv[])
{
	char buff[256];
	int pv[2], fd;
	if(argc>1)
		fd = pipe(pv);
	else
		fd = socketpair(PF_UNIX, SOCK_STREAM, 0, pv);
	if(fd<0)
	{
		fprintf(stderr,"socketpar failed err=%d\n",errno);
		exit(1);
	}
	if(argc<2)
	{
		if(shutdown(pv[0],1)< 0)
		{
			fprintf(stderr,"shutdown send failed err=%d\n",errno);
			exit(1);
		}
		if(shutdown(pv[1],0)< 0)
		{
			fprintf(stderr,"shutdown recv failed err=%d\n",errno);
			exit(1);
		}
	}
	if(argc!=2)
	{
		fchmod(pv[0],S_IRUSR);
		fchmod(pv[1],S_IWUSR);
	}
	sprintf(buff,"/dev/fd/%d\0",pv[0]);
	errno = 0;
	fd = open(buff,0);
	fprintf(stderr,"name=%s fd=%d errno=%d\n",buff,fd,errno);
	sprintf(buff,"/proc/%d/fd/%d\0",getpid(),pv[0]);
	fd = open(buff,0);
	fprintf(stderr,"name=%s fd=%d errno=%d\n",buff,fd,errno);
	return(0);
}

==================cut here======================

David Korn
dgk@research.att.com
