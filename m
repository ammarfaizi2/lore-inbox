Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUGIXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUGIXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUGIXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:11:26 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:52111 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266016AbUGIXLV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:11:21 -0400
Message-ID: <c26fd82804070916115a1e238b@mail.gmail.com>
Date: Fri, 9 Jul 2004 16:11:12 -0700
From: Qiuyu Zhang <qiuyu.zhang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: strange about copy_from_user
In-Reply-To: <Pine.LNX.4.53.0407091752360.2731@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <c26fd828040709143843b3143f@mail.gmail.com> <Pine.LNX.4.53.0407091752360.2731@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, 

I can describe what I do and my code simply.

I am try to do a module driver. So far  I can insmod the module and
config ip address etc.  There is a existed queue in user space which
is alloc by a user application. When I send a ping packet by the
device I create, it will call dev->hard_start_xmit. In this function I
need put the data into user space queue. Similarly, I also need read
the data from queue when user put a data into queue. That's what I
want to do.

Code description:
struct Queue
{
      int read;
      int write;
      int length;
      char *data;
};


At first, the module driver is inserted into kernel  by calling
insmod. And then user space application call a function to tell
(register) module driver what is the pointer of the queue. The
function be called by user application is as following

int regQ2kernel( char *devname , char *queue){
     struct ifrequ ifr;
      int sockfd;
      if((sockfd =  socket(AF_INET,SOCK_DGRAM,0))<0）{
             ....
     } 
      strncpy(ifr.ifr_name, devname, sizeof(ifr.ifr_name));
      ifr.ifr_data = pQueue;
      if((ret= ioctl(sockfd, SIOREGIFFLAGS, (int)&ifr))<0}{

      }

      close(sockfd);
       return 1;
}

When the user application call the above function, the module driver
in kernel can get the pointer of queue. And then I just store the
pointer of queue.

After I configure IP address and startup the module driver, I send a
ping packet to the device. The packet arrived to the device correctly,
then I need copy the data to queue in user space.

Here, I have questions. 

1) when I got the pointer of queue, can I access the item in the
struct directly such as read, write etc?  I try to do it. Sometimes it
will crash  OS.

2) Due to the above reason, I want to copy the struct of queue to
kernel space and then access the item of the Queue. But I cannot get
the correct content .

static int usbModem_dev_xmit(struct sk_buff *skb, struct net_device *dev){

     struct Queue *p =  (struct Queue *)dev->priv;
     struct Queue kQueue;
     copy_from_user(&kQueue, *p, sizeof(struct Queue));
      ......
     // here , the data of kQueue is not the data in Queue in user
space, I don't know why.

}


The strange thing is that when I use copy_from_user at ioctl function,
everything is correct. How could figure it out?

So far the quesiton is clear ?

Thanks again.





On Fri, 9 Jul 2004 17:57:57 -0400 (EDT), Richard B. Johnson
<root@chaos.analogic.com> wrote:
> 
> 
> On Fri, 9 Jul 2004, Qiuyu Zhang wrote:
> 
> > Hi all,
> > I am working on writing a module driver.
> >
> > I am trying to use API copy_from_user to copy a bunch of memory from
> > user space to kernel space. I write a ioctl function to register the
> > pointer of the memory to kernel. And in the ioctl function I can use
> > copy_from_user to get the correct data, but the strange thing is that
> > when I use copy_from_user in other kernel function such as
> > dev_hard_xmit function , I cannot
> > get the correct result. I don't konw what the reason is . Thx.
> > -
> 
> Without looking at the code it's hard to figure out what you
> may be doing. However, copy_from_user() and copy_to_user() may
> not ever be executed with a spin-lock held. Generally, if
> you need to put user data into kernel "things", you need
> to buffer it, i.e., copy_from_user() into a kmalloc(ed) buffer,
> then work with it in kernel space.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
>
