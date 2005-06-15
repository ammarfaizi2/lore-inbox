Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVFOLoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVFOLoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFOLoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:44:16 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:45204 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261373AbVFOLlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:41:42 -0400
Message-Id: <s2afbf95.067@lyle.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 Beta
Date: Wed, 15 Jun 2005 05:41:47 -0600
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH]
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part62419DEB.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part62419DEB.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

When significant delays happen during boot (e.g. with a kernel debugger, =
but
the problem has also seen in other cases) the timeout for blanking the
console may trigger, but the work scheduler may not have been initialized,
yet. This previously led to a page fault due to a NULL pointer access.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc6.base/drivers/char/vt.c linux-2.6.12-rc6/drivers=
/char/vt.c
--- linux-2.6.12-rc6.base/drivers/char/vt.c	2005-06-15 13:24:51.0000000=
00 +0200
+++ linux-2.6.12-rc6/drivers/char/vt.c	2005-06-15 13:30:39.933774576 =
+0200
@@ -2867,6 +2867,10 @@ void unblank_screen(void)
  */
 static void blank_screen_t(unsigned long dummy)
 {
+	if (unlikely(!keventd_up())) {
+		mod_timer(&console_timer, jiffies + blankinterval);
+		return;
+	}
 	blank_timer_expired =3D 1;
 	schedule_work(&console_work);
 }



--=__Part62419DEB.0__=
Content-Type: text/plain; name="linux-2.6.12-rc6-blank-timeout.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.12-rc6-blank-timeout.patch"

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

When significant delays happen during boot (e.g. with a kernel debugger, but
the problem has also seen in other cases) the timeout for blanking the
console may trigger, but the work scheduler may not have been initialized,
yet. This previously led to a page fault due to a NULL pointer access.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru linux-2.6.12-rc6.base/drivers/char/vt.c linux-2.6.12-rc6/drivers/char/vt.c
--- linux-2.6.12-rc6.base/drivers/char/vt.c	2005-06-15 13:24:51.000000000 +0200
+++ linux-2.6.12-rc6/drivers/char/vt.c	2005-06-15 13:30:39.933774576 +0200
@@ -2867,6 +2867,10 @@ void unblank_screen(void)
  */
 static void blank_screen_t(unsigned long dummy)
 {
+	if (unlikely(!keventd_up())) {
+		mod_timer(&console_timer, jiffies + blankinterval);
+		return;
+	}
 	blank_timer_expired = 1;
 	schedule_work(&console_work);
 }

--=__Part62419DEB.0__=--
