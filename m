Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWAGHDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWAGHDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWAGHDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:03:22 -0500
Received: from web53707.mail.yahoo.com ([206.190.37.28]:11861 "HELO
	web53707.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964867AbWAGHDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:03:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IzZkykArl99ycKmh51QhNVYtDGdhjYm2P6cX3CMxRsSnDWQNbsye7VTnkXDe0z4qJnumnewAgRgou/y18o4Olrb/HZ37niQW3YlOl5mwVXXkyZgmOI+pgUcDCzMZPHp2Noj+uwNakexn1pRauBEFBxyUNAHXQpo8C4vMZYVK4Ms=  ;
Message-ID: <20060107070319.17141.qmail@web53707.mail.yahoo.com>
Date: Fri, 6 Jan 2006 23:03:19 -0800 (PST)
From: Mikado <mikado4vn@yahoo.com>
Subject: Netlink socket problem
To: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1852838660-1136617399=:16130"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1852838660-1136617399=:16130
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

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

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1852838660-1136617399=:16130
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
ID0gTVNHX1NJWkU7CgkJbmxfaGRyLT5ubG1zZ19waWQgPSBwaWQ7CgkJbmxf
aGRyLT5ubG1zZ19mbGFncyA9IDA7CgkJc3RyY3B5KE5MTVNHX0RBVEEobmxf
aGRyKSwgImhlbGxvIHVzZXIgYWJjZDEyMzQiKTsKCQlORVRMSU5LX0NCKG5s
X3NrYikucGlkID0gMDsKCQlORVRMSU5LX0NCKG5sX3NrYikuZHN0X3BpZCA9
IHBpZDsKCQlORVRMSU5LX0NCKG5sX3NrYikuZHN0X2dyb3VwID0gVkZXX0dS
T1VQOwoJCW5ldGxpbmtfdW5pY2FzdChubF9zaywgbmxfc2tiLCBwaWQsIDAp
OwoJCWtmcmVlX3NrYihubF9za2IpOwoJfQp9CgpzdGF0aWMgaW50IF9faW5p
dCBubHRlc3RfaW5pdCh2b2lkKQp7CglwcmludGsoS0VSTl9BTEVSVCAibmx0
ZXN0OiBpbml0XG4iKTsKCQoJbmxfc2sgPSBuZXRsaW5rX2tlcm5lbF9jcmVh
dGUoTkVUTElOS19WRlcsIFZGV19HUk9VUCwgbmx0ZXN0X3JjdiwgVEhJU19N
T0RVTEUpOwoJaWYgKCFubF9zaykgewoJCXByaW50ayhLRVJOX0FMRVJUICJu
bHRlc3Q6IG5ldGxpbmtfa2VybmVsX2NyZWF0ZSgpIGZhaWxlZFxuIik7CgkJ
cmV0dXJuIC0xOwoJfQoJCglyZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgX19l
eGl0IG5sdGVzdF9leGl0KHZvaWQpCnsKCXByaW50ayhLRVJOX0FMRVJUICJu
bHRlc3Q6IGV4aXRcbiIpOwoJCglzb2NrX3JlbGVhc2Uobmxfc2stPnNrX3Nv
Y2tldCk7CgkKCXJldHVybjsKfQoKbW9kdWxlX2luaXQobmx0ZXN0X2luaXQp
Owptb2R1bGVfZXhpdChubHRlc3RfZXhpdCk7CgpNT0RVTEVfREVTQ1JJUFRJ
T04oIk5ldGxpbmsgVGVzdCIpOwpNT0RVTEVfQVVUSE9SKCJOZ3V5ZW4gTWlu
aCBOaGF0IDxuZ21uaGF0QGdtYWlsLmNvbT4iKTsKTU9EVUxFX0xJQ0VOU0Uo
IkdQTCIpOwo=

--0-1852838660-1136617399=:16130
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

--0-1852838660-1136617399=:16130--
