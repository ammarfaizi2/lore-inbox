Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTINLt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 07:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTINLt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 07:49:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:3204 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262373AbTINLty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 07:49:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Willy Tarreau <willy@w.ods.org>
Date: Sun, 14 Sep 2003 21:48:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16228.21909.391485.229455@notabene.cse.unsw.edu.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre4 => NFSD problem on alpha
In-Reply-To: message from Willy Tarreau on Sunday September 14
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet>
	<20030914113421.GA705@alpha.home.local>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 14, willy@w.ods.org wrote:
> Hi Marcelo, Neil,
> 
> I've tested -pre4 on my alpha, and noticed that knsfd doesn't work anymore :
> the client sticks in D state forever. It has been working flawlessly for
> weeks with 2.4.22-rc2. What's strange is that 23-pre4 is OK on my athlon with
> the same nfs-utils (1.0.5).
> 
> I have the following NFSD options on both kernels :
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_TCP=y
> 
> My alpha kernels were build with GCC 3.2.3, while the athlon one is done with
> 2.95.3.
> 
> If I have some time, I'll try intermediate kernels to find which one brought
> the problem. I noticed that there were knfsd changes in 2.4.23-pre3, perhaps
> they're related. If you want me to try a patch, please ask.

I know what broke it.  Please try this patch and let me know.

NeilBrown

=======================================================================
Fix cmsg setup for sock_sendmsg in svc_sendto

From: Trond Myklebust <trond.myklebust@fys.uio.no>

... see the code in ip_sockglue.c + the macros in socket.h....
AFAICS the control messages have wierd alignment requirements.

 ----------- Diffstat output ------------
 ./net/sunrpc/svcsock.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff ./net/sunrpc/svcsock.c~current~ ./net/sunrpc/svcsock.c
--- ./net/sunrpc/svcsock.c~current~	2003-09-12 13:41:15.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2003-09-14 21:46:50.000000000 +1000
@@ -317,9 +317,9 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	struct svc_sock	*svsk = rqstp->rq_sock;
 	struct socket	*sock = svsk->sk_sock;
 	struct msghdr	msg;
-	struct { struct cmsghdr cmh;
-		struct in_pktinfo pki;
-	} cm;
+	char 		buffer[CMSG_SPACE(sizeof(struct in_pktinfo))];
+	struct cmsghdr *cmh = (struct cmsghdr *)buffer;
+	struct in_pktinfo *pki = (struct in_pktinfo *)CMSG_DATA(cmh);
 	int		i, buflen, len;
 
 	for (i = buflen = 0; i < nr; i++)
@@ -330,13 +330,13 @@ svc_sendto(struct svc_rqst *rqstp, struc
 	msg.msg_iov     = iov;
 	msg.msg_iovlen  = nr;
 	if (rqstp->rq_prot == IPPROTO_UDP) {
-		msg.msg_control = &cm;
-		msg.msg_controllen = sizeof(cm);
-		cm.cmh.cmsg_len = sizeof(cm);
-		cm.cmh.cmsg_level = SOL_IP;
-		cm.cmh.cmsg_type = IP_PKTINFO;
-		cm.pki.ipi_ifindex = 0;
-		cm.pki.ipi_spec_dst.s_addr = rqstp->rq_daddr;
+		msg.msg_control = cmh;
+		msg.msg_controllen = sizeof(buffer);
+		cmh->cmsg_len = CMSG_LEN(sizeof(*pki));
+		cmh->cmsg_level = SOL_IP;
+		cmh->cmsg_type = IP_PKTINFO;
+		pki->ipi_ifindex = 0;
+		pki->ipi_spec_dst.s_addr = rqstp->rq_daddr;
 	} else {
 		msg.msg_control = NULL;
 		msg.msg_controllen = 0;
