Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVIBN1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVIBN1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVIBN1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:27:46 -0400
Received: from smtp2.cict.fr ([195.220.59.17]:62406 "EHLO smtp2.cict.fr")
	by vger.kernel.org with ESMTP id S1751159AbVIBN1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:27:45 -0400
Message-Id: <200509021327.j82DRJK18844@irsamc.ups-tlse.fr>
Date: Fri, 2 Sep 2005 15:27:16 +0200 (CEST)
From: frahm@irsamc.ups-tlse.fr
Subject: 2.6.13 psmouse: problem wheel detection: AlpsPS/2 versus ImPS/2
To: linux-kernel@vger.kernel.org
cc: frahm@irsamc.ups-tlse.fr
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have encountered a strange problem for the detection of the wheel of my 
PS/2 Mouse (Labtec, optical, three buttons plus wheel, works well 
with the IMPS/2 driver) connected to a Laptop as an external mouse.

Actually, the problem appeares on a Dell Lattitude C840 which has a touch-pad 
mouse (and also a mouse as a small rough button in the keyboard between the 
keys "G" and "H"). Since I don't use neither the touch-pad nor the 
button-mouse I have connected the optical mouse with wheel by a 
standard PS/2 connector at the back of the Lattitude. Up to Kernel 2.6.12 and 
also with all recent 2.4 kernels (including 2.4.31) the external mouse works 
well with the wheel. However at 2.6.13 the wheel is no longer recognized. 
I didn't test intermediate rc-releases between 2.6.12 and 2.6.13 but I have 
seen in the Changelog that there has been some considerable modifications exactly 
for the wheel detection in the psmouse-driver, for example:

----------------------------
commit 7b4019d04895de7407c9989895c3664c24ed01f7
Author: Vojtech Pavlik <vojtech@suse.cz>
Date:   Fri Jul 15 01:50:08 2005 -0500

    Input: psmouse - wheel mice (imps, exps) always have 3rd button
    
    Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
    Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---------------------------

The reason for the non-detetection of the wheel in my case appears to be 
quite simple. During the boot a of 2.6.12 or earlier kernels the driver 
psmouse detects a standard ImPS/2 mouse with the message:

input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

However with 2.6.13 it detects a different "mouse" due to the touch-pad which 
is AlpsPS/2 and not ImPS/2, more precisely the AlpsPS/2-driver seems to be a 
"better" (?) driver for the touch pad mouse but it does NOT recognize the 
wheel of the external mouse. In addition the touch pad also seems to work 
correctly with the ImPS/2-driver. The problem is also independent of the 
fact if I use the nv-driver from XFree/Xorg or the nvidia-driver from NVIDIA 
for the graphic card. 

I have therefore commented in the file "drivers/input/mouse/psmouse-base.c" 
the code where the AlpsPS/2-Mouse is detected and afterwards also the kernel 
2.6.13 falls back to the ImPS/2 Mouse with the wheel properly working. 
The corresponding patch is:

--- drivers/input/mouse/psmouse-base.c.orig     Tue Aug 30 13:15:36 2005
+++ drivers/input/mouse/psmouse-base.c  Fri Sep  2 14:07:01 2005
@@ -489,17 +489,21 @@
 /*
  * Try ALPS TouchPad
  */
+/*
        if (max_proto > PSMOUSE_IMEX) {
                ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
                if (alps_detect(psmouse, set_properties) == 0) {
                        if (!set_properties || alps_init(psmouse) == 0)
                                return PSMOUSE_ALPS;
+*/
 /*
  * Init failed, try basic relative protocols
  */
+/*
                        max_proto = PSMOUSE_IMEX;
                }
        }
+*/
 
        if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
                return PSMOUSE_GENPS;


This is of course only a very simple work-around patch which aims mainly to 
describe the problem than solving it. Furthermore I have no particular 
knowledge of the internals of the psmouse-driver. For the moment being the above 
patch solves the problem to my satisfaction, however, I suppose the 
maintainers of this driver will find a proper way to enable the detection 
of an external mouse with wheel even if there is an internal touch-pad mouse 
(without simply disabling the AlpsPS/2-driver). 

In case you need further information please make a "cc" to my email adress 
since I am not subscribed to the kernel-mailing list (however I will regularly 
consult the archive).


Greetings, Klaus Frahm.


