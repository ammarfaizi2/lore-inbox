Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSJPR2x>; Wed, 16 Oct 2002 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJPR2x>; Wed, 16 Oct 2002 13:28:53 -0400
Received: from quattro.sventech.com ([205.252.248.110]:63213 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S261284AbSJPR2r>; Wed, 16 Oct 2002 13:28:47 -0400
Date: Wed, 16 Oct 2002 13:34:43 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Peter Osterlund <petero2@telia.com>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
Message-ID: <20021016133443.U32760@sventech.com>
References: <Pine.LNX.4.44.0210082025570.16233-100000@p4.localdomain> <3DA34204.1030708@pacbell.net> <m2n0peuw5e.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2n0peuw5e.fsf@p4.localdomain>; from petero2@telia.com on Wed, Oct 16, 2002 at 07:32:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002, Peter Osterlund <petero2@telia.com> wrote:
> David Brownell <david-b@pacbell.net> writes:
> 
> > >>>>How does 2.5.41 work for you?
> > >>>
> > >>>It seems to be fixed. Thanks.
> > >>
> > >>Heh, that's pretty funny.  There were not any uhci specific fixes in
> > >>2.5.41...
> > >>
> > >>Not complaining,
> > > Actually, there were. This patch is in 2.5.41.
> > 
> > And wouldn't have changed any oopsing behavior, I assure you.
> > 
> > Your panic was being caused by something else.  I saw plenty
> > of strange 2.5.40 behavior indicative of someone walking over
> > memory they didn't own, and maybe your panic was another case.
> 
> The problem is back in 2.5.43, although it doesn't happen on every
> boot. I think I first saw this problem in 2.5.35.
> 
> The oops looks the same as usual. The oops happens because urb->hcpriv
> is NULL in uhci_result_control() so the list_empty() check oopses.
> 
> At the end of uhci_urb_enqueue() this code
> 
> 	if (ret != -EINPROGRESS) {
> 		uhci_destroy_urb_priv (uhci, urb);
> 		return ret;
> 	}
> 
> appears to be calling uhci_destroy_urb_priv() without having acquired
> the urb_list_lock. Can this be the cause of my problem?

Have you tried this patch? It's in Greg's BK tree, but hasn't been
picked up by Linus yet.

JE

# This is a BitKeeper generated patch for the following project:
# Project Name: greg k-h's linux 2.5 USB kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.892   -> 1.893  
#	drivers/usb/host/uhci-hcd.c	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/13	johannes@devel.(none)	1.893
# uhci-hcd.c:
#   If we fail adding the URB to the schedule, we need to make
#   sure that we remove it from the urb_list. Thanks to
#   Dan Streetman for finding and fixing this bug.
# --------------------------------------------
#
diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	Sun Oct 13 18:11:20 2002
+++ b/drivers/usb/host/uhci-hcd.c	Sun Oct 13 18:11:20 2002
@@ -1496,12 +1496,19 @@
 		break;
 	}
 
-	spin_unlock_irqrestore(&uhci->urb_list_lock, flags);
-
 	if (ret != -EINPROGRESS) {
+		/* Submit failed, so delete it from the urb_list */
+		struct urb_priv *urbp = urb->hcpriv;
+
+		list_del_init(&urbp->urb_list);
+		spin_unlock_irqrestore(&uhci->urb_list_lock, flags);
 		uhci_destroy_urb_priv (uhci, urb);
+
 		return ret;
 	}
+
+	spin_unlock_irqrestore(&uhci->urb_list_lock, flags);
+
 	return 0;
 }
 
