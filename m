Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUKGNQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUKGNQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUKGNQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:16:47 -0500
Received: from fep18.inet.fi ([194.251.242.243]:58617 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261612AbUKGNQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:16:43 -0500
Date: Sun, 7 Nov 2004 15:16:41 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel panic while using netcat since linux-2.6.9
Message-ID: <20041107131641.GA6312@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041106202600.GA1002@debbie> <418E1CB4.2040805@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418E1CB4.2040805@rainbow-software.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 02:01:40PM +0100, Ondrej Zary wrote:
> Ramsés Rodríguez Martínez wrote:
> >Hi,
> >Sorry i don't include any dump, but it seems kernel-patch-lkcd for 2.6.9 is
> >not available yet. I could handcopy the kernel-oops if you want. I think
> >it'll be something related with bind() as it fails with "netcat".
> >
> >The problem is only present with 2.6.9 (or at least not with 2.6.8 nor
> >2.6.5)
> >
> >------------------------
> >SCRIPT TO REPRODUCE:
> >  
> >su
> >apt-get install nc
> >exit
> >nc -p2000 127.0.0.1 2000        # kernel panic
> >
> >------------------------
> 
> It does the same thing for me. Here's the BUG output from serial console.

can you confirm does this patch fix the issue.
http://linux.bkbits.net:8080/linux-2.6/gnupatch@4175f00ayR2dZynZ8yUWYSVkL6Z5og

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/19 21:56:42-07:00 herbert@gondor.apana.org.au 
#   [NET]: Make sure to copy TSO fields in copy_skb_header().
#   
#   Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/core/skbuff.c
#   2004/10/19 21:56:24-07:00 herbert@gondor.apana.org.au +2 -4
#   [NET]: Make sure to copy TSO fields in copy_skb_header().
#   
#   Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	2004-11-07 05:16:05 -08:00
+++ b/net/core/skbuff.c	2004-11-07 05:16:05 -08:00
@@ -394,6 +394,8 @@
 	new->tc_index	= old->tc_index;
 #endif
 	atomic_set(&new->users, 1);
+	skb_shinfo(new)->tso_size = skb_shinfo(old)->tso_size;
+	skb_shinfo(new)->tso_segs = skb_shinfo(old)->tso_segs;
 }
 
 /**
@@ -483,8 +485,6 @@
 		}
 		skb_shinfo(n)->nr_frags = i;
 	}
-	skb_shinfo(n)->tso_size = skb_shinfo(skb)->tso_size;
-	skb_shinfo(n)->tso_segs = skb_shinfo(skb)->tso_segs;
 
 	if (skb_shinfo(skb)->frag_list) {
 		skb_shinfo(n)->frag_list = skb_shinfo(skb)->frag_list;
@@ -631,8 +631,6 @@
 		BUG();
 
 	copy_skb_header(n, skb);
-	skb_shinfo(n)->tso_size = skb_shinfo(skb)->tso_size;
-	skb_shinfo(n)->tso_segs = skb_shinfo(skb)->tso_segs;
 
 	return n;
 }

