Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWGZDaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWGZDaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 23:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGZDaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 23:30:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51718 "EHLO
	www262.sakura.ne.jp") by vger.kernel.org with ESMTP id S932376AbWGZDaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 23:30:24 -0400
Message-Id: <200607260330.k6Q3UMnS028536@www262.sakura.ne.jp>
Subject: Re: [PATCH][IPv4/IPv6] Setting 0 for unused port field.
From: from-linux-kernel@i-love.sakura.ne.jp
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 12:30:22 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I ran the following programs and I confirmed that
applying the patch attached to the previous message
suppresses returning random u16 values.

As with IPv4, I found that using
"sin->sin_port = sin->sin_port = htons(skb->nh.iph->protocol);"
instead of "sin->sin_port = 0;"
seems to set protocol number in port field,
but I couldn't find appropriate field for IPv6.

Regards.
--
  Tetsuo Handa

------- send.c -------
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <linux/ip.h>

int main(int argc, char *argv[]) {
	static struct iphdr ip;
	struct sockaddr_in addr;
	const int fd = socket(PF_INET, SOCK_RAW, IPPROTO_RAW);
	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
	ip.version = 4;
	ip.ihl = sizeof(struct iphdr) / 4;
	ip.protocol = IPPROTO_RAW;
	ip.saddr = ip.daddr = addr.sin_addr.s_addr;
	while (1) {
		if (sendto(fd, &ip, sizeof(ip), 0, (struct sockaddr *) &addr, sizeof(addr)) == EOF) break;
		sleep(1);
	}
	return 0;
}

------- recv.c -------

#include <stdio.h>
#include <string.h> 
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(int argc, char *argv[]) {
	const int fd = socket(PF_INET, SOCK_RAW, IPPROTO_RAW);
	while (1) {
		static int counter = 0;
		static char buffer[16384];
		struct sockaddr_in addr;
		socklen_t len = sizeof(addr);
		if (counter++ % 5 == 0) {
			sendto(fd, NULL, 0, 0, (struct sockaddr *) &addr, 0);
		}
		memset(&addr, 0, sizeof(addr));
		if (recvfrom(fd, buffer, sizeof(buffer), 0, (struct sockaddr *) &addr, &len) >= 0) {
			printf("%d %08X %d\n", addr.sin_family, ntohl(addr.sin_addr.s_addr), ntohs(addr.sin_port));
		}
	}
	return 0;
}
