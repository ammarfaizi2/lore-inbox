Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVDKFrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVDKFrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 01:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDKFrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 01:47:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20105 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261412AbVDKFr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 01:47:26 -0400
Message-ID: <425A0E7C.8080900@engr.sgi.com>
Date: Sun, 10 Apr 2005 22:43:24 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
References: <1112277542.20919.215.camel@frecb000711.frec.bull.fr>	<20050331144428.7bbb4b32.akpm@osdl.org>	<424C9177.1070404@engr.sgi.com>	<1112341968.9334.109.camel@uganda>	<4255B6D2.7050102@engr.sgi.com>	<4255B868.6040600@engr.sgi.com>	<1112955840.28858.236.camel@uganda>	<1112957563.28858.240.camel@uganda>	<4256E940.9050306@engr.sgi.com>	<425700CD.5040906@engr.sgi.com>	<20050409021856.39e99bef@zanzibar.2ka.mipt.ru>	<42574C88.9080601@engr.sgi.com> <20050409102926.0cbf031c@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050409102926.0cbf031c@zanzibar.2ka.mipt.ru>
Content-Type: multipart/mixed;
 boundary="------------090903030608020000070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903030608020000070301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I based my listen program on the fclisten.c posted by Kaigai Kohei
with my own modification. Unfortunately i lost my test machine in the
lab. I will recreate the listen program Monday. The original listener
did not validate sequence number. It also prints length of data and
sequence number of every message it receives. My listener prints
only out-of-sequence error messages.

The fork generator fork-test.c was yours? I called it fork-test
and let it run continuously in while-loop:

# while 1
# ./fork-test 10000000
# sleep 1
# end

I let it do 10,000,000 times of fork continuously while the system
is running AIM7 and/or ubench.

The original fclisten.c and fork-test.c are attached for your reference.

- jay


Evgeniy Polyakov wrote:
> On Fri, 08 Apr 2005 20:31:20 -0700
> Jay Lan <jlan@engr.sgi.com> wrote:
> 
> 
>>With the patch you provide to me, i did not see the bugcheck
>>at cn_queue_wrapper() at the console.
>>
>>Unmatched sequence number messages still happened. We expect
>>to lose packets under system stressed situation, but i still
>>observed duplicate messages, which concerned me.
> 
> 
> What tool and what version do you use 
> as message generator and receiver?
> 
> 
>>Thanks,
>>  - jay
> 
> 
> 	Evgeniy Polyakov
> 
> Only failure makes us experts. -- Theo de Raadt

--------------090903030608020000070301
Content-Type: text/plain;
 name="fclisten.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fclisten.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <asm/types.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <linux/netlink.h>

void usage(){
  puts("usage: fclisten <on|off>");
  puts("  Default -> listening fork-connector");
  puts("  on      -> fork-connector Enable");
  puts("  off     -> fork-connector Disable");
  exit(0);
}

#define MODE_LISTEN  (1)
#define MODE_ENABLE  (2)
#define MODE_DISABLE (3)

struct cb_id
{
  __u32                   idx;
  __u32                   val;
};

struct cn_msg
{
  struct cb_id            id;
  __u32                   seq;
  __u32                   ack;
  __u32                   len;            /* Length of the following data */
  __u8                    data[0];
};


int main(int argc, char *argv[]){
  char buf[4096];
  int mode, sockfd, len;
  struct sockaddr_nl ad;
  struct nlmsghdr *hdr = (struct nlmsghdr *)buf;
  struct cn_msg *msg = (struct cn_msg *)(buf+sizeof(struct nlmsghdr));
  
  switch(argc){
  case 1:
    mode = MODE_LISTEN;
    break;
  case 2:
    if (strcasecmp("on",argv[1])==0) {
      mode = MODE_ENABLE;
    }else if (strcasecmp("off",argv[1])==0){
      mode = MODE_DISABLE;
    }else{
      usage();
    }
    break;
  default:
    usage();
    break;
  }
  
  if( (sockfd=socket(PF_NETLINK, SOCK_RAW, NETLINK_NFLOG)) < 0 ){
    fprintf(stderr, "Fault on socket().\n");
    return( 1 );
  }
  ad.nl_family = AF_NETLINK;
  ad.nl_pad = 0;
  ad.nl_pid = getpid();
  ad.nl_groups = CN_IDX_FORK;
  if( bind(sockfd, (struct sockaddr *)&ad, sizeof(ad)) ){
    fprintf(stderr, "Fault on bind to netlink.\n");
    return( 2 );
  }

  if (mode==MODE_LISTEN) {
    while(-1){
      len = recvfrom(sockfd, buf, 4096, 0, NULL, NULL);
      printf("%d-byte recv Seq=%d\n", len, hdr->nlmsg_seq);
    }
  }else{
    ad.nl_family = AF_NETLINK;
    ad.nl_pad = 0;
    ad.nl_pid = 0;
    ad.nl_groups = 1;
    
    hdr->nlmsg_len = sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + sizeof(int);
    hdr->nlmsg_type = 0;
    hdr->nlmsg_flags = 0;
    hdr->nlmsg_seq = 0;
    hdr->nlmsg_pid = getpid();
    msg->id.idx = 0xfeed;
    msg->id.val = 0xbeef;
    msg->seq = msg->ack = 0;
    msg->len = sizeof(int);

    if (mode==MODE_ENABLE){
      (*(int *)(msg->data)) = 1;
    } else {
      (*(int *)(msg->data)) = 0;
    }
    sendto(sockfd, buf, sizeof(struct nlmsghdr)+sizeof(struct cn_msg)+sizeof(int),
	   0, (struct sockaddr *)&ad, sizeof(ad));
  }
}

--------------090903030608020000070301
Content-Type: text/plain;
 name="fork-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fork-test.c"

#include <sys/signal.h>
#include <sys/time.h>

int main(int argc, char *argv[])
{
        int pid;
        int i = 0, max = 100000;
        struct timeval tv0, tv1;
        struct timezone tz;
        long diff;

        if (argc >= 2)
                max = atoi(argv[1]);

        signal(SIGCHLD, SIG_IGN);

        gettimeofday(&tv0, &tz);
        while (i++ < max) {
                pid = fork();
                if (pid == 0) {
                        sleep(1);
                        exit (0);
                }
        }
        gettimeofday(&tv1, &tz);

        diff = (tv1.tv_sec - tv0.tv_sec)*1000000 + (tv1.tv_usec - tv0.tv_usec);

        printf("Average per process fork+exit time is %ld usecs [diff=%lu, max=%d].\n", diff/max, diff, max);
        return 0;
}


--------------090903030608020000070301--

