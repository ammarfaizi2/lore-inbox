Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSJ1WwE>; Mon, 28 Oct 2002 17:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJ1WwE>; Mon, 28 Oct 2002 17:52:04 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:16548 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261657AbSJ1WwB>;
	Mon, 28 Oct 2002 17:52:01 -0500
Date: Mon, 28 Oct 2002 23:58:21 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       torvalds@transmeta.com
Subject: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021028225821.GA29868@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Hanna Linder <hannal@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
	torvalds@transmeta.com
References: <20021028220809.GB27798@outpost.ds9a.nl> <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 02:29:37PM -0800, Davide Libenzi wrote:

> sys_epoll, by plugging directly in the existing kernel architecture,
> supports sockets and pipes. It does not support and there're not even
> plans to support other devices like tty, where poll() and select() works
> flawlessy. Since the sys_epoll ( and /dev/epoll ) fd support standard polling, you

Ok. I suggest the manpage mention this prominently. 

I tried a somewhat more involved example and it indeed works expected. As an
application developer, this suits my needs just fine. I really like the
'edge' nature of it all.

The interface is also lovely:

for(;;) {
  nfds = sys_epoll_wait(kdpfd, &pfds, -1);	
  fprintf(stderr,"sys_epoll_wait returned: %d\n",nfds);
  
  for(n=0;n<nfds;++n) {
    if(pfds[n].fd==s) {
      client=accept(s, (struct sockaddr*)&local, &addrlen);

      if(client<0){
	perror("accept");
	continue;
      }
      if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN ) < 0) {
	fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
	return -1;
      }                                        
    }
    else
      printf("something happened on fd %d\n", pfds[n].fd);
  }
}

Each time a packet comes in, sys_wait returns just once so I can immediately
call it again without having to wait for another thread to have actually
*done* something with that socket.

Righteous stuff, I'll be using this, thanks.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
