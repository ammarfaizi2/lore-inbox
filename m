Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUFLUB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUFLUB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbUFLUB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:01:58 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:50097 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S264911AbUFLUB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:01:56 -0400
Date: Sat, 12 Jun 2004 22:01:43 +0200 (CEST)
From: Egmont Koblinger <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: linux-kernel@vger.kernel.org
Subject: information leak in vga console scrollback buffer
Message-ID: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using the standard vga console, it is easily possible to read some random
pieces of texts that were scrolled out a long time ago (often you can see
your boot messages or similar stuff even after switcing to another
console or even to X. All you need is a local user access to the console.

2.4 and 2.6 series are both affected, maybe older ones too.

What to do to face the bug in 10 seconds:
- switch to a vga text console
- start "less somebigtextfile" where somebigtextfile means longer than a
  screenful. /etc/services might be a good choice.
- press Down arrow one or more times
- switch to another console or X, optionally do whatever you want to do
- switch back to "less"
- (Shift+PageUp now doesn't do anything as it is supposed to)
- press the Up arrow
- press Shift+PageUp. Voila! A long buffer of texts that you forgot a long
  time ago... And, interesting, when scrolling backwards the columns are
  shifted with a certain amount, but when scrolling back to the bottom of
  the page with Shift+PageDown the columns are ok.

It seems to me that the bug is triggered when an application tries to
scroll the content of the terminal downwards (i.e. the unusual direction),
and looking at the source, I guess something is wrong around the handling
of the variable "vga_rolled_over" and its fellows in
drivers/video/console/vgacon.c. But I don't yet fully understand the code,
I only have a rough feeling how it works, so unfortunately I'm far from
creating a fix.

I haven't tested it with framebuffer but I guess that one is unaffected.

I guess this is a serious privacy hole since I've seen dozens of people
hitting Alt+F1 Alt+F2 or something similar before they leave the machine
just to make sure that the scrollback buffers are emptied. But due to this
bug it might be possible for others to read some of their scrolled out
data, mail etc...



bye,

Egmont
