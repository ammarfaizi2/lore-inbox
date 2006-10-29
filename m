Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWJ2Urp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWJ2Urp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWJ2Urp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:47:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:14693 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030205AbWJ2Urn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:47:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Clg7lzOVMxe1mJHWXh3mcUe/TJuI8uMBC650aAgpyyu3d87Hc4HLp/cZOjmZ4xzfX+1f0pzLT8ojUKYtLAegqgMF5LWEDGEW3QcC09S4mOcm7HsvoYePZGOrplrHKTXOGGkBSmwYVDeL6hXb2JrhAAYZHtT5Jj+6/bBnZSPuxN4=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18 forcedeth GSO panic on send
Date: Sun, 29 Oct 2006 22:45:40 +0100
User-Agent: KMail/1.8.2
Cc: Manfred Spraul <manfred@colorfullife.com>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <200610270117.57877.vda.linux@googlemail.com> <200610291355.56196.vda.linux@googlemail.com> <20061029141029.GA5084@gondor.apana.org.au>
In-Reply-To: <20061029141029.GA5084@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610292245.40702.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 15:10, Herbert Xu wrote:
> On Sun, Oct 29, 2006 at 01:55:56PM +0100, Denis Vlasenko wrote:
> > 
> > With "echo 1 >/proc/sys/kernel/panic_on_oops" I've got
> > what you're requested. See screenshot:
> > 
> > http://busybox.net/~vda/gso_panic/forcedeth_gso_panic2.jpg
> 
> Thanks!
> 
> Please let me know if this patch fixes it:
> 
> [NET]: Fix segmentation of linear packets

Okay, will test now.

> The fact that you're triggering this bug at all means that
> something else has gone wrong.  First of all your picture
> shows a device setting of "lo".  This does not tally with
> the fact that the BUG was triggered by ssh.  Do you have
> any idea why this is the case? Do you have any netfilter
> rules that might cause this?

Yes, I have netfilter rules which redirect all outgoing
port 22 connections to local port 2222. I run tcpserver
on 2222 which spawns hose for each connection.

All this ugliness is required to get ssh working across
buggy D-Link router. It chokes on nagle-disabled sessions,
I think.

The rules:

# iptables -t nat -N redir22
# iptables -t nat -A redir22 -d 192.168.1.111 -j RETURN
# iptables -t nat -A redir22 -d 127.0.0.1 -j RETURN
# iptables -t nat -A redir22 --match owner --uid-owner daemon -j RETURN
# iptables -t nat -A redir22 -p tcp -j REDIRECT --to 2222
# iptables -t nat -A OUTPUT -p tcp --dport 22 -j redir22

---FILTER--
Chain INPUT (policy ACCEPT 20 packets, 1360 bytes)
Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
Chain OUTPUT (policy ACCEPT 2 packets, 100 bytes)
---NAT-----
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
Chain POSTROUTING (policy ACCEPT 1 packets, 60 bytes)
Chain OUTPUT (policy ACCEPT 1 packets, 60 bytes)
       0        0 redir22    tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           tcp dpt:22
Chain redir22 (1 references)
       0        0 RETURN     all  --  *      *       0.0.0.0/0            192.168.1.111
       0        0 RETURN     all  --  *      *       0.0.0.0/0            127.0.0.1
       0        0 RETURN     all  --  *      *       0.0.0.0/0            0.0.0.0/0           OWNER UID match 50
       0        0 REDIRECT   tcp  --  *      *       0.0.0.0/0            0.0.0.0/0           redir ports 2222
---MANGLE--
Chain PREROUTING (policy ACCEPT 2 packets, 100 bytes)
Chain INPUT (policy ACCEPT 2 packets, 100 bytes)
Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
Chain OUTPUT (policy ACCEPT 2 packets, 100 bytes)
Chain POSTROUTING (policy ACCEPT 2 packets, 100 bytes)

On port 2222 I have the following running:

run:
====
ip=0.0.0.0
port=2222
user=daemon
maxconn=100
# envuidgid $user tcpserver -U:
# run tcpserver as $user
exec \
env - \
softlimit \
envuidgid $user \
tcpserver \
    -U \
    -v -R -H -l 0 -c $maxconn \
    $ip $port \
./startproxy22

startproxy22
============
targetip="$TCPORIGDSTIP"
targetport=22
# Loop prevention
if test "$TCPLOCALIP" = "$targetip"; then
    if test "$TCPLOCALPORT" = "$targetport"; then
        env >loop.detected
        exit 0
    fi
fi
# netcat rulez... however hose of netpipes fame
# is still better because --netslave properly closes
# connection on input EOF.
exec env - hose "$targetip" "$targetport" --netslave

> If it is indeed lo, could you please check the ethtool -k
> setting on it? Also what is the ethtool -k setting on the
> interface where you expect ssh to go out?

# ethtool -k lo
Offload parameters for lo:
Cannot get device rx csum settings: Operation not supported
Cannot get device tx csum settings: Operation not supported
Cannot get device scatter-gather settings: Operation not supported
rx-checksumming: off
tx-checksumming: off
scatter-gather: off
tcp segmentation offload: off
--
vda
