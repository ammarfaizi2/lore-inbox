Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267969AbTBSEHx>; Tue, 18 Feb 2003 23:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267970AbTBSEHx>; Tue, 18 Feb 2003 23:07:53 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:46531 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267969AbTBSEHw>; Tue, 18 Feb 2003 23:07:52 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Wed, 19 Feb 2003 15:13:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15955.1148.929905.130326@notabene.cse.unsw.edu.au>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: sendmsg and IP_PKTINFO
In-Reply-To: message from David S. Miller on Tuesday February 18
References: <15949.40369.601166.550803@notabene.cse.unsw.edu.au>
	<1045552237.4501.8.camel@rth.ninka.net>
	<15954.4693.893707.471216@notabene.cse.unsw.edu.au>
	<20030218.195205.85404023.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 18, davem@redhat.com wrote:
>    From: Neil Brown <neilb@cse.unsw.edu.au>
>    Date: Tue, 18 Feb 2003 22:00:37 +1100
>    
>    It does go on to say that the outgoing packet will be sent over the
>    same interface, however I feel that is an illogical conclusion given
>    the description of the meaning of the field.
>    
>    So yes, the current behaviour seems to match part of the
>    documentation.  However I argue that the documented behaviour is
>    irrational.
> 
> Alexey and myself totally disagree.  We have described for you
> the intended purpose of this feature.  Please do not try to use
> it in some other way, it may prove to be painful :-)


Thankyou for making that clear.

I am currently working towards testing a patch that will fix the
behaviour of glibc.

Currently the sunrpc/svc_udp.c code asks for an IP_PKTINFO from
recvmsg, and passes it verbatim down through sendmsg.
My patch checks that the returned data looks believable and, if it
does, zeros the ipi_ifindex field.

NeilBrown



--- sunrpc/svc_udp.c.orig	2003-02-19 11:25:20.000000000 +1100
+++ sunrpc/svc_udp.c	2003-02-19 14:28:46.000000000 +1100
@@ -256,8 +256,26 @@
       mesgp->msg_controllen = sizeof(xprt->xp_pad)
 			      - sizeof (struct iovec) - sizeof (struct msghdr);
       rlen = recvmsg (xprt->xp_sock, mesgp, 0);
-      if (rlen >= 0)
-	len = mesgp->msg_namelen;
+      if (rlen >= 0) {
+	      struct cmsghdr *cmsg;
+	      len = mesgp->msg_namelen;
+	      cmsg = CMSG_FIRSTHDR(mesgp);
+	      if (cmsg == NULL ||
+		  CMSG_NXTHDR(mesgp, cmsg) != NULL ||
+		  cmsg->cmsg_level != SOL_IP ||
+		  cmsg->cmsg_type != IP_PKTINFO ||
+		  cmsg->cmsg_len != sizeof(struct in_pktinfo)) {
+		      /* Not a simple IP_PKTINFO, ignore it */
+		      mesgp->msg_control = NULL;
+		      mesgp->msg_controllen = 0;
+	      } else {
+		      /* it was a simple IP_PKTIFO as we expected,
+		       * Discard the interface field 
+		       */
+		      struct in_pktinfo *pkti = CMSG_DATA(cmsg);
+		      pkti->ipi_ifindex = 0;
+	      }
+      }
     }
   else
 #endif

