Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264115AbTCXFim>; Mon, 24 Mar 2003 00:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264116AbTCXFim>; Mon, 24 Mar 2003 00:38:42 -0500
Received: from [196.12.44.6] ([196.12.44.6]:10473 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S264115AbTCXFil>;
	Mon, 24 Mar 2003 00:38:41 -0500
Date: Mon, 24 Mar 2003 11:21:42 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: GETHOSTBYNAME()
In-Reply-To: <F64RsqSoQHK3gSkQsfl0000279b@hotmail.com>
Message-ID: <Pine.LNX.4.44.0303241111250.26195-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just have a look at the code at the bottom... that should make it clear.  
This again is what i implemented for my project and its working fine.

> Thanks for the help. But if I am opening a socket in a lodable kernel module 
> and need to send a message to a perticular IP say 158.168.1.1, then how to 
> populate the structure sock_data.sin_addrs


	// We dont have a inet_addr in user space.
	unsigned int inet_addr(char *str)
	{
	  int a,b,c,d;
	  char arr[4];
	  sscanf(str,"%d.%d.%d.%d",&a,&b,&c,&d);
	  arr[0] = a; arr[1] = b; arr[2] = c; arr[3] = d;
	  return *(unsigned int*)arr;
	}

	// Get the host...
	int gethost(struct sockaddr_in *addr)
	{
	  unsigned long ad;
	  addr->sin_family = AF_INET;
	  addr->sin_port = htons(sysctl_dos_tcpport );
	  ad = inet_addr("172.16.7.12");
	  if( ad == INADDR_NONE ){
	    printk("dos_select_host: Host not found");
	    return -EHOSTUNREACH;
	  }
	  addr->sin_addr.s_addr = ad;
	  return 0;
	}


	// Connect to the remote host...
	struct socket* connect(struct sockaddr_in* sock_addr)
	{
	  int retval;
	  struct socket *sock;
	
	  retval = sock_create(AF_INET,SOCK_STREAM,0,&sock);
	
	  if (retval < 0) {
	    printk("(connect) could not create a socket\n");
	    return NULL;
	  }

	  retval = sock->ops->connect(sock,
			(struct sockaddr *)sock_addr,
			sizeof(struct sockaddr_in),0);
	
	  if (retval < 0) {
	    printk("(connect) error on connect: %d\n",retval);
	    sock_release(sock);
	    return NULL;
	  }
	
	  return sock;
	}

Hope this serves your purpose...

Prasad.

-- 
Failure is not an option


