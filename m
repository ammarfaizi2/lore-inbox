Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423750AbWJ0Gy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423750AbWJ0Gy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 02:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423754AbWJ0Gy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 02:54:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:41155 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423750AbWJ0Gy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 02:54:56 -0400
X-Authenticated: #14349625
Subject: Re: CPU Loading
From: Mike Galbraith <efault@gmx.de>
To: Indian Mogul <indian_mogul@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061027053731.57351.qmail@web54511.mail.yahoo.com>
References: <20061027053731.57351.qmail@web54511.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 07:26:28 +0000
Message-Id: <1161933988.6102.28.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 22:37 -0700, Indian Mogul wrote:

> How can I load the CPU such that the scheduling time
> slice is insuffucent for mplayer to playout the video?
> To the mplayer the system thus appears "slow" ?

:) unusual request.

The proglet below, which someone posted a while back, should meet your
needs nicely.  Fire up a few copies in the background with args like
5000 6000 7000 8000 9000.., and mplayer should become decidedly unhappy.

The scheduler round robin schedules tasks which it has classified as
interactive (tasks which sleep somewhat regularly basically) at a higher
rate than their timeslice to reduce latency, but the more tasks
circulating at the same priority (or above) as mplayer, the bigger the
latency hit mplayer will take.

	-Mike

#include <stdlib.h>
#include <unistd.h>

static void burn_cpu(unsigned int x)
{
	static char buf[1024];
	int i;
	
	for (i=0; i < x; ++i)
		buf[i%sizeof(buf)] = (x-i)*3;
}

int main(int argc, char **argv)
{
	unsigned long burn;
	if (argc != 2)
		return 1;
	burn = (unsigned long)atoi(argv[1]);
	while(1) {
		burn_cpu(burn*1000);
		usleep(1);
	}
	return 0;
}


