Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTJUAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTJUAmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:42:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262955AbTJUAmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:42:01 -0400
To: Ben Collins <bcollins@debian.org>, marcelo.tosatti@cyclades.com.br
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       James Goodwin <jamesg@filanet.com>
Subject: patch for 2.4.22 sbp2 hang when loaded with devices already connected
References: <ord6csra7h.fsf@free.redhat.lsd.ic.unicamp.br>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 20 Oct 2003 22:40:23 -0200
In-Reply-To: <ord6csra7h.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <orbrsba0eg.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

We were free()ing a packet before sbp2_agent_reset() had a chance to
wake up on its semaphore, which would often cause sbp2 to hang in
`initializing' state if it was loaded when firewire devices were
already connected to the host.  Details of the symptoms at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=103821

This patch fixes it.  I guess Ben likes it because he sent me a very
similar patch to test just as I was finishing testing this one :-)

Thanks, Ben, for helping me figure out what was going on!

Please Cc: me on replies, as I'm not subscribed.  In fact, I'm not
even sure my posting will make it to the lists.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=sbp2-init.patch

--- /usr/src/linux-2.4/drivers/ieee1394/sbp2.c	2003-08-25 08:44:42.000000000 -0300
+++ drivers/ieee1394/sbp2.c	2003-10-20 22:16:17.000000000 -0200
@@ -372,8 +372,10 @@ static int sbp2util_down_timeout(atomic_
 }
 
 /* Free's an allocated packet */
-static void sbp2_free_packet(struct hpsb_packet *packet)
+static void sbp2_free_packet(void *packet_)
 {
+	struct hpsb_packet *packet = packet_;
+
 	hpsb_free_tlabel(packet);
 	free_hpsb_packet(packet);
 }
@@ -389,7 +391,8 @@ static struct hpsb_packet *
 sbp2util_allocate_write_packet(struct sbp2scsi_host_info *hi,
 			       struct node_entry *ne, u64 addr,
 			       size_t data_size,
-			       quadlet_t *data)
+			       quadlet_t *data,
+			       int keep)
 {
 	struct hpsb_packet *packet;
 
@@ -399,8 +402,10 @@ sbp2util_allocate_write_packet(struct sb
         if (!packet)
                 return NULL;
 
-	hpsb_set_packet_complete_task(packet, (void (*)(void*))sbp2_free_packet,
-				      packet);
+	if (!keep)
+		hpsb_set_packet_complete_task(packet,
+					      sbp2_free_packet,
+					      packet);
 
 	hpsb_node_fill_packet(ne, packet);
 
@@ -1763,7 +1768,7 @@ static int sbp2_agent_reset(struct scsi_
 	packet = sbp2util_allocate_write_packet(hi, scsi_id->ne,
 						scsi_id->sbp2_command_block_agent_addr +
 						SBP2_AGENT_RESET_OFFSET,
-						4, &data);
+						4, &data, wait);
 
 	if (!packet) {
 		SBP2_ERR("sbp2util_allocate_write_packet failed");
@@ -1779,6 +1784,7 @@ static int sbp2_agent_reset(struct scsi_
 	if (wait) {
 		down(&packet->state_change);
 		down(&packet->state_change);
+		sbp2_free_packet(packet); 
 	}
 
 	/*
@@ -2073,7 +2079,7 @@ static int sbp2_link_orb_command(struct 
 
 			packet = sbp2util_allocate_write_packet(hi, scsi_id->ne,
 								scsi_id->sbp2_command_block_agent_addr +
-								SBP2_ORB_POINTER_OFFSET, 8, NULL);
+								SBP2_ORB_POINTER_OFFSET, 8, NULL, 0);
 		
 			if (!packet) {
 				SBP2_ERR("sbp2util_allocate_write_packet failed");
@@ -2123,7 +2129,7 @@ static int sbp2_link_orb_command(struct 
 
 			packet = sbp2util_allocate_write_packet(hi, scsi_id->ne,
 					scsi_id->sbp2_command_block_agent_addr +
-					SBP2_DOORBELL_OFFSET, 4, &data);
+					SBP2_DOORBELL_OFFSET, 4, &data, 0);
 	
 			if (!packet) {
 				SBP2_ERR("sbp2util_allocate_write_packet failed");

--=-=-=


-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist                Professional serial bug killer

--=-=-=--
