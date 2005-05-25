Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVEYS32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVEYS32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVEYS3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:29:06 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:11242 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S261488AbVEYSSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:18:12 -0400
Message-ID: <4294C165.7010503@cachola.com.br>
Date: Wed, 25 May 2005 15:18:13 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH (?)] vt: fix possible memory corruption in complement_pos
Content-Type: multipart/mixed;
 boundary="------------000301050207070604070403"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000301050207070604070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.
In the file drivers/char/vt.c the function complement_pos (used by 
selection: complement pointer position) saves the memory position of 
previous pointer position. If, between 2 successive calls of this 
function, the memory location of the screen has changed (e.g. the window 
has been resized), the old pointer position is invalid, and, if this 
memory position has been allocated by another kernel data, this data may 
be corrupted since this function will try to restore the previous data.

I don't know if this is the right approach, but this patch will solve 
this bug.

--- linux-2.6.12-rc4-mm2.orig/drivers/char/vt.c 2005-05-25 
12:04:54.000000000 -0300
+++ linux-2.6.12-rc4-mm2/drivers/char/vt.c      2005-05-25 
12:36:20.000000000 -0300
@@ -434,21 +434,21 @@ void invert_screen(struct vc_data *vc, i
 /* used by selection: complement pointer position */
 void complement_pos(struct vc_data *vc, int offset)
 {
-       static unsigned short *p;
+       static int old_offset=-1;
        static unsigned short old;
        static unsigned short oldx, oldy;

        WARN_CONSOLE_UNLOCKED();

-       if (p) {
-               scr_writew(old, p);
+       if (old_offset!=-1) {
+               scr_writew(old, screenpos(vc, old_offset, 1));
                if (DO_UPDATE(vc))
                        vc->vc_sw->con_putc(vc, old, oldy, oldx);
        }
-       if (offset == -1)
-               p = NULL;
-       else {
+       old_offset=offset;
+       if (offset != -1) {
                unsigned short new;
+               unsigned short *p;
                p = screenpos(vc, offset, 1);
                old = scr_readw(p);
                new = old ^ vc->vc_complement_mask;




--------------000301050207070604070403
Content-Type: text/x-patch;
 name="vt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt.patch"

--- linux-2.6.12-rc4-mm2.orig/drivers/char/vt.c	2005-05-25 12:04:54.000000000 -0300
+++ linux-2.6.12-rc4-mm2/drivers/char/vt.c	2005-05-25 12:36:20.000000000 -0300
@@ -434,21 +434,21 @@ void invert_screen(struct vc_data *vc, i
 /* used by selection: complement pointer position */
 void complement_pos(struct vc_data *vc, int offset)
 {
-	static unsigned short *p;
+	static int old_offset=-1;
 	static unsigned short old;
 	static unsigned short oldx, oldy;
 
 	WARN_CONSOLE_UNLOCKED();
 
-	if (p) {
-		scr_writew(old, p);
+	if (old_offset!=-1) {
+		scr_writew(old, screenpos(vc, old_offset, 1));
 		if (DO_UPDATE(vc))
 			vc->vc_sw->con_putc(vc, old, oldy, oldx);
 	}
-	if (offset == -1)
-		p = NULL;
-	else {
+	old_offset=offset;
+	if (offset != -1) {
 		unsigned short new;
+		unsigned short *p;
 		p = screenpos(vc, offset, 1);
 		old = scr_readw(p);
 		new = old ^ vc->vc_complement_mask;


--------------000301050207070604070403--
