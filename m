Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314481AbSDWW6B>; Tue, 23 Apr 2002 18:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314482AbSDWW6B>; Tue, 23 Apr 2002 18:58:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58099
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314481AbSDWW6A>; Tue, 23 Apr 2002 18:58:00 -0400
Date: Tue, 23 Apr 2002 16:00:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Lennert Buytenhek <buytenh@gnu.org>
Subject: [PATCH] Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020423230042.GL574@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	Lennert Buytenhek <buytenh@gnu.org>
In-Reply-To: <20020410015311.GA31952@matchmail.com> <20020410181606.GD23513@matchmail.com> <20020411004911.GH23513@matchmail.com> <20020411010515.GI23513@matchmail.com> <20020411014035.GJ23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 06:40:35PM -0700, Mike Fedyk wrote:
> On Wed, Apr 10, 2002 at 06:05:15PM -0700, Mike Fedyk wrote:
> > On Wed, Apr 10, 2002 at 05:49:11PM -0700, Mike Fedyk wrote:
> > > 2.4.18_fix_port_state_handling.diff
> > > 
> > > Is causing the problem on 2.4.17-19p6tulip-br0fpsh.  I haven't tested the
> > > other patches though.
> > > 
> > > I'm going to reverse this patch on 2.4.19-pre6 to see if it fixes it there
> > > too.  Stay tuned.
> > 
> > 2.4.18_enslave_bridge_dev_to_bridge_dev.diff
> > 
> > Is fine I didn't reproduce the trouble in 2.4.17-19p6tulip-br0ebdtbd (it was
> > already compiling when I tested the port_state kernel...).
> > 
> > 2.4.19-pre6-nobr0fpsh building now...
> 
> Yep, reversing 2.4.18_fix_port_state_handling.diff fixed it.
> 

Instead of reversing the patch, use this patch from Lennert Buytenhek instead:

Note: this problem should only show up on smp kernels(unvarified), it showed
up with a smp kernel on a UP system for me.

--- linux-2.4.18/net/bridge/br_input.c.orig	Thu Apr 18 11:50:16 2002
+++ linux-2.4.18/net/bridge/br_input.c	Thu Apr 18 11:50:26 2002
@@ -161,8 +161,10 @@
 handle_special_frame:
 	if (!dest[5]) {
 		br_stp_handle_bpdu(skb);
+		read_unlock(&br->lock);
 		return;
 	}
 
+	read_unlock(&br->lock);
 	kfree_skb(skb);
 }



