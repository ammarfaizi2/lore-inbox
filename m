Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130323AbQLGTem>; Thu, 7 Dec 2000 14:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbQLGTec>; Thu, 7 Dec 2000 14:34:32 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:12933 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130323AbQLGTeX>; Thu, 7 Dec 2000 14:34:23 -0500
Date: Thu, 07 Dec 2000 09:46:39 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Out of socket memory? (2.4.0-test11)
To: linux-kernel@vger.kernel.org, zwwe@opti.cgi.net
Reply-to: dank@alumni.caltech.edu
Message-id: <3A2FCCFF.6D1F0BC7@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3A2F4D48.41FE8BC8@alumni.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> Daniel Walton (zwwe@opti.cgi.net) wrote:
> > I've been having a problem with a high volume Linux web server. This 
> > particular web server used to be a FreeBSD machine and I've been trying to 
> > successfully make the switch for some time now. I've been trying the 2.4 
> > development kernels as they come out and I've been tweaking the /proc 
> > filesystem variables but so far nothing seems to have fixed the 
> > problem. The problem is that I get "Out of socket memory" errors and the 
> > networking locks up...
>
> FWIW, the code that prints this is in ipv4/tcp_timer.c
> and it looks like it's a DoS attack countermeasure.
>
> /* Do not allow orphaned sockets to eat all our resources.
>  * This is direct violation of TCP specs, but it is required
>  * to prevent DoS attacks. It is called when a retransmission timeout
>  * or zero probe timeout occurs on orphaned socket.
> ...
>     if (orphans >= sysctl_tcp_max_orphans ||
>         (sk->wmem_queued > SOCK_MIN_SNDBUF &&
>          atomic_read(&tcp_memory_allocated) > sysctl_tcp_mem[2])) {
>         if (net_ratelimit())
>             printk(KERN_INFO "Out of socket memory\n");

See Documentation/networking/ip-sysctl.txt for more info and tuning
suggestions, esp. tcp_orphan_retries and tcp_max_orphans.
An orphaned socket is one that has at least partially
opened, but has not been fully accepted.  You might try reducing
tcp_orphan_retries.

It looks like you can view the current number of orphans at
/proc/net/sockstat or something like that.
 
/*
 *  Report socket allocation statistics [mea@utu.fi]
 */
int afinet_get_info(char *buffer, char **start, off_t offset, int length)
{
    /* From  net/socket.c  */
    extern int socket_get_info(char *, char **, off_t, int);
 
    int len  = socket_get_info(buffer,start,offset,length);
 
    len += sprintf(buffer+len,"TCP: inuse %d orphan %d tw %d alloc %d mem %d\n",
               fold_prot_inuse(&tcp_prot),
               atomic_read(&tcp_orphan_count), tcp_tw_count,
               atomic_read(&tcp_sockets_allocated),
               atomic_read(&tcp_memory_allocated));     

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
