Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbTGPKVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270876AbTGPKVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:21:55 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:10370 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S270875AbTGPKVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:21:53 -0400
Message-Id: <200307161032.MAA09922@fire.malware.de>
Date: Wed, 16 Jul 2003 12:35:55 +0200
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, glibc-sc@gnu.org
Subject: [2.4] Inconsistency in poll(2)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: SI4a0OZU8eqS8Qrp4hcOVuyd2N2c5jL0fKE+DZZKUlSCGQIv75LNo9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi readers of linux-kernel and glibc maintainers,

while hacking on a network application I found following oddity:

poll(pds,nfds,timeout) called with one of the file descriptors listed in
pds being invalid always does return nfds.

Output of appended sample code:
poll returned 2
revent[0]: 0
revent[1]: 32

According to IEEE Std 1003.1, 2003 Edition, the return value should have
been 1 in the above sample.

The kernel is 2.4.20 (debian 2.4.20-3-686). After a short look at the
code for sys_poll I am certain the problem is originated within the
kernel.

Any suggestions which actions to take?


Michael


Simple sample code demonstrating the problem:

#include <stdio.h>
#include <sys/poll.h>

struct pollfd fds[] = {
 { 0, POLLIN, 0 },
 { 110, POLLIN, 0}
};

int main(void)
{
	int r = poll(fds, sizeof fds / sizeof fds[0], -1);
	if ( r < 0 )
		perror("poll");
	else
		printf("poll returned %d\n");

	for ( r=0; r < sizeof fds / sizeof fds[0]; r++ )
		printf("revent[%d]: %hd\n", r, fds[r].revents);

	return 0;
}

-- 
Linux@TekXpress
http://www-users.rwth-aachen.de/Michael.Mueller4/tekxp/tekxp.html
