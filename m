Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281554AbRKPVZw>; Fri, 16 Nov 2001 16:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRKPVZc>; Fri, 16 Nov 2001 16:25:32 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:26127 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281554AbRKPVZW>;
	Fri, 16 Nov 2001 16:25:22 -0500
Date: Fri, 16 Nov 2001 13:25:20 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Cc: Andrew Morton <akpm@zip.com.au>, hogsberg@users.sourceforge.net,
        jamesg@filanet.com, linux-1394devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: sbp2.c on SMP
Message-ID: <20011116132520.A6204@lucon.org>
In-Reply-To: <3BEF27D1.7793AE8E@zip.com.au> <3BEF27D1.7793AE8E@zip.com.au> <20011113191721.A9276@lucon.org> <3BF21B79.5F188A0D@zip.com.au> <20011115193234.A22081@lucon.org> <m3snbeofnw.fsf@dk20037170.bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3snbeofnw.fsf@dk20037170.bang-olufsen.dk>; from hogsberg@users.sf.net on Fri, Nov 16, 2001 at 05:15:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 05:15:47PM +0100, Kristian Hogsberg wrote:
> This is true, but only because the struct list_head is the first
> element in struct node_entry.  If it wasn't, lh would have been -16 or
> so, as Andrew says.
> 
> In any case, it's the wrong fix, because the error is elsewhere:
> neither the host_info list or the node list should contain NULL
> entries.  This is just curing the symptoms.  HJ, could you provide
> some details on the crash?  Do you have the sbp2 module loaded when
> you insmod/rmmod ohci1394, and if so, does it crash without sbp2
> loaded?
> 

Found it. You have to use list_for_each_safe when you remove things.
Here is a patch.


H.J.
----
--- linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c.rmmod	Tue Nov 13 19:15:44 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/nodemgr.c	Fri Nov 16 13:14:22 2001
@@ -558,7 +558,7 @@ done_reset_host:
 
 static void nodemgr_remove_host(struct hpsb_host *host)
 {
-	struct list_head *lh;
+	struct list_head *lh, *spare;
 	struct host_info *hi = NULL;
 	struct node_entry *ne;
 	unsigned long flags;
@@ -568,7 +568,7 @@ static void nodemgr_remove_host(struct h
 
 	/* First remove all node entries for this host */
 	write_lock_irqsave(&node_lock, flags);
-	list_for_each(lh, &node_list) {
+	list_for_each_safe(lh, spare, &node_list) {
 		ne = list_entry(lh, struct node_entry, list);
 
 		/* Only checking this host */
--- linux-2.4.9-12.2mod/drivers/ieee1394/sbp2.c.rmmod	Thu Nov 15 17:08:49 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/sbp2.c	Fri Nov 16 13:14:37 2001
@@ -754,13 +754,13 @@ static int sbp2util_create_command_orb_p
 static void sbp2util_remove_command_orb_pool(struct scsi_id_instance_data *scsi_id,
 					     struct sbp2scsi_host_info *hi)
 {
-	struct list_head *lh;
+	struct list_head *lh, *spare;
 	struct sbp2_command_info *command;
 	unsigned long flags;
         
 	sbp2_spin_lock(&scsi_id->sbp2_command_orb_lock, flags);
 	if (!list_empty(&scsi_id->sbp2_command_orb_completed)) {
-		list_for_each(lh, &scsi_id->sbp2_command_orb_completed) {
+		list_for_each_safe(lh, spare, &scsi_id->sbp2_command_orb_completed) {
 			command = list_entry(lh, struct sbp2_command_info, list);
 
 			/* Release our generic DMA's */
--- linux-2.4.9-12.2mod/drivers/ieee1394/video1394.c.rmmod	Sun Nov 11 21:06:48 2001
+++ linux-2.4.9-12.2mod/drivers/ieee1394/video1394.c	Fri Nov 16 13:15:28 2001
@@ -1592,7 +1592,7 @@ static void video1394_remove_host (struc
 {
 	struct ti_ohci *ohci;
 	unsigned long flags;
-	struct list_head *lh;
+	struct list_head *lh, *spare;
 
 	/* We only work with the OHCI-1394 driver */
 	if (strcmp(host->template->name, OHCI1394_DRIVER_NAME))
@@ -1603,7 +1603,7 @@ static void video1394_remove_host (struc
         spin_lock_irqsave(&video1394_cards_lock, flags);
 	if (!list_empty(&video1394_cards)) {
 		struct video_card *p;
-		list_for_each(lh, &video1394_cards) {
+		list_for_each_safe(lh, spare, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
 			if (p ->ohci == ohci) {
 				remove_card(p);
