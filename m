Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTJaEzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 23:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTJaEzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 23:55:38 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:37030 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S263007AbTJaEzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 23:55:36 -0500
From: Junji Kanemaru <junji.kanemaru@oracle.com>
Reply-To: junji.kanemaru@datacentrix.co.jp
Organization: Oracle Japan
To: linux-kernel@vger.kernel.org
Subject: patch: logips2pp.c - Wheel(middle) button fix
Date: Fri, 31 Oct 2003 13:58:53 +0900
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310311358.54109.junji.kanemaru@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Hackers

Recently I switched to 2.6.0-test8,9 kernel and encountered
a problem that my mouse's middle button no longer works.
My mouse, Arvel MFS07MT,  has a wheel and it is also 
a button, I was able to paste text by pressing it with 2.4.x
kernel but 2.6.0-8,9.

I looked into input driver code and found where the problem
resides. The problem is my mouse is buggy.
There's code that clears BTN_MIDDLE bit in logips2pp.c
line 157-158 if the mouse says it has less than 3 buttons.
My mouse should set 3 in param[1] but it sets 2.
So that's why my mouse's middle button gets disabled.
But I really need my mouse's middle button working and
I think there may be other mice have same problem out
there we have to work out on this problem.

First I thought setting the BTN_MIDDLE bit back at the enf of
ps2pp_detect_model() function, right before it's returning
zero(0) when it fails to detect model. But even with this fix
there might be some buggy mice are still there that they are
detected as valid model and report they have two buttons
though they have wheel-button at middle.
So probably the best way to fix this problem without getting
into complicated mouse detection, just leave BTN_MIDDLE bit
on if param[1] >= 2, clear it when param[1] < 2.

Below is my tiny fix. Not 100% sure if I did right thing or not.
If this fix is acceptable for maintainer of logips2pp.c then
please apply.

Thanks,

-- Junji Kanemaru
Data Centrix Co., Ltd.
Tokyo Japan


--- linux-2.6.0-test9/drivers/input/mouse/logips2pp.c   2003-10-26 
03:43:59.000000000 +0900
+++ linux-2.6.0-test9-debug/drivers/input/mouse/logips2pp.c 2003-10-31 
13:48:38.000000000 +0900
@@ -154,10 +154,18 @@
    psmouse->vendor = "Logitech";
    psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);

-   if (param[1] < 3)
-       clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
-   if (param[1] < 2)
+   /*
+    * We clear middle BTN_MIDDLE only when the mouse says
+    * there's only one button on it(param[1] < 2).
+    * This is a workaround for some buggy mice which report
+    * they have only 2 buttons though they have wheel-button
+    * which also works as middle button.
+    * 10/31/2003 - junji.kanemaru@datacentrix.co.jp
+    */
+   if (param[1] < 2) {
        clear_bit(BTN_RIGHT, psmouse->dev.keybit);
+       clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
+    }

    psmouse->type = PSMOUSE_PS2;



