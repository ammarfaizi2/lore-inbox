Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLGJ1F>; Thu, 7 Dec 2000 04:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLGJ0z>; Thu, 7 Dec 2000 04:26:55 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:21168 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129183AbQLGJ0q>; Thu, 7 Dec 2000 04:26:46 -0500
Date: Thu, 07 Dec 2000 00:41:44 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Out of socket memory? (2.4.0-test11)
To: linux-kernel@vger.kernel.org, zwwe@opti.cgi.net
Reply-to: dank@alumni.caltech.edu
Message-id: <3A2F4D48.41FE8BC8@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walton (zwwe@opti.cgi.net) wrote:
> I've been having a problem with a high volume Linux web server. This 
> particular web server used to be a FreeBSD machine and I've been trying to 
> successfully make the switch for some time now. I've been trying the 2.4 
> development kernels as they come out and I've been tweaking the /proc 
> filesystem variables but so far nothing seems to have fixed the 
> problem. The problem is that I get "Out of socket memory" errors and the 
> networking locks up...

FWIW, the code that prints this is in ipv4/tcp_timer.c 
and it looks like it's a DoS attack countermeasure.
Looks like you can tune it with sysctl_tcp_max_orphans, among
other things.  Here's the code from test11-pre4:

/* Do not allow orphaned sockets to eat all our resources.
 * This is direct violation of TCP specs, but it is required
 * to prevent DoS attacks. It is called when a retransmission timeout
 * or zero probe timeout occurs on orphaned socket.
 *
 * Criterium is still not confirmed experimentally and may change.
 * We kill the socket, if:
 * 1. If number of orphaned sockets exceeds an administratively configured
 *    limit.
 * 2. If we have strong memory pressure.
 */
static int tcp_out_of_resources(struct sock *sk, int do_reset)
{
    struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
    int orphans = atomic_read(&tcp_orphan_count);
 
    /* If peer does not open window for long time, or did not transmit
     * anything for long time, penalize it. */
    if ((s32)(tcp_time_stamp - tp->lsndtime) > 2*TCP_RTO_MAX || !do_reset)
        orphans <<= 1;
 
    /* If some dubious ICMP arrived, penalize even more. */
    if (sk->err_soft)
        orphans <<= 1;
 
    if (orphans >= sysctl_tcp_max_orphans ||
        (sk->wmem_queued > SOCK_MIN_SNDBUF &&
         atomic_read(&tcp_memory_allocated) > sysctl_tcp_mem[2])) {
        if (net_ratelimit())
            printk(KERN_INFO "Out of socket memory\n");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
