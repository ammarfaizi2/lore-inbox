Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVIAVoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVIAVoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbVIAVoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:44:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030413AbVIAVop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:44:45 -0400
Date: Thu, 1 Sep 2005 17:44:11 -0400
From: Alan Cox <alan@redhat.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Alan Cox <alan@redhat.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-ID: <20050901214411.GD25405@devserv.devel.redhat.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com> <43176AE8.8060105@austin.ibm.com> <20050901211647.GC25405@devserv.devel.redhat.com> <431771EA.4030809@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431771EA.4030809@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:26:02PM -0500, Joel Schopp wrote:
> It's like whack a mole.  30 more now in drivers/serial/jsm/jsm_tty.c and 
>  drivers/serial/icom.c

I've been whacking moles for some time doing all those I can. the jsm_tty
code needs major surgery and its bad it ever got into the kernel as most of
the code is duplicating chunks of the tty layer and working around it. The
jsm stuff is unintelligible and the docs dont appear to be public.

I'll take a look at icom.c now. I notice at least one bug already that
should be dealt with - the existing code assumes that tty->flip.char_buf_ptr[0]
is the first it inserted this time which may not be true as far as I can see.
And it looks there if count was 0 so its undefined.. 

Assuming it means the first char this block then the following should do
the trick, but really someone who knows wtf that code is trying to do needs
to fix it - please review/test/let me know.


--- drivers/serial/icom.c~	2005-09-01 22:37:16.986829264 +0100
+++ drivers/serial/icom.c	2005-09-01 22:37:16.986829264 +0100
@@ -737,6 +737,7 @@
 
 	status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
 	while (status & SA_FL_RCV_DONE) {
+		int first = -1;
 
 		trace(icom_port, "FID_STATUS", status);
 		count = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].leLength);
@@ -751,15 +752,17 @@
 			icom_port->recv_buf_pci;
 
 		/* Block copy all but the last byte as this may have status */
-		if(count > 0)
+		if(count > 0) {
+			first = icon->recv_buf[offset];
 			tty_insert_flip_string(tty, icon_port->recv_buf + offset, count - 1);
+		}
 
 		icount = &icom_port->uart_port.icount;
 		icount->rx += count;
 
 		/* Break detect logic */
 		if ((status & SA_FLAGS_FRAME_ERROR)
-		    && (tty->flip.char_buf_ptr[0] == 0x00)) {
+		    && first == 0) {
 			status &= ~SA_FLAGS_FRAME_ERROR;
 			status |= SA_FLAGS_BREAK_DET;
 			trace(icom_port, "BREAK_DET", 0);



Keep whacking - obviously I don't have a PPC64 (*and please don't send me one*)



Alan

