Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJ2AM0>; Mon, 28 Oct 2002 19:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJ2AM0>; Mon, 28 Oct 2002 19:12:26 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:32424 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261715AbSJ2AMW>;
	Mon, 28 Oct 2002 19:12:22 -0500
Date: Tue, 29 Oct 2002 01:18:43 +0100
From: bert hubert <ahu@ds9a.nl>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       davidel@xmailserver.org
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029001843.GB31212@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	John Gardiner Myers <jgmyers@netscape.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
	davidel@xmailserver.org
References: <20021028220809.GB27798@outpost.ds9a.nl> <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com> <20021028225821.GA29868@outpost.ds9a.nl> <3DBDCC02.6060100@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBDCC02.6060100@netscape.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 03:45:06PM -0800, John Gardiner Myers wrote:

> As you have amply demonstrated, the current epoll API is error prone. 
> The API should be fixed to test the poll condition and, if necessary, 
> drop an event upon insertion to the set.

That is a semantics change and not an API/ABI change. To reiterate, you
mention the following scenario:

for(;;) {
	nfds = sys_epoll_wait(kdpfd, &pfds, -1);
	for(n = 0; n < nfds; ++n) {
		if((fd = pfds[n].fd) == s) {
                        /* 1: accept client (SYN/SYN|ACK/ACK completed) */
			client = accept(s, (struct sockaddr*)&local, &addrlen);
			if(client < 0){
				perror("accept");
				continue;
			}

			/* 2: packet comes in, client becomes readable  */
			/* 3: registering interest */
			if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN ) < 0) {
				fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
				return -1;
			}
			
			/* 4: interest only now registered, no edge will be
			   reported, our fd is lost */

			fd = client;
		}
		do_use_fd(fd);
	}
}                                                                                                                     

There are lots of ways to solve this, I bet Davide knows best. Perhaps it is
solved already, you can't tell from only studying the API, the problem isn't
intrinsic to it.  

An easy solution is to have sys_epoll_ctl check if there is there is data
ready and make sure there is an edge to report in that case to the next call
of sys_epoll_ctl().

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
