Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135540AbRDXRYY>; Tue, 24 Apr 2001 13:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135586AbRDXRYO>; Tue, 24 Apr 2001 13:24:14 -0400
Received: from nevald.k-net.dtu.dk ([130.225.71.226]:2015 "EHLO
	nevald.k-net.dk") by vger.kernel.org with ESMTP id <S135549AbRDXRX7>;
	Tue, 24 Apr 2001 13:23:59 -0400
Date: Tue, 24 Apr 2001 19:25:47 +0200
From: Martin Clausen <martin@ostenfeld.dk>
To: netfilter-devel@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Kernel Oops when using the Netfilter QUEUE target
Message-ID: <20010424192547.B2840@ostenfeld.dk>
Reply-To: Martin Clausen <martin@ostenfeld.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there!

I have encountered a problem (perhaps a bug)! The attached code makes my kernel oops
in some cases when injecting new packets through Netfilter's QUEUE target. The problem 
only appears when the original packet is a TCP packet; i have tried with ICMP and UDP packets 
also but this does not trigger any oops. I have tried to code on several computers and they 
all oops. The following description regards the case when submitting new packets instead 
of TCP packets.

It seems that new packets can not have a length greater than 92 bytes under 2.4.2-ac21
and 76 under 2.4.3; these sizes may vary but the oops can be triggered by choosing
a larger packet size.

Netfilter is configured the following way:

[root@lwb7 ipsecd]# modprobe iptable_filter
[root@lwb7 ipsecd]# modprobe ip_queue      
[root@lwb7 ipsecd]# iptables -t mangle -A OUTPUT -d lwb5 -j LOG
[root@lwb7 ipsecd]# iptables -t mangle -A OUTPUT -d lwb5 -j QUEUE
[root@lwb7 ipsecd]# lsmod
Module                  Size  Used by
ipt_LOG                 4063   1  (autoclean)
iptable_mangle          2542   0  (autoclean) (unused)
ip_queue                5946   0  (unused)
iptable_filter          2533   0  (unused)
ip_tables              14936   3  [ipt_LOG iptable_mangle iptable_filter]
NVdriver              688003  12  (autoclean)
8139too                16845   1  (autoclean)
[root@lwb7 ipsecd]# iptables -t mangle -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
LOG        all  --  anywhere             lwb5.it.dtu.dk     LOG level warning 
QUEUE      all  --  anywhere             lwb5.it.dtu.dk  

I have added some printk's in net/code/netfilter.c in nf_reinject() and i seems that
the kernel oops' in info->okfn(skb) (i added printk before and after):

IN= OUT=eth0 SRC=130.225.76.37 DST=130.225.76.35 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=173 PROTO=TCP SPT=1025 DPT=23 WINDOW=5840 RES=0x00 SYN URGP=0
nf_hook: Verdict = QUEUE.                                                     
In nf_reinject() before info->okfn(skb) line 521                              
Unable to handle kernel NULL pointer dereference at virtual address 000002b4   
printing eip:                                                                
c01e7456                                                                      
*pde = 00000000
                                                                                                                                             
Entering kdb (current=0xc68f6000, pid 884) Oops: Oops                         
due to oops @ 0xc01e7456                                                      
eax = 0x000005dc ebx = 0xc7acf224 ecx = 0x0000000e edx = 0xc72f8440           
esi = 0xc7cee740 edi = 0x00000000 esp = 0xc68f7c90 eip = 0xc01e7456           
ebp = 0xc68f7cb0 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010287        
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc68f7c5c     
kdb> 

I will be glad to submit som more (debug) information?!

I really hope someone can help me :)

Best regards,
Martin Clausen

-- 
                       There's no place like ~

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfcrash.c"

/* Compile: gcc -o nfcrash nfcrash.c -lipq
 */	

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

#include <netinet/in.h>
#include <netinet/in_systm.h>
#include <netinet/ip.h>
#include <arpa/inet.h>

#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/netfilter_ipv4/ip_queue.h>

#include <linux/libipq.h>

#include <sys/types.h>
#include <sys/socket.h>

/* For CRASH_ME <= 32 everything seems to work (2.4.2-ac21).
 * For CRASH_ME > 32 the kernel oops'es in case of TCP traffic (2.4.2-ac21)?!
 * 
 * For CRASH_ME <= 16 everything seems to work (2.4.3).
 * For CRASH_ME > 16 the kernel oops'es in case of TCP traffic (2.4.3)?!
 * 
 */
const int CRASH_ME = 17;

const int ESP_OFF = 0;

unsigned short in_cksum(unsigned short *addr, int len)
{
  int nleft = len;
  int sum 	= 0;
  unsigned short *w = addr;
  unsigned short answer = 0;
  
  while (nleft > 1) {
    sum += *w++;
    nleft -= 2;
  }

  if (nleft == 1) {
    *(unsigned char *)(&answer) = *(unsigned char *) w;
    sum += answer;
  }
  
  sum = (sum >> 16) + (sum & 0xffff); 
  sum += (sum >> 16);                
  answer = ~sum;                     
  
  return answer;
}

int main(int argc, char **argv)
{
  struct ipq_handle *qh;
  struct ipq_packet_msg *qpkt;
  struct iphdr *iph;
  unsigned char	buff[8192];
  unsigned char *esppkt;
  int esppkt_len;
  int type; 
  int len;
      
  /* Init first (flags are not implemented; yet) */
  if ( (qh = ipq_create_handle(0)) == NULL) {
    /* Run away... */
    ipq_perror("create_handle()");
    exit(1);
  }
	
  /* We would like to receive not only metadata... */
  if (ipq_set_mode(qh, IPQ_COPY_PACKET, sizeof(buff)) < 0) {
    ipq_perror("set_mode()");
    goto cleanup;
  }
  
  /* Now real fun begins... Just stay in loop, read packets,
   * accept them if they are IP. */
  while (1) {
    len = ipq_read(qh, buff, sizeof buff, 0);
    
    if (len == 0) {
      fprintf(stderr, "read(): Zero length packet; ingnoring\n");
      continue;
    }
    
    if (len < 0) {
      /* Error, quit the program */
      ipq_perror("read()");
      goto cleanup;
    }    
        
    /* If packet type from kernel is not known to us,
     * just ignore it (but notify user) */
    if ( (type = ipq_message_type(buff)) != IPQM_PACKET) {
      fprintf(stderr, "read(): Unknown message type %u\n", type);
      continue;
    }
    
    /* Now we know that it is IPv4 packet */
    qpkt = ipq_get_packet(buff);
    
    /*esppkt_len = sizeof(struct iphdr) + ESP_OFF + qpkt->data_len + CRASH_ME;*/
    esppkt_len = qpkt->data_len + CRASH_ME;
    esppkt = (unsigned char *) malloc(esppkt_len);
    memset((char *)esppkt, '\0', esppkt_len);

    printf("sizeof(esppkt) = %d\n", esppkt_len);
    
    /* Build new IP header */
    iph = (struct iphdr *) esppkt;
    iph->ihl = 5;
    iph->version = 4; /* IPv4 */
    iph->tot_len = htons(esppkt_len);
    /*iph->id = htons(getpid());*/
    iph->ttl = 64; /* Default TTL */
    iph->protocol = IPPROTO_ESP;
    iph->saddr = inet_addr("130.225.76.37");
    iph->daddr = inet_addr("130.225.76.35");
    iph->check = (unsigned short)in_cksum((unsigned short *) iph, sizeof(struct iphdr));

    /*memcpy(esppkt + sizeof(struct iphdr) + ESP_OFF, qpkt->payload, qpkt->data_len);*/

    /* Return the verdict and the encapsulated (ESP) packet */
    /*if (ipq_set_verdict(qh, qpkt->packet_id, NF_ACCEPT, qpkt->data_len, (unsigned char *) qpkt->payload) < 0) { */
    if (ipq_set_verdict(qh, qpkt->packet_id, NF_ACCEPT, esppkt_len, (unsigned char *) esppkt) < 0) {
      ipq_perror("set_verdict(): Oops!");
      goto cleanup;
    }    
  }
  
 cleanup:
  ipq_destroy_handle(qh);
  
  exit(0);
}

--+QahgC5+KEYLbs62--
