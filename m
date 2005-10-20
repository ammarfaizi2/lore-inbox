Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVJTQN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVJTQN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJTQN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:13:28 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:61672 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S932344AbVJTQN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:13:28 -0400
Date: Thu, 20 Oct 2005 18:13:11 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix vgacon blanking
Message-ID: <20051020161311.GA30041@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

This patch fixes a long-standing vgacon bug: characters with the bright 
bit set were left on the screen and not blacked out.
All I did was that I lookuped up some examples on the net about setting 
the vga palette, and added the call missing from the linux kernel, but 
included in all other ones. It works for me.

You can test this by writing something with the bright set to the 
console, for example:
  echo -e "\e[1;31mhello there\e[0m"
and then wait for the console to blank itself (by default, after 10 mins 
of inactivity), maybe making it faster using
  setterm -blank 1
so you only have to wait 1 minute.


Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>


Please review and apply,


-- 
pozsy


--- orig/drivers/video/console/vgacon.c	2005-10-11 03:19:19.000000000 +0200
+++ pozsy/drivers/video/console/vgacon.c	2005-10-20 15:41:18.000000000 +0200
@@ -575,6 +510,7 @@ static void vga_set_palette(struct vc_da
 {
 	int i, j;
 
+	vga_w(state.vgabase, VGA_PEL_MSK, 0xff);
 	for (i = j = 0; i < 16; i++) {
 		vga_w(state.vgabase, VGA_PEL_IW, table[i]);
 		vga_w(state.vgabase, VGA_PEL_D, vc->vc_palette[j++] >> 2);
@@ -717,6 +653,7 @@ static void vga_pal_blank(struct vgastat
 {
 	int i;
 
+	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
 	for (i = 0; i < 16; i++) {
 		vga_w(state->vgabase, VGA_PEL_IW, i);
 		vga_w(state->vgabase, VGA_PEL_D, 0);
