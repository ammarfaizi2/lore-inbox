Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCCFyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCCFyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVCCFwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:52:05 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:10385 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261502AbVCCFrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:47:45 -0500
Date: Thu, 3 Mar 2005 08:46:56 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Erich Focht <efocht@hpce.nec.com>, Netlink List <netdev@oss.sgi.com>
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
Message-ID: <20050303084656.A15197@2ka.mipt.ru>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr> <1109753292.8422.117.camel@frecb000711.frec.bull.fr> <42268201.80706@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42268201.80706@ak.jp.nec.com>; from kaigai@ak.jp.nec.com on Thu, Mar 03, 2005 at 12:18:25PM +0900
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Mar 2005 08:46:59 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 12:18:25PM +0900, Kaigai Kohei (kaigai@ak.jp.nec.com) wrote:
> Hello, Guillaume
> 
> I tried to measure the process-creation/destruction performance on 2.6.11-rc4-mm1 plus
> some extensiton(Normal/with PAGG/with Fork-Connector).
> But I received a following messages endlessly on system console with Fork-Connector extensiton.
> 
> # on IA-64 environment / When an simple fork() iteration is run in parallel.
> skb does not have enough length: requested msg->len=10[28], nlh->nlmsg_len=48[32], skb->len=48[must be 30].
> skb does not have enough length: requested msg->len=10[28], nlh->nlmsg_len=48[32], skb->len=48[must be 30].
> skb does not have enough length: requested msg->len=10[28], nlh->nlmsg_len=48[32], skb->len=48[must be 30].
>   :
> 
> Is's generated at drivers/connector/connector.c:__cn_rx_skb(), and this warn the length of msg's payload
> does not fit in nlmsghdr's length.
> This message means netlink packet is not sent to user space.
> I was notified occurence of fork() by printk(). :-(

No, lengths are correct, but skb can be dropped due to misaligned sizes check.

> The attached simple *.c file can enable/disable fork-connector and listen the fork-notification.
> Because It's first experimence for me to write a code to use netlink, point out a right how-to-use
> if there's some mistakes at user side apprication.
> 
> Thanks.
> 
> P.S. I can't reproduce lockup on 367th-fork() with your latest patch.

I've sent that patch to Guillaume and upstream, hopefully it will be
integrated into next -mm release.

> Guillaume Thouvenin wrote:
> >   ChangeLog:
> > 
> >     - Add parenthesis around sizeof(struct cn_msg) + CN_FORK_INFO_SIZE
> >       in the CN_FORK_MSG_SIZE macro
> >     - fork_cn_lock is declareed with DEFINE_SPINLOCK()
> >     - fork_cn_lock is defined as static and local to fork_connector()
> >     - Create a specific module cn_fork.c in drivers/connector to
> >       register the callback.
> >     - Improve the callback that turns on/off the fork connector
> > 
> >   I also run the lmbench and results are send in response to another
> > thread "A common layer for Accounting packages". When fork connector is
> > turned off the overhead is negligible. This patch works with another
> > small patch that fix a problem in the connector. Without it, there is a
> > message that says "skb does not have enough length". It will be fix in
> > the next -mm tree I think.
> > 
> > 
> > Thanks everyone for the comments,
> > Guillaume
> 
> -- 
> Linux Promotion Center, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>

> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <asm/types.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <linux/netlink.h>
> 
> void usage(){
>   puts("usage: fclisten <on|off>");
>   puts("  Default -> listening fork-connector");
>   puts("  on      -> fork-connector Enable");
>   puts("  off     -> fork-connector Disable");
>   exit(0);
> }
> 
> #define MODE_LISTEN  (1)
> #define MODE_ENABLE  (2)
> #define MODE_DISABLE (3)
> 
> struct cb_id
> {
>   __u32                   idx;
>   __u32                   val;
> };
> 
> struct cn_msg
> {
>   struct cb_id            id;
>   __u32                   seq;
>   __u32                   ack;
>   __u32                   len;            /* Length of the following data */
>   __u8                    data[0];
> };
> 
> 
> int main(int argc, char *argv[]){
>   char buf[4096];
>   int mode, sockfd, len;
>   struct sockaddr_nl ad;
>   struct nlmsghdr *hdr = (struct nlmsghdr *)buf;
>   struct cn_msg *msg = (struct cn_msg *)(buf+sizeof(struct nlmsghdr));
>   
>   switch(argc){
>   case 1:
>     mode = MODE_LISTEN;
>     break;
>   case 2:
>     if (strcasecmp("on",argv[1])==0) {
>       mode = MODE_ENABLE;
>     }else if (strcasecmp("off",argv[1])==0){
>       mode = MODE_DISABLE;
>     }else{
>       usage();
>     }
>     break;
>   default:
>     usage();
>     break;
>   }
>   
>   if( (sockfd=socket(PF_NETLINK, SOCK_RAW, NETLINK_NFLOG)) < 0 ){
>     fprintf(stderr, "Fault on socket().\n");
>     return( 1 );
>   }
>   ad.nl_family = AF_NETLINK;
>   ad.nl_pad = 0;
>   ad.nl_pid = getpid();
>   ad.nl_groups = -1;

Group should be CN_FORK_IDX to receive only fork's messages.

>   if( bind(sockfd, (struct sockaddr *)&ad, sizeof(ad)) ){
>     fprintf(stderr, "Fault on bind to netlink.\n");
>     return( 2 );
>   }
> 
>   if (mode==MODE_LISTEN) {
>     while(-1){
>       len = recvfrom(sockfd, buf, 4096, 0, NULL, NULL);
>       printf("%d-byte recv Seq=%d\n", len, hdr->nlmsg_seq);
>     }
>   }else{
>     ad.nl_family = AF_NETLINK;
>     ad.nl_pad = 0;
>     ad.nl_pid = 0;
>     ad.nl_groups = 1;
>     
>     hdr->nlmsg_len = sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + sizeof(int);
>     hdr->nlmsg_type = 0;
>     hdr->nlmsg_flags = 0;
>     hdr->nlmsg_seq = 0;
>     hdr->nlmsg_pid = getpid();
>     msg->id.idx = 0xfeed;
>     msg->id.val = 0xbeef;
>     msg->seq = msg->ack = 0;
>     msg->len = sizeof(int);
> 
>     if (mode==MODE_ENABLE){
>       (*(int *)(msg->data)) = 1;
>     } else {
>       (*(int *)(msg->data)) = 0;
>     }
>     sendto(sockfd, buf, sizeof(struct nlmsghdr)+sizeof(struct cn_msg)+sizeof(int),
> 	   0, (struct sockaddr *)&ad, sizeof(ad));
>   }
> }

Later today I will post finished connector.c with the all pending
patches in, and simple test program for anyone, who wants 
to test fork() performace with and without fork's connector enabled.

Since Guillaume is busy, I will test it in my 2-way (1+1HT) CPU system.

-- 
	Evgeniy Polyakov ( s0mbre )
