Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVDDFwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVDDFwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVDDFwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:52:19 -0400
Received: from [140.113.203.2] ([140.113.203.2]:4487 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261732AbVDDFvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:51:43 -0400
Message-ID: <4250D5D9.2060104@gmail.com>
Date: Mon, 04 Apr 2005 13:51:21 +0800
From: MingChieh <mingjie.tw@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: zh-tw, en-us, en, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to cope with "Scheduling in interrupt" problem
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I try to modify inet_sendmsg() and inet_recvmsg().
To defer the time to notify a receiver, I use a timer for the problem.
But it causes "Scheduling in interrupt" error.
Is there any method to reform it?

Thank you for tour help


MingChieh Chang,
Taiwan


Scheduling in interrupt
invalid operand: 0000
CPU: 0
EIP: 0819:[<c0005d6f>] Not tainted
EFLAGS: 00010286
eax: 00000018 ebx: c19c2000 ecx: c0170894 edx: fbff9000
esi: c19c2000 edi: c1d42da0 ebp: c19c3cf4 esp: c19c3cd0
ds: 0821 es: 0821 ss: 0821
Process ftp (pid: 1312, stackpage=c19c3000)<1>



EX:
inet_sendmsg()
{
.
.
.
BYE:

if(sock->send_nonnotify_size>0&&0==sock->send_set_timer)
{
sock->send_notify_timer.function=notify_receiver;
sock->send_notify_timer.expires=MY_EXT_NOTIFY_TIME + jiffies;
sock->send_notify_timer.data=(unsigned long)(sock);

dbprintk("set notify timer, sock addr=%p\n",sock);
add_timer(&sock->send_notify_timer);
sock->send_set_timer=1;

}
release_sock(sock->sk);
}

static void notify_receiver(unsigned long data)
{
struct socket* sock=(struct socket*)data;
struct SHM_INFO shm_tmp;

if(!sock||!sock->sk)
return;

lock_sock(sock->sk);
sock->send_set_timer=0;

if(sock->send_nonnotify_size)
{
dbprintk("notify_receiver:notify
receivers,size=%d\n",sock->send_nonnotify_size);
sock->send_nonnotify_size=0;

shm_tmp.saddr=ntohl(sock->sk->saddr);
shm_tmp.sport=ntohl(sock->sk->sport);

shm_tmp.reqaddr=shm_tmp.saddr;
shm_tmp.reqport=shm_tmp.sport;

shm_tmp.daddr=ntohl(sock->sk->daddr);
shm_tmp.dport=ntohl(sock->sk->dport);
shm_tmp.maddr=NULL;
release_sock(sock->sk);

dbprintk("notift_recv: call send_data()......");
HYPERVISOR_send_data(&shm_tmp);
dbprintk("done\n");
return;
}

release_sock(sock->sk);
}


