Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBBJaa>; Fri, 2 Feb 2001 04:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRBBJaU>; Fri, 2 Feb 2001 04:30:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56961 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129033AbRBBJaR>;
	Fri, 2 Feb 2001 04:30:17 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.32235.542511.977558@pizda.ninka.net>
Date: Fri, 2 Feb 2001 01:29:15 -0800 (PST)
To: Prasanna P Subash <psubash@turbolinux.com>
Cc: Chris Evans <chris@scary.beasts.org>,
        Malcolm Beattie <mbeattie@sable.ox.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch]Re: Serious reproducible 2.4.x kernel hang
In-Reply-To: <20010202012550.A9756@turbolinux.com>
In-Reply-To: <20010201165247.D27009@sable.ox.ac.uk>
	<Pine.LNX.4.30.0102011826060.397-100000@ferret.lmh.ox.ac.uk>
	<20010202012550.A9756@turbolinux.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Prasanna P Subash writes:
 > I looked at the skb_recv_datagram code and noticed that wait_for_packet is not
 > returning an error, even while trying to read a closed socket.
 > Anyways here is a patch against 2.4.1 that will fix the issue.
 > Please feel free to flame me about the patch :)

Please read the rest of today's postings, Alexey Kuznetsov already
posted the correct fix, which I'm attached below:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/net/core/datagram.c linux/net/core/datagram.c
--- vanilla/linux/net/core/datagram.c	Sat Nov 11 19:02:40 2000
+++ linux/net/core/datagram.c	Thu Feb  1 17:15:12 2001
@@ -72,19 +73,19 @@
 	/* Socket errors? */
 	error = sock_error(sk);
 	if (error)
-		goto out;
+		goto out_err;
 
 	if (!skb_queue_empty(&sk->receive_queue))
 		goto ready;
 
 	/* Socket shut down? */
 	if (sk->shutdown & RCV_SHUTDOWN)
-		goto out;
+		goto out_noerr;
 
 	/* Sequenced packets can come disconnected. If so we report the problem */
 	error = -ENOTCONN;
 	if(connection_based(sk) && !(sk->state==TCP_ESTABLISHED || sk->state==TCP_LISTEN))
-		goto out;
+		goto out_err;
 
 	/* handle signals */
 	if (signal_pending(current))
@@ -99,11 +100,16 @@
 
 interrupted:
 	error = sock_intr_errno(*timeo_p);
+out_err:
+	*err = error;
 out:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(sk->sleep, &wait);
-	*err = error;
 	return error;
+out_noerr:
+	*err = 0;
+	error = 1;
+	goto out;
 }
 
 /*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
