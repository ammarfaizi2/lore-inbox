Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750823AbWFEVDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFEVDt (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWFEVDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:03:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11930 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750823AbWFEVDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:03:47 -0400
Subject: Re: 2.6.17-rc5-mm3
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
In-Reply-To: <20060605204456.GF6143@redhat.com>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605194844.GA6143@redhat.com> <20060605130626.3f2917a2.akpm@osdl.org>
	 <20060605200947.GC6143@redhat.com>  <20060605204456.GF6143@redhat.com>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 23:03:43 +0200
Message-Id: <1149541423.3111.130.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 16:44 -0400, Dave Jones wrote:
> On Mon, Jun 05, 2006 at 04:09:47PM -0400, Dave Jones wrote:
> 
>  >  > Try reverting debug-shared-irqs.patch, or disable the sound driver?
>  > Will turn off the sound driver, and see what happens.
> 
> Win! It now boots.   I blew it up really easy with a socket-fuzzer though.
> (http://people.redhat.com/davej/sfuzz.c)
> 
> [  874.865028] ======================================
> [  874.943738] [ BUG: bad unlock ordering detected! ]
> [  875.002919] --------------------------------------
> [  875.062134] sfuzz/23915 is trying to release lock (&sctp_port_alloc_lock) at:
> [  875.149619]  [<d128ed4e>] sctp_get_port_local+0xd0/0x285 [sctp]
> [  875.222636] but the next lock to release is:
> [  875.276019]  (&sctp_port_hashtable[i].lock){-...}, at: [<d128ed0e>] sctp_get_port_local+0x90/0x285 [sctp]
> [  875.393031]

this is "interesting" code to follow but it looks like a honest case of
deliberate out of order unlock

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 net/sctp/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc5-mm3/net/sctp/socket.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/net/sctp/socket.c
+++ linux-2.6.17-rc5-mm3/net/sctp/socket.c
@@ -4597,7 +4597,7 @@ static long sctp_get_port_local(struct s
 			sctp_spin_unlock(&head->lock);
 		} while (--remaining > 0);
 		sctp_port_rover = rover;
-		sctp_spin_unlock(&sctp_port_alloc_lock);
+		spin_unlock_non_nested(&sctp_port_alloc_lock);
 
 		/* Exhausted local port range during search? */
 		ret = 1;


