Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131072AbQKXOT1>; Fri, 24 Nov 2000 09:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131057AbQKXOTS>; Fri, 24 Nov 2000 09:19:18 -0500
Received: from ns.tasking.nl ([195.193.207.2]:43026 "EHLO ns.tasking.nl")
        by vger.kernel.org with ESMTP id <S130514AbQKXNbc>;
        Fri, 24 Nov 2000 08:31:32 -0500
Date: Fri, 24 Nov 2000 13:59:57 +0100
From: Dick Streefland <dick.streefland@tasking.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11: es1371 mixer problems
Message-ID: <20001124135956.A5842@kemi.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING Software BV, Amersfoort, The Netherlands
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test11 introduced a problem with the mixer device of my SB128
soundcard (es1371 driver). When I start a mixer application like
xmixer or aumix, only a small subset of the mixer devices are available.
With 2.4.0-test10, using the same .config, all devices are available.

I've looked through the test11 patch and noticed that it contains
a lot of changes like:

  _IOC_DIR	--> _SIOC_DIR
  _IOC_READ	--> _SIOC_READ
  _IOC_WRITE	--> _SIOC_WRITE
  _IOC_SIZE	--> _SIOC_SIZE

These changes are not yet applied to ac97.c and ac97_codec.c, but that
does not seem to be the problem, because after making these changes
(see patch below), the problem persists.

-- 
Dick Streefland                      ////            TASKING Software BV
dick.streefland@tasking.com         (@ @)         http://www.tasking.com
--------------------------------oOO--(_)--OOo---------------------------

--- linux-2.4.0-test11/drivers/sound/ac97.c.orig	Fri Jan  7 00:01:56 2000
+++ linux-2.4.0-test11/drivers/sound/ac97.c	Thu Nov 23 00:02:31 2000
@@ -407,19 +407,19 @@
 	/* Read or write request. */
 	ret = -EINVAL;
 	if (_IOC_TYPE (cmd) == 'M') {
-	    int dir = _IOC_DIR (cmd);
+	    int dir = _SIOC_DIR (cmd);
 	    int channel = _IOC_NR (cmd);
 
 	    if (channel >= 0 && channel < SOUND_MIXER_NRDEVICES) {
 		ret = 0;
-		if (dir & _IOC_WRITE) {
+		if (dir & _SIOC_WRITE) {
 		    int val;
 		    if (get_user (val, (int *) arg) == 0)
 			ret = ac97_set_mixer (dev, channel, val);
 		    else
 			ret = -EFAULT;
 		}
-		if (ret >= 0 && (dir & _IOC_READ)) {
+		if (ret >= 0 && (dir & _SIOC_READ)) {
 		    if (dev->last_written_OSS_values[channel]
 			== AC97_REGVAL_UNKNOWN)
 			dev->last_written_OSS_values[channel]
--- linux-2.4.0-test11/drivers/sound/ac97_codec.c.orig	Tue Nov 21 21:41:02 2000
+++ linux-2.4.0-test11/drivers/sound/ac97_codec.c	Thu Nov 23 00:02:45 2000
@@ -405,13 +405,13 @@
 		return 0;
 	}
 
-	if (_IOC_TYPE(cmd) != 'M' || _IOC_SIZE(cmd) != sizeof(int))
+	if (_IOC_TYPE(cmd) != 'M' || _SIOC_SIZE(cmd) != sizeof(int))
 		return -EINVAL;
 
 	if (cmd == OSS_GETVERSION)
 		return put_user(SOUND_VERSION, (int *)arg);
 
-	if (_IOC_DIR(cmd) == _IOC_READ) {
+	if (_SIOC_DIR(cmd) == _SIOC_READ) {
 		switch (_IOC_NR(cmd)) {
 		case SOUND_MIXER_RECSRC: /* give them the current record source */
 			if (!codec->recmask_io) {
@@ -451,7 +451,7 @@
 		return put_user(val, (int *)arg);
 	}
 
-	if (_IOC_DIR(cmd) == (_IOC_WRITE|_IOC_READ)) {
+	if (_SIOC_DIR(cmd) == (_SIOC_WRITE|_SIOC_READ)) {
 		codec->modcnt++;
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
