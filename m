Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVDDFps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDDFps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDDFps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:45:48 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:17536 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261231AbVDDFpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:45:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: Re: [PATCH 4/4] psmouse: dynamic protocol switching via sysfs
Date: Mon, 4 Apr 2005 00:45:18 -0500
User-Agent: KMail/1.8
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <200503220217.47624.dtor_core@ameritech.net> <1112557765.3625.9.camel@localhost>
In-Reply-To: <1112557765.3625.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504040045.19263.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenan,

On Sunday 03 April 2005 14:49, Kenan Esau wrote:
> Patches 1-3 are fine.
> 

Thank you very much for testing the patches. Based on the feedback I
received I am goping to drop that DMI patch - does not save enough to
justify the ifdefs...

> Protocol switching via sysfs works too but if I switch from LBPS/2 to
> PS/2 the device name changes from "/dev/event1" to "/dev/event2" -- is
> this intended?

Yes - we in fact getting somewhat a "new" device with new capabilities so
the driver unregisters old input device and creates a new one. I strongly
believe that we should not change input device attributes "on fly".

> If I do "echo -n 50 > resolution" "0xe8 0x01" is sent. I don't know if
> this is correct for "usual" PS/2-devices but for the lifebook it's
> wrong.
> 
> For the lifebook the parameters are as following:
> 
> 50cpi  <=> 0x00
> 100cpi <=> 0x01
> 200cpi <=> 0x02
> 400cpi <=> 0x03
> 

"Classic" PS/2 protocol specifies available resolutions of 1, 2, 4 and 8
units per mm which gives you 25, 50, 100 and 200 cpi respectively. I am
surprised that Lifebook simply doubles the rates, but if it does I guess
the patch below will suffice. 

-- 
Dmitry

===================================================================

Input: apparently Lifebook touchscreens have double resolution
       compared to "classic" PS/2 mice, provide appropriate
       resolution setting handler.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 lifebook.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: dtor/drivers/input/mouse/lifebook.c
===================================================================
--- dtor.orig/drivers/input/mouse/lifebook.c
+++ dtor/drivers/input/mouse/lifebook.c
@@ -82,6 +82,17 @@ static int lifebook_absolute_mode(struct
 	return 0;
 }
 
+static void lifebook_set_resolution(struct psmouse *psmouse, unsigned int resolution)
+{
+	unsigned char params[] = { 0, 1, 2, 2, 3 };
+
+	if (resolution == 0 || resolution > 400)
+		resolution = 400;
+
+	ps2_command(&psmouse->ps2dev, &params[resolution / 100], PSMOUSE_CMD_SETRES);
+	psmouse->resolution = 50 << params[resolution / 100];
+}
+
 static void lifebook_disconnect(struct psmouse *psmouse)
 {
 	psmouse_reset(psmouse);
@@ -114,6 +125,7 @@ int lifebook_init(struct psmouse *psmous
 	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1024, 0, 0);
 
 	psmouse->protocol_handler = lifebook_process_byte;
+	psmouse->set_resolution = lifebook_set_resolution;
 	psmouse->disconnect = lifebook_disconnect;
 	psmouse->reconnect  = lifebook_absolute_mode;
 	psmouse->pktsize = 3;
