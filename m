Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTHZQyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTHZQyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:54:55 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:29192 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262052AbTHZQyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:54:51 -0400
Date: Wed, 27 Aug 2003 01:54:48 +0900 (JST)
Message-Id: <20030827.015448.70287953.yoshfuji@linux-ipv6.org>
To: sebek64@post.cz, oford@arghblech.com, smiler@lanil.mine.nu,
       jmorris@intercode.com.au
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [OOPS] less /proc/net/igmp
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030826.173226.114994096.yoshfuji@linux-ipv6.org>
References: <20030826.150331.102449369.yoshfuji@linux-ipv6.org>
	<1061878985.3463.2.camel@spider.hotmonkeyporn.com>
	<20030826.173226.114994096.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20030826.173226.114994096.yoshfuji@linux-ipv6.org> (at Tue, 26 Aug 2003 17:32:26 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> > I can confirm. I have it with 2.6.0-test4.
> > 
> > Let me know what useful info I can provide.  The oops is the same.
> 
> Okay, everyone. I'll try to fix this.

Please try this patch.

Index: linux-2.6/net/ipv4/igmp.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/igmp.c,v
retrieving revision 1.33
diff -u -r1.33 igmp.c
--- linux-2.6/net/ipv4/igmp.c	21 Aug 2003 17:47:23 -0000	1.33
+++ linux-2.6/net/ipv4/igmp.c	26 Aug 2003 15:18:03 -0000
@@ -2122,6 +2122,7 @@
 			break;
 		}
 		read_unlock(&in_dev->lock);
+		in_dev_put(in_dev);
 	}
 	return im;
 }
@@ -2181,7 +2182,9 @@
 	if (likely(state->in_dev != NULL)) {
 		read_unlock(&state->in_dev->lock);
 		in_dev_put(state->in_dev);
+		state->in_dev = NULL;
 	}
+	state->dev = NULL;
 	read_unlock(&dev_base_lock);
 }
 
@@ -2284,6 +2287,7 @@
 			spin_unlock_bh(&im->lock);
 		}
 		read_unlock_bh(&idev->lock);
+		in_dev_put(idev);
 	}
 	return psf;
 }
@@ -2350,12 +2354,16 @@
 static void igmp_mcf_seq_stop(struct seq_file *seq, void *v)
 {
 	struct igmp_mcf_iter_state *state = igmp_mcf_seq_private(seq);
-	if (likely(state->im != NULL))
+	if (likely(state->im != NULL)) {
 		spin_unlock_bh(&state->im->lock);
+		state->im = NULL;
+	}
 	if (likely(state->idev != NULL)) {
 		read_unlock_bh(&state->idev->lock);
 		in_dev_put(state->idev);
+		state->idev = NULL;
 	}
+	state->dev = NULL;
 	read_unlock(&dev_base_lock);
 }
 
Index: linux-2.6/net/ipv6/mcast.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/mcast.c,v
retrieving revision 1.30
diff -u -r1.30 mcast.c
--- linux-2.6/net/ipv6/mcast.c	21 Aug 2003 23:44:54 -0000	1.30
+++ linux-2.6/net/ipv6/mcast.c	26 Aug 2003 15:18:03 -0000
@@ -2078,6 +2078,7 @@
 			break;
 		}
 		read_unlock_bh(&idev->lock);
+		in6_dev_put(idev);
 	}
 	return im;
 }
@@ -2135,7 +2136,9 @@
 	if (likely(state->idev != NULL)) {
 		read_unlock_bh(&state->idev->lock);
 		in6_dev_put(state->idev);
+		state->idev = NULL;
 	}
+	state->dev = NULL;
 	read_unlock(&dev_base_lock);
 }
 
@@ -2225,6 +2228,7 @@
 			spin_unlock_bh(&im->mca_lock);
 		}
 		read_unlock_bh(&idev->lock);
+		in6_dev_put(idev);
 	}
 	return psf;
 }
@@ -2291,12 +2295,16 @@
 static void igmp6_mcf_seq_stop(struct seq_file *seq, void *v)
 {
 	struct igmp6_mcf_iter_state *state = igmp6_mcf_seq_private(seq);
-	if (likely(state->im != NULL))
+	if (likely(state->im != NULL)) {
 		spin_unlock_bh(&state->im->mca_lock);
+		state->im = NULL;
+	}
 	if (likely(state->idev != NULL)) {
 		read_unlock_bh(&state->idev->lock);
 		in6_dev_put(state->idev);
+		state->idev = NULL;
 	}
+	state->dev = NULL;
 	read_unlock(&dev_base_lock);
 }
 


-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
