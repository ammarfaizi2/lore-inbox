Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRFBUxg>; Sat, 2 Jun 2001 16:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262700AbRFBUx0>; Sat, 2 Jun 2001 16:53:26 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:37362 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S262694AbRFBUxV>; Sat, 2 Jun 2001 16:53:21 -0400
Date: Sat, 2 Jun 2001 21:53:19 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: USB mouse wheel breakage was Re: Linux 2.4.5-ac5
Message-ID: <20010602215319.A13026@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010601105717.A2468@debian> <991399435.4435.0.camel@phantasy> <991431152.653.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991431152.653.0.camel@phantasy>
User-Agent: Mutt/1.3.18i
From: Michael <leahcim@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 05:32:26PM -0400, Robert M. Love wrote:
> I and another user thought the problem was in hid_input_field, but upon
> looking I now think not.

It is, check against hid.c in 2.4.5, the new code &&'s the first 2 if statements and so it
now checks non-zero HID_MAIN_INPUT_RELATIVE values for new and old being
the same, which AFAICT, they can and often will be.


Patch against ac6 reverts back to original hid.c check :-

--- ../linux.orig/drivers/usb/hid-core.c	Sat Jun  2 21:47:35 2001
+++ drivers/usb/hid-core.c	Sat Jun  2 21:46:00 2001
@@ -773,10 +773,11 @@
 
 		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
 
-			if ((field->flags & HID_MAIN_ITEM_RELATIVE) && !value[n])
-				continue;
-			if (value[n] == field->value[n])
-				continue;
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				if (!value[n]) continue;
+			} else {
+				if (value[n] == field->value[n]) continue;
+			}	
 			hid_process_event(hid, field, &field->usage[n], value[n]);
 			continue;
 		}

-- 
Michael.
