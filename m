Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTEYXHD (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 19:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTEYXHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 19:07:03 -0400
Received: from pat.uio.no ([129.240.130.16]:65228 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263825AbTEYXHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 19:07:01 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
   linux-kernel@vger.kernel.org, linux-mm@kvack.org,
   Trond Myklebust <trond.myklebust@fys.uio.no>,
   Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.5.69-mm9
References: <20030525042759.6edacd62.akpm@digeo.com>
	<1053899811.750.1.camel@teapot.felipe-alfaro.com>
	<20030525154840.3ba7609b.akpm@digeo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 26 May 2003 01:19:54 +0200
In-Reply-To: <20030525154840.3ba7609b.akpm@digeo.com>
Message-ID: <shsk7ceaa1x.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

     > I would be inclined to say that this is a hitherto undiscovered
     > use-after-free bug.

Does the following fix it?

Cheers,
  Trond


--- linux-2.5.69/net/sunrpc/svcsock.c.orig	2003-05-20 08:34:35.000000000 +0200
+++ linux-2.5.69/net/sunrpc/svcsock.c	2003-05-26 01:16:33.000000000 +0200
@@ -600,6 +600,7 @@
 			return 0;
 		}
 		local_bh_enable();
+		svsk->sk_sk->stamp = skb->stamp;
 		skb_free_datagram(svsk->sk_sk, skb); 
 	} else {
 		/* we can use it in-place */
@@ -614,6 +615,7 @@
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		}
 		rqstp->rq_skbuff = skb;
+		svsk->sk_sk->stamp = skb->stamp;
 	}
 
 	rqstp->rq_arg.page_base = 0;
@@ -629,7 +631,6 @@
 		serv->sv_stats->netudpcnt++;
 
 	/* One down, maybe more to go... */
-	svsk->sk_sk->stamp = skb->stamp;
 	svc_sock_received(svsk);
 
 	return len;
