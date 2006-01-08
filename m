Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWAHJZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWAHJZM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbWAHJZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:25:11 -0500
Received: from web53702.mail.yahoo.com ([206.190.37.23]:43100 "HELO
	web53702.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1752606AbWAHJZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:25:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ap8KLEE6W6w0xc3WBxQxCC46rDCyL6DGC7GHu9vlQoJNA31S14e78QJcXwB216GhBcpVFGyMMBzhNrawiPWRzTxJ3nmyiAjLnwtVkeDzd3kzWs4gnf2VcBiJsKMbYxDzKBEc4dy5pvxp0igjt5oAnofDqime/VQ4TfjIMvPy9Bw=  ;
Message-ID: <20060108092505.62484.qmail@web53702.mail.yahoo.com>
Date: Sun, 8 Jan 2006 01:25:05 -0800 (PST)
From: Mikado <mikado4vn@yahoo.com>
Subject: Resend: Netlink socket problem
To: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-669305880-1136712305=:62235"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-669305880-1136712305=:62235
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I write a kernel module and a userspace client. They use netlink sockets to communicate with each
other. The source codes and the last kernel log before system crashed are attached below.
Inserting the module is ok but when I ran the client, my kernel crashed after the client received
first message from the module. Is there anything wrong in my codes? I think the problem is the
netlink_unicast(), because when I didn't call it, everything work well. Please help me.

Thank you.

=== nltest.c - kernel module ===
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <net/sock.h>
#include <linux/socket.h>
#include <linux/net.h>
#include <asm/types.h>
#include <linux/netlink.h>
#include <linux/skbuff.h>

#define NETLINK_VFW 18
#define VFW_GROUP 0
#define MSG_SIZE NLMSG_SPACE(1024)

static struct sock *nl_sk = NULL;

static void nltest_rcv(struct sock *sk, int len)
{
        struct sk_buff *nl_skb;
        struct nlmsghdr *nl_hdr;
        int pid;

        while ((nl_skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
                nl_hdr = (struct nlmsghdr *)nl_skb->data;
                pid = nl_hdr->nlmsg_pid;
                printk(KERN_ALERT "nltest: message from user (pid = %d) = %s\n", pid, (char
*)NLMSG_DATA(nl_hdr));
                nl_skb = alloc_skb(MSG_SIZE, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
                skb_put(nl_skb, MSG_SIZE);
                nl_hdr = (struct nlmsghdr *)nl_skb->data;
                nl_hdr->nlmsg_len = MSG_SIZE;
                nl_hdr->nlmsg_pid = 0;
                nl_hdr->nlmsg_flags = 0;
                strcpy(NLMSG_DATA(nl_hdr), "hello user abcd1234");
                NETLINK_CB(nl_skb).pid = 0;
                NETLINK_CB(nl_skb).dst_pid = pid;
                NETLINK_CB(nl_skb).dst_group = VFW_GROUP;
                netlink_unicast(nl_sk, nl_skb, pid, 0);
                kfree_skb(nl_skb);
        }
}

static int __init nltest_init(void)
{
        printk(KERN_ALERT "nltest: init\n");

        nl_sk = netlink_kernel_create(NETLINK_VFW, VFW_GROUP, nltest_rcv, THIS_MODULE);
        if (!nl_sk) {
                printk(KERN_ALERT "nltest: netlink_kernel_create() failed\n");
                return -1;
        }

        return 0;
}

static void __exit nltest_exit(void)
{
        printk(KERN_ALERT "nltest: exit\n");

        sock_release(nl_sk->sk_socket);

        return;
}

module_init(nltest_init);
module_exit(nltest_exit);

MODULE_DESCRIPTION("Netlink Test");
MODULE_LICENSE("GPL");

=== nlclient.c - userspace client ===
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <asm/types.h>
#include <linux/netlink.h>

#define NETLINK_VFW 18
#define VFW_GROUP 0
#define MSG_SIZE NLMSG_SPACE(1024)

int main(void)
{
        int nl_sd;
        struct sockaddr_nl src_addr;
        struct nlmsghdr *nl_hdr;
        unsigned char buf[MSG_SIZE];
        int ret;

        memset(&src_addr, 0, sizeof(struct sockaddr_nl));
        memset(buf, 0, MSG_SIZE);

        nl_sd = socket(PF_NETLINK, SOCK_RAW, NETLINK_VFW);

        src_addr.nl_family = AF_NETLINK;
        src_addr.nl_pid = getpid();
        src_addr.nl_groups = VFW_GROUP;

        bind(nl_sd, (struct sockaddr *)&src_addr, sizeof(struct sockaddr));

        nl_hdr = (struct nlmsghdr *)buf;
        nl_hdr->nlmsg_len = MSG_SIZE;
        nl_hdr->nlmsg_pid = getpid();
        nl_hdr->nlmsg_flags = 0;
        strcpy(NLMSG_DATA(nl_hdr), "hello kernel");

        ret = send(nl_sd, buf, MSG_SIZE, 0);
        printf("send ret = %d\n", ret);
        if (ret == -1)
                return ret;

        while (1) {
                ret = recv(nl_sd, buf, MSG_SIZE, 0);
                printf("message from kernel = %s\n", (char *)NLMSG_DATA(nl_hdr));
        }

        return 0;
}

=== syslog ===
Hi,

I write a kernel module and a userspace client. They use netlink sockets to communicate with each
other. The source codes are attached below. Inserting the module is ok but when I ran the client,
my kernel crashed after the client received first message from the module. Is there anything wrong
in my codes?

Thank you.

=== nltest.c - kernel module ===
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <net/sock.h>
#include <linux/socket.h>
#include <linux/net.h>
#include <asm/types.h>
#include <linux/netlink.h>
#include <linux/skbuff.h>

#define NETLINK_VFW 18
#define VFW_GROUP 0
#define MSG_SIZE NLMSG_SPACE(1024)

static struct sock *nl_sk = NULL;

static void nltest_rcv(struct sock *sk, int len)
{
        struct sk_buff *nl_skb;
        struct nlmsghdr *nl_hdr;
        int pid;

        while ((nl_skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
                nl_hdr = (struct nlmsghdr *)nl_skb->data;
                pid = nl_hdr->nlmsg_pid;
                printk(KERN_ALERT "nltest: message from user (pid = %d) = %s\n", pid, (char
*)NLMSG_DATA(nl_hdr));
                nl_skb = alloc_skb(MSG_SIZE, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
                skb_put(nl_skb, MSG_SIZE);
                nl_hdr = (struct nlmsghdr *)nl_skb->data;
                nl_hdr->nlmsg_len = MSG_SIZE;
                nl_hdr->nlmsg_pid = pid;
                nl_hdr->nlmsg_flags = 0;
                strcpy(NLMSG_DATA(nl_hdr), "hello user abcd1234");
                NETLINK_CB(nl_skb).pid = 0;
                NETLINK_CB(nl_skb).dst_pid = pid;
                NETLINK_CB(nl_skb).dst_group = VFW_GROUP;
                netlink_unicast(nl_sk, nl_skb, pid, 0);
                kfree_skb(nl_skb);
        }
}

static int __init nltest_init(void)
{
        printk(KERN_ALERT "nltest: init\n");

        nl_sk = netlink_kernel_create(NETLINK_VFW, VFW_GROUP, nltest_rcv, THIS_MODULE);
        if (!nl_sk) {
                printk(KERN_ALERT "nltest: netlink_kernel_create() failed\n");
                return -1;
        }

        return 0;
}

static void __exit nltest_exit(void)
{
        printk(KERN_ALERT "nltest: exit\n");

        sock_release(nl_sk->sk_socket);

        return;
}

module_init(nltest_init);
module_exit(nltest_exit);

MODULE_DESCRIPTION("Netlink Test");
MODULE_LICENSE("GPL");

=== nlclient.c - userspace client ===
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <asm/types.h>
#include <linux/netlink.h>

#define NETLINK_VFW 18
#define VFW_GROUP 0
#define MSG_SIZE NLMSG_SPACE(1024)

int main(void)
{
        int nl_sd;
        struct sockaddr_nl src_addr;
        struct nlmsghdr *nl_hdr;
        unsigned char buf[MSG_SIZE];
        int ret;

        memset(&src_addr, 0, sizeof(struct sockaddr_nl));
        memset(buf, 0, MSG_SIZE);

        nl_sd = socket(PF_NETLINK, SOCK_RAW, NETLINK_VFW);

        src_addr.nl_family = AF_NETLINK;
        src_addr.nl_pid = getpid();
        src_addr.nl_groups = VFW_GROUP;

        bind(nl_sd, (struct sockaddr *)&src_addr, sizeof(struct sockaddr));

        nl_hdr = (struct nlmsghdr *)buf;
        nl_hdr->nlmsg_len = MSG_SIZE;
        nl_hdr->nlmsg_pid = getpid();
        nl_hdr->nlmsg_flags = 0;
        strcpy(NLMSG_DATA(nl_hdr), "hello kernel");

        ret = send(nl_sd, buf, MSG_SIZE, 0);
        printf("send ret = %d\n", ret);
        if (ret == -1)
                return ret;

        while (1) {
                ret = recv(nl_sd, buf, MSG_SIZE, 0);
                printf("message from kernel = %s\n", (char *)NLMSG_DATA(nl_hdr));
        }

        return 0;
}

=== syslog ===J
Jan  8 15:42:07 vfw kernel: [   61.627275] nltest: init
Jan  8 15:42:10 vfw kernel: [   64.540280] nltest: message from user (pid = 2467) = hello kernel
Jan  8 15:42:10 vfw kernel: [   64.550012] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
Jan  8 15:42:10 vfw kernel: [   64.551283]  printing eip:
Jan  8 15:42:10 vfw kernel: [   64.552893] c041c83f
Jan  8 15:42:10 vfw kernel: [   64.552950] *pde = 00000000
Jan  8 15:42:10 vfw kernel: [   64.553106] Oops: 0002 [#1]
Jan  8 15:42:10 vfw kernel: [   64.555635] Modules linked in: nltest vmhgfs
Jan  8 15:42:10 vfw kernel: [   64.561239] CPU:    0
Jan  8 15:42:10 vfw kernel: [   64.561249] EIP:    0060:[<c041c83f>]    Tainted: P      VLI
Jan  8 15:42:10 vfw kernel: [   64.561254] EFLAGS: 00010046   (2.6.14.5) 
Jan  8 15:42:10 vfw kernel: [   64.573449] EIP is at skb_dequeue+0x2f/0x60
Jan  8 15:42:10 vfw kernel: [   64.577072] eax: 00000000   ebx: c59d3080   ecx: 00000000   edx:
00000282
Jan  8 15:42:10 vfw kernel: [   64.578352] esi: c59da1e0   edi: c59d308c   ebp: c59d3080   esp:
c2609d10
Jan  8 15:42:10 vfw kernel: [   64.588064] ds: 007b   es: 007b   ss: 0068
Jan  8 15:42:10 vfw kernel: [   64.594769] Process nlclient (pid: 2467, threadinfo=c2608000
task=c5ba9030)
Jan  8 15:42:10 vfw kernel: [   64.595567] Stack: 00000000 c59d3000 c59d3000 c041d598 c59d3080
00000320 c10c3000 7fffffff 
Jan  8 15:42:10 vfw kernel: [   64.600285]        c24b9ac0 c59d3000 00000410 c2609f2c c042f616
c59d3000 00000000 00000000 
Jan  8 15:42:10 vfw kernel: [   64.614903]        c2609d60 00000001 00000000 c2609dac c68f3a00
00000000 00000286 00000007 
Jan  8 15:42:10 vfw kernel: [   64.624126] Call Trace:
Jan  8 15:42:10 vfw kernel: [   64.638760]  [<c041d598>] skb_recv_datagram+0xc8/0xd0
Jan  8 15:42:10 vfw kernel: [   64.644494]  [<c042f616>] netlink_recvmsg+0x56/0x250
Jan  8 15:42:10 vfw kernel: [   64.656522]  [<c0303042>] soft_cursor+0x192/0x1f0
Jan  8 15:42:10 vfw kernel: [   64.660636]  [<c0416383>] sock_recvmsg+0xf3/0x110
Jan  8 15:42:10 vfw kernel: [   64.668551]  [<c02fa4f9>] bit_cursor+0x349/0x550
Jan  8 15:42:10 vfw kernel: [   64.676291]  [<c0134b40>] autoremove_wake_function+0x0/0x60
Jan  8 15:42:10 vfw kernel: [   64.682837]  [<c0417772>] sys_recvfrom+0xb2/0x120
Jan  8 15:42:10 vfw kernel: [   64.691864]  [<c0337038>] write_chan+0x158/0x230
Jan  8 15:42:10 vfw kernel: [   64.698739]  [<c011c70e>] __wake_up+0x3e/0x60
Jan  8 15:42:10 vfw kernel: [   64.708252]  [<c033174d>] tty_write+0x1ed/0x240
Jan  8 15:42:10 vfw kernel: [   64.712340]  [<c0417813>] sys_recv+0x33/0x40
Jan  8 15:42:10 vfw kernel: [   64.724514]  [<c0417f34>] sys_socketcall+0x164/0x260
Jan  8 15:42:10 vfw kernel: [   64.728817]  [<c015eab1>] sys_write+0x51/0x80
Jan  8 15:42:10 vfw kernel: [   64.740049]  [<c01030b9>] syscall_call+0x7/0xb
Jan  8 15:42:10 vfw kernel: [   64.744699] Code: 1c 24 8b 5c 24 10 89 7c 24 08 89 74 24 04 8d 7b
0c 31 f6 89 f8 e8 42 4b 0c 00 89 c2 8b 03 39 d8 74 19 89 c6 8b 00 ff 4b 08 89 03 <89> 58 04 c7 06
00 00 00 00 c7 46 04 00 00 00 00 89 f8 e8 5a 4c 




		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

--0-669305880-1136712305=:62235
Content-Type: application/octet-stream; name="nltest.c"
Content-Transfer-Encoding: base64
Content-Description: 938020532-nltest.c
Content-Disposition: attachment; filename="nltest.c"

I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVkZSA8bGludXgva2Vy
bmVsLmg+CiNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiNpbmNsdWRlIDxuZXQv
c29jay5oPgojaW5jbHVkZSA8bGludXgvc29ja2V0Lmg+CiNpbmNsdWRlIDxs
aW51eC9uZXQuaD4KI2luY2x1ZGUgPGFzbS90eXBlcy5oPgojaW5jbHVkZSA8
bGludXgvbmV0bGluay5oPgojaW5jbHVkZSA8bGludXgvc2tidWZmLmg+Cgoj
ZGVmaW5lIE5FVExJTktfVkZXIDE4CiNkZWZpbmUgVkZXX0dST1VQIDAKI2Rl
ZmluZSBNU0dfU0laRSBOTE1TR19TUEFDRSgxMDI0KQoKc3RhdGljIHN0cnVj
dCBzb2NrICpubF9zayA9IE5VTEw7CgpzdGF0aWMgdm9pZCBubHRlc3RfcmN2
KHN0cnVjdCBzb2NrICpzaywgaW50IGxlbikKewoJc3RydWN0IHNrX2J1ZmYg
Km5sX3NrYjsKCXN0cnVjdCBubG1zZ2hkciAqbmxfaGRyOwoJaW50IHBpZDsK
CQoJd2hpbGUgKChubF9za2IgPSBza2JfZGVxdWV1ZSgmc2stPnNrX3JlY2Vp
dmVfcXVldWUpKSAhPSBOVUxMKSB7CgkJbmxfaGRyID0gKHN0cnVjdCBubG1z
Z2hkciAqKW5sX3NrYi0+ZGF0YTsKCQlwaWQgPSBubF9oZHItPm5sbXNnX3Bp
ZDsKCQlwcmludGsoS0VSTl9BTEVSVCAibmx0ZXN0OiBtZXNzYWdlIGZyb20g
dXNlciAocGlkID0gJWQpID0gJXNcbiIsIHBpZCwgKGNoYXIgKilOTE1TR19E
QVRBKG5sX2hkcikpOwoJCW5sX3NrYiA9IGFsbG9jX3NrYihNU0dfU0laRSwg
aW5faW50ZXJydXB0KCkgPyBHRlBfQVRPTUlDIDogR0ZQX0tFUk5FTCk7CgkJ
c2tiX3B1dChubF9za2IsIE1TR19TSVpFKTsKCQlubF9oZHIgPSAoc3RydWN0
IG5sbXNnaGRyICopbmxfc2tiLT5kYXRhOwoJCW5sX2hkci0+bmxtc2dfbGVu
ID0gTVNHX1NJWkU7CgkJbmxfaGRyLT5ubG1zZ19waWQgPSAwOwoJCW5sX2hk
ci0+bmxtc2dfZmxhZ3MgPSAwOwoJCXN0cmNweShOTE1TR19EQVRBKG5sX2hk
ciksICJoZWxsbyB1c2VyIGFiY2QxMjM0Iik7CgkJTkVUTElOS19DQihubF9z
a2IpLnBpZCA9IDA7CgkJTkVUTElOS19DQihubF9za2IpLmRzdF9waWQgPSBw
aWQ7CgkJTkVUTElOS19DQihubF9za2IpLmRzdF9ncm91cCA9IFZGV19HUk9V
UDsKCQluZXRsaW5rX3VuaWNhc3Qobmxfc2ssIG5sX3NrYiwgcGlkLCAwKTsK
CQlrZnJlZV9za2Iobmxfc2tiKTsKCX0KfQoKc3RhdGljIGludCBfX2luaXQg
bmx0ZXN0X2luaXQodm9pZCkKewoJcHJpbnRrKEtFUk5fQUxFUlQgIm5sdGVz
dDogaW5pdFxuIik7CgkKCW5sX3NrID0gbmV0bGlua19rZXJuZWxfY3JlYXRl
KE5FVExJTktfVkZXLCBWRldfR1JPVVAsIG5sdGVzdF9yY3YsIFRISVNfTU9E
VUxFKTsKCWlmICghbmxfc2spIHsKCQlwcmludGsoS0VSTl9BTEVSVCAibmx0
ZXN0OiBuZXRsaW5rX2tlcm5lbF9jcmVhdGUoKSBmYWlsZWRcbiIpOwoJCXJl
dHVybiAtMTsKCX0KCQoJcmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIF9fZXhp
dCBubHRlc3RfZXhpdCh2b2lkKQp7CglwcmludGsoS0VSTl9BTEVSVCAibmx0
ZXN0OiBleGl0XG4iKTsKCQoJc29ja19yZWxlYXNlKG5sX3NrLT5za19zb2Nr
ZXQpOwoJCglyZXR1cm47Cn0KCm1vZHVsZV9pbml0KG5sdGVzdF9pbml0KTsK
bW9kdWxlX2V4aXQobmx0ZXN0X2V4aXQpOwoKTU9EVUxFX0RFU0NSSVBUSU9O
KCJOZXRsaW5rIFRlc3QiKTsKTU9EVUxFX0FVVEhPUigiTmd1eWVuIE1pbmgg
TmhhdCA8bmdtbmhhdEBnbWFpbC5jb20+Iik7Ck1PRFVMRV9MSUNFTlNFKCJH
UEwiKTsK

--0-669305880-1136712305=:62235
Content-Type: application/octet-stream; name="nlclient.c"
Content-Transfer-Encoding: base64
Content-Description: 3903798118-nlclient.c
Content-Disposition: attachment; filename="nlclient.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1
ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxz
eXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUg
PG5ldGluZXQvaW4uaD4KI2luY2x1ZGUgPGFycGEvaW5ldC5oPgojaW5jbHVk
ZSA8YXNtL3R5cGVzLmg+CiNpbmNsdWRlIDxsaW51eC9uZXRsaW5rLmg+Cgoj
ZGVmaW5lIE5FVExJTktfVkZXIDE4CiNkZWZpbmUgVkZXX0dST1VQIDAKI2Rl
ZmluZSBNU0dfU0laRSBOTE1TR19TUEFDRSgxMDI0KQoKaW50IG1haW4odm9p
ZCk7CgppbnQgbWFpbih2b2lkKQp7CglpbnQgbmxfc2Q7CglzdHJ1Y3Qgc29j
a2FkZHJfbmwgc3JjX2FkZHI7CglzdHJ1Y3Qgbmxtc2doZHIgKm5sX2hkcjsK
CXVuc2lnbmVkIGNoYXIgYnVmW01TR19TSVpFXTsKCWludCByZXQ7CgkKCW1l
bXNldCgmc3JjX2FkZHIsIDAsIHNpemVvZihzdHJ1Y3Qgc29ja2FkZHJfbmwp
KTsKCW1lbXNldChidWYsIDAsIE1TR19TSVpFKTsKCQoJbmxfc2QgPSBzb2Nr
ZXQoUEZfTkVUTElOSywgU09DS19SQVcsIE5FVExJTktfVkZXKTsKCQoJc3Jj
X2FkZHIubmxfZmFtaWx5ID0gQUZfTkVUTElOSzsKCXNyY19hZGRyLm5sX3Bp
ZCA9IGdldHBpZCgpOwoJc3JjX2FkZHIubmxfZ3JvdXBzID0gVkZXX0dST1VQ
OwoJCgliaW5kKG5sX3NkLCAoc3RydWN0IHNvY2thZGRyICopJnNyY19hZGRy
LCBzaXplb2Yoc3RydWN0IHNvY2thZGRyKSk7CgkKCW5sX2hkciA9IChzdHJ1
Y3Qgbmxtc2doZHIgKilidWY7CglubF9oZHItPm5sbXNnX2xlbiA9IE1TR19T
SVpFOwoJbmxfaGRyLT5ubG1zZ19waWQgPSBnZXRwaWQoKTsKCW5sX2hkci0+
bmxtc2dfZmxhZ3MgPSAwOwoJc3RyY3B5KE5MTVNHX0RBVEEobmxfaGRyKSwg
ImhlbGxvIGtlcm5lbCIpOwoKCXJldCA9IHNlbmQobmxfc2QsIGJ1ZiwgTVNH
X1NJWkUsIDApOwoJcHJpbnRmKCJzZW5kIHJldCA9ICVkXG4iLCByZXQpOwoJ
aWYgKHJldCA9PSAtMSkKCQlyZXR1cm4gcmV0OwoJCgl3aGlsZSAoMSkgewoJ
CXJldCA9IHJlY3Yobmxfc2QsIGJ1ZiwgTVNHX1NJWkUsIDApOwoJCXByaW50
ZigibWVzc2FnZSBmcm9tIGtlcm5lbCA9ICVzXG4iLCAoY2hhciAqKU5MTVNH
X0RBVEEobmxfaGRyKSk7Cgl9CgkKCXJldHVybiAwOwp9Cg==

--0-669305880-1136712305=:62235
Content-Type: application/octet-stream; name=syslog
Content-Transfer-Encoding: base64
Content-Description: 3086173224-syslog
Content-Disposition: attachment; filename=syslog

SmFuICA4IDE1OjQyOjA3IHZmdyBrZXJuZWw6IFsgICA2MS42MjcyNzVdIG5s
dGVzdDogaW5pdApKYW4gIDggMTU6NDI6MTAgdmZ3IGtlcm5lbDogWyAgIDY0
LjU0MDI4MF0gbmx0ZXN0OiBtZXNzYWdlIGZyb20gdXNlciAocGlkID0gMjQ2
NykgPSBoZWxsbyBrZXJuZWwKSmFuICA4IDE1OjQyOjEwIHZmdyBrZXJuZWw6
IFsgICA2NC41NTAwMTJdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAw
MDQKSmFuICA4IDE1OjQyOjEwIHZmdyBrZXJuZWw6IFsgICA2NC41NTEyODNd
ICBwcmludGluZyBlaXA6CkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBb
ICAgNjQuNTUyODkzXSBjMDQxYzgzZgpKYW4gIDggMTU6NDI6MTAgdmZ3IGtl
cm5lbDogWyAgIDY0LjU1Mjk1MF0gKnBkZSA9IDAwMDAwMDAwCkphbiAgOCAx
NTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQuNTUzMTA2XSBPb3BzOiAwMDAy
IFsjMV0KSmFuICA4IDE1OjQyOjEwIHZmdyBrZXJuZWw6IFsgICA2NC41NTU2
MzVdIE1vZHVsZXMgbGlua2VkIGluOiBubHRlc3Qgdm1oZ2ZzCkphbiAgOCAx
NTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQuNTYxMjM5XSBDUFU6ICAgIDAK
SmFuICA4IDE1OjQyOjEwIHZmdyBrZXJuZWw6IFsgICA2NC41NjEyNDldIEVJ
UDogICAgMDA2MDpbPGMwNDFjODNmPl0gICAgVGFpbnRlZDogUCAgICAgIFZM
SQpKYW4gIDggMTU6NDI6MTAgdmZ3IGtlcm5lbDogWyAgIDY0LjU2MTI1NF0g
RUZMQUdTOiAwMDAxMDA0NiAgICgyLjYuMTQuNSkgCkphbiAgOCAxNTo0Mjox
MCB2Zncga2VybmVsOiBbICAgNjQuNTczNDQ5XSBFSVAgaXMgYXQgc2tiX2Rl
cXVldWUrMHgyZi8weDYwCkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBb
ICAgNjQuNTc3MDcyXSBlYXg6IDAwMDAwMDAwICAgZWJ4OiBjNTlkMzA4MCAg
IGVjeDogMDAwMDAwMDAgICBlZHg6IDAwMDAwMjgyCkphbiAgOCAxNTo0Mjox
MCB2Zncga2VybmVsOiBbICAgNjQuNTc4MzUyXSBlc2k6IGM1OWRhMWUwICAg
ZWRpOiBjNTlkMzA4YyAgIGVicDogYzU5ZDMwODAgICBlc3A6IGMyNjA5ZDEw
CkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQuNTg4MDY0XSBk
czogMDA3YiAgIGVzOiAwMDdiICAgc3M6IDAwNjgKSmFuICA4IDE1OjQyOjEw
IHZmdyBrZXJuZWw6IFsgICA2NC41OTQ3NjldIFByb2Nlc3MgbmxjbGllbnQg
KHBpZDogMjQ2NywgdGhyZWFkaW5mbz1jMjYwODAwMCB0YXNrPWM1YmE5MDMw
KQpKYW4gIDggMTU6NDI6MTAgdmZ3IGtlcm5lbDogWyAgIDY0LjU5NTU2N10g
U3RhY2s6IDAwMDAwMDAwIGM1OWQzMDAwIGM1OWQzMDAwIGMwNDFkNTk4IGM1
OWQzMDgwIDAwMDAwMzIwIGMxMGMzMDAwIDdmZmZmZmZmIApKYW4gIDggMTU6
NDI6MTAgdmZ3IGtlcm5lbDogWyAgIDY0LjYwMDI4NV0gICAgICAgIGMyNGI5
YWMwIGM1OWQzMDAwIDAwMDAwNDEwIGMyNjA5ZjJjIGMwNDJmNjE2IGM1OWQz
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIApKYW4gIDggMTU6NDI6MTAgdmZ3IGtl
cm5lbDogWyAgIDY0LjYxNDkwM10gICAgICAgIGMyNjA5ZDYwIDAwMDAwMDAx
IDAwMDAwMDAwIGMyNjA5ZGFjIGM2OGYzYTAwIDAwMDAwMDAwIDAwMDAwMjg2
IDAwMDAwMDA3IApKYW4gIDggMTU6NDI6MTAgdmZ3IGtlcm5lbDogWyAgIDY0
LjYyNDEyNl0gQ2FsbCBUcmFjZToKSmFuICA4IDE1OjQyOjEwIHZmdyBrZXJu
ZWw6IFsgICA2NC42Mzg3NjBdICBbPGMwNDFkNTk4Pl0gc2tiX3JlY3ZfZGF0
YWdyYW0rMHhjOC8weGQwCkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBb
ICAgNjQuNjQ0NDk0XSAgWzxjMDQyZjYxNj5dIG5ldGxpbmtfcmVjdm1zZysw
eDU2LzB4MjUwCkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQu
NjU2NTIyXSAgWzxjMDMwMzA0Mj5dIHNvZnRfY3Vyc29yKzB4MTkyLzB4MWYw
CkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQuNjYwNjM2XSAg
WzxjMDQxNjM4Mz5dIHNvY2tfcmVjdm1zZysweGYzLzB4MTEwCkphbiAgOCAx
NTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQuNjY4NTUxXSAgWzxjMDJmYTRm
OT5dIGJpdF9jdXJzb3IrMHgzNDkvMHg1NTAKSmFuICA4IDE1OjQyOjEwIHZm
dyBrZXJuZWw6IFsgICA2NC42NzYyOTFdICBbPGMwMTM0YjQwPl0gYXV0b3Jl
bW92ZV93YWtlX2Z1bmN0aW9uKzB4MC8weDYwCkphbiAgOCAxNTo0MjoxMCB2
Zncga2VybmVsOiBbICAgNjQuNjgyODM3XSAgWzxjMDQxNzc3Mj5dIHN5c19y
ZWN2ZnJvbSsweGIyLzB4MTIwCkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVs
OiBbICAgNjQuNjkxODY0XSAgWzxjMDMzNzAzOD5dIHdyaXRlX2NoYW4rMHgx
NTgvMHgyMzAKSmFuICA4IDE1OjQyOjEwIHZmdyBrZXJuZWw6IFsgICA2NC42
OTg3MzldICBbPGMwMTFjNzBlPl0gX193YWtlX3VwKzB4M2UvMHg2MApKYW4g
IDggMTU6NDI6MTAgdmZ3IGtlcm5lbDogWyAgIDY0LjcwODI1Ml0gIFs8YzAz
MzE3NGQ+XSB0dHlfd3JpdGUrMHgxZWQvMHgyNDAKSmFuICA4IDE1OjQyOjEw
IHZmdyBrZXJuZWw6IFsgICA2NC43MTIzNDBdICBbPGMwNDE3ODEzPl0gc3lz
X3JlY3YrMHgzMy8weDQwCkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBb
ICAgNjQuNzI0NTE0XSAgWzxjMDQxN2YzND5dIHN5c19zb2NrZXRjYWxsKzB4
MTY0LzB4MjYwCkphbiAgOCAxNTo0MjoxMCB2Zncga2VybmVsOiBbICAgNjQu
NzI4ODE3XSAgWzxjMDE1ZWFiMT5dIHN5c193cml0ZSsweDUxLzB4ODAKSmFu
ICA4IDE1OjQyOjEwIHZmdyBrZXJuZWw6IFsgICA2NC43NDAwNDldICBbPGMw
MTAzMGI5Pl0gc3lzY2FsbF9jYWxsKzB4Ny8weGIKSmFuICA4IDE1OjQyOjEw
IHZmdyBrZXJuZWw6IFsgICA2NC43NDQ2OTldIENvZGU6IDFjIDI0IDhiIDVj
IDI0IDEwIDg5IDdjIDI0IDA4IDg5IDc0IDI0IDA0IDhkIDdiIDBjIDMxIGY2
IDg5IGY4IGU4IDQyIDRiIDBjIDAwIDg5IGMyIDhiIDAzIDM5IGQ4IDc0IDE5
IDg5IGM2IDhiIDAwIGZmIDRiIDA4IDg5IDAzIDw4OT4gNTggMDQgYzcgMDYg
MDAgMDAgMDAgMDAgYzcgNDYgMDQgMDAgMDAgMDAgMDAgODkgZjggZTggNWEg
NGMgCg==

--0-669305880-1136712305=:62235--
