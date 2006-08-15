Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWHOXUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWHOXUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWHOXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:20:25 -0400
Received: from mail1.cenara.com ([193.111.152.3]:46034 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S1750810AbWHOXUZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:20:25 -0400
From: Magnus =?iso-8859-1?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Dmitry Torokhov" <dtor@insightbb.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Zephaniah E. Hull" <warp@aehallh.com>, wigge@bigfoot.com
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Date: Wed, 16 Aug 2006 01:20:03 +0200
User-Agent: KMail/1.9.1
References: <200608121724.16119.wigge@bigfoot.com> <d120d5000608140815g121a84a3o58919582d5797305@mail.gmail.com> <200608150049.50815.wigge@bigfoot.com>
In-Reply-To: <200608150049.50815.wigge@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608160120.03398.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 00:49, Magnus Vigerlöf wrote:
[...]
> However, this doesn't address the problem I initially described (I
> think)... What if two application open the same device and one of the
> application do a EVIOCGRAB. Should both applications still get events? With
> the above fix two applications that opens /dev/input/mouse2 resp
> /dev/input/event4 for the same hw and the latter grabs the device, both
> will get events. Using a counter for grab (just like the open-counter) on
> the handler should make them behave the same way in both cases I think.
> Gnnn... I'll make a patch tomorrow (ok today, Tuesday) so you can see what
> I rambling about..

Ok, this is what I mean (in code) if anyone's interested.. It should apply cleanly
on Dmitrys git-tree. It seems to work on my system without any side-effects
regarding the keyboard and Wacom tablet.

/Magnus

---
 drivers/input/evdev.c |   41 +++++++++++++++++------------------------
 1 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 12c7ab8..c7e741b 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -29,7 +29,7 @@ struct evdev {
 	char name[16];
 	struct input_handle handle;
 	wait_queue_head_t wait;
-	struct evdev_list *grab;
+	int grab;
 	struct list_head list;
 };
 
@@ -37,6 +37,7 @@ struct evdev_list {
 	struct input_event buffer[EVDEV_BUFFER_SIZE];
 	int head;
 	int tail;
+	int grab;
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
@@ -49,8 +50,7 @@ static void evdev_event(struct input_han
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	if (evdev->grab) {
-		list = evdev->grab;
+	list_for_each_entry(list, &evdev->list, node) {
 
 		do_gettimeofday(&list->buffer[list->head].time);
 		list->buffer[list->head].type = type;
@@ -59,17 +59,7 @@ static void evdev_event(struct input_han
 		list->head = (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
 
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
-	} else
-		list_for_each_entry(list, &evdev->list, node) {
-
-			do_gettimeofday(&list->buffer[list->head].time);
-			list->buffer[list->head].type = type;
-			list->buffer[list->head].code = code;
-			list->buffer[list->head].value = value;
-			list->head = (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
-
-			kill_fasync(&list->fasync, SIGIO, POLL_IN);
-		}
+	}
 
 	wake_up_interruptible(&evdev->wait);
 }
@@ -104,9 +94,10 @@ static int evdev_release(struct inode * 
 {
 	struct evdev_list *list = file->private_data;
 
-	if (list->evdev->grab == list) {
-		input_release_device(&list->evdev->handle);
-		list->evdev->grab = NULL;
+	if (list->grab) {
+		if(!--list->evdev->grab && list->evdev->exist)
+			input_release_device(&list->evdev->handle);
+		list->grab = 0;
 	}
 
 	evdev_fasync(-1, file, 0);
@@ -483,17 +474,19 @@ static long evdev_ioctl_handler(struct f
 
 		case EVIOCGRAB:
 			if (p) {
-				if (evdev->grab)
-					return -EBUSY;
-				if (input_grab_device(&evdev->handle))
+				if (list->grab)
 					return -EBUSY;
-				evdev->grab = list;
+				if (!evdev->grab++)
+					if (input_grab_device(&evdev->handle))
+						return -EBUSY;
+				list->grab = 0;
 				return 0;
 			} else {
-				if (evdev->grab != list)
+				if (!list->grab)
 					return -EINVAL;
-				input_release_device(&evdev->handle);
-				evdev->grab = NULL;
+				if (!--evdev->grab)
+					input_release_device(&evdev->handle);
+				list->grab = 0;
 				return 0;
 			}
 
