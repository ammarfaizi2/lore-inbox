Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVKTOCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVKTOCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 09:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVKTOCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 09:02:22 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:57285 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750987AbVKTOCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 09:02:21 -0500
Date: Sun, 20 Nov 2005 06:02:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Marcel Zalmanovici <MARCEL@il.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inconsistent timing results of multithreaded program on an SMP
 machine.
Message-Id: <20051120060212.16ff475c.pj@sgi.com>
In-Reply-To: <OFEF2B25AC.706FA8BA-ONC22570BF.00336502-C22570BF.0033F2B7@il.ibm.com>
References: <OFEF2B25AC.706FA8BA-ONC22570BF.00336502-C22570BF.0033F2B7@il.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel wrote:
> Instead what I've got was an oscillation where the maximum time was twice
> and more than the minimum!! For a short test results ranged ~7sec to ~16 ...

Just for grins, try displaying which cpu each thread runs on.  Display the
return from "latestcpu(getpid())" in the two per-thread printf's, to display
the thread's cpu at the beginning and end of each compute_thread().  Perhaps
you will notice that the per-thread cpu correlates with the test times.

/*
 * int latestcpu(pid_t pid)
 *
 * Copyright (C) 2005 Silicon Graphics, Inc.
 * This code is subject to the terms and conditions of the
 * GNU General Public License.
 *
 * Return most recent CPU on which task pid executed.
 *
 * The last used CPU is visible for a given pid as field #39
 * (starting with #1) in the file /proc/<pid>/stat.  Currently
 * this file has 41 fields, in which case this is the 3rd to
 * the last field.
 */

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <limits.h>
#include <linux/limits.h>

int latestcpu(pid_t pid)
{
	char buf[PATH_MAX];
	int fd;
	int cpu = -1;

	snprintf(buf, sizeof(buf), "/proc/%d/stat", pid);
	fd = open(buf, O_RDONLY);
	buf[0] = 0;     /* in case fd < 0 and read() is no-op */
	read(fd, buf, sizeof(buf));
	close(fd);
	sscanf(buf, "%*u %*s %*s %*u %*u %*u %*u %*u %*u %*u "
		    "%*u %*u %*u %*u %*u %*u %*u %*u %*u %*u "
		    "%*u %*u %*u %*u %*u %*u %*u %*u %*u %*u "
		    "%*u %*u %*u %*u %*u %*u %*u %*u %u", /* 39th field */
		    &cpu);
	return cpu;
}

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
